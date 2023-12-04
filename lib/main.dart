import 'package:clean_architecture/common/routes.dart';
import 'package:clean_architecture/presentation/cubit/create_user/create_user_cubit.dart';
import 'package:clean_architecture/presentation/cubit/detail_user/detail_user_cubit.dart';
import 'package:clean_architecture/presentation/cubit/comment/comment_cubit.dart';
import 'package:clean_architecture/presentation/cubit/post/post_cubit.dart';
import 'package:clean_architecture/presentation/cubit/user/user_cubit.dart';
import 'package:clean_architecture/presentation/pages/create_user_screen.dart';
import 'package:clean_architecture/presentation/pages/detail_user_screen.dart';
import 'package:clean_architecture/presentation/pages/comment_screen.dart';
import 'package:clean_architecture/presentation/pages/post_screen.dart';
import 'package:clean_architecture/presentation/pages/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection.dart' as git;

void main() {
  git.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => git.locator<CreateUserCubit>()..init()),
          BlocProvider(create: (_) => git.locator<DetailUserCubit>()),
          BlocProvider(create: (_) => git.locator<CommentCubit>()),
          BlocProvider(create: (_) => git.locator<PostCubit>()),
          BlocProvider(create: (_) => git.locator<UserCubit>()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const CreateUserScreen(),
            initialRoute: '/',
            onGenerateRoute: (routes) {
              switch (routes.name) {
                case MyRoute.listPost:
                  return MaterialPageRoute(builder: (_) => const PostScreen());
                case MyRoute.listComment:
                  return MaterialPageRoute(builder: (_) => const CommentScreen());
                case MyRoute.listUser:
                  return MaterialPageRoute(builder: (_) => const UserScreen());
                case MyRoute.detailUser:
                  final id = routes.arguments as Map;
                  return MaterialPageRoute(
                      builder: (_) => DetailUserScreen(id: id['id']));
                default:
                  return MaterialPageRoute(
                      builder: (_) =>  const Center(
                        child: Text('Halaman tidak ditemukan'),
                      ));
              }
            }));
  }
}