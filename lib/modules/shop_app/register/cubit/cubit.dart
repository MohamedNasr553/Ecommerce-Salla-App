import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/shop_register_model.dart';
import 'package:shop_app/modules/shop_app/register/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility;

  void changeVisibility(){
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityState());
  }

  ShopRegisterModel? shopRegisterModel;
  void registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
  }){
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
        url: REGISTER,
        token: userToken,
        data: {
          name : 'name',
          email : 'email',
          password : 'password',
          phone : 'phone',
        }
    ).then((value){
      shopRegisterModel = ShopRegisterModel.fromJson(value.data);

      emit(ShopRegisterSuccessState());
    }).catchError((error){
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}