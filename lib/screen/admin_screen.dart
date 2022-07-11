import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admin/controller/auth_controller.dart';
import 'package:firebase_admin/controller/product_controller.dart';
import 'package:firebase_admin/screen/add_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key, this.email}) : super(key: key);
  final String? email;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final proCon = Get.put(ProductController());

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
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: const [
                  Expanded(flex: 2, child: Text('name')),
                  Expanded(child: Text('category')),
                  Expanded(child: Text('price')),
                  Expanded(
                    child: Text('discount'),
                  ),
                  Expanded(
                    child: Text('Total'),
                  ),
                  SizedBox(
                    width: 80,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (index, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("dat1a ${snapshot.error}");
                }
                if (snapshot.hasData) {
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            children: [
                              Expanded(flex: 2, child: Text(data['name'])),
                              Expanded(child: Text(data['category'])),
                              Expanded(child: Text('\$${data['price']}')),
                              Expanded(child: Text('${data['discount']}%')),
                              Expanded(child: Text('\$${data['total']}')),
                              IconButton(
                                  onPressed: () {
                                    proCon.proID.value.text =
                                        data['productID'].toString();
                                    proCon.proName.value.text =
                                        data['name'].toString();
                                    proCon.proCate.value.text =
                                        data['category'].toString();
                                    proCon.proPrice.value.text =
                                        data['price'].toString();
                                    proCon.proDis.value.text =
                                        data['discount'].toString();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => AddProduct(
                                              id: data['id'],
                                            )),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.edit_rounded)),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(
                                            'Do want to delete ${data['name']}?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              proCon
                                                  .deleteProduct(data['id'])
                                                  .then((value) {
                                                Get.snackbar('Success',
                                                    'Product deleted successfully',
                                                    backgroundColor:
                                                        Colors.red);
                                                Navigator.pop(context);
                                              });
                                              // Navigator.pop(context);
                                            },
                                            child: const Text('Confirm'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.delete))
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddProduct()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
