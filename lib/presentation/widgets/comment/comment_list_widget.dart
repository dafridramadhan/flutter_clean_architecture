import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:clean_architecture/domain/entities/comment_entity.dart';
import 'package:clean_architecture/presentation/cubit/comment/comment_cubit.dart';

class CommentListWidget extends StatelessWidget {
  final List<CommentEntity> commentList;

  const CommentListWidget({required this.commentList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullUp: true,
      enablePullDown: true,
      onRefresh: () => context.read<CommentCubit>()..getRefresh(),
      onLoading: () => context.read<CommentCubit>()..getLoadMore(),
      controller: CommentCubit.controller,
      child: ListView.builder(
        itemCount: commentList.length,
        itemBuilder: (BuildContext context, int index) {
          CommentEntity data = commentList[index];
          return _buildCommentItem(data);
        },
      ),
    );
  }

  Widget _buildCommentItem(CommentEntity data) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${data.owner.firstName} ${data.owner.lastName}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(data.publishDate)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            data.message,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
