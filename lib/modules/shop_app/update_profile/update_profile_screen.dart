import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class ShopUpdateProfileScreen extends StatelessWidget {
  ShopUpdateProfileScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                  // ShopCubit.get(context).updateUserData();
                },
                text: 'Update',
                color: Colors.deepOrange,
                radius: 20.0,
                height: 45.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// return BlocConsumer<ShopCubit, ShopStates>(
    //   listener: (context, state) {},
    //   builder: (context, state) {
    //     // nameController.text = model!.data!.name! ;
    //     // emailController.text = model.data!.email!;
    //     // emailController.text = model.data!.phone!;
    //
    //     return ConditionalBuilder(
    //       condition: ShopCubit.get(context).shopProfileModel != null,
    //       builder: (context) => Expanded(
    //         child: Column(
    //           children: [
    //             defaultTextFormField(
    //               validate: (value){},
    //               controller: nameController,
    //               type: TextInputType.text,
    //               labelText: 'Name',
    //               prefix: Icons.person,
    //             ),
    //             const SizedBox(
    //               height: 20.0,
    //             ),
    //             defaultTextFormField(
    //               validate: (value){},
    //               controller: emailController,
    //               type: TextInputType.emailAddress,
    //               labelText: 'Email Address',
    //               prefix: Icons.email,
    //             ),
    //             const SizedBox(
    //               height: 20.0,
    //             ),
    //             defaultTextFormField(
    //               validate: (value){},
    //               controller: phoneController,
    //               type: TextInputType.phone,
    //               labelText: 'Phone Number',
    //               prefix: Icons.phone,
    //             ),
    //             const SizedBox(
    //               height: 20.0,
    //             ),
    //             defaultButton(
    //               function: (){
    //                 // ShopCubit.get(context).updateUserData();
    //               },
    //               text: 'Update',
    //             ),
    //             const SizedBox(
    //               height: 20.0,
    //             ),
    //             defaultButton(
    //               function: (){
    //                 signOut(context);
    //               },
    //               text: 'Logout',
    //             ),
    //           ],
    //         ),
    //       ),
    //       fallback: (context) => const Center(child: CircularProgressIndicator()),
    //     );
    //   },
    // );
