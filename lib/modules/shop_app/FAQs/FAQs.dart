import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/shop_FAQ_model.dart';
import 'package:shop_app/modules/shop_app/FAQs/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/FAQs/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FAQsCubit, FAQsStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(),
          body: ListView.separated(
            itemBuilder: (context, int index) => buildFAQItem(FAQsCubit.get(context).faqModel!.data!.data[index]),
            separatorBuilder: (context, int index) => separator(),
            itemCount: 6,
          ),
        );
      },
    );
  }

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
