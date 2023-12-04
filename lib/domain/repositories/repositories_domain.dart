import 'package:clean_architecture/common/input_create_user.dart';
import 'package:clean_architecture/domain/entities/comment_entity.dart';
import 'package:clean_architecture/domain/entities/create_user_entity.dart';
import 'package:clean_architecture/domain/entities/detail_user_entity.dart';
import 'package:clean_architecture/domain/entities/post_entity.dart';
import 'package:clean_architecture/domain/entities/user_entity.dart';

import 'package:dartz/dartz.dart';

abstract class RepositoriesDomain {
  Future<Either<String, List<UserEntity>>> getUser(int pages);
  Future<Either<String, List<PostEntity>>> getPost(int id);
  Future<Either<String, List<CommentEntity>>> getComment(int id);
  Future<Either<String, CreateUserEntity>> getCreateUser(InputCreateUser icu);
  Future<Either<String, DetailUserEntity>> getDetailUser(String id);
}