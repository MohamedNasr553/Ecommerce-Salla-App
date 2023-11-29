import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/ShopLayout.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/modules/shop_app/login/LoginScreen.dart';
import 'package:shop_app/modules/shop_app/on_boarding/onboarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/CacheHelper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async {
  // ensure that everything in the main method has finished then run MyApp.
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool isDark = CacheHelper.get(key: 'isDark') ?? false;

  bool onBoarding = CacheHelper.get(key: 'onBoarding') ?? false;

  userToken = await getUserToken();
  print(userToken);

  if (onBoarding != null) {
    if (userToken != null) {
      widget = const ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  return runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  const MyApp({
    super.key,
    required this.isDark,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()..changeTheme(fromShared: isDark,),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..shopHomeData()
            ..getCategories()
            ..getUserProfile(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
