import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/shop_complaint_model.dart';
import 'package:shop_app/modules/shop_app/complaints/cubit/states.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ComplaintsCubit extends Cubit<ComplaintsStates>{
  ComplaintsCubit() : super(ComplaintsInitialState());

  static ComplaintsCubit get(context) => BlocProvider.of(context);

  ComplaintModel? complaintModel;

  void userComplaints({
    required String name,
    required String phone,
    required String email,
    required String message,
  }){
    emit(ComplaintsLoadingState());

    DioHelper.postData(
      url: COMPLAINTS,
      data:
      {
        'name' : name,
        'phone': phone,
        'email' : email,
        'message' : message,
      },
    ).then((value){
      complaintModel = ComplaintModel.fromJson(value.data);

      emit(ComplaintsSuccessState());
    }).catchError((error){
      emit(ComplaintsErrorState(error.toString()));
    });
  }
}