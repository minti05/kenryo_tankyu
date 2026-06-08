// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserStats {
  int get todayViews;
  int get weekViews;
  int get totalViews;
  int get streakDays;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserStatsCopyWith<UserStats> get copyWith =>
      _$UserStatsCopyWithImpl<UserStats>(this as UserStats, _$identity);

  /// Serializes this UserStats to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserStats &&
            (identical(other.todayViews, todayViews) ||
                other.todayViews == todayViews) &&
            (identical(other.weekViews, weekViews) ||
                other.weekViews == weekViews) &&
            (identical(other.totalViews, totalViews) ||
                other.totalViews == totalViews) &&
            (identical(other.streakDays, streakDays) ||
                other.streakDays == streakDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, todayViews, weekViews, totalViews, streakDays);

  @override
  String toString() {
    return 'UserStats(todayViews: $todayViews, weekViews: $weekViews, totalViews: $totalViews, streakDays: $streakDays)';
  }
}

/// @nodoc
abstract mixin class $UserStatsCopyWith<$Res> {
  factory $UserStatsCopyWith(UserStats value, $Res Function(UserStats) _then) =
      _$UserStatsCopyWithImpl;
  @useResult
  $Res call({int todayViews, int weekViews, int totalViews, int streakDays});
}

/// @nodoc
class _$UserStatsCopyWithImpl<$Res> implements $UserStatsCopyWith<$Res> {
  _$UserStatsCopyWithImpl(this._self, this._then);

  final UserStats _self;
  final $Res Function(UserStats) _then;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todayViews = null,
    Object? weekViews = null,
    Object? totalViews = null,
    Object? streakDays = null,
  }) {
    return _then(_self.copyWith(
      todayViews: null == todayViews
          ? _self.todayViews
          : todayViews // ignore: cast_nullable_to_non_nullable
              as int,
      weekViews: null == weekViews
          ? _self.weekViews
          : weekViews // ignore: cast_nullable_to_non_nullable
              as int,
      totalViews: null == totalViews
          ? _self.totalViews
          : totalViews // ignore: cast_nullable_to_non_nullable
              as int,
      streakDays: null == streakDays
          ? _self.streakDays
          : streakDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserStats].
extension UserStatsPatterns on UserStats {
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
    TResult Function(_UserStats value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserStats() when $default != null:
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
    TResult Function(_UserStats value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserStats():
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
    TResult? Function(_UserStats value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserStats() when $default != null:
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
            int todayViews, int weekViews, int totalViews, int streakDays)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserStats() when $default != null:
        return $default(_that.todayViews, _that.weekViews, _that.totalViews,
            _that.streakDays);
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
            int todayViews, int weekViews, int totalViews, int streakDays)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserStats():
        return $default(_that.todayViews, _that.weekViews, _that.totalViews,
            _that.streakDays);
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
            int todayViews, int weekViews, int totalViews, int streakDays)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserStats() when $default != null:
        return $default(_that.todayViews, _that.weekViews, _that.totalViews,
            _that.streakDays);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserStats implements UserStats {
  const _UserStats(
      {required this.todayViews,
      required this.weekViews,
      required this.totalViews,
      required this.streakDays});
  factory _UserStats.fromJson(Map<String, dynamic> json) =>
      _$UserStatsFromJson(json);

  @override
  final int todayViews;
  @override
  final int weekViews;
  @override
  final int totalViews;
  @override
  final int streakDays;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserStatsCopyWith<_UserStats> get copyWith =>
      __$UserStatsCopyWithImpl<_UserStats>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserStatsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserStats &&
            (identical(other.todayViews, todayViews) ||
                other.todayViews == todayViews) &&
            (identical(other.weekViews, weekViews) ||
                other.weekViews == weekViews) &&
            (identical(other.totalViews, totalViews) ||
                other.totalViews == totalViews) &&
            (identical(other.streakDays, streakDays) ||
                other.streakDays == streakDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, todayViews, weekViews, totalViews, streakDays);

  @override
  String toString() {
    return 'UserStats(todayViews: $todayViews, weekViews: $weekViews, totalViews: $totalViews, streakDays: $streakDays)';
  }
}

/// @nodoc
abstract mixin class _$UserStatsCopyWith<$Res>
    implements $UserStatsCopyWith<$Res> {
  factory _$UserStatsCopyWith(
          _UserStats value, $Res Function(_UserStats) _then) =
      __$UserStatsCopyWithImpl;
  @override
  @useResult
  $Res call({int todayViews, int weekViews, int totalViews, int streakDays});
}

/// @nodoc
class __$UserStatsCopyWithImpl<$Res> implements _$UserStatsCopyWith<$Res> {
  __$UserStatsCopyWithImpl(this._self, this._then);

  final _UserStats _self;
  final $Res Function(_UserStats) _then;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? todayViews = null,
    Object? weekViews = null,
    Object? totalViews = null,
    Object? streakDays = null,
  }) {
    return _then(_UserStats(
      todayViews: null == todayViews
          ? _self.todayViews
          : todayViews // ignore: cast_nullable_to_non_nullable
              as int,
      weekViews: null == weekViews
          ? _self.weekViews
          : weekViews // ignore: cast_nullable_to_non_nullable
              as int,
      totalViews: null == totalViews
          ? _self.totalViews
          : totalViews // ignore: cast_nullable_to_non_nullable
              as int,
      streakDays: null == streakDays
          ? _self.streakDays
          : streakDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
