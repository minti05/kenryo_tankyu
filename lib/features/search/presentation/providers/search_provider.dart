import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import "package:kenryo_tankyu/core/constants/work/info_value.dart";
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import "package:kenryo_tankyu/core/constants/work/sub_category_value.dart";
import 'package:kenryo_tankyu/features/search/domain/models/search.dart';

final suggestCategoryProvider = StateProvider<Category>((ref) => Category.none);
final suggestSubCategoryProvider = StateProvider<SubCategory>((ref) => SubCategory.none);

final searchProvider =
    NotifierProvider<SearchNotifier, Search>(SearchNotifier.new);

class SearchNotifier extends Notifier<Search> {
  @override
  Search build() {
    return const Search(category: Category.none, subCategory: SubCategory.none, eventName: EventName.undefined, course: Course.undefined,enterYear: EnterYear.undefined);
  }
  void reloadSearch(Category value) {
    state = state.copyWith(category: value);
  }

  void selectedCategory(Category selectCategoryName) {
    state = state.copyWith(category: selectCategoryName, subCategory: SubCategory.none);
  }

  void selectedYear(EnterYear selectYear) {
    state = state.copyWith(enterYear: selectYear);
  }

  void selectedEventName(EventName selectEventName) {
    state = state.copyWith(eventName: selectEventName);
  }

  void selectedCourse(Course selectCourse) {
    state = state.copyWith(course: selectCourse);
  }

  void selectedSubCategory(SubCategory selectSubCategory) {
    state = state.copyWith(subCategory: selectSubCategory);
  }

  void deleteAllParameters(){
    state = state.copyWith(enterYear: EnterYear.undefined,eventName: EventName.undefined,course: Course.undefined,subCategory: SubCategory.none,category: Category.none,searchWord: []);
  }

  void deleteParameter(String parameterName){
    switch(parameterName){
      case 'year':
        state = state.copyWith(enterYear: EnterYear.undefined);
        break;
      case 'eventName':
        state = state.copyWith(eventName: EventName.undefined);
        break;
      case 'course':
        state = state.copyWith(course: Course.undefined);
        break;
      case 'subCategory':
        state = state.copyWith(subCategory: SubCategory.none);
        break;
      case 'category':
        state = state.copyWith(category: Category.none, subCategory: SubCategory.none);
        break;
      case 'searchWord':
        state = state.copyWith(searchWord: []);
        break;
    }
  }

  void addKeyWord(List<String> word){
    state = state.copyWith(searchWord: word);
  }

  void setParameters(Search search){
    state = search;
  }

  void deleteWord(int index){
    final List<String> word = state.searchWord.where((content) => state.searchWord.indexOf(content) != index).toList();
    state = state.copyWith(searchWord: word);
  }

}
