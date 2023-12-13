import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/models/shop_app/category_details_model.dart';
import 'package:shop_app/shared/components/components.dart';

class LightingCategory extends StatelessWidget {
  const LightingCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final lightingDetailedData = ShopCubit.get(context).lightingCategory!.data!.data;
        return Scaffold(
          appBar: AppBar(),
          body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => buildLightingCategoryItem(lightingDetailedData[index], context),
            separatorBuilder: (context, index) => separator(),
            itemCount: ShopCubit.get(context).lightingCategory!.data!.data.length,
          ),
        );
      },
    );
  }

  Widget buildLightingCategoryItem(DetailedData lightingDetailedData, context) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 160.0,
          width: double.infinity,
          child: Row(
            children: [
              buildProductImage(lightingDetailedData),
              const SizedBox(width: 10.0),
              Expanded(
                child: buildProductDetails(lightingDetailedData, context),
              ),
            ],
          ),
        ),
      );

  Widget buildProductImage(DetailedData lightingDetailedData) => Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Image.network(
        lightingDetailedData.image!,
        width: 150.0,
        height: 150.0,
      ),
      if (lightingDetailedData.discount != 0)
        buildDiscountContainer(),
    ],
  );

  Widget buildDiscountContainer() => Container(
    color: Colors.red,
    padding: const EdgeInsets.symmetric(horizontal: 5.0),
    child: const Text(
      'DISCOUNT',
      style: TextStyle(
        fontSize: 10.0,
        color: Colors.white,
      ),
    ),
  );

  Widget buildProductDetails(DetailedData lightingDetailedData, context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildProductName(lightingDetailedData),
      buildProductPrice(lightingDetailedData, context),
    ],
  );

  Widget buildProductName(DetailedData lightingDetailedData) => SizedBox(
    height: 108.0,
    child: Text(
      lightingDetailedData.name!,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
    ),
  );

  Widget buildProductPrice(DetailedData lightingDetailedData, context) => Row(
    children: [
      buildCurrentPrice(lightingDetailedData),
      const SizedBox(width: 5.0),
      if (lightingDetailedData.discount != 0)
        buildOldPrice(lightingDetailedData),
      const Spacer(),
      buildFavoriteButton(lightingDetailedData, context),
    ],
  );

  Widget buildCurrentPrice(DetailedData lightingDetailedData) => Text(
    '${lightingDetailedData.price!.round()}',
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
      fontSize: 14.0,
      height: 1.3,
      fontWeight: FontWeight.bold,
      color: Colors.deepOrange,
    ),
  );

  Widget buildOldPrice(DetailedData lightingDetailedData) => Text(
    '${lightingDetailedData.oldPrice!.round()}',
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
      fontSize: 12.0,
      height: 1.3,
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.lineThrough,
    ),
  );

  Widget buildFavoriteButton(DetailedData lightingDetailedData, context) => IconButton(
    onPressed: () {
      int productId = lightingDetailedData.id!;
      ShopCubit shopCubit = ShopCubit.get(context);
      shopCubit.changeFavorites(productId);
      showToast(
        text: shopCubit.favorites[productId]!
            ? "Added to favorites"
            : "Removed from favorites",
        state: ToastStates.SUCCESS,
      );
    },
    icon: CircleAvatar(
      radius: 15.0,
      backgroundColor: ShopCubit.get(context).favorites[lightingDetailedData.id]!
          ? Colors.deepOrange
          : Colors.grey,
      child: const Icon(
        Icons.favorite_border,
        size: 15.0,
        color: Colors.white,
      ),
    ),
  );
}
