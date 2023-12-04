import 'package:clean_architecture/common/routes.dart';
import 'package:clean_architecture/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  final UserEntity data;

  const UserListItem({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MyRoute.detailUser, arguments: {'id': data.id});
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            Image.network(
              data.picture,
              width: 110,
              height: 126,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
                Text(
                  '${data.firstName} ${data.lastName}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
