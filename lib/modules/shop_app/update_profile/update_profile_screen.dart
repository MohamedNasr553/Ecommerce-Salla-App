import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class ShopUpdateProfileScreen extends StatelessWidget {
  ShopUpdateProfileScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
              controller: emailController,
              type: TextInputType.emailAddress,
              labelText: 'Email Address',
              prefix: Icons.email,
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
              height: 40.0,
            ),
            defaultButton(
              function: () {
                // ShopCubit.get(context).updateUserData();
              },
              text: 'Update',
              color: Colors.deepOrange,
            ),
            const SizedBox(
              height: 20.0,
            ),
            defaultButton(
              function: () {
                signOut(context);
              },
              text: 'Logout',
              color: Colors.deepOrange,
            ),
          ],
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
