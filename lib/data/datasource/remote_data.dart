import 'package:clean_architecture/common/input_create_user.dart';
import 'package:clean_architecture/data/model/create_user_model.dart';
import 'package:clean_architecture/data/model/detail_user_model.dart';
import 'package:clean_architecture/data/model/user_model.dart';
import 'package:clean_architecture/data/model/post_model.dart';
import 'package:clean_architecture/data/model/comment_model.dart';

abstract class RemoteData {
  Future<List<UserModel>> userModel(int pages);
  Future<List<PostModel>> postModel(int pages);
  Future<List<CommentModel>> commentModel(int pages);
  Future<DetailUserModel> detailUserModel(String id);
  Future<CreateUserModel> createUserModel(InputCreateUser icu);
}