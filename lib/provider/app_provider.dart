import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/helpers/enumerators.dart';
import 'package:flutter_ecommerce/models/orders.dart';
import 'package:flutter_ecommerce/services/orders.dart';

class AppProvider with ChangeNotifier {
  late DisplayedPage currentPage;
  late OrderServices _orderServices = OrderServices();
  late OrderModel _orderModel;
  late double revenue = 0;

  AppProvider.init() {
    _getRevenue();
    changeCurrentPage(DisplayedPage.HOME);
  }

  changeCurrentPage(DisplayedPage newPage) {
    currentPage = newPage;
    notifyListeners();
  }

  void _getRevenue() async {
    await _orderServices.getAllOrders().then((orders) {
      for (OrderModel order in orders) {
        revenue = revenue + order.total;
        print("======= TOTAL REVENUE: ${revenue.toString()}");
        print("======= TOTAL REVENUE: ${revenue.toString()}");
        print("======= TOTAL REVENUE: ${revenue.toString()}");
      }
      notifyListeners();
    });
  }
}
