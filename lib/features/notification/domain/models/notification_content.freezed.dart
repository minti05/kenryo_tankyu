// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationContent {
  String get id; //firestoreで自動で割り振られるID
  @NotificationTypeEnumConverter()
  NotificationType get type;
  String get headerImagePath; //firestore databaseに保存されているpngファイル名（.pngを抜いて）
  String get title;
  String get contents;
  @DateTimeConverter()
  DateTime get sendAt;
  @DateTimeConverter()
  DateTime get savedAt;

  /// Create a copy of NotificationContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NotificationContentCopyWith<NotificationContent> get copyWith =>
      _$NotificationContentCopyWithImpl<NotificationContent>(
          this as NotificationContent, _$identity);

  /// Serializes this NotificationContent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NotificationContent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.headerImagePath, headerImagePath) ||
                other.headerImagePath == headerImagePath) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.contents, contents) ||
                other.contents == contents) &&
            (identical(other.sendAt, sendAt) || other.sendAt == sendAt) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, headerImagePath, title, contents, sendAt, savedAt);

  @override
  String toString() {
    return 'NotificationContent(id: $id, type: $type, headerImagePath: $headerImagePath, title: $title, contents: $contents, sendAt: $sendAt, savedAt: $savedAt)';
  }
}

/// @nodoc
abstract mixin class $NotificationContentCopyWith<$Res> {
  factory $NotificationContentCopyWith(
          NotificationContent value, $Res Function(NotificationContent) _then) =
      _$NotificationContentCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @NotificationTypeEnumConverter() NotificationType type,
      String headerImagePath,
      String title,
      String contents,
      @DateTimeConverter() DateTime sendAt,
      @DateTimeConverter() DateTime savedAt});
}

/// @nodoc
class _$NotificationContentCopyWithImpl<$Res>
    implements $NotificationContentCopyWith<$Res> {
  _$NotificationContentCopyWithImpl(this._self, this._then);

  final NotificationContent _self;
  final $Res Function(NotificationContent) _then;

  /// Create a copy of NotificationContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? headerImagePath = null,
    Object? title = null,
    Object? contents = null,
    Object? sendAt = null,
    Object? savedAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      headerImagePath: null == headerImagePath
          ? _self.headerImagePath
          : headerImagePath // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      contents: null == contents
          ? _self.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String,
      sendAt: null == sendAt
          ? _self.sendAt
          : sendAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      savedAt: null == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [NotificationContent].
extension NotificationContentPatterns on NotificationContent {
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
    TResult Function(_NotificationContent value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationContent() when $default != null:
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
    TResult Function(_NotificationContent value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationContent():
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
    TResult? Function(_NotificationContent value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationContent() when $default != null:
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
            String id,
            @NotificationTypeEnumConverter() NotificationType type,
            String headerImagePath,
            String title,
            String contents,
            @DateTimeConverter() DateTime sendAt,
            @DateTimeConverter() DateTime savedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationContent() when $default != null:
        return $default(_that.id, _that.type, _that.headerImagePath,
            _that.title, _that.contents, _that.sendAt, _that.savedAt);
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
            String id,
            @NotificationTypeEnumConverter() NotificationType type,
            String headerImagePath,
            String title,
            String contents,
            @DateTimeConverter() DateTime sendAt,
            @DateTimeConverter() DateTime savedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationContent():
        return $default(_that.id, _that.type, _that.headerImagePath,
            _that.title, _that.contents, _that.sendAt, _that.savedAt);
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
            String id,
            @NotificationTypeEnumConverter() NotificationType type,
            String headerImagePath,
            String title,
            String contents,
            @DateTimeConverter() DateTime sendAt,
            @DateTimeConverter() DateTime savedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationContent() when $default != null:
        return $default(_that.id, _that.type, _that.headerImagePath,
            _that.title, _that.contents, _that.sendAt, _that.savedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NotificationContent extends NotificationContent {
  const _NotificationContent(
      {required this.id,
      @NotificationTypeEnumConverter() required this.type,
      required this.headerImagePath,
      required this.title,
      required this.contents,
      @DateTimeConverter() required this.sendAt,
      @DateTimeConverter() required this.savedAt})
      : super._();
  factory _NotificationContent.fromJson(Map<String, dynamic> json) =>
      _$NotificationContentFromJson(json);

  @override
  final String id;
//firestoreで自動で割り振られるID
  @override
  @NotificationTypeEnumConverter()
  final NotificationType type;
  @override
  final String headerImagePath;
//firestore databaseに保存されているpngファイル名（.pngを抜いて）
  @override
  final String title;
  @override
  final String contents;
  @override
  @DateTimeConverter()
  final DateTime sendAt;
  @override
  @DateTimeConverter()
  final DateTime savedAt;

  /// Create a copy of NotificationContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotificationContentCopyWith<_NotificationContent> get copyWith =>
      __$NotificationContentCopyWithImpl<_NotificationContent>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NotificationContentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationContent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.headerImagePath, headerImagePath) ||
                other.headerImagePath == headerImagePath) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.contents, contents) ||
                other.contents == contents) &&
            (identical(other.sendAt, sendAt) || other.sendAt == sendAt) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, headerImagePath, title, contents, sendAt, savedAt);

  @override
  String toString() {
    return 'NotificationContent(id: $id, type: $type, headerImagePath: $headerImagePath, title: $title, contents: $contents, sendAt: $sendAt, savedAt: $savedAt)';
  }
}

/// @nodoc
abstract mixin class _$NotificationContentCopyWith<$Res>
    implements $NotificationContentCopyWith<$Res> {
  factory _$NotificationContentCopyWith(_NotificationContent value,
          $Res Function(_NotificationContent) _then) =
      __$NotificationContentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @NotificationTypeEnumConverter() NotificationType type,
      String headerImagePath,
      String title,
      String contents,
      @DateTimeConverter() DateTime sendAt,
      @DateTimeConverter() DateTime savedAt});
}

/// @nodoc
class __$NotificationContentCopyWithImpl<$Res>
    implements _$NotificationContentCopyWith<$Res> {
  __$NotificationContentCopyWithImpl(this._self, this._then);

  final _NotificationContent _self;
  final $Res Function(_NotificationContent) _then;

  /// Create a copy of NotificationContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? headerImagePath = null,
    Object? title = null,
    Object? contents = null,
    Object? sendAt = null,
    Object? savedAt = null,
  }) {
    return _then(_NotificationContent(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      headerImagePath: null == headerImagePath
          ? _self.headerImagePath
          : headerImagePath // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      contents: null == contents
          ? _self.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String,
      sendAt: null == sendAt
          ? _self.sendAt
          : sendAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      savedAt: null == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
