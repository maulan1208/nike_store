import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nike_shop/screens/bottomnav.dart';
import 'package:nike_shop/screens/login.dart';
import 'package:nike_shop/service/database.dart';
import 'package:nike_shop/service/shared_pref.dart';
import 'package:random_string/random_string.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  String email = "", password = "", name = "";

  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null) {
      try{
        UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
        
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Đăng ký thành công", 
            style: TextStyle(fontSize: 20.0),
            ))));

          String Id = randomAlphaNumeric(100);
          Map<String, dynamic> addUserInfo = {
            "Name": namecontroller.text,
            "Email": emailcontroller.text,
            "Wallet": "0",
            "Id": Id,
          };
          Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav()));

          await DatabaseMethod().addUserDetail(addUserInfo, Id);
          await SharedPreferenceHelper().saveUserName(namecontroller.text);
          await SharedPreferenceHelper().saveUserEmail(emailcontroller.text);
          await SharedPreferenceHelper().saveUserWallet("0");
          await SharedPreferenceHelper().saveUserId(Id);

      } on FirebaseException catch(e) {
        if( e.code == "waek-password"){
          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "mật khẩu yếu", 
              style: TextStyle(fontSize: 20.0),
              ))));

        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Đã có tài khoản", 
              style: TextStyle(fontSize: 20.0),
              ))));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset('images/logo.png'),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Form(
                  key: _formkey, 
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                  
                          const Text(
                            'Tên',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  
                          const SizedBox(height: 10),
                  
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                            ),
                            child: TextFormField(
                              controller: namecontroller,
                              validator: (value){
                                if (value == null || value.isEmpty){
                                  return "Nhập tên";
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.supervised_user_circle,
                                  color: Colors.white,
                                ),
                                hintText: 'Tên',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                  
                          const SizedBox(height: 10),
                  
                          const Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  
                          const SizedBox(height: 10),
                  
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                            ),
                            child: TextFormField(
                              controller: emailcontroller,
                              validator: (value){
                                if (value == null || value.isEmpty){
                                  return "Nhập email";
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                  
                          const SizedBox(height: 15),
                  
                          const Text(
                            'Mật khẩu',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                  
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                            ),
                            child: TextFormField(
                              controller: passwordcontroller,
                              validator: (value){
                                if (value == null || value.isEmpty){
                                  return "Nhập mật khẩu";
                                }
                                return null;
                              },
                              obscureText: true,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                hintText: 'Mật khẩu',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 35),
                          GestureDetector(
                            onTap: () async{
                              if (_formkey.currentState!.validate()){
                                setState(() {
                                  email = emailcontroller.text;
                                  name = namecontroller.text;
                                  password = passwordcontroller.text;
                                });
                              }
                              registration();
                            },
                            child: Container(
                              margin: EdgeInsetsDirectional.only(start: 130),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black,
                              ),
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Đăng ký",
                                    style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  ),
                                  ),
                              ),
                            ),
                            
                          ),
                          const SizedBox(height: 35),
                          GestureDetector(
                            onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                            child: const Center(
                              child: Text(
                                '- Đã có tài khoản -',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}