import 'package:flutter/material.dart';

import '../model/restournt.dart';
import '../services/api_services.dart';

class RestaurantProvider extends ChangeNotifier {
  late bool _isLoading;
  late List<Restaurant> _restaurants;
  late List<Restaurant> _filteredRestaurants;

  List<Restaurant> get restaurants => _filteredRestaurants;
  bool get isLoading => _isLoading;

  void fetchRestaurants() async {
    _isLoading = true;
    notifyListeners();
    try {
      
      final List<Restaurant> data = await ApiServices().getRestournts();
      _restaurants = _filteredRestaurants = data;
      notifyListeners();
    } catch (e) {
      print('Error fetching restaurants: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void searchRestaurants(String keyword) {
    if (keyword.isEmpty) {
      _filteredRestaurants = List.from(_restaurants);
    } else {
      _filteredRestaurants = _restaurants.where((restaurant) =>
          restaurant.name!.toLowerCase().contains(keyword.toLowerCase())).toList();
    }
    notifyListeners();
  }

}
