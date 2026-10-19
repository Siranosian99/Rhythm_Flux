import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhythm_flux/features/auth/auth_cubit.dart';
import 'package:rhythm_flux/features/score/score_cubit.dart';
import 'package:rhythm_flux/screens/splash_screen.dart';
import 'features/score/score_repository.dart';
import 'features/user/user_cubit.dart';
import 'features/user/user_repository.dart';
import 'core/network/dio_client.dart';
import 'features/auth/auth_repository.dart';

void main() {
  final dioClient = DioClient();

  final authRepository = AuthRepository(
    dio: dioClient.dio,
    tokenHelper: dioClient.tokenHelper,
  );

  dioClient.addAuthInterceptor(
    refreshAccessToken: authRepository.refreshAccessToken,
  );

  final userRepository = UserRepository(
    dio: dioClient.dio, tokenHelper: dioClient.tokenHelper,
  );

  final scoreRepository = ScoreRepository(
    dio: dioClient.dio, tokenHelper: dioClient.tokenHelper,
  );
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (_) => AudioProvider(),
  //     child: const MyApp(),
  //   ),
  // );
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(
          value: authRepository,
        ),
        RepositoryProvider<UserRepository>.value(
          value: userRepository,
        ),
        RepositoryProvider<ScoreRepository>.value(
          value: scoreRepository,
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => UserCubit(repository: userRepository),
        ),
        BlocProvider(
          create: (context) => ScoreCubit(repository: scoreRepository),
        ),
        BlocProvider(
          create: (context) => AuthCubit(repository: authRepository),
        ),
      ], child: const MyApp(),)
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rhythm Flux',
      theme: ThemeData(
        appBarTheme:AppBarThemeData(
          backgroundColor:Colors.black
        ),
        scaffoldBackgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:const SplashScreen()
    );
  }
}
