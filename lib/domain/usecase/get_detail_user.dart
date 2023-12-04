import 'package:clean_architecture/domain/entities/detail_user_entity.dart';
import 'package:clean_architecture/domain/repositories/repositories_domain.dart';
import 'package:dartz/dartz.dart';

class GetDetailUser {
  final RepositoriesDomain repositoriesDomain;

  GetDetailUser(this.repositoriesDomain);

  Future <Either<String, DetailUserEntity>> fetchDetailUser(String id){
    return repositoriesDomain.getDetailUser(id);
  }
}