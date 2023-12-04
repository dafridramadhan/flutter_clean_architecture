import 'package:clean_architecture/domain/entities/post_entity.dart';
import 'package:flutter/material.dart';

class PostListWidget extends StatelessWidget {
  final List<PostEntity> postList;

  const PostListWidget({required this.postList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: postList.length,
      itemBuilder: (BuildContext context, int index) {
        PostEntity data = postList[index];
        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              Image.network(
                data.image,
                width: 110,
                height: 126,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(child: Text(data.text)),
            ],
          ),
        );
      },
    );
  }
}
