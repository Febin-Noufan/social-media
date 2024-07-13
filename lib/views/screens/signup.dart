import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/const.dart';
import 'package:flutter_application_1/controller/signup/bloc/signup_bloc.dart';
import 'package:flutter_application_1/views/screens/signin.dart';
import 'package:flutter_application_1/views/screens/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  File? _profileImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        foregroundColor: whiteColor,
        elevation: 0,
        title: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Success")),
            );
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SplashPage(),
                ));
          } else if (state is SignupErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                    child: _profileImage == null
                        ? Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: Colors.grey[800],
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 50),
                _buildTextField(_nameController, 'Name', Icons.person),
                const SizedBox(height: 20),
                _buildTextField(_usernameController, 'Username', Icons.alternate_email),
                const SizedBox(height: 20),
                _buildTextField(_emailController, 'Email', Icons.email, inputType: TextInputType.emailAddress),
                const SizedBox(height: 20),
                _buildTextField(_passwordController, 'Password', Icons.lock, isPassword: true),
                const SizedBox(height: 20),
                _buildTextField(_bioController, 'Bio', Icons.info, maxLines: 3),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<SignupBloc>(context).add(SignUpAdd(
                      name: _nameController.text,
                      bio: _bioController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                      profile: _profileImage,
                      username: _usernameController.text,
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: blackColor),
                  ),
                ),
                SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",style: TextStyle(color: Colors.white),),
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SigninScreen(),));

                  }, child: Text("Login"))
                ],
              )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, IconData icon,
      {bool isPassword = false,
      TextInputType inputType = TextInputType.text,
      int maxLines = 1}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: inputType,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      cursorColor: whiteColor,
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
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    );
  }
}
