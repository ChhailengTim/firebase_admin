import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_admin/controller/imagepick_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

import '../controller/product_controller.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({
    Key? key,
    this.id,
    this.name,
    this.cat,
    this.price,
    this.discount,
  }) : super(key: key);
  @override
  State<AddProduct> createState() => _AddProductState();
  final String? id;
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
    // final AuthController authController = Get.put(AuthController());
    final productController = Get.put(ProductController());
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.id != null ? 'Update Product' : "Add product",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formKey,
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
              TextFormField(
                onSaved: (value) {
                  productController.proid(value);
                },
                controller: productController.proID.value,
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
              TextFormField(
                onSaved: (value) {
                  productController.proname(value);
                },
                controller: productController.proName.value,
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
              TextFormField(
                onSaved: (value) {
                  productController.category(value);
                },
                controller: productController.proCate.value,
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
              TextFormField(
                onSaved: (value) {
                  productController.price(value);
                },
                controller: productController.proPrice.value,
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
              TextFormField(
                onSaved: (value) {
                  productController.discount(value);
                },
                controller: productController.proDis.value,
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
                  formKey.currentState != null
                      ? formKey.currentState!.save()
                      : null;
                  widget.id != null
                      ? productController.editProduct(widget.id!).then((value) {
                          Navigator.pop(context);
                          Get.snackbar('Success', 'Product Update successfully',
                              backgroundColor: Colors.green);
                        })
                      : productController.addProduct().then((value) {
                          Navigator.pop(context);
                          Get.snackbar('Success', 'Product Add successfully',
                              backgroundColor: Colors.green);
                        });
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.id != null ? 'Update Product' : "Add product",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
