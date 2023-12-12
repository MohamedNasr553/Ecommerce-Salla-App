import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/ShopLayout.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/CacheHelper.dart';

class ShopUpdateProfileScreen extends StatelessWidget {
  ShopUpdateProfileScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopUpdateProfileSuccessState) {
          if (state.updateProfileModel.status! == true) {
            CacheHelper.saveData(
              key: "token",
              value: state.updateProfileModel.data!.token,
            ).then((value) {
              navigateToPage(context, const ShopLayout());
            });

            showToast(
              text: state.updateProfileModel.message ?? "txt",
              // if message = null return "txt"
              state: ToastStates.SUCCESS,
            );
          }
          else {
            showToast(
              text: state.updateProfileModel.message ?? "txt",
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        // Take the default values from login info
        var shopCubit = ShopCubit.get(context);
        if (shopCubit.shopProfileModel != null) {
          nameController.text = shopCubit.shopProfileModel!.data!.name!;
          emailController.text = shopCubit.shopProfileModel!.data!.email!;
          phoneController.text = shopCubit.shopProfileModel!.data!.phone!;
        }
        return Scaffold(
          appBar: AppBar(),
          body: buildUpdateProfileScreen(context),
        );
      },
    );
  }

  Widget buildUpdateProfileScreen(context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          defaultTextFormField(
            validate: (value) {},
            controller: nameController,
            type: TextInputType.text,
            labelText: 'Name',
            prefix: Icons.person,
          ),
          const SizedBox(
            height: 20.0,
          ),
          defaultTextFormField(
            validate: (value) {},
            controller: phoneController,
            type: TextInputType.phone,
            labelText: 'Phone Number',
            prefix: Icons.phone,
          ),
          const SizedBox(
            height: 20.0,
          ),
          defaultTextFormField(
            validate: (value) {},
            controller: emailController,
            type: TextInputType.emailAddress,
            labelText: 'Email Address',
            prefix: Icons.email,
          ),
          const SizedBox(
            height: 20.0,
          ),
          defaultTextFormField(
              controller: passwordController,
              type: TextInputType.visiblePassword,
              validate: (value) {},
              labelText: 'Password',
              prefix: Icons.lock,
              suffixPressed: () {}
          ),
          const SizedBox(
            height: 30.0,
          ),
          defaultButton(
            function: () {
              ShopCubit.get(context).updateProfile(
                name: nameController.text,
                phone: phoneController.text,
                email: emailController.text,
                password: passwordController.text,
              );
            },
            text: 'Update',
            color: Colors.deepOrange,
            radius: 20.0,
            height: 45.0,
          ),
        ],
      ),
    ),
  );
}
