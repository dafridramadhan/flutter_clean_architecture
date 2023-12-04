import 'package:clean_architecture/data/repositories/remote_data_implementation.dart';
import 'package:clean_architecture/data/repositories/repositories_domain_implementation.dart';
import 'package:clean_architecture/domain/repositories/repositories_domain.dart';
import 'package:clean_architecture/domain/usecase/get_create_user.dart';
import 'package:clean_architecture/domain/usecase/get_detail_user.dart';
import 'package:clean_architecture/domain/usecase/get_comment.dart';
import 'package:clean_architecture/domain/usecase/get_post.dart';
import 'package:clean_architecture/domain/usecase/get_user.dart';
import 'package:clean_architecture/presentation/cubit/create_user/create_user_cubit.dart';
import 'package:clean_architecture/presentation/cubit/detail_user/detail_user_cubit.dart';
import 'package:clean_architecture/presentation/cubit/comment/comment_cubit.dart';
import 'package:clean_architecture/presentation/cubit/post/post_cubit.dart';
import 'package:clean_architecture/presentation/cubit/user/user_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final locator = GetIt.instance;

void initialize() {
  //use case
  locator.registerFactory(() => GetCreateUser(locator()));
  locator.registerFactory(() => GetDetailUser(locator()));
  locator.registerFactory(() => GetComment(locator()));
  locator.registerFactory(() => GetPost(locator()));
  locator.registerFactory(() => GetUser(locator()));

  //state manage cubit
  locator.registerFactory(() => UserCubit(locator()));
  locator.registerFactory(() => PostCubit(locator()));
  locator.registerFactory(() => CommentCubit(locator()));
  locator.registerFactory(() => DetailUserCubit(locator()));
  locator.registerFactory(() => CreateUserCubit(locator()));

  //repository domain impl
  locator.registerFactory<RepositoriesDomain>(
      () => RepositoriesDomainImplementation(locator()));

  //repository remote data
  locator.registerFactory(() => RemoteDataImplementation(locator()));

  // external library
  locator.registerFactory(() => Client());
}