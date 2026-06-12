// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Search {
  @CategoryEnumConverter()
  Category get category;
  @SubCategoryEnumConverter()
  SubCategory get subCategory;
  @EnterYearEnumConverter()
  EnterYear get enterYear;
  @EventNameEnumConverter()
  EventName get eventName;
  @CourseEnumConverter()
  Course get course;
  @SearchWordConverter()
  List<String> get searchWord;
  int get numberOfHits;
  @DateTimeConverter()
  DateTime? get savedAt;

  /// Create a copy of Search
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SearchCopyWith<Search> get copyWith =>
      _$SearchCopyWithImpl<Search>(this as Search, _$identity);

  /// Serializes this Search to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Search &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subCategory, subCategory) ||
                other.subCategory == subCategory) &&
            (identical(other.enterYear, enterYear) ||
                other.enterYear == enterYear) &&
            (identical(other.eventName, eventName) ||
                other.eventName == eventName) &&
            (identical(other.course, course) || other.course == course) &&
            const DeepCollectionEquality()
                .equals(other.searchWord, searchWord) &&
            (identical(other.numberOfHits, numberOfHits) ||
                other.numberOfHits == numberOfHits) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      category,
      subCategory,
      enterYear,
      eventName,
      course,
      const DeepCollectionEquality().hash(searchWord),
      numberOfHits,
      savedAt);

  @override
  String toString() {
    return 'Search(category: $category, subCategory: $subCategory, enterYear: $enterYear, eventName: $eventName, course: $course, searchWord: $searchWord, numberOfHits: $numberOfHits, savedAt: $savedAt)';
  }
}

/// @nodoc
abstract mixin class $SearchCopyWith<$Res> {
  factory $SearchCopyWith(Search value, $Res Function(Search) _then) =
      _$SearchCopyWithImpl;
  @useResult
  $Res call(
      {@CategoryEnumConverter() Category category,
      @SubCategoryEnumConverter() SubCategory subCategory,
      @EnterYearEnumConverter() EnterYear enterYear,
      @EventNameEnumConverter() EventName eventName,
      @CourseEnumConverter() Course course,
      @SearchWordConverter() List<String> searchWord,
      int numberOfHits,
      @DateTimeConverter() DateTime? savedAt});
}

/// @nodoc
class _$SearchCopyWithImpl<$Res> implements $SearchCopyWith<$Res> {
  _$SearchCopyWithImpl(this._self, this._then);

  final Search _self;
  final $Res Function(Search) _then;

