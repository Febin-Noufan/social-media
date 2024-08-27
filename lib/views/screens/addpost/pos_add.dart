import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/addpost/bloc/postadd_bloc.dart';
import 'package:flutter_application_1/controller/addpost/bloc/postadd_event.dart';
import 'package:flutter_application_1/controller/addpost/bloc/postadd_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPostBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create a New Post', style: TextStyle(fontWeight: FontWeight.bold)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocListener<AddPostBloc, AddPostState>(
          listener: (context, state) {
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Post submitted successfully!')),
              );
            } else if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to submit post!')),
              );
            }
          },
          child: BlocBuilder<AddPostBloc, AddPostState>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                              width: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  onChanged: (text) {
                                    context.read<AddPostBloc>().add(TextChanged(text: text));
                                  },
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                    hintText: 'What\'s on your mind?',
                                    border: InputBorder.none,
                                  ),
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () async {
                                    final  image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                    if (image !=null) {
                                       context.read<AddPostBloc>().add(ImagePicked(image: File(image.path)));
                                    }
                                   
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: state.image != null ? 200 : 150,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey[400]!),
                                      image: state.image != null
                                          ? DecorationImage(
                                              image: FileImage(File(state.image!.path)),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                    ),
                                    child: state.image == null
                                        ? const Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.add_a_photo, color: Colors.grey, size: 50),
                                                SizedBox(height: 10),
                                                Text('Add an Image',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.deepPurple),
                            onPressed: () async {
                              final 
                               image = await ImagePicker().pickImage(source: ImageSource.gallery);
                              // ignore: use_build_context_synchronously
                              context.read<AddPostBloc>().add(ImagePicked(image: File(image!.path)));
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.location_on, color: Colors.deepPurple),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.tag, color: Colors.deepPurple),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.people, color: Colors.deepPurple),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: BlocBuilder<AddPostBloc, AddPostState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: state.isSubmitting ? null : () => context.read<AddPostBloc>().add(SubmitPost()),
              backgroundColor: Colors.deepPurple,
              child: state.isSubmitting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Icon(Icons.send),
            );
          },
        ),
      ),
    );
  }
}
