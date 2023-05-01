import 'package:doit/modules/home_screen/home_screen.dart';
import 'package:doit/modules/login_screen/bloc/auth_bloc.dart';
import 'package:doit/widgets/elevated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _authenticateWithGoogle(context) {
    print("event added auth");
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
    print("event completed auth");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          print(state.toString());
          if (state is GoogleSignInState && state.isCompleted) {
            Navigator.pushNamedAndRemoveUntil(context, '/homeScreen', (route) => false);
          }
          if (state is GoogleSignInState && state.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error")));
            // Navigator.pushNamedAndRemoveUntil(context, '/homeScreen', (route) => false);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                  SvgPicture.asset('assets/images/login_img.svg', width: MediaQuery.of(context).size.width / 1.2),
                  const Text(
                    "Lets help you to do your task",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  CustomElevatedButtonIcon(
                      icon: const FaIcon(FontAwesomeIcons.google, color: Colors.black),
                      onTap: () {
                        _authenticateWithGoogle(context);
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                      text: "Continue with Google"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('TEst'),
    );
  }
}
