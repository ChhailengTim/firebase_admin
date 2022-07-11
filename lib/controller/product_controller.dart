import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admin/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final proid = ''.obs;
  final proname = ''.obs;
  final category = ''.obs;
  final price = ''.obs;
  final discount = ''.obs;
  final proID = TextEditingController().obs;
  final proName = TextEditingController().obs;
  final proCate = TextEditingController().obs;
  final proPrice = TextEditingController().obs;
  final proDis = TextEditingController().obs;

  void clearData() {
    proid.value = '';
    proID.value.text = '';
    proname.value = '';
    proName.value.text = '';
    category.value = '';
    proCate.value.text = '';
    price.value = '';
    proPrice.value.text = '';
    discount.value = '';
    proDis.value.text = '';
  }

  Future addProduct() async {
    var item = ProductModel();
    item.productID = int.tryParse(proid.value) ?? 0;
    item.name = proname.value;
    item.category = category.value;
    item.price = double.tryParse(price.value) ?? 0.00;

    item.discount = double.tryParse(discount.value) ?? 0;
    item.total = item.price! - ((item.price! * item.discount!) / 100);
    await FirebaseFirestore.instance
        .collection('products')
        .add(item.toMap())
        .then((value) {
      clearData();
      FirebaseFirestore.instance
          .collection('products')
          .doc(value.id)
          .update({'id': value.id});
    });
  }

  Future editProduct(String id) async {
    var item = ProductModel();
    item.productID = int.tryParse(proid.value) ?? 0;
    item.name = proname.value;
    item.category = category.value;
    item.price = double.tryParse(price.value) ?? 0.00;
    item.discount = double.tryParse(discount.value) ?? 0;
    item.total = item.price! - ((item.price! * item.discount!) / 100);
    await FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .update(item.toMap());
  }

  Future deleteProduct(String id) async {
    await FirebaseFirestore.instance.collection('products').doc(id).delete();
  }
}
