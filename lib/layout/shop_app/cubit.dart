import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/models/shop_app/shop_categories_model.dart';
import 'package:shop_app/models/shop_app/shop_favorites_model.dart';
import 'package:shop_app/models/shop_app/shop_layout_model.dart';
import 'package:shop_app/models/shop_app/shop_login_model.dart';
import 'package:shop_app/modules/shop_app/category/category.dart';
import 'package:shop_app/modules/shop_app/favorites/favorites.dart';
import 'package:shop_app/modules/shop_app/products/products.dart';
import 'package:shop_app/modules/shop_app/settings/settings.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> shopScreens = [
    const ShopProductScreen(),
    const ShopCategoryScreen(),
    const ShopFavoriteScreen(),
    ShopSettingScreen(),
  ];

  int currentIndex = 0;

  void changeIndex(int index){
    currentIndex = index;

    emit(ShopChangeBottomNavBarState());
  }
  
  ShopLayoutModel? shopLayoutModel;
  
  Map<int, bool> favorites = {};
  
  void shopHomeData(){
   emit(ShopHomeLoadingState());

   DioHelper.getData(
     url: HOME,
   ).then((value){
     shopLayoutModel = ShopLayoutModel.fromJson(value.data);

     shopLayoutModel!.data!.products.forEach((element) {
       favorites.addAll({
         element.id: element.inFavorites,
       });
     });
     
     emit(ShopHomeSuccessState());
   }).catchError((error){
      emit(ShopHomeErrorState());
   });
  }

  ShopLoginModel? shopProfileModel;
  void getUserProfile(){
    emit(ShopProfileLoadingState());

    DioHelper.getData(
      url: PROFILE,
    ).then((value){
      shopProfileModel = ShopLoginModel.fromJson(value.data);

      emit(ShopProfileSuccessState());
    }).catchError((error){
      emit(ShopProfileErrorState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories(){
    emit(ShopCategoriesLoadingState());

    DioHelper.getData(
      url: CATEGORIES,
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopCategoriesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopCategoriesErrorState());
    });
  }

  ShopFavoritesModel? shopFavoritesModel;
  void changeFavorites(int productId){

    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesSuccessState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'productId': productId,
      }
    ).then((value){
      shopFavoritesModel = ShopFavoritesModel.fromJson(value.data);

      if(shopFavoritesModel!.status!){
        favorites[productId] = !favorites[productId]!;
      }

      emit(ShopFavoritesSuccessState());
    }).catchError((error){
      print(error.toString());

      favorites[productId] = !favorites[productId]!;
      emit(ShopFavoritesErrorState());
    });
  }
}