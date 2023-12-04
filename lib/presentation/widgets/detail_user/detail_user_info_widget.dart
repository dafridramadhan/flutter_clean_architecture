import 'package:clean_architecture/domain/entities/detail_user_entity.dart';
import 'package:flutter/material.dart';

class DetailUserInfoWidget extends StatelessWidget {
  final DetailUserEntity detailUser;

  const DetailUserInfoWidget({required this.detailUser, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                detailUser.picture,
                width: 110,
                height: 126,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(detailUser.title,
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
                    Text(
                        '${detailUser.firstName} ${detailUser.lastName}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(detailUser.gender,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                    Text(detailUser.email,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(detailUser.dateOfBirth,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Text('Location',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
          const SizedBox(
            height: 24,
          ),
          Text(detailUser.location.state,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
          Text(detailUser.location.timezone,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          Text(detailUser.location.country,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          Text(detailUser.location.city,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          Text(detailUser.location.street,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
