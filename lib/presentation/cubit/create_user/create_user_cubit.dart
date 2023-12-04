import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:clean_architecture/common/input_create_user.dart';
import 'package:clean_architecture/domain/entities/create_user_entity.dart';
import 'package:clean_architecture/domain/usecase/get_create_user.dart';
import 'package:clean_architecture/common/enum_status.dart';

part 'create_user_state.dart';

class CreateUserCubit extends Cubit<CreateUserState> {
  CreateUserCubit(this.getCreateUser) : super(CreateUserInitial());

  final GetCreateUser getCreateUser;
  static final first = TextEditingController();
  static final last = TextEditingController();
  static final email = TextEditingController();

  init() {
    emit(CreateUserLoaded(null, "Hit initial in loaded", EnumStatus.empty));
  }

  fetchUserCreate(BuildContext context) async {
    emit(CreateUserLoaded(null, "Create account....", EnumStatus.loading));
    final input = InputCreateUser(
        firstName: first.text, lastName: last.text, email: email.text);
    final result = await getCreateUser.fetchCreateUser(input);
    result.fold((l) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Register Gagal")));
      emit(CreateUserError(l.toString(), EnumStatus.error));
    }, (r) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Berhasil membuat akun")));
      emit(CreateUserLoaded(r, "Berhasil membuat akun", EnumStatus.loaded));
    });
  }
}