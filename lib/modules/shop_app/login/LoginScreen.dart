import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/ShopLayout.dart';
import 'package:shop_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';
import 'package:shop_app/modules/shop_app/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/CacheHelper.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is UserLoginSuccessState) {
            if (state.loginModel.status! == true) {
              CacheHelper.saveData(
                key: "token",
                value: state.loginModel.data!.token,
              ).then((value) {
                navigateAndFinish(context, const ShopLayout());
              });

              showToast(
                text: state.loginModel.message ?? "txt",
                // if message = null return "txt"
                state: ToastStates.SUCCESS,
              );
            } else {
              showToast(
                text: state.loginModel.message ?? "txt",
                state: ToastStates.ERROR,
              );
            }
          }

          if (state is UserLoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Welcome back Text
                          const Text(
                            'Welcome back',
                            style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Sign in to continue Text
                          Text(
                            'Sign in with your email and password',
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          // Email Address TextField
                          defaultTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Email Address shouldn\'t be empty!';
                              }
                              return null;
                            },
                            labelText: 'Email Address',
                            prefix: Icons.email_outlined,
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          // Password TextField
                          defaultTextFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Password shouldn\'t be empty!';
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              labelText: 'Password',
                              isPassword:
                                  ShopLoginCubit.get(context).isPassword,
                              suffix: ShopLoginCubit.get(context).suffix,
                              prefix: Icons.lock_outline_rounded,
                              suffixPressed: () {
                                ShopLoginCubit.get(context).changeVisibility();
                              }),
                          const SizedBox(
                            height: 40.0,
                          ),
                          // Login Button
                          ConditionalBuilder(
                            condition: state is! UserLoginLoadingState,
                            builder: (context) => defaultButton(
                              text: 'login',
                              isUpperCase: true,
                              color: Colors.deepOrange.shade400,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              radius: 20.0,
                              width: MediaQuery.of(context).size.width,
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.grey,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateToPage(context, RegisterScreen());
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.deepOrange.shade300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
