import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_maadi/layout/home/home_screen.dart';
import 'package:todo_c10_maadi/layout/register/register_screen.dart';
import 'package:todo_c10_maadi/shared/constants.dart';
import 'package:todo_c10_maadi/shared/dialog_utils.dart';
import 'package:todo_c10_maadi/shared/firebaseautherrorcodes.dart';
import 'package:todo_c10_maadi/shared/remote/firebase/firestore_helper.dart';
import 'package:todo_c10_maadi/shared/reusable_componenets/custom_form_field.dart';
import 'package:todo_c10_maadi/style/app_colors.dart';
import 'package:todo_c10_maadi/model/user.dart' as MyUser;
import '../../shared/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/Login";
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscured = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/back.jpg"))
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Login",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.transparent,
          centerTitle: true,

        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key:formKey ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomFormField(
                  label: "Email",
                  controller: emailController,
                  keyboard: TextInputType.emailAddress,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "This field can't be empty";
                    }
                    if(!RegExp(Constants.emailRegex).hasMatch(value)){
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10,),
                CustomFormField(
                  controller: passwordController,
                  label: "Password",
                  keyboard: TextInputType.visiblePassword,
                  obscureText: isObscured,
                  suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                      icon: Icon(
                        isObscured?Icons.visibility_off:Icons.visibility,
                        color: AppColors.primaryLightColor,
                        size: 24,
                      )
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "This field can't be empty";
                    }
                    if(value.length<8){
                      return "Password should be at least 8 char";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  login();
                },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryLightColor
                    ),
                    child: Text("Login",style: TextStyle(color: Colors.white),)),
                SizedBox(height: 20,),
                TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child:Text("Dont't have an account? signup"))
              ],
            ),
          ),
        ),
      ),
    );
  }
  void login()async{
    Authprovider provider = Provider.of<Authprovider>(context,listen: false);
    if(formKey.currentState?.validate()??false){
      DialogUtils.showLoadingDialog(context);
      try{
        UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
        DialogUtils.hideLoading(context);
        print("user id: ${credential.user?.uid}");
        MyUser.User? user = await FirestoreHelper.GetUser(credential.user!.uid);
        provider.setUsers(credential.user, user);
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);

      }on FirebaseAuthException catch(error){
        DialogUtils.hideLoading(context);
        if(error.code == FirebaseAuthErrorCodes.userNotFound){
          DialogUtils.showMessage(context: context, message: "User not found",
          positiveText: "Ok",
            positivePress: (){
              Navigator.pop(context);
            }
          );

        }else if(error.code == FirebaseAuthErrorCodes.wrongPassword){
          print("Wrong password");
          DialogUtils.showMessage(context: context, message: "Wrong password",
              positiveText: "Ok",
              positivePress: (){
                Navigator.pop(context);
              }
          );
        }
      }catch(e){
        print(e.toString());
      }
    }
  }
}
