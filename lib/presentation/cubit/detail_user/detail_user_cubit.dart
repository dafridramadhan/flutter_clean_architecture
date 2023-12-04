import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:clean_architecture/domain/usecase/get_detail_user.dart';
import 'package:clean_architecture/domain/entities/detail_user_entity.dart';

part 'detail_user_state.dart';

class DetailUserCubit extends Cubit<DetailUserState> {
  DetailUserCubit(this.getDetailUser) : super(DetailUserInitial());

  final GetDetailUser getDetailUser;

  getUserDetail(String id) async {
    final result = await getDetailUser.fetchDetailUser(id);
    result.fold((l) {
      emit(DetailUserError(l.toString()));
    }, (r) {
      emit(DetailUserLoaded(r, "Detail user berhasil diload"));
    });
  }
}