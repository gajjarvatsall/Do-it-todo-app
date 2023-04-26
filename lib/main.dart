import 'package:doit/bloc/auth_bloc.dart';
import 'package:doit/modules/home_screen.dart';
import 'package:doit/modules/login_screen.dart';
import 'package:doit/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(authRepository: RepositoryProvider.of<AuthRepository>(context)),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/loginScreen',
          routes: {
            '/loginScreen': (context) => const loginScreen(),
            // '/signIn': (context) => const signInScreen(),
            '/homeScreen': (context) => const HomeScreen(),
          },
        ),
      ),
    );
  }
}
