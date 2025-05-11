import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:packagedeliveryapp/Admin/home_admin.dart';
import 'package:packagedeliveryapp/service/widget_support.dart';

class AdminLogIn extends StatefulWidget {
  const AdminLogIn({super.key});

  @override
  State<AdminLogIn> createState() => _AdminLogInState();
}

class _AdminLogInState extends State<AdminLogIn> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                "images/admin.png",
                height: 180,
                width: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 50.0),
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),

              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50.0),
                  Center(
                    child: Text(
                      "Admin Login",
                      style: AppWidget.WhiteTextfeildStyle(30.0),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Text("Username", style: AppWidget.WhiteTextfeildStyle(20.0)),
                  const SizedBox(height: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: usernamecontroller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Username",
                        prefixIcon: Icon(Icons.person),
                        hintStyle: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Text("Password", style: AppWidget.WhiteTextfeildStyle(20.0)),
                  const SizedBox(height: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      obscureText: true,
                      controller: passwordcontroller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Password",
                        prefixIcon: Icon(Icons.person),
                        hintStyle: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            GestureDetector(
              onTap: (){
                loginAdmin();
              },
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: MediaQuery.of(context).size.width / 1.6,
                  child: Center(
                    child: Text(
                      "LogIn",
                      style: AppWidget.WhiteTextfeildStyle(25.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      for (var result in snapshot.docs) {
        if (result.data()["username"] != usernamecontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Your username is not correct",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else if (result.data()["password"] !=
            passwordcontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Your password is not correct",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeAdmin()),
          );
        }
      }
    });
  }
}
