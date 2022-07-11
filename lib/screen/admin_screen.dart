import 'package:firebase_admin/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key, this.email}) : super(key: key);
  final String? email;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              authController.singout();
            },
            icon: const Icon(Icons.logout_outlined)),
      ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: Column(
                children: [
                  const Icon(Icons.people),
                  Text('$email'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
