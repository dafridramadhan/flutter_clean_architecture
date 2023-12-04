part of 'comment_cubit.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoaded extends CommentState {
  final List<CommentEntity> list;
  final String message;
  final int pages;

  CommentLoaded(this.list, this.message, {this.pages = 1});
}

class CommentError extends CommentState {
  final String message;

  CommentError(this.message);
}