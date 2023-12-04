import 'package:clean_architecture/common/input_create_user.dart';
import 'package:clean_architecture/data/repositories/remote_data_implementation.dart';
import 'package:clean_architecture/domain/entities/comment_entity.dart';
import 'package:clean_architecture/domain/entities/create_user_entity.dart';
import 'package:clean_architecture/domain/entities/detail_user_entity.dart';
import 'package:clean_architecture/domain/entities/post_entity.dart';
import 'package:clean_architecture/domain/entities/user_entity.dart';
import 'package:clean_architecture/domain/repositories/repositories_domain.dart';
import 'package:dartz/dartz.dart';

class RepositoriesDomainImplementation implements RepositoriesDomain {
  final RemoteDataImplementation remoteDataImplementation;

  RepositoriesDomainImplementation(this.remoteDataImplementation);

  Future<Either<String, T>> _handleError<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CreateUserEntity>> getCreateUser(
      InputCreateUser icu) async {
    return _handleError(() => remoteDataImplementation
        .createUserModel(icu)
        .then((result) => result.toEntity()));
  }

  @override
  Future<Either<String, DetailUserEntity>> getDetailUser(String id) async {
    return _handleError(() => remoteDataImplementation
        .detailUserModel(id)
        .then((result) => result.toEntity()));
  }

  @override
  Future<Either<String, List<CommentEntity>>> getComment(int id) async {
    return _handleError(() => remoteDataImplementation
        .commentModel(id)
        .then((result) => result.map((e) => e.toEntity()).toList()));
  }

  @override
  Future<Either<String, List<PostEntity>>> getPost(int id) async {
    return _handleError(() => remoteDataImplementation
        .postModel(id)
        .then((result) => result.map((e) => e.toEntity()).toList()));
  }

  @override
  Future<Either<String, List<UserEntity>>> getUser(int id) async {
    return _handleError(() => remoteDataImplementation
        .userModel(id)
        .then((result) => result.map((e) => e.toEntity()).toList()));
  }
}