  /// Create a copy of Search
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? subCategory = null,
    Object? enterYear = null,
    Object? eventName = null,
    Object? course = null,
    Object? searchWord = null,
    Object? numberOfHits = null,
    Object? savedAt = freezed,
  }) {
    return _then(_self.copyWith(
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      subCategory: null == subCategory
          ? _self.subCategory
          : subCategory // ignore: cast_nullable_to_non_nullable
              as SubCategory,
      enterYear: null == enterYear
          ? _self.enterYear
          : enterYear // ignore: cast_nullable_to_non_nullable
              as EnterYear,
      eventName: null == eventName
          ? _self.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as EventName,
      course: null == course
          ? _self.course
          : course // ignore: cast_nullable_to_non_nullable
              as Course,
      searchWord: null == searchWord
          ? _self.searchWord
          : searchWord // ignore: cast_nullable_to_non_nullable
              as List<String>,
      numberOfHits: null == numberOfHits
          ? _self.numberOfHits
          : numberOfHits // ignore: cast_nullable_to_non_nullable
              as int,
      savedAt: freezed == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Search].
extension SearchPatterns on Search {
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
    TResult Function(_Search value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Search() when $default != null:
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
    TResult Function(_Search value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Search():
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
    TResult? Function(_Search value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Search() when $default != null:
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
    TResult Function(
            @CategoryEnumConverter() Category category,
            @SubCategoryEnumConverter() SubCategory subCategory,
            @EnterYearEnumConverter() EnterYear enterYear,
            @EventNameEnumConverter() EventName eventName,
            @CourseEnumConverter() Course course,
            @SearchWordConverter() List<String> searchWord,
            int numberOfHits,
            @DateTimeConverter() DateTime? savedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Search() when $default != null:
        return $default(
            _that.category,
            _that.subCategory,
            _that.enterYear,
            _that.eventName,
            _that.course,
            _that.searchWord,
            _that.numberOfHits,
            _that.savedAt);
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
    TResult Function(
            @CategoryEnumConverter() Category category,
            @SubCategoryEnumConverter() SubCategory subCategory,
            @EnterYearEnumConverter() EnterYear enterYear,
            @EventNameEnumConverter() EventName eventName,
            @CourseEnumConverter() Course course,
            @SearchWordConverter() List<String> searchWord,
            int numberOfHits,
            @DateTimeConverter() DateTime? savedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Search():
        return $default(
            _that.category,
            _that.subCategory,
            _that.enterYear,
            _that.eventName,
            _that.course,
            _that.searchWord,
            _that.numberOfHits,
            _that.savedAt);
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
    TResult? Function(
            @CategoryEnumConverter() Category category,
            @SubCategoryEnumConverter() SubCategory subCategory,
            @EnterYearEnumConverter() EnterYear enterYear,
            @EventNameEnumConverter() EventName eventName,
            @CourseEnumConverter() Course course,
            @SearchWordConverter() List<String> searchWord,
            int numberOfHits,
            @DateTimeConverter() DateTime? savedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Search() when $default != null:
        return $default(
            _that.category,
            _that.subCategory,
            _that.enterYear,
            _that.eventName,
            _that.course,
            _that.searchWord,
            _that.numberOfHits,
            _that.savedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Search extends Search {
  const _Search(
      {@CategoryEnumConverter() required this.category,
      @SubCategoryEnumConverter() required this.subCategory,
      @EnterYearEnumConverter() required this.enterYear,
      @EventNameEnumConverter() required this.eventName,
      @CourseEnumConverter() required this.course,
      @SearchWordConverter() final List<String> searchWord = const [],
      this.numberOfHits = 0,
      @DateTimeConverter() this.savedAt})
      : _searchWord = searchWord,
        super._();
  factory _Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);

  @override
  @CategoryEnumConverter()
  final Category category;
  @override
  @SubCategoryEnumConverter()
  final SubCategory subCategory;
  @override
  @EnterYearEnumConverter()
  final EnterYear enterYear;
  @override
  @EventNameEnumConverter()
  final EventName eventName;
  @override
  @CourseEnumConverter()
  final Course course;
  final List<String> _searchWord;
  @override
  @JsonKey()
  @SearchWordConverter()
  List<String> get searchWord {
    if (_searchWord is EqualUnmodifiableListView) return _searchWord;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchWord);
  }

  @override
  @JsonKey()
  final int numberOfHits;
  @override
  @DateTimeConverter()
  final DateTime? savedAt;

  /// Create a copy of Search
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearchCopyWith<_Search> get copyWith =>
      __$SearchCopyWithImpl<_Search>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SearchToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Search &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subCategory, subCategory) ||
                other.subCategory == subCategory) &&
            (identical(other.enterYear, enterYear) ||
                other.enterYear == enterYear) &&
            (identical(other.eventName, eventName) ||
                other.eventName == eventName) &&
            (identical(other.course, course) || other.course == course) &&
            const DeepCollectionEquality()
                .equals(other._searchWord, _searchWord) &&
            (identical(other.numberOfHits, numberOfHits) ||
                other.numberOfHits == numberOfHits) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      category,
      subCategory,
      enterYear,
      eventName,
      course,
      const DeepCollectionEquality().hash(_searchWord),
      numberOfHits,
      savedAt);

  @override
  String toString() {
    return 'Search(category: $category, subCategory: $subCategory, enterYear: $enterYear, eventName: $eventName, course: $course, searchWord: $searchWord, numberOfHits: $numberOfHits, savedAt: $savedAt)';
  }
}

/// @nodoc
abstract mixin class _$SearchCopyWith<$Res> implements $SearchCopyWith<$Res> {
  factory _$SearchCopyWith(_Search value, $Res Function(_Search) _then) =
      __$SearchCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@CategoryEnumConverter() Category category,
      @SubCategoryEnumConverter() SubCategory subCategory,
      @EnterYearEnumConverter() EnterYear enterYear,
      @EventNameEnumConverter() EventName eventName,
      @CourseEnumConverter() Course course,
      @SearchWordConverter() List<String> searchWord,
      int numberOfHits,
      @DateTimeConverter() DateTime? savedAt});
}

/// @nodoc
class __$SearchCopyWithImpl<$Res> implements _$SearchCopyWith<$Res> {
  __$SearchCopyWithImpl(this._self, this._then);

  final _Search _self;
  final $Res Function(_Search) _then;

  /// Create a copy of Search
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? category = null,
    Object? subCategory = null,
    Object? enterYear = null,
    Object? eventName = null,
    Object? course = null,
    Object? searchWord = null,
    Object? numberOfHits = null,
    Object? savedAt = freezed,
  }) {
    return _then(_Search(
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      subCategory: null == subCategory
          ? _self.subCategory
          : subCategory // ignore: cast_nullable_to_non_nullable
              as SubCategory,
      enterYear: null == enterYear
          ? _self.enterYear
          : enterYear // ignore: cast_nullable_to_non_nullable
              as EnterYear,
      eventName: null == eventName
          ? _self.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as EventName,
      course: null == course
          ? _self.course
          : course // ignore: cast_nullable_to_non_nullable
              as Course,
      searchWord: null == searchWord
          ? _self._searchWord
          : searchWord // ignore: cast_nullable_to_non_nullable
              as List<String>,
      numberOfHits: null == numberOfHits
          ? _self.numberOfHits
          : numberOfHits // ignore: cast_nullable_to_non_nullable
              as int,
      savedAt: freezed == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
