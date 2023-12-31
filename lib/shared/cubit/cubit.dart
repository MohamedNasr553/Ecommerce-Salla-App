import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/CacheHelper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  
  void changeTheme({
    bool? fromShared
  }){
    if(fromShared != null){
      isDark = fromShared;
      emit(ChangeThemeState());
    }
    else{
      isDark = !isDark;
      CacheHelper.saveData(
        key: 'isDark',
        value: isDark
      ).then((value){
        emit(ChangeThemeState());
      });
    }
  }
}
