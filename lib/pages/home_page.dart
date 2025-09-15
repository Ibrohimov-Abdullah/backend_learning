import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rest_api_learning/models/product_model.dart';
import 'package:rest_api_learning/service/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> malumotlar = [];
  bool yuklanyapti = false;

  @override
  void initState() {
    super.initState();
    malumotOlibKel();
  }

  malumotOlibKel() async {
    setState(() {
      yuklanyapti = true;
    });
    String? natija = await Api.get(Api.productsApi);
    log(natija.toString());
    if (natija != null) {
      malumotlar = productModelFromJson(natija);
      setState(() {});
    }
    setState(() {
      yuklanyapti = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: yuklanyapti == true
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Ma'lumotlar royxati",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 400,
                  width: 350,
                  child: ListView.builder(
                    itemCount: malumotlar.length,
                    itemBuilder: (context, index) {
                      var malumot = malumotlar[index];
                      return Card(
                        child: ListTile(
                          title: Text("${malumot.id}"),
                          subtitle: Text("${malumot.name}"),
                          trailing: Text("${malumot.age}"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          malumotOlibKel();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
