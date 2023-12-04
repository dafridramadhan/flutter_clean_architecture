part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final List<UserEntity> list;
  final String message;
  final int pages;

  UserLoaded(this.list, this.message, {this.pages = 1});
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}