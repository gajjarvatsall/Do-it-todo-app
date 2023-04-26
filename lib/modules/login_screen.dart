import 'package:doit/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is GoogleSignInState && state.isCompleted) {
            Navigator.pushNamed(context, '/homeScreen');
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset('assets/images/login_img.svg'),
              ElevatedButton(
                  onPressed: () {
                    _authenticateWithGoogle(context);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(70, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text("Continue with Google"))
            ],
          );
        },
      ),
    );
  }
}
