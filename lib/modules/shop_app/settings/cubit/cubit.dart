import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/settings/cubit/states.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingInitialState());

  static SettingsCubit get(context) => BlocProvider.of(context);

  // bool isSelected = false;
  //
  // void changeSelection(int index){
  //   isSelected = !isSelected;
  //   emit(SettingChangeSelection());
  // }
}
