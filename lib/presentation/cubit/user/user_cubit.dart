import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:clean_architecture/domain/entities/user_entity.dart';
import 'package:clean_architecture/domain/usecase/get_user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.getListUser) : super(UserInitial());

  final GetUser getListUser;
  static final controller = RefreshController();

  getUserList() async {
    final result = await getListUser.fetchUser(1);
    result.fold((l) {
      emit(UserError(l.toString()));
      controller.refreshCompleted();
    }, (r) {
      emit(UserLoaded(r, "List user berhasil diload"));
      controller.refreshCompleted();
    });
  }

  getRefresh() {
    getUserList();
  }

  getLoadMore() async {
    var myState = state as UserLoaded;
    int currentPages = myState.pages + 1;

    final result = await getListUser.fetchUser(currentPages);
    result.fold((l) {
      emit(UserError(l.toString()));
      controller.loadComplete();
    }, (r) {
      List<UserEntity> old = myState.list;
      List<UserEntity> result = [...old, ...r];

      emit(UserLoaded(result, "List user berhasil diload",
          pages: currentPages));
      controller.loadComplete();
    });
  }
}