import 'package:doit/modules/home_screen/home_screen.dart';
import 'package:doit/modules/login_screen/bloc/auth_bloc.dart';
import 'package:doit/modules/login_screen/login_screen.dart';
import 'package:doit/modules/login_screen/repository/auth_repository.dart';
import 'package:doit/modules/tasks_screen/Bloc/task_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Stream<User?> authState;

  @override
  void initState() {
    authState = FirebaseAuth.instance.authStateChanges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(authRepository: RepositoryProvider.of<AuthRepository>(context)),
          ),
          BlocProvider(
            create: (context) => TaskBloc(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.black,
            useMaterial3: true,
            fontFamily: 'Sequel',
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: authState,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomeScreen();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return const LoginScreen();
            },
          ),
          routes: {
            '/loginScreen': (context) => const LoginScreen(),
            '/homeScreen': (context) => const HomeScreen(),
          },
        ),
      ),
    );
  }
}
