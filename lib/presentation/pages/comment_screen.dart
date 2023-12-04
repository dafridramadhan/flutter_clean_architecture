import 'package:clean_architecture/presentation/widgets/comment/comment_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/custom_error.dart';
import '../../common/custom_loading.dart';
import '../../injection.dart' as git;
import 'package:clean_architecture/presentation/cubit/comment/comment_cubit.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text(
        'List Comment',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white70,
    ),
      body: BlocProvider(
        create: (_) => git.locator<CommentCubit>()..getCommentList(),
        child: BlocBuilder<CommentCubit, CommentState>(
          builder: (context, state) {
            if (state is CommentLoaded) {
              return _buildCommentList(state);
            } else if (state is CommentError) {
              return CustomError(message: state.message);
            }
            return const CustomLoading();
          },
        ),
      ),
    );
  }

  Widget _buildCommentList(CommentLoaded state) {
    return CommentListWidget(commentList: state.list);
  }
}
