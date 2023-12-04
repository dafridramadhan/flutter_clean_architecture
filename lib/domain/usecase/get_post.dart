import 'package:clean_architecture/domain/entities/post_entity.dart';
import 'package:clean_architecture/domain/repositories/repositories_domain.dart';
import 'package:dartz/dartz.dart';

class GetPost {
  final RepositoriesDomain repositoriesDomain;

  GetPost(this.repositoriesDomain);

  Future<Either<String, List<PostEntity>>> fetchPost(int id){
    return repositoriesDomain.getPost(id);
  }
}