import 'package:clean_architecture/presentation/cubit/detail_user/detail_user_cubit.dart';
import 'package:clean_architecture/presentation/widgets/detail_user/detail_user_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/custom_error.dart';
import '../../common/custom_loading.dart';
import '../../domain/entities/detail_user_entity.dart';
import '../../injection.dart' as git;

class DetailUserScreen extends StatelessWidget {
  const DetailUserScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text(
        'Detail User',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white70,
    ),
      body: BlocProvider(
        create: (_) => git.locator<DetailUserCubit>()..getUserDetail(id),
        child: BlocBuilder<DetailUserCubit, DetailUserState>(
          builder: (context, state) {
            if (state is DetailUserLoaded) {
              DetailUserEntity data = state.list;
              return DetailUserInfoWidget(detailUser: data);
            } else if (state is DetailUserError) {
              return CustomError(message: state.message);
            }
            return const CustomLoading();
          },
        ),
      ),
    );
  }
}