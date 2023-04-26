import 'package:doit/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _accountSignOut(context) {
    BlocProvider.of<AuthBloc>(context).add(
      SignOutRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Center(child: Text("Home Screen"))],
      ),
      floatingActionButton: ElevatedButton(
        child: Text("Sign Out"),
        onPressed: () {
          _accountSignOut(context);
          Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (route) => false);
        },
      ),
    );
  }
}
