import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:clean_architecture/domain/usecase/get_post.dart';
import 'package:clean_architecture/domain/entities/post_entity.dart';
import 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this.getListPost) : super(PostInitial());

  final GetPost getListPost;
  static final controller = RefreshController();

  getPostList() async {
    final result = await getListPost.fetchPost(1);
    result.fold((l) {
      emit(PostError(l.toString()));
      controller.refreshCompleted();
    }, (r) {
      emit(PostLoaded(r, "Sukses data didapatkan"));
      controller.refreshCompleted();
    });
  }

  getRefresh() {
    getPostList();
  }

  getLoadMore() async {
    var myState = state as PostLoaded;
    int totalPages = myState.pages + 1;

    final result = await getListPost.fetchPost(totalPages);
    result.fold((l) {
      emit(PostError(l.toString()));
      controller.loadComplete();
    }, (r) {
      List<PostEntity> old = myState.list;
      List<PostEntity> result = [...old, ...r];

      emit(PostLoaded(result, "Sukses data didapatkan", pages: totalPages));
      controller.loadComplete();
    });
  }
}