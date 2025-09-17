import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rest_api_learning/models/contact_model.dart';
import 'package:rest_api_learning/service/http_service.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {


  Widget customTextField(TextEditingController controller, String ism) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: ism,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.black)
              )
            ),
            controller: controller,
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }


  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact qo'shish"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customTextField(controller,"Toliq ism va familiyani kiriting"),
          customTextField(controller2,"Nomerizi kiriting"),
          customTextField(controller3,"Rasm kiriting"),

          SizedBox(height: 30,),
          ElevatedButton(onPressed: () async{
            setState(() {
              isLoading = true;
            });
            ContactModel model = ContactModel(
              image: controller3.text,
              fullName: controller.text,
              phoneNumber: controller2.text,
            );
            String? info = await Api.post(Api.productsApi, model.toJson());

            if(info != null){
              log("Muvafaqiyatli yuklandi");
              controller.clear();
              controller2.clear();
              controller3.clear();
              Navigator.pop(context);
            }else{
              log("Yuklashta muammo bo'ldi");
            }
          }, child: isLoading ? Center(child: CircularProgressIndicator(),) : Text("qo'shish"),
          )
        ],
      ),

    );
  }
}
