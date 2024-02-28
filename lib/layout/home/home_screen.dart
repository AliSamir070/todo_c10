import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_maadi/layout/home/provider/home_provider.dart';
import 'package:todo_c10_maadi/layout/home/tabs/list_tab.dart';
import 'package:todo_c10_maadi/layout/home/tabs/settings_tab.dart';
import 'package:todo_c10_maadi/layout/login/login_screen.dart';
import 'package:todo_c10_maadi/shared/providers/auth_provider.dart';
import 'package:todo_c10_maadi/style/app_colors.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/HomeScreen";
  List<Widget> tabs = [ListTab(),SettingsTab()];
  @override
  Widget build(BuildContext context) {
    Authprovider provider = Provider.of<Authprovider>(context);
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: (){},
          shape: StadiumBorder(
            side: BorderSide(
              color: Colors.white,
              width: 5
            )
          ),
          child: Icon(Icons.add,color: Colors.white,size: 18,),
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
      body: tabs[homeProvider.currentNavIndex],
    );
  }
}
