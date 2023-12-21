import 'package:flutter/material.dart';
import 'package:noteapps/components/textformdFieldAdd.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
        actions: [Icon(Icons.arrow_back)],
      ),
      body: Form(
        key: globalKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: CustomAddTextForm(
                hinttext: "Enter Name",
                mycontroller: name,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "can't be empty";
                  }
                },
              ),
            ),
            MaterialButton(
              onPressed: () {},
              child: Text("Add",),
            )
          ],
        ),
      ),
    );
  }
}
