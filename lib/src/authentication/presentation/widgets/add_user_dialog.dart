import 'package:bloc_clean_architecture/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({super.key, required this.nameController});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'username'
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  final avatar = 'https://avatars.githubusercontent.com/u/67597128';
                  final name = nameController.text.trim();
                  context.read<AuthenticationCubit>().createUser(createdAt: DateTime.now().toString(), name: name, avatar: avatar);
                  Navigator.of(context).pop();
                }, 
                child: const Text("Create User")
              )
            ],
          ),
        ),
      )
    );
  }
}