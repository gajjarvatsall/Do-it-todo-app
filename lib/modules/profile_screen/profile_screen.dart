import 'package:doit/modules/login_screen/bloc/auth_bloc.dart';
import 'package:doit/widgets/elevated_icon_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;

  void _accountSignOut(context) {
    BlocProvider.of<AuthBloc>(context).add(
      SignOutRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          const Text("User Profile"),
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage(
              "${auth.currentUser!.photoURL}",
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          Text(
            "${auth.currentUser!.displayName}",
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "${auth.currentUser!.email}",
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              height: MediaQuery.of(context).size.height / 7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [const Text("Pending Tasks"), const Text("2")],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      color: Colors.black,
                      width: 0.5,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [const Text("Completed Tasks"), const Text("5")],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomElevatedButtonIcon(
              onTap: () {
                _accountSignOut(context);
                Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (route) => false);
              },
              text: "Sign Out",
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}
