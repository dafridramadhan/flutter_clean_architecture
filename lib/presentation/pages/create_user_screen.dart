import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_architecture/common/enum_status.dart';
import 'package:clean_architecture/common/routes.dart';
import 'package:clean_architecture/presentation/cubit/create_user/create_user_cubit.dart';
import 'package:clean_architecture/presentation/widgets/create_user/action_button_widget.dart';
import 'package:clean_architecture/presentation/widgets/create_user/navigation_button_widget.dart';
import 'package:clean_architecture/presentation/widgets/create_user/text_field_widget.dart';

class CreateUserScreen extends StatelessWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white70,
      ),
      body: BlocBuilder<CreateUserCubit, CreateUserState>(
        builder: (context, state) {
          if (state is CreateUserLoaded) {
            return _buildLoadedUI(context, state);
          } else if (state is CreateUserError) {
            return const Center(
              child: Text('Error'),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildLoadedUI(BuildContext context, CreateUserLoaded state) {
    return Column(
      children: [
        const SizedBox(height: 30),
        CustomTextField(
            hintText: 'First name', controller: CreateUserCubit.first),
        CustomTextField(
            hintText: 'Last name', controller: CreateUserCubit.last),
        CustomTextField(
            hintText: 'Email', controller: CreateUserCubit.email),
        const SizedBox(height: 40),
        ActionButton(
          text: 'Create Account',
          onTap: state.enumStatus != EnumStatus.loading
              ? () {
                  context.read<CreateUserCubit>().fetchUserCreate(context);
                }
              : null,
          isLoading: state.enumStatus == EnumStatus.loading,
        ),
        const SizedBox(height: 40),
        NavigationButton(
          text: 'Lihat Post',
          context: context,
          route: MyRoute.listPost,
        ),
        const SizedBox(height: 12),
        NavigationButton(
          text: 'Lihat Comment',
          context: context,
          route: MyRoute.listComment,
        ),
        const SizedBox(height: 12),
        NavigationButton(
          text: 'Lihat User',
          context: context,
          route: MyRoute.listUser,
        ),
      ],
    );
  }
}
