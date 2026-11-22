import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1. Импорт маршрутов
import 'package:project/src/app/routes.dart'; // или просто 'routes.dart', если файл лежит в той же папке

// 2. Импорт BLoC и Cubit (нужны для MultiBlocProvider)
import 'package:project/src/features/auth/application/auth_bloc.dart';
import 'package:project/src/features/home/application/home_cubit.dart';

// 3. Импорт всех экранов (presentation)
import 'package:project/src/features/loading/loading_page.dart';
import 'package:project/src/features/auth/presentation/login_page.dart';
import 'package:project/src/features/auth/presentation/register_page.dart';
import 'package:project/src/features/home/presentation/home_page.dart';
import 'package:project/src/features/profile/presentation/profile_page.dart';
import 'package:project/src/features/detail/presentation/detail_page.dart';

import '../features/loading/loading_page.dart';

class EventPlannerApp extends StatelessWidget {
  const EventPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => HomeCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Планировщик мероприятий',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          fontFamily: 'CustomEventFont',
        ),
        initialRoute: Routes.loading,
        routes: {
          Routes.loading: (_) => const LoadingPage(),
          Routes.login: (_) => const LoginPage(),
          Routes.register: (_) => const RegisterPage(),
          Routes.home: (_) => const HomePage(),
          Routes.profile: (_) => const ProfilePage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == Routes.detail) {
            final args = settings.arguments as Map<String, dynamic>? ?? {};
            return MaterialPageRoute(
              builder: (_) => DetailPage(
                title: args['title'] as String? ?? 'Детали',
                description: args['description'] as String? ?? '',
                imagePath: args['imagePath'] as String?,
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}