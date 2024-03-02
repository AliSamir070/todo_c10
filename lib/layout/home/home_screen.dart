import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_maadi/layout/home/provider/home_provider.dart';
import 'package:todo_c10_maadi/layout/home/tabs/list_tab.dart';
import 'package:todo_c10_maadi/layout/home/tabs/settings_tab.dart';
import 'package:todo_c10_maadi/layout/home/widgets/add_task_sheet.dart';
import 'package:todo_c10_maadi/layout/login/login_screen.dart';
import 'package:todo_c10_maadi/model/task.dart';
import 'package:todo_c10_maadi/shared/dialog_utils.dart';
import 'package:todo_c10_maadi/shared/providers/auth_provider.dart';
import 'package:todo_c10_maadi/shared/remote/firebase/firestore_helper.dart';
import 'package:todo_c10_maadi/style/app_colors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [ListTab(),SettingsTab()];
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSheetOpened = false;
  @override
  Widget build(BuildContext context) {
    Authprovider provider = Provider.of<Authprovider>(context);
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    bool isKeyboardOpened = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:isKeyboardOpened?null: FloatingActionButton(
          onPressed: () async {
            if(!isSheetOpened){
              showAddTaskBottomSheet();
              isSheetOpened = true;
            }else{
              if((formKey.currentState?.validate()??false) && homeProvider.selectedDate != null){
                await FirestoreHelper.AddNewTask(
                    Task(
                        title: titleController.text,
                        date: homeProvider.selectedDate!.millisecondsSinceEpoch,
                        description: descController.text),
                      provider.firebaseUserAuth!.uid
                );
                DialogUtils.showMessage(context: context,
                    message: "Task Added Successfully",positiveText: "Ok",positivePress: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                isSheetOpened = false;
              }

            }
            setState(() {

            });
          },
          shape: StadiumBorder(
            side: BorderSide(
              color: Colors.white,
              width: 5
            )
          ),
          child: isSheetOpened
        ?Icon(Icons.check,color: Colors.white,size: 18,)
          :Icon(Icons.add,color: Colors.white,size: 18,),
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        shape: CircularNotchedRectangle(),
        notchMargin: 15,
        child: BottomNavigationBar(
            onTap: (index){
              homeProvider.changeTab(index);
            },
            currentIndex: homeProvider.currentNavIndex,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/images/list.svg",
                    colorFilter: ColorFilter.mode(AppColors.unselectedIconColor, BlendMode.srcIn),),
                  activeIcon: SvgPicture.asset("assets/images/list.svg",),
                  label: ""),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/images/settings.svg"),
                  activeIcon:  SvgPicture.asset("assets/images/settings.svg",
                    colorFilter: ColorFilter.mode(Theme.of(context).primaryColor,BlendMode.srcIn ),),
                  label: ""),
            ]
        ),
      ),
      appBar: AppBar(
        title: Text("Todo list app",),
        leading: IconButton(
            onPressed: ()async{
              await provider.SignOut();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            icon: Icon(
              Icons.exit_to_app,
              size: 20,
              color: Colors.white,
            )
        ),
      ),
      body: Scaffold(
        key: scaffoldKey,
        body: tabs[homeProvider.currentNavIndex],
      ),
    );
  }

  void showAddTaskBottomSheet() {
    scaffoldKey.currentState?.showBottomSheet(
        (context)=>AddTaskSheet(
          titleController: titleController,
          descController: descController,
          formKey: formKey,
          onCancel: (){
            isSheetOpened = false;
            setState(() {

            });
          },
        ),
        enableDrag: false
    );
  }
}
