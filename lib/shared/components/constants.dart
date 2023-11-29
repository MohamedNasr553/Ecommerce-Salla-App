import 'package:shop_app/modules/shop_app/login/LoginScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/CacheHelper.dart';

void signOut(context){
  CacheHelper.removeData(key: "token").then((value){
    if(value){
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

String? userToken = '';
Future<String> getUserToken() async{
  return CacheHelper.get(key: 'token')?? "OUivTRhAD27e7V4ulp3L8M6BimJo2UjUJ5MSVWYU450VMgVchMnKpdjl0yuIWai0j8Ix8z";
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}