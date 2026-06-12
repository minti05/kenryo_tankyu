// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'searched.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Searched {
  int get documentID;
  bool get isFavorite;
  @CategoryEnumConverter()
  Category get category1;
  @SubCategoryEnumConverter()
  SubCategory get subCategory1;
  @CategoryEnumConverter()
  Category get category2;
  @SubCategoryEnumConverter()
  SubCategory get subCategory2;
  @EnterYearEnumConverter()
  EnterYear get enterYear;
  @EventNameEnumConverter()
  EventName get eventName;
  @CourseEnumConverter()
  Course get course;
  String get title;
  String get author;
  int get likes;
  bool get existsSlide;
  bool get existsReport;
  bool get existsThesis;
  bool get existsPoster;
  @DateTimeConverter()
  DateTime? get savedAt;
  bool get isCached;
  int? get awardType;
  String? get awardName;

  /// Create a copy of Searched
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SearchedCopyWith<Searched> get copyWith =>
      _$SearchedCopyWithImpl<Searched>(this as Searched, _$identity);

  /// Serializes this Searched to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Searched &&
            (identical(other.documentID, documentID) ||
                other.documentID == documentID) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.category1, category1) ||
                other.category1 == category1) &&
            (identical(other.subCategory1, subCategory1) ||
                other.subCategory1 == subCategory1) &&
            (identical(other.category2, category2) ||
                other.category2 == category2) &&
            (identical(other.subCategory2, subCategory2) ||
                other.subCategory2 == subCategory2) &&
            (identical(other.enterYear, enterYear) ||
                other.enterYear == enterYear) &&
            (identical(other.eventName, eventName) ||
                other.eventName == eventName) &&
            (identical(other.course, course) || other.course == course) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            (identical(other.existsSlide, existsSlide) ||
                other.existsSlide == existsSlide) &&
            (identical(other.existsReport, existsReport) ||
                other.existsReport == existsReport) &&
            (identical(other.existsThesis, existsThesis) ||
                other.existsThesis == existsThesis) &&
            (identical(other.existsPoster, existsPoster) ||
                other.existsPoster == existsPoster) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt) &&
            (identical(other.isCached, isCached) ||
                other.isCached == isCached) &&
            (identical(other.awardType, awardType) ||
                other.awardType == awardType) &&
            (identical(other.awardName, awardName) ||
                other.awardName == awardName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        documentID,
        isFavorite,
        category1,
        subCategory1,
        category2,
        subCategory2,
        enterYear,
        eventName,
        course,
        title,
        author,
        likes,
        existsSlide,
        existsReport,
        existsThesis,
        existsPoster,
        savedAt,
        isCached,
        awardType,
        awardName
      ]);

  @override
  String toString() {
    return 'Searched(documentID: $documentID, isFavorite: $isFavorite, category1: $category1, subCategory1: $subCategory1, category2: $category2, subCategory2: $subCategory2, enterYear: $enterYear, eventName: $eventName, course: $course, title: $title, author: $author, likes: $likes, existsSlide: $existsSlide, existsReport: $existsReport, existsThesis: $existsThesis, existsPoster: $existsPoster, savedAt: $savedAt, isCached: $isCached, awardType: $awardType, awardName: $awardName)';
  }
}

/// @nodoc
abstract mixin class $SearchedCopyWith<$Res> {
  factory $SearchedCopyWith(Searched value, $Res Function(Searched) _then) =
      _$SearchedCopyWithImpl;
  @useResult
  $Res call(
      {int documentID,
      bool isFavorite,
      @CategoryEnumConverter() Category category1,
      @SubCategoryEnumConverter() SubCategory subCategory1,
      @CategoryEnumConverter() Category category2,
      @SubCategoryEnumConverter() SubCategory subCategory2,
      @EnterYearEnumConverter() EnterYear enterYear,
      @EventNameEnumConverter() EventName eventName,
      @CourseEnumConverter() Course course,
      String title,
      String author,
      int likes,
      bool existsSlide,
      bool existsReport,
      bool existsThesis,
      bool existsPoster,
      @DateTimeConverter() DateTime? savedAt,
      bool isCached,
      int? awardType,
      String? awardName});
}

/// @nodoc
class _$SearchedCopyWithImpl<$Res> implements $SearchedCopyWith<$Res> {
  _$SearchedCopyWithImpl(this._self, this._then);

  final Searched _self;
  final $Res Function(Searched) _then;

