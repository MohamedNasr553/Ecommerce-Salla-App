import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/shop_FAQ_model.dart';
import 'package:shop_app/modules/shop_app/FAQs/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class FAQsCubit extends Cubit<FAQsStates> {
  FAQsCubit() : super(FAQsInitialState());

  static FAQsCubit get(context) => BlocProvider.of(context);

  FAQModel? faqModel;
  void getFAQs(){
    emit(FAQsLoadingState());

    DioHelper.getData(
      url: FAQs,
      token: userToken,
    ).then((value){
      faqModel = FAQModel.fromJson(value.data);

      emit(FAQsSuccessState());
    }).catchError((error){
      emit(FAQsErrorState(error));
    });
  }
}
