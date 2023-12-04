import 'package:clean_architecture/domain/entities/user_entity.dart';
import 'package:clean_architecture/domain/repositories/repositories_domain.dart';
import 'package:dartz/dartz.dart';

class GetUser {
  final RepositoriesDomain repositoriesDomain;

  GetUser(this.repositoriesDomain);

  Future<Either<String, List<UserEntity>>> fetchUser(int id){
    return repositoriesDomain.getUser(id);
  }
}