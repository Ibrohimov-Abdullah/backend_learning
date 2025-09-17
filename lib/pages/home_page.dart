import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rest_api_learning/models/contact_model.dart';
import 'package:rest_api_learning/pages/add_contact.dart';
import 'package:rest_api_learning/service/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ContactModel> malumotlar = [];
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
      malumotlar = contactModelFromJson(natija);
      setState(() {});
    }
    setState(() {
      yuklanyapti = false;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Kontaqtlar royxati",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 30,
          ),
        ),
      ),
      body: yuklanyapti == true
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeAlign: 8,
                trackGap: 0,
                strokeWidth: 5,
                backgroundColor: Colors.grey,
              ),
            )
          : SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: malumotlar.length,
                  itemBuilder: (context, index) {
                    var malumot = malumotlar[index];
                    return Card(
                      child: ListTile(
                        onLongPress: () async{
                          setState(() {
                            yuklanyapti = true;
                          });

                          String? info = await Api.delete(Api.productsApi, malumot.id.toString(), );
                          if(info != null){
                            log("O'chirildi");
                            malumotOlibKel();
                            setState(() {

                            });
                          }else{
                            log("Muammo o'chirilishda");
                          }
                          setState(() {
                            yuklanyapti= false;
                          });
                        },
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              image: NetworkImage(malumot.image!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(malumot.fullName!),
                        subtitle: Text(malumot.phoneNumber!),
                        trailing: Text(malumot.id.toString()),
                      ),
                    );
                  },
                ),
              ),
            ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "hero",
            backgroundColor: Colors.black,
            onPressed: () async{
              var keladigonNatija = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddContact()
              ));


            },
            child: Icon(Icons.add, color: Colors.white),
          ),
          SizedBox(height: 10,),
          FloatingActionButton(
            heroTag: "hero2",
            backgroundColor: Colors.black,
            onPressed: () {
              malumotOlibKel();
            },
            child: Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
