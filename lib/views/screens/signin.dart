import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/signin/bloc/signin_bloc.dart';
import 'package:flutter_application_1/views/screens/signup.dart';
import 'package:flutter_application_1/views/screens/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<SigninBloc, SigninState>(
        listener: (context, state) {
          if (state is SigninSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Success")),
            );
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SplashPage(),
                ));
          } else if (state is SigninErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("error")),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 150),
                  _buildTextField(
                    controller: emailController,
                    labelText: 'Email',
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(
                    controller: passwordController,
                    labelText: 'Password',
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  const SizedBox(height: 100),
                  BlocConsumer<SigninBloc, SigninState>(
                    listener: (context, state) {
                        if (state is SigninSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Success")),
            );
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SplashPage(),
                ));
          } else if (state is SigninErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("error")),
            );
          }
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<SigninBloc>(context).add(
                              SigninButtonClick(
                                  email: emailController.text,
                                  password: passwordController.text));
                          // Handle login logic here
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ));
                          },
                          child: Text("Login"))
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool isPassword = false,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: inputType,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    );
  }
}
