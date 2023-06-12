// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, use_key_in_widget_constructors, dead_code, sort_child_properties_last, must_be_immutable, unused_import, prefer_final_fields, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  var isPasswordHidden = true.obs;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Account',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade200,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "First Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Your first name...',
                      suffixIcon: Container(
                          margin: EdgeInsets.all(5), child: Icon(Icons.person)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Last Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Your last name...',
                      suffixIcon: Container(
                          margin: EdgeInsets.all(5), child: Icon(Icons.person)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Email",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email...',
                      suffixIcon: Container(
                          margin: EdgeInsets.all(5), child: Icon(Icons.email)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Password",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Obx(
                    () => TextField(
                      controller: passwordController,
                      obscureText: isPasswordHidden.value,
                      decoration: InputDecoration(
                        hintText: 'Password...',
                        suffix: InkWell(
                          child: Icon(
                              isPasswordHidden.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                              size: 20),
                          onTap: () {
                            isPasswordHidden.value = !isPasswordHidden.value;
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Re-enter Password",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Re-enter Password...',
                      suffix: InkWell(
                        child: Icon(
                            isPasswordHidden.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                            size: 20),
                        onTap: () {
                          isPasswordHidden.value = !isPasswordHidden.value;
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 35),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
