import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_admin/controller/auth_controller.dart';
import 'package:firebase_admin/controller/imagepick_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class AddProduct extends StatefulWidget {
  AddProduct({
    Key? key,
    this.id,
    this.name,
    this.cat,
    this.price,
    this.discount,
  }) : super(key: key);
  @override
  State<AddProduct> createState() => _AddProductState();
  String? id;
  final String? name;
  final String? cat;
  final String? price;
  final String? discount;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'cat': cat,
        'price': price,
        'discount': discount,
      };
}

class _AddProductState extends State<AddProduct> {
  Uint8List? image;
  File? file;
  final proID = TextEditingController();
  final proName = TextEditingController();
  final proCate = TextEditingController();
  final proPrice = TextEditingController();
  final proDis = TextEditingController();
  selectImage() async {
    Uint8List im = await imagePick(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                const CircleAvatar(
                  //backgroundColor: Colors.white,
                  radius: 100,
                  child: Icon(
                    Icons.image,
                    size: 50,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 150,
                  child: IconButton(
                    onPressed: selectFile,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: proID,
              decoration: InputDecoration(
                hintText: "Product ID",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: proName,
              decoration: InputDecoration(
                hintText: "Product name",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: proCate,
              decoration: InputDecoration(
                hintText: "Category",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: proPrice,
              decoration: InputDecoration(
                hintText: "Price",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: proDis,
              decoration: InputDecoration(
                hintText: "Discount",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                final addProduct = AddProduct(
                  id: proID.text,
                  name: proName.text,
                  cat: proCate.text,
                  price: proPrice.text,
                  discount: proDis.text,
                );
                addNew(addProduct);
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Add product",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future addNew(AddProduct addProduct) async {
  final docProduct = FirebaseFirestore.instance.collection('products').doc();

  addProduct.id = docProduct.id;

  final json = addProduct.toJson();
  await docProduct.set(json);
}




// class ProductModel {
//   final String? id;
//   final String? name;
//   final String? cat;
//   final String? price;
//   final String? discount;

//   ProductModel({
//     this.id,
//     this.name,
//     this.cat,
//     this.price,
//     this.discount,
//   });
// }
