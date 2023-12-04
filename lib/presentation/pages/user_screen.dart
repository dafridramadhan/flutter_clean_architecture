import 'package:clean_architecture/presentation/widgets/user/user_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/custom_error.dart';
import '../../common/custom_loading.dart';
import '../../domain/entities/user_entity.dart';
import '../../injection.dart' as git;
import 'package:clean_architecture/presentation/cubit/user/user_cubit.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List User',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white70,
      ),
      body: BlocProvider(
        create: (_) => git.locator<UserCubit>()..getUserList(),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              return SmartRefresher(
                controller: UserCubit.controller,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () => context.read<UserCubit>()..getRefresh(),
                onLoading: () => context.read<UserCubit>()..getLoadMore(),
                child: ListView.builder(
                  itemCount: state.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    UserEntity data = state.list[index];
                    return UserListItem(data: data);
                  },
                ),
              );
            } else if (state is UserError) {
              return CustomError(message: state.message);
            }
            return const CustomLoading();
          },
        ),
      ),
    );
  }
}
