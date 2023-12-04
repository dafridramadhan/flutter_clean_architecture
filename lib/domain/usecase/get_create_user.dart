import 'package:clean_architecture/common/input_create_user.dart';
import 'package:clean_architecture/domain/entities/create_user_entity.dart';
import 'package:clean_architecture/domain/repositories/repositories_domain.dart';
import 'package:dartz/dartz.dart';

class GetCreateUser {
  final RepositoriesDomain repositoriesDomain;

  GetCreateUser(this.repositoriesDomain);

  Future<Either<String, CreateUserEntity>> fetchCreateUser(InputCreateUser icu){
    return repositoriesDomain.getCreateUser(icu);
  }
}