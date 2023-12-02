import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/complaints/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/complaints/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class ComplaintsScreen extends StatelessWidget {
  ComplaintsScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComplaintsCubit, ComplaintsStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 10.0,
                start: 20.0,
                end: 20.0,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name TextField
                      defaultTextFormField(
                        controller: nameController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'name shouldn\'t be empty!';
                          }
                          return null;
                        },
                        labelText: 'Name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // phone TextField
                      defaultTextFormField(
                        controller: phoneController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'phone shouldn\'t be empty!';
                          }
                          return null;
                        },
                        labelText: 'Phone number',
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height: 25.0,
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
                        prefix: Icons.email,
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      // Message TextField
                      defaultTextFormField(
                        controller: messageController,
                        maxLines: 7,
                        minLines: 4,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Email Address shouldn\'t be empty!';
                          }
                          return null;
                        },
                        labelText: 'Write your complain here!',
                        prefix: Icons.message,
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      // Submit Button
                      ConditionalBuilder(
                        condition: state is! ComplaintsLoadingState,
                        builder: (context) => defaultButton(
                          text: 'submit',
                          isUpperCase: true,
                          color: Colors.deepOrange.shade400,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ComplaintsCubit.get(context).userComplaints(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                message: messageController.text,
                              );
                              showToast(
                                text: ComplaintsCubit.get(context).complaintModel!.message ?? "txt",
                                state: ToastStates.SUCCESS,
                              );
                            }
                          },
                          radius: 4.0,
                        ),
                        fallback: (context) => const Center(
                            child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
