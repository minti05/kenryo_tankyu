import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:kenryo_tankyu/features/auth/data/repositories/user_repository_impl.dart';
import 'package:kenryo_tankyu/features/auth/domain/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_provider.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepositoryImpl(ref.watch(firebaseFirestoreProvider));
}
