import 'package:apidio/api_service.dart';
import 'package:apidio/login_model.dart';
import 'package:apidio/product_list_screen.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formkey=GlobalKey<FormState>();
  ApiService apiService=ApiService();
  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();

  bool isLoading=false;
  String? message;

  Future<void>login()async{
    setState(() {
      isLoading=true;
    });
    LoginModel userData=await apiService
        .logInUser(
        username.text.trim(),
        password.text.trim());
    setState(() {
      isLoading=false; //data paile false korbo
    });
    if(userData.accessToken != null){
      Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductListScreen()));
    }else{
      setState(() {
        isLoading=false;
        message=userData.message ??"Invailid Credential";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formkey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: username,
              decoration: InputDecoration(hint: Text("Name"),
                  label: Text("Name"),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Enter Your Name";
                }
                return null;
              },
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: password,
              decoration: InputDecoration(hint: Text("Password"),
                  label: Text("Password"),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Enter Password";
                }
                return null;
              },

            ),SizedBox(height: 30,),

            isLoading ? CircularProgressIndicator():SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(onPressed: (){
                if(formkey.currentState!.validate()){
                  login();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please Input All Data")));
                }
              }, child: Text("Login")),
            ),
            if(message != null)...[
              SizedBox(height: 20,),
              Text(message!,style: TextStyle(color: Colors.red),)
            ]


          ],
              ),
        ),
      ),);
  }
}
