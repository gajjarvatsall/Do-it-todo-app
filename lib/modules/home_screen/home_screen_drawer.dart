import 'package:doit/modules/login_screen/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenDrawer extends StatefulWidget {
  const HomeScreenDrawer({Key? key}) : super(key: key);

  @override
  State<HomeScreenDrawer> createState() => _HomeScreenDrawerState();
}

class _HomeScreenDrawerState extends State<HomeScreenDrawer> {
  final auth = FirebaseAuth.instance;

  void _accountSignOut(context) {
    BlocProvider.of<AuthBloc>(context).add(
      SignOutRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.grey[900]),
              currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(100), child: Image.network("${auth.currentUser!.photoURL}")),
              accountName: Text("${auth.currentUser!.displayName}"),
              accountEmail: Text(
                "${auth.currentUser!.email}",
                style: TextStyle(fontSize: 12),
              )),
          ListTile(
            title: const Text(
              "Sign Out",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              _accountSignOut(context);
              Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (route) => false);
            },
          )
        ],
      ),
    );
  }
}
