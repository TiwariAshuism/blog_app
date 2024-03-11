import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImp(this.remoteDataSource);
  @override
  Future<Either<Failure, String>> loginUpWithEmailPassword(
      {required String email, required String password, required String name}) {
    // TODO: implement loginUpWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final userID = await remoteDataSource.signUpWithEmailPassword(
          email: email, password: password, name: name);
      return right(userID);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
