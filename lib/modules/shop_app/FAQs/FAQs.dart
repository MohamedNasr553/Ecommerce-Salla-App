import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/shop_FAQ_model.dart';
import 'package:shop_app/modules/shop_app/FAQs/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/FAQs/cubit/states.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FAQsCubit, FAQsStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(),
        );
        // return ConditionalBuilder(
        //   condition: FAQsCubit.get(context).faqModel != null,
        //   builder: (context) => buildFAQScreen(FAQsCubit.get(context).faqModel, context),
        //   fallback: (context) => const Center(child: CircularProgressIndicator(color: Colors.deepOrange)),
        // );
      },
    );
  }

  Widget buildFAQScreen(FAQModel? faqModel, context) => ListView.separated(
        itemBuilder: (context, int index) => buildFAQItem(faqModel.data!.data[index]),
        separatorBuilder: (context, int index) => const SizedBox(height: 1.0,),
        itemCount: faqModel!.data!.data.length,
      );

  Widget buildFAQItem(DetailedFAQData detailedFAQData) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${detailedFAQData.question}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 8.0,),
        Text(
          '${detailedFAQData.answer}',
          style: TextStyle(
            color: Colors.black.withOpacity(0.4),
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
      ],
    ),
  );
}
