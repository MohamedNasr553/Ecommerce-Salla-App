import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/modules/shop_app/search/search.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Salla',
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateToPage(context, ShopSearchScreen());
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
          body: shopCubit.shopScreens[shopCubit.currentIndex],
          bottomNavigationBar: Container(
            height: 65.0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavyBar(
                backgroundColor: Colors.white,
                iconSize: 25.0,
                selectedIndex: shopCubit.currentIndex,
                onItemSelected: (int index) {
                  shopCubit.changeIndex(index);
                },
                animationDuration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutCirc,
                items: [
                  BottomNavyBarItem(
                    title: const Text('Home'),
                    activeColor: Colors.deepOrange,
                    inactiveColor: Colors.grey,
                    icon: const Icon(Icons.home,),
                  ),
                  BottomNavyBarItem(
                    title: const Text('Categories'),
                    activeColor: Colors.deepOrange,
                    inactiveColor: Colors.grey,
                    icon: const Icon(Icons.grid_view_sharp,),
                  ),
                  BottomNavyBarItem(
                    title: const Text('Favorites'),
                    activeColor: Colors.deepOrange,
                    inactiveColor: Colors.grey,
                    icon: const Icon(Icons.favorite,),
                  ),
                  BottomNavyBarItem(
                    title: const Text('Cart'),
                    activeColor: Colors.deepOrange,
                    inactiveColor: Colors.grey,
                    icon: const Icon(Icons.shopping_cart,),
                  ),
                  BottomNavyBarItem(
                    title: const Text('Settings'),
                    activeColor: Colors.deepOrange,
                    inactiveColor: Colors.grey,
                    icon: const Icon(Icons.settings,),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
