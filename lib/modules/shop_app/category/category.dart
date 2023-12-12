import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/models/shop_app/shop_categories_model.dart';
import 'package:shop_app/modules/shop_app/clothes_category/clothes.dart';
import 'package:shop_app/modules/shop_app/electronic_category/electronic_category.dart';
import 'package:shop_app/modules/shop_app/lighting_category/lighting.dart';
import 'package:shop_app/modules/shop_app/preventCorona_category/preventCorona.dart';
import 'package:shop_app/modules/shop_app/sports_category/sports.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopCategoryScreen extends StatelessWidget {
  const ShopCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index], context),
          separatorBuilder: (context, index) => separator(),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(
          image: NetworkImage(
              model.image!
          ),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 15.0,
        ),
        Text(
          model.name!,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: (){
            switch (model.name) {
              case 'electrionic devices':
                navigateToPage(context, const ElectronicCategory());
                break;
              case 'Prevent Corona':
                navigateToPage(context, const PreventCoronaCategory());
                break;
              case 'sports':
                navigateToPage(context, const SportsCategory());
                break;
              case 'Lighting':
                navigateToPage(context, const LightingCategory());
                break;
              case 'Clothes':
                navigateToPage(context, const ClothesCategory());
                break;
              default:
                // Handle the default case if needed
                break;
            }
          },
          icon: const Icon(
            Icons.arrow_circle_right_outlined,
            size: 30.0,
          ),
        ),
      ],
    ),
  );
}
