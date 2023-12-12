import 'package:shop_app/models/shop_app/update_profile_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopSuccessState extends ShopStates{}

class ShopErrorState extends ShopStates{}

class ShopChangeBottomNavBarState extends ShopStates{}

class ShopHomeLoadingState extends ShopStates{}

class ShopHomeSuccessState extends ShopStates{}

class ShopHomeErrorState extends ShopStates{}

class ShopProfileLoadingState extends ShopStates{}

class ShopProfileSuccessState extends ShopStates{}

class ShopProfileErrorState extends ShopStates{}

class ShopUpdateProfileInitialState extends ShopStates{}

class ShopUpdateProfileLoadingState extends ShopStates{}

class ShopUpdateProfileSuccessState extends ShopStates{
  final UpdateProfileModel updateProfileModel;

  ShopUpdateProfileSuccessState(this.updateProfileModel);
}

class ShopUpdateProfileErrorState extends ShopStates{
  final String error;

  ShopUpdateProfileErrorState(this.error);
}

class ShopCategoriesLoadingState extends ShopStates{}

class ShopCategoriesSuccessState extends ShopStates{}

class ShopCategoriesErrorState extends ShopStates{}

class ShopFavoritesSuccessState extends ShopStates{}

class ShopChangeFavoritesSuccessState extends ShopStates{}

class ShopFavoritesErrorState extends ShopStates{}

class ShopElectronicCategoriesLoadingState extends ShopStates{}

class ShopElectronicCategoriesSuccessState extends ShopStates{}

class ShopElectronicCategoriesErrorState extends ShopStates{}

class ShopPreventCoronaCategoriesLoadingState extends ShopStates{}

class ShopPreventCoronaCategoriesSuccessState extends ShopStates{}

class ShopPreventCoronaCategoriesErrorState extends ShopStates{}

class ShopSportsCategoriesLoadingState extends ShopStates{}

class ShopSportsCategoriesSuccessState extends ShopStates{}

class ShopSportsCategoriesErrorState extends ShopStates{}

class ShopLightingCategoriesLoadingState extends ShopStates{}

class ShopLightingCategoriesSuccessState extends ShopStates{}

class ShopLightingCategoriesErrorState extends ShopStates{}

class ShopClothesCategoriesLoadingState extends ShopStates{}

class ShopClothesCategoriesSuccessState extends ShopStates{}

class ShopClothesCategoriesErrorState extends ShopStates{}