import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:clean_architecture/domain/usecase/get_comment.dart';
import 'package:clean_architecture/domain/entities/comment_entity.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit(this.getListComment) : super(CommentInitial());

  final GetComment getListComment;
  static final controller = RefreshController();

  getCommentList() async {
    final result = await getListComment.fetchComment(1);
    result.fold((l) {
      emit(CommentError(l.toString()));
      controller.refreshCompleted();
    }, (r) {
      emit(CommentLoaded(r, "List comment berhasil diload"));
      controller.refreshCompleted();
    });
  }

  getRefresh() async {
    getCommentList();
  }

  getLoadMore() async {
    var myState = state as CommentLoaded;
    int currentPages = myState.pages + 1;

    final result = await getListComment.fetchComment(currentPages);
    result.fold((l) {
      emit(CommentError(l.toString()));
      controller.loadComplete();
    }, (r) {
      List<CommentEntity> old = myState.list;
      List<CommentEntity> result = [...old, ...r];

      emit(CommentLoaded(result, "List comment berhasil diload",
          pages: currentPages));
      controller.loadComplete();
    });
  }
}