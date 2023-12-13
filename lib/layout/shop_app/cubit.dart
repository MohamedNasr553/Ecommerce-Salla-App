import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/models/shop_app/category_details_model.dart';
import 'package:shop_app/models/shop_app/shop_categories_model.dart';
import 'package:shop_app/models/shop_app/shop_add_delete_favorite_model.dart';
import 'package:shop_app/models/shop_app/shop_get_favorites_model.dart';
import 'package:shop_app/models/shop_app/shop_layout_model.dart';
import 'package:shop_app/models/shop_app/shop_login_model.dart';
import 'package:shop_app/models/shop_app/update_profile_model.dart';
import 'package:shop_app/modules/shop_app/cart/cartScreen.dart';
import 'package:shop_app/modules/shop_app/category/category.dart';
import 'package:shop_app/modules/shop_app/favorites/favorites.dart';
import 'package:shop_app/modules/shop_app/products/products.dart';
import 'package:shop_app/modules/shop_app/settings/settings.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> shopScreens = [
    const ShopProductScreen(),
    const ShopCategoryScreen(),
    const ShopFavoriteScreen(),
    const ShopCartScreen(),
    const ShopSettingScreen(),
  ];

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;

    emit(ShopChangeBottomNavBarState());
  }

  /// ---------------- All Products -------------------
  Map<int, bool> favorites = {};

  ShopLayoutModel? shopLayoutModel;

  void shopHomeData() {
    emit(ShopHomeLoadingState());

    DioHelper.getData(
      url: HOME,
      token: userToken,
    ).then((value) {
      shopLayoutModel = ShopLayoutModel.fromJson(value.data);

      for (var element in shopLayoutModel!.data!.products) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      }

      emit(ShopHomeSuccessState());
    }).catchError((error) {
      emit(ShopHomeErrorState());
    });
  }

  /// ---------------- User Profile -------------------
  ShopLoginModel? shopProfileModel;

  void getUserProfile() {
    emit(ShopProfileLoadingState());

    DioHelper.getData(
      url: PROFILE,
      token: userToken,
    ).then((value) {
      shopProfileModel = ShopLoginModel.fromJson(value.data);

      emit(ShopProfileSuccessState());
    }).catchError((error) {
      emit(ShopProfileErrorState());
    });
  }

  UpdateProfileModel? updateProfileModel;

  void updateProfile({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(ShopUpdateProfileLoadingState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: userToken,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
      },
    ).then((value) {
      updateProfileModel = UpdateProfileModel.fromJson(value.data);

      emit(ShopUpdateProfileSuccessState(updateProfileModel!));
    }).catchError((error) {
      print(error.toString());

      emit(ShopUpdateProfileErrorState(error.toString()));
    });
  }

  /// ---------------- Categories -------------------
  CategoriesModel? categoriesModel;

  void getCategories() {
    emit(ShopCategoriesLoadingState());

    DioHelper.getData(
      url: CATEGORIES,
      token: userToken,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesErrorState());
    });
  }

  CategoryDetailsModel? electronicCategoryModel;

  void getElectronicCategory() {
    emit(ShopElectronicCategoriesLoadingState());

    DioHelper.getData(
      url: ELECTRONIC_CATEGORIES,
      token: userToken,
    ).then((value) {
      electronicCategoryModel = CategoryDetailsModel.fromJson(value.data);

      emit(ShopElectronicCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopElectronicCategoriesErrorState());
    });
  }

  CategoryDetailsModel? preventCoronaCategory;

  void getPreventCoronaCategories() {
    emit(ShopPreventCoronaCategoriesLoadingState());

    DioHelper.getData(
      url: PREVENT_CORONA_CATEGORIES,
      token: userToken,
    ).then((value) {
      preventCoronaCategory = CategoryDetailsModel.fromJson(value.data);

      emit(ShopPreventCoronaCategoriesSuccessState());
    }).catchError((onError) {
      print(onError.toString());

      emit(ShopPreventCoronaCategoriesErrorState());
    });
  }

  CategoryDetailsModel? sportsCategory;

  void getSportsCategories() {
    emit(ShopSportsCategoriesLoadingState());

    DioHelper.getData(
      url: SPORTS_CATEGORIES,
      token: userToken,
    ).then((value) {
      sportsCategory = CategoryDetailsModel.fromJson(value.data);

      emit(ShopSportsCategoriesSuccessState());
    }).catchError((onError) {
      print(onError.toString());

      emit(ShopSportsCategoriesErrorState());
    });
  }

  CategoryDetailsModel? lightingCategory;

  void getLightingCategories() {
    emit(ShopLightingCategoriesLoadingState());

    DioHelper.getData(
      url: LIGHTING_CATEGORIES,
      token: userToken,
    ).then((value) {
      lightingCategory = CategoryDetailsModel.fromJson(value.data);

      emit(ShopLightingCategoriesSuccessState());
    }).catchError((onError) {
      print(onError.toString());

      emit(ShopLightingCategoriesErrorState());
    });
  }

  CategoryDetailsModel? clothesCategory;

  void getClothesCategories() {
    emit(ShopClothesCategoriesLoadingState());

    DioHelper.getData(
      url: CLOTHES_CATEGORIES,
      token: userToken,
    ).then((value) {
      clothesCategory = CategoryDetailsModel.fromJson(value.data);

      emit(ShopClothesCategoriesSuccessState());
    }).catchError((onError) {
      print(onError.toString());

      emit(ShopClothesCategoriesErrorState());
    });
  }

  /// ---------------- Favorites -------------------
  ShopFavoritesModel? shopFavoritesModel;

  void changeFavorites(int productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = false;
    }

    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesSuccessState());

    DioHelper.postData(
      url: ADD_DELETE_FAVORITES,
      token: userToken,
      data: {
        'product_id': productId
      },
    ).then((value) {
      shopFavoritesModel = ShopFavoritesModel.fromJson(value.data);
      getFavoriteItems();

      if (shopFavoritesModel!.status!) {
        emit(ShopAddDeleteFavoritesSuccessState());
      }
    }).catchError((error) {
      print(error.toString());

      favorites[productId] = !favorites[productId]!;
      emit(ShopAddDeleteFavoritesErrorState());
    });
  }

  GetFavoritesModel? getFavoritesModel;

  void getFavoriteItems() {
    emit(ShopGetFavoritesLoadingState());

    DioHelper.getData(
      url: GET_FAVORITES,
      token: userToken,
    ).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);

      emit(ShopGetFavoritesSuccessState());
    }).catchError((onError) {
      print(onError.toString());

      emit(ShopGetFavoritesErrorState());
    });
  }
}
