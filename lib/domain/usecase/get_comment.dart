import 'package:clean_architecture/domain/entities/comment_entity.dart';
import 'package:clean_architecture/domain/repositories/repositories_domain.dart';
import 'package:dartz/dartz.dart';

class GetComment {
  final RepositoriesDomain repositoriesDomain;

  GetComment(this.repositoriesDomain);

  Future <Either<String, List<CommentEntity>>> fetchComment(int id){
    return repositoriesDomain.getComment(id);
  }
}