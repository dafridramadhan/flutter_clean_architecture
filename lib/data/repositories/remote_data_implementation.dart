import 'dart:convert';
import 'dart:developer';

import 'package:clean_architecture/common/constant.dart';
import 'package:clean_architecture/common/input_create_user.dart';
import 'package:clean_architecture/data/datasource/remote_data.dart';
import 'package:clean_architecture/data/model/comment_model.dart';
import 'package:clean_architecture/data/model/create_user_model.dart';
import 'package:clean_architecture/data/model/detail_user_model.dart';
import 'package:clean_architecture/data/model/post_model.dart';
import 'package:clean_architecture/data/model/user_model.dart';
import 'package:http/http.dart' as http;

class RemoteDataImplementation implements RemoteData {
  final http.Client client;

  RemoteDataImplementation(this.client);

  @override
  Future<CreateUserModel> createUserModel(InputCreateUser icu) async {
    final request = await http
        .post(Uri.parse("${Constant.baseURL}/user/create"), headers: {
      "app-id": Constant.appID
    }, body: {
      "firstName": icu.firstName,
      "lastName": icu.lastName,
      "email": icu.email
    });

    final response = jsonDecode(request.body);
    log("log register user: $response");
    return CreateUserModel.fromJson(response);
  }

  @override
  Future<DetailUserModel> detailUserModel(String id) async {
    final request = await http.get(Uri.parse("${Constant.baseURL}user/$id"),
        headers: {'app-id': Constant.appID});
    final response = jsonDecode(request.body);
    return DetailUserModel.fromJson(response);
  }

  @override
  Future<List<PostModel>> postModel(int pages) async {
    final request = await http.get(
        Uri.parse("${Constant.baseURL}post?page=${pages.toString()}&limit=14"),
        headers: {'app-id': Constant.appID});
    final response = jsonDecode(request.body);
    final List data = response['data'];
    return data.map((e) => PostModel.fromJson(e)).toList();
  }

  @override
  Future<List<UserModel>> userModel(int pages) async {
    final request = await http.get(
        Uri.parse("${Constant.baseURL}user?page=${pages.toString()}&limit=10"),
        headers: {'app-id': Constant.appID});
    final response = jsonDecode(request.body);
    final List data = response['data'];
    return data.map((e) => UserModel.fromJson(e)).toList();
  }

  @override
  Future<List<CommentModel>> commentModel(int pages) async {
    final request = await http.get(
        Uri.parse(
            "${Constant.baseURL}comment?page=${pages.toString()}&limit=14"),
        headers: {'app-id': Constant.appID});
    final response = jsonDecode(request.body);
    final List data = response['data'];
    return data.map((e) => CommentModel.fromJson(e)).toList();
  }
}
