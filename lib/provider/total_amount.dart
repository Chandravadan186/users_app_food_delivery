import 'package:flutter/cupertino.dart';

class TotalAmount extends ChangeNotifier
{
  double totalAmount = 0;

  double get tAmount => totalAmount;

  displayTotalAmount(double number) async
  {
    totalAmount = number;

    notifyListeners();
  }
}