
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier{
  int currentNavIndex = 0;

  void changeTab(int newIndex){
    if(currentNavIndex == newIndex) return;
    currentNavIndex = newIndex;
    notifyListeners();
  }

  DateTime? selectedDate;

  void selectNewDate(DateTime? newSelected){
    selectedDate = newSelected;
    notifyListeners();
  }
}