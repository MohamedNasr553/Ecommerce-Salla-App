import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/shop_contactUs_model.dart';
import 'package:shop_app/modules/shop_app/settings/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingInitialState());

  static SettingsCubit get(context) => BlocProvider.of(context);

  ContactUsModel? contactUsModel;
  void getContacts(){
    emit(ContactLoadingState());

    DioHelper.getData(
      url: CONTACT_US,
      token: userToken,
    ).then((value){
      contactUsModel = ContactUsModel.fromJson(value.data);

      emit(ContactSuccessState());
    }).catchError((error){
      emit(ContactErrorState(error));
    });
  }
}
