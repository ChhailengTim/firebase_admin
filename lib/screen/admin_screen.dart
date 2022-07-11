import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admin/controller/auth_controller.dart';
import 'package:firebase_admin/screen/add_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key, this.email}) : super(key: key);
  final String? email;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text("$email"),
        actions: [
          IconButton(
            onPressed: () {
              authController.singout();
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (index, snapshot) {
          if (snapshot.hasError) {
            return const Text("data");
          }
          return const Text("data");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddProduct(
                        id: '',
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
