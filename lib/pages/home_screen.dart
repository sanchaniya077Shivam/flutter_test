import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/restournt.dart';
import '../providers/restaurant_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    Provider.of<RestaurantProvider>(context, listen: false).fetchRestaurants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deWidth = MediaQuery.sizeOf(context).width;
    final deHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: Consumer<RestaurantProvider>(
          builder:
              (BuildContext context, RestaurantProvider restaurantProvider, Widget? child) {
            return Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        child: CupertinoSearchTextField(
                          controller: _searchController,
                          onChanged: (value) {
                            restaurantProvider.searchRestaurants(value);
                          },
                        ),
                      ),
                      ListView.builder(
                        itemCount: restaurantProvider.restaurants.length,
                        itemBuilder: (context, index) {
                          final Restaurant restourant = restaurantProvider.restaurants[index];
                          final photos = restourant.photos;
                          return ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.00)),
                              child:
                                  CachedNetworkImage(imageUrl: photos!.first.imgUrl!),
                            ),
                            title: Text(
                              restourant.name!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 26.00),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                (restaurantProvider.restaurants.isEmpty || restaurantProvider.isLoading)
                    ? Container(
                        color: Colors.grey.withOpacity(0.6),
                        width: deWidth,
                        height: deHeight,
                        child: const CircularProgressIndicator(),
                      )
                    : Container()
              ],
            );
          },
        ),
      ),
    );
  }
}
