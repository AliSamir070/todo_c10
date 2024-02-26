import 'package:flutter/material.dart';

class DialogUtils{
  static void showLoadingDialog(BuildContext context , ){
    showDialog(context: context, builder: (context){
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator.adaptive(),
                SizedBox(width: 15,),
                Text("Loading...")
              ],
            ),
          ),
        ),
      );
    });
  }
  static void hideLoading(BuildContext context){
    Navigator.pop(context);
  }
  static void showMessage({required BuildContext context , required String message,
    String? positiveText,
    String? negativeText,
  void Function()? positivePress,
  void Function()? negativePress,
  }){
    showDialog(context: context, builder: (context){
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(positiveText!=null)
                      TextButton(
                        onPressed: positivePress,
                        child: Text(positiveText)
                    ),
                    if(negativeText!=null)
                      TextButton(
                          onPressed: negativePress,
                          child: Text(negativeText)
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}