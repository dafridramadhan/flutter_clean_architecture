import 'package:clean_architecture/common/custom_error.dart';
import 'package:clean_architecture/common/custom_loading.dart';
import 'package:clean_architecture/presentation/cubit/post/post_cubit.dart';
import 'package:clean_architecture/presentation/cubit/post/post_state.dart';
import 'package:clean_architecture/presentation/widgets/post/post_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../injection.dart' as git;

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text(
        'List Post',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white70,
    ),
      body: BlocProvider(
        create: (_) => git.locator<PostCubit>()..getPostList(),
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if (state is PostLoaded) {
              return _buildPostList(context, state);
            } else if (state is PostError) {
              return CustomError(message: state.message);
            }
            return const CustomLoading();
          },
        ),
      ),
    );
  }

  Widget _buildPostList(BuildContext context, PostLoaded state) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: () => context.read<PostCubit>()..getRefresh(),
      onLoading: () => context.read<PostCubit>()..getLoadMore(),
      controller: PostCubit.controller,
      child: PostListWidget(postList: state.list),
    );
  }
}