// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchResult {
  List<Searched> get hits;
  int get page;
  int get nbPages;
  int get nbHits;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SearchResultCopyWith<SearchResult> get copyWith =>
      _$SearchResultCopyWithImpl<SearchResult>(
          this as SearchResult, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SearchResult &&
            const DeepCollectionEquality().equals(other.hits, hits) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.nbPages, nbPages) || other.nbPages == nbPages) &&
            (identical(other.nbHits, nbHits) || other.nbHits == nbHits));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(hits), page, nbPages, nbHits);

  @override
  String toString() {
    return 'SearchResult(hits: $hits, page: $page, nbPages: $nbPages, nbHits: $nbHits)';
  }
}

/// @nodoc
abstract mixin class $SearchResultCopyWith<$Res> {
  factory $SearchResultCopyWith(
          SearchResult value, $Res Function(SearchResult) _then) =
      _$SearchResultCopyWithImpl;
  @useResult
  $Res call({List<Searched> hits, int page, int nbPages, int nbHits});
}

/// @nodoc
class _$SearchResultCopyWithImpl<$Res> implements $SearchResultCopyWith<$Res> {
  _$SearchResultCopyWithImpl(this._self, this._then);

  final SearchResult _self;
  final $Res Function(SearchResult) _then;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hits = null,
    Object? page = null,
    Object? nbPages = null,
    Object? nbHits = null,
  }) {
    return _then(_self.copyWith(
      hits: null == hits
          ? _self.hits
          : hits // ignore: cast_nullable_to_non_nullable
              as List<Searched>,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      nbPages: null == nbPages
          ? _self.nbPages
          : nbPages // ignore: cast_nullable_to_non_nullable
              as int,
      nbHits: null == nbHits
          ? _self.nbHits
          : nbHits // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [SearchResult].
extension SearchResultPatterns on SearchResult {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SearchResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SearchResult() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SearchResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchResult():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SearchResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchResult() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Searched> hits, int page, int nbPages, int nbHits)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SearchResult() when $default != null:
        return $default(_that.hits, _that.page, _that.nbPages, _that.nbHits);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Searched> hits, int page, int nbPages, int nbHits)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchResult():
        return $default(_that.hits, _that.page, _that.nbPages, _that.nbHits);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<Searched> hits, int page, int nbPages, int nbHits)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchResult() when $default != null:
        return $default(_that.hits, _that.page, _that.nbPages, _that.nbHits);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SearchResult extends SearchResult {
  const _SearchResult(
      {required final List<Searched> hits,
      required this.page,
      required this.nbPages,
      required this.nbHits})
      : _hits = hits,
        super._();

  final List<Searched> _hits;
  @override
  List<Searched> get hits {
    if (_hits is EqualUnmodifiableListView) return _hits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hits);
  }

  @override
  final int page;
  @override
  final int nbPages;
  @override
  final int nbHits;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearchResultCopyWith<_SearchResult> get copyWith =>
      __$SearchResultCopyWithImpl<_SearchResult>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchResult &&
            const DeepCollectionEquality().equals(other._hits, _hits) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.nbPages, nbPages) || other.nbPages == nbPages) &&
            (identical(other.nbHits, nbHits) || other.nbHits == nbHits));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_hits), page, nbPages, nbHits);

  @override
  String toString() {
    return 'SearchResult(hits: $hits, page: $page, nbPages: $nbPages, nbHits: $nbHits)';
  }
}

/// @nodoc
abstract mixin class _$SearchResultCopyWith<$Res>
    implements $SearchResultCopyWith<$Res> {
  factory _$SearchResultCopyWith(
          _SearchResult value, $Res Function(_SearchResult) _then) =
      __$SearchResultCopyWithImpl;
  @override
  @useResult
  $Res call({List<Searched> hits, int page, int nbPages, int nbHits});
}

/// @nodoc
class __$SearchResultCopyWithImpl<$Res>
    implements _$SearchResultCopyWith<$Res> {
  __$SearchResultCopyWithImpl(this._self, this._then);

  final _SearchResult _self;
  final $Res Function(_SearchResult) _then;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? hits = null,
    Object? page = null,
    Object? nbPages = null,
    Object? nbHits = null,
  }) {
    return _then(_SearchResult(
      hits: null == hits
          ? _self._hits
          : hits // ignore: cast_nullable_to_non_nullable
              as List<Searched>,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      nbPages: null == nbPages
          ? _self.nbPages
          : nbPages // ignore: cast_nullable_to_non_nullable
              as int,
      nbHits: null == nbHits
          ? _self.nbHits
          : nbHits // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
