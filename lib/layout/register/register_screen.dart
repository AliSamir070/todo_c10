import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_maadi/model/user.dart';
import 'package:todo_c10_maadi/shared/constants.dart';
import 'package:todo_c10_maadi/shared/dialog_utils.dart';
import 'package:todo_c10_maadi/shared/firebaseautherrorcodes.dart';
import 'package:todo_c10_maadi/shared/remote/firebase/firestore_helper.dart';
import 'package:todo_c10_maadi/shared/reusable_componenets/custom_form_field.dart';
import 'package:todo_c10_maadi/style/app_colors.dart';
import 'package:todo_c10_maadi/model/user.dart' as MyUser;

import '../../shared/providers/auth_provider.dart';
import '../home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "/register";
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isObscured = true;
  bool isConfirmObscured = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
          title: Text("Create Account",style: TextStyle(color: Colors.white),),
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
                  label: "Full Name",
                  controller: fullNameController,
                  keyboard: TextInputType.name,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "This field can't be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10,),
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
                SizedBox(height: 10,),
                CustomFormField(
                  controller: confirmPasswordController,
                  label: "Confirm Password",
                  keyboard: TextInputType.visiblePassword,
                  obscureText: isConfirmObscured,
                  suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          isConfirmObscured = !isConfirmObscured;
                        });
                      },
                      icon: Icon(
                        isConfirmObscured?Icons.visibility_off:Icons.visibility,
                        color: AppColors.primaryLightColor,
                        size: 24,
                      )
                  ),
                  validator: (value){
                    if(value != passwordController.text){
                      return "don't match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  createNewUser();
                },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLightColor
                    ),
                    child: Text("Register",style: TextStyle(color: Colors.white),))
              ],
            ),
          ),
        ),
      ),
    );
  }
  void createNewUser()async{
    Authprovider provider = Provider.of<Authprovider>(context,listen: false);
    if(formKey.currentState?.validate()??false){
      DialogUtils.showLoadingDialog(context);
      try{
        UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        FirestoreHelper.AddUser(
            emailController.text,
            fullNameController.text,
            credential.user!.uid
        );
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, message: "Registered successfully ${credential.user?.uid}",
            positiveText: "Ok",
            positivePress: (){
              provider.setUsers(credential.user, MyUser.User(
                  id: credential.user!.uid,
                  email: emailController.text,
                  fullname: fullNameController.text));

              DialogUtils.hideLoading(context);
              Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
            });

  }on FirebaseAuthException catch (e) {
        DialogUtils.hideLoading(context);
        if (e.code == FirebaseAuthErrorCodes.weakPassword) {
          print('The password provided is too weak.');
          DialogUtils.showMessage(context: context, message: "The password provided is too weak.",
              positiveText: "Ok",
              positivePress: (){
                DialogUtils.hideLoading(context);
              });
        } else if (e.code == FirebaseAuthErrorCodes.emailAlreadyInUse) {
          print('The account already exists for that email.');

          DialogUtils.showMessage(context: context, message: "The account already exists for that email.",
              positiveText: "Ok",
              positivePress: (){
                DialogUtils.hideLoading(context);
              });
        }
      }catch(e){
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, message: e.toString(),
            positiveText: "Ok",
            positivePress: (){
              DialogUtils.hideLoading(context);
            });
      }
    }

  }
}
