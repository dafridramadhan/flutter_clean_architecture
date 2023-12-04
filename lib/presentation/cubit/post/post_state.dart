import 'package:flutter/cupertino.dart';

import 'package:clean_architecture/domain/entities/post_entity.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoaded extends PostState {
  final List<PostEntity> list;
  final String message;
  final int pages;

  PostLoaded(this.list, this.message, {this.pages = 1});
}

class PostError extends PostState {
  final String message;
  PostError(this.message);
}