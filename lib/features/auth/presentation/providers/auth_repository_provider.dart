import 'package:kenryo_tankyu/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:kenryo_tankyu/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kenryo_tankyu/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider));
}