  /// Create a copy of Searched
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documentID = null,
    Object? isFavorite = null,
    Object? category1 = null,
    Object? subCategory1 = null,
    Object? category2 = null,
    Object? subCategory2 = null,
    Object? enterYear = null,
    Object? eventName = null,
    Object? course = null,
    Object? title = null,
    Object? author = null,
    Object? likes = null,
    Object? existsSlide = null,
    Object? existsReport = null,
    Object? existsThesis = null,
    Object? existsPoster = null,
    Object? savedAt = freezed,
    Object? isCached = null,
    Object? awardType = freezed,
    Object? awardName = freezed,
  }) {
    return _then(_self.copyWith(
      documentID: null == documentID
          ? _self.documentID
          : documentID // ignore: cast_nullable_to_non_nullable
              as int,
      isFavorite: null == isFavorite
          ? _self.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      category1: null == category1
          ? _self.category1
          : category1 // ignore: cast_nullable_to_non_nullable
              as Category,
      subCategory1: null == subCategory1
          ? _self.subCategory1
          : subCategory1 // ignore: cast_nullable_to_non_nullable
              as SubCategory,
      category2: null == category2
          ? _self.category2
          : category2 // ignore: cast_nullable_to_non_nullable
              as Category,
      subCategory2: null == subCategory2
          ? _self.subCategory2
          : subCategory2 // ignore: cast_nullable_to_non_nullable
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
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      likes: null == likes
          ? _self.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      existsSlide: null == existsSlide
          ? _self.existsSlide
          : existsSlide // ignore: cast_nullable_to_non_nullable
              as bool,
      existsReport: null == existsReport
          ? _self.existsReport
          : existsReport // ignore: cast_nullable_to_non_nullable
              as bool,
      existsThesis: null == existsThesis
          ? _self.existsThesis
          : existsThesis // ignore: cast_nullable_to_non_nullable
              as bool,
      existsPoster: null == existsPoster
          ? _self.existsPoster
          : existsPoster // ignore: cast_nullable_to_non_nullable
              as bool,
      savedAt: freezed == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCached: null == isCached
          ? _self.isCached
          : isCached // ignore: cast_nullable_to_non_nullable
              as bool,
      awardType: freezed == awardType
          ? _self.awardType
          : awardType // ignore: cast_nullable_to_non_nullable
              as int?,
      awardName: freezed == awardName
          ? _self.awardName
          : awardName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Searched].
extension SearchedPatterns on Searched {
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
    TResult Function(_Searched value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Searched() when $default != null:
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
    TResult Function(_Searched value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Searched():
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
    TResult? Function(_Searched value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Searched() when $default != null:
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
            int documentID,
            bool isFavorite,
            @CategoryEnumConverter() Category category1,
            @SubCategoryEnumConverter() SubCategory subCategory1,
            @CategoryEnumConverter() Category category2,
            @SubCategoryEnumConverter() SubCategory subCategory2,
            @EnterYearEnumConverter() EnterYear enterYear,
            @EventNameEnumConverter() EventName eventName,
            @CourseEnumConverter() Course course,
            String title,
            String author,
            int likes,
            bool existsSlide,
            bool existsReport,
            bool existsThesis,
            bool existsPoster,
            @DateTimeConverter() DateTime? savedAt,
            bool isCached,
            int? awardType,
            String? awardName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Searched() when $default != null:
        return $default(
            _that.documentID,
            _that.isFavorite,
            _that.category1,
            _that.subCategory1,
            _that.category2,
            _that.subCategory2,
            _that.enterYear,
            _that.eventName,
            _that.course,
            _that.title,
            _that.author,
            _that.likes,
            _that.existsSlide,
            _that.existsReport,
            _that.existsThesis,
            _that.existsPoster,
            _that.savedAt,
            _that.isCached,
            _that.awardType,
            _that.awardName);
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
            int documentID,
            bool isFavorite,
            @CategoryEnumConverter() Category category1,
            @SubCategoryEnumConverter() SubCategory subCategory1,
            @CategoryEnumConverter() Category category2,
            @SubCategoryEnumConverter() SubCategory subCategory2,
            @EnterYearEnumConverter() EnterYear enterYear,
            @EventNameEnumConverter() EventName eventName,
            @CourseEnumConverter() Course course,
            String title,
            String author,
            int likes,
            bool existsSlide,
            bool existsReport,
            bool existsThesis,
            bool existsPoster,
            @DateTimeConverter() DateTime? savedAt,
            bool isCached,
            int? awardType,
            String? awardName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Searched():
        return $default(
            _that.documentID,
            _that.isFavorite,
            _that.category1,
            _that.subCategory1,
            _that.category2,
            _that.subCategory2,
            _that.enterYear,
            _that.eventName,
            _that.course,
            _that.title,
            _that.author,
            _that.likes,
            _that.existsSlide,
            _that.existsReport,
            _that.existsThesis,
            _that.existsPoster,
            _that.savedAt,
            _that.isCached,
            _that.awardType,
            _that.awardName);
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
            int documentID,
            bool isFavorite,
            @CategoryEnumConverter() Category category1,
            @SubCategoryEnumConverter() SubCategory subCategory1,
            @CategoryEnumConverter() Category category2,
            @SubCategoryEnumConverter() SubCategory subCategory2,
            @EnterYearEnumConverter() EnterYear enterYear,
            @EventNameEnumConverter() EventName eventName,
            @CourseEnumConverter() Course course,
            String title,
            String author,
            int likes,
            bool existsSlide,
            bool existsReport,
            bool existsThesis,
            bool existsPoster,
            @DateTimeConverter() DateTime? savedAt,
            bool isCached,
            int? awardType,
            String? awardName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Searched() when $default != null:
        return $default(
            _that.documentID,
            _that.isFavorite,
            _that.category1,
            _that.subCategory1,
            _that.category2,
            _that.subCategory2,
            _that.enterYear,
            _that.eventName,
            _that.course,
            _that.title,
            _that.author,
            _that.likes,
            _that.existsSlide,
            _that.existsReport,
            _that.existsThesis,
            _that.existsPoster,
            _that.savedAt,
            _that.isCached,
            _that.awardType,
            _that.awardName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Searched extends Searched {
  const _Searched(
      {this.documentID = 00000000,
      this.isFavorite = false,
      @CategoryEnumConverter() required this.category1,
      @SubCategoryEnumConverter() required this.subCategory1,
      @CategoryEnumConverter() required this.category2,
      @SubCategoryEnumConverter() required this.subCategory2,
      @EnterYearEnumConverter() required this.enterYear,
      @EventNameEnumConverter() required this.eventName,
      @CourseEnumConverter() required this.course,
      this.title = '',
      this.author = '',
      this.likes = 0,
      this.existsSlide = false,
      this.existsReport = false,
      this.existsThesis = false,
      this.existsPoster = false,
      @DateTimeConverter() this.savedAt,
      this.isCached = true,
      this.awardType,
      this.awardName})
      : super._();
  factory _Searched.fromJson(Map<String, dynamic> json) =>
      _$SearchedFromJson(json);

  @override
  @JsonKey()
  final int documentID;
  @override
  @JsonKey()
  final bool isFavorite;
  @override
  @CategoryEnumConverter()
  final Category category1;
  @override
  @SubCategoryEnumConverter()
  final SubCategory subCategory1;
  @override
  @CategoryEnumConverter()
  final Category category2;
  @override
  @SubCategoryEnumConverter()
  final SubCategory subCategory2;
  @override
  @EnterYearEnumConverter()
  final EnterYear enterYear;
  @override
  @EventNameEnumConverter()
  final EventName eventName;
  @override
  @CourseEnumConverter()
  final Course course;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String author;
  @override
  @JsonKey()
  final int likes;
  @override
  @JsonKey()
  final bool existsSlide;
  @override
  @JsonKey()
  final bool existsReport;
  @override
  @JsonKey()
  final bool existsThesis;
  @override
  @JsonKey()
  final bool existsPoster;
  @override
  @DateTimeConverter()
  final DateTime? savedAt;
  @override
  @JsonKey()
  final bool isCached;
  @override
  final int? awardType;
  @override
  final String? awardName;

  /// Create a copy of Searched
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearchedCopyWith<_Searched> get copyWith =>
      __$SearchedCopyWithImpl<_Searched>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SearchedToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Searched &&
            (identical(other.documentID, documentID) ||
                other.documentID == documentID) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.category1, category1) ||
                other.category1 == category1) &&
            (identical(other.subCategory1, subCategory1) ||
                other.subCategory1 == subCategory1) &&
            (identical(other.category2, category2) ||
                other.category2 == category2) &&
            (identical(other.subCategory2, subCategory2) ||
                other.subCategory2 == subCategory2) &&
            (identical(other.enterYear, enterYear) ||
                other.enterYear == enterYear) &&
            (identical(other.eventName, eventName) ||
                other.eventName == eventName) &&
            (identical(other.course, course) || other.course == course) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            (identical(other.existsSlide, existsSlide) ||
                other.existsSlide == existsSlide) &&
            (identical(other.existsReport, existsReport) ||
                other.existsReport == existsReport) &&
            (identical(other.existsThesis, existsThesis) ||
                other.existsThesis == existsThesis) &&
            (identical(other.existsPoster, existsPoster) ||
                other.existsPoster == existsPoster) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt) &&
            (identical(other.isCached, isCached) ||
                other.isCached == isCached) &&
            (identical(other.awardType, awardType) ||
                other.awardType == awardType) &&
            (identical(other.awardName, awardName) ||
                other.awardName == awardName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        documentID,
        isFavorite,
        category1,
        subCategory1,
        category2,
        subCategory2,
        enterYear,
        eventName,
        course,
        title,
        author,
        likes,
        existsSlide,
        existsReport,
        existsThesis,
        existsPoster,
        savedAt,
        isCached,
        awardType,
        awardName
      ]);

  @override
  String toString() {
    return 'Searched(documentID: $documentID, isFavorite: $isFavorite, category1: $category1, subCategory1: $subCategory1, category2: $category2, subCategory2: $subCategory2, enterYear: $enterYear, eventName: $eventName, course: $course, title: $title, author: $author, likes: $likes, existsSlide: $existsSlide, existsReport: $existsReport, existsThesis: $existsThesis, existsPoster: $existsPoster, savedAt: $savedAt, isCached: $isCached, awardType: $awardType, awardName: $awardName)';
  }
}

/// @nodoc
abstract mixin class _$SearchedCopyWith<$Res>
    implements $SearchedCopyWith<$Res> {
  factory _$SearchedCopyWith(_Searched value, $Res Function(_Searched) _then) =
      __$SearchedCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int documentID,
      bool isFavorite,
      @CategoryEnumConverter() Category category1,
      @SubCategoryEnumConverter() SubCategory subCategory1,
      @CategoryEnumConverter() Category category2,
      @SubCategoryEnumConverter() SubCategory subCategory2,
      @EnterYearEnumConverter() EnterYear enterYear,
      @EventNameEnumConverter() EventName eventName,
      @CourseEnumConverter() Course course,
      String title,
      String author,
      int likes,
      bool existsSlide,
      bool existsReport,
      bool existsThesis,
      bool existsPoster,
      @DateTimeConverter() DateTime? savedAt,
      bool isCached,
      int? awardType,
      String? awardName});
}

/// @nodoc
class __$SearchedCopyWithImpl<$Res> implements _$SearchedCopyWith<$Res> {
  __$SearchedCopyWithImpl(this._self, this._then);

  final _Searched _self;
  final $Res Function(_Searched) _then;

  /// Create a copy of Searched
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? documentID = null,
    Object? isFavorite = null,
    Object? category1 = null,
    Object? subCategory1 = null,
    Object? category2 = null,
    Object? subCategory2 = null,
    Object? enterYear = null,
    Object? eventName = null,
    Object? course = null,
    Object? title = null,
    Object? author = null,
    Object? likes = null,
    Object? existsSlide = null,
    Object? existsReport = null,
    Object? existsThesis = null,
    Object? existsPoster = null,
    Object? savedAt = freezed,
    Object? isCached = null,
    Object? awardType = freezed,
    Object? awardName = freezed,
  }) {
    return _then(_Searched(
      documentID: null == documentID
          ? _self.documentID
          : documentID // ignore: cast_nullable_to_non_nullable
              as int,
      isFavorite: null == isFavorite
          ? _self.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      category1: null == category1
          ? _self.category1
          : category1 // ignore: cast_nullable_to_non_nullable
              as Category,
      subCategory1: null == subCategory1
          ? _self.subCategory1
          : subCategory1 // ignore: cast_nullable_to_non_nullable
              as SubCategory,
      category2: null == category2
          ? _self.category2
          : category2 // ignore: cast_nullable_to_non_nullable
              as Category,
      subCategory2: null == subCategory2
          ? _self.subCategory2
          : subCategory2 // ignore: cast_nullable_to_non_nullable
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
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      likes: null == likes
          ? _self.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      existsSlide: null == existsSlide
          ? _self.existsSlide
          : existsSlide // ignore: cast_nullable_to_non_nullable
              as bool,
      existsReport: null == existsReport
          ? _self.existsReport
          : existsReport // ignore: cast_nullable_to_non_nullable
              as bool,
      existsThesis: null == existsThesis
          ? _self.existsThesis
          : existsThesis // ignore: cast_nullable_to_non_nullable
              as bool,
      existsPoster: null == existsPoster
          ? _self.existsPoster
          : existsPoster // ignore: cast_nullable_to_non_nullable
              as bool,
      savedAt: freezed == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCached: null == isCached
          ? _self.isCached
          : isCached // ignore: cast_nullable_to_non_nullable
              as bool,
      awardType: freezed == awardType
          ? _self.awardType
          : awardType // ignore: cast_nullable_to_non_nullable
              as int?,
      awardName: freezed == awardName
          ? _self.awardName
          : awardName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
