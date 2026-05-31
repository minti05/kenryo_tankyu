import 'dart:convert';

import 'package:kenryo_tankyu/core/constants/work/category_value.dart';
import 'package:kenryo_tankyu/core/constants/work/info_value.dart';
import 'package:kenryo_tankyu/core/constants/work/sub_category_value.dart';
import 'package:kenryo_tankyu/core/providers/supabase_provider.dart';
import 'package:kenryo_tankyu/features/search/domain/models/search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'search_history_data_source.g.dart';

@Riverpod(keepAlive: true)
SearchHistoryDataSource searchHistoryDataSource(Ref ref) {
  return SearchHistoryDataSource(ref.watch(supabaseClientProvider));
}

class SearchHistoryDataSource {
  SearchHistoryDataSource(this._client);

  final SupabaseClient _client;

  Future<void> insertHistory(String userId, Search search) async {
    await _client.from('search_history').upsert(
          _toRow(userId, search),
          onConflict:
              'user_id,category,sub_category,enter_year,event_name,course,search_word',
        );
  }

  Future<List<Search>?> getAllHistory(String userId) async {
    final rows = await _client
        .from('search_history')
        .select()
        .eq('user_id', userId)
        .order('searched_at', ascending: false);
    if (rows.isEmpty) return null;
    return rows.map(_fromRow).toList();
  }

  Future<void> deleteAllHistory(String userId) async {
    await _client.from('search_history').delete().eq('user_id', userId);
  }

  Map<String, dynamic> _toRow(String userId, Search search) => {
        'user_id': userId,
        'category': const CategoryEnumConverter().toJson(search.category),
        'sub_category':
            const SubCategoryEnumConverter().toJson(search.subCategory),
        'enter_year': const EnterYearEnumConverter().toJson(search.enterYear),
        'event_name': const EventNameEnumConverter().toJson(search.eventName),
        'course': const CourseEnumConverter().toJson(search.course),
        'search_word': jsonEncode(search.searchWord),
        'number_of_hits': search.numberOfHits,
        'searched_at':
            (search.savedAt ?? DateTime.now()).toUtc().toIso8601String(),
      };

  Search _fromRow(Map<String, dynamic> row) => Search(
        category:
            const CategoryEnumConverter().fromJson(row['category'] as String),
        subCategory: const SubCategoryEnumConverter()
            .fromJson(row['sub_category'] as String),
        enterYear:
            const EnterYearEnumConverter().fromJson(row['enter_year'] as int),
        eventName: const EventNameEnumConverter()
            .fromJson(row['event_name'] as String),
        course: const CourseEnumConverter().fromJson(row['course'] as String),
        searchWord: (jsonDecode(row['search_word'] as String) as List)
            .map((e) => e.toString())
            .toList(),
        numberOfHits: (row['number_of_hits'] as int?) ?? 0,
        savedAt: row['searched_at'] != null
            ? DateTime.parse(row['searched_at'] as String).toLocal()
            : null,
      );
}
