import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/models/shop_app/category_details_model.dart';
import 'package:shop_app/shared/components/components.dart';

class ClothesCategory extends StatelessWidget {
  const ClothesCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final clothesDetailedData = ShopCubit.get(context).clothesCategory!.data!.data;
        return Scaffold(
          appBar: AppBar(),
          body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => buildClothesCategoryItem(clothesDetailedData[index], context),
            separatorBuilder: (context, index) => separator(),
            itemCount: ShopCubit.get(context).clothesCategory!.data!.data.length,
          ),
        );
      },
    );
  }

  Widget buildClothesCategoryItem(DetailedData clothesDetailedData, context) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 160.0,
          width: double.infinity,
          child: Row(
            children: [
              buildProductImage(clothesDetailedData),
              const SizedBox(width: 10.0),
              Expanded(
                child: buildProductDetails(clothesDetailedData, context),
              ),
            ],
          ),
        ),
      );

  Widget buildProductImage(DetailedData clothesDetailedData) => Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Image.network(
        clothesDetailedData.image!,
        width: 150.0,
        height: 150.0,
      ),
      if (clothesDetailedData.discount != 0)
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

  Widget buildProductDetails(DetailedData clothesDetailedData, context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildProductName(clothesDetailedData),
      buildProductPrice(clothesDetailedData, context),
    ],
  );

  Widget buildProductName(DetailedData clothesDetailedData) => SizedBox(
    height: 108.0,
    child: Text(
      clothesDetailedData.name!,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
    ),
  );

  Widget buildProductPrice(DetailedData clothesDetailedData, context) => Row(
    children: [
      buildCurrentPrice(clothesDetailedData),
      const SizedBox(width: 5.0),
      if (clothesDetailedData.discount != 0)
        buildOldPrice(clothesDetailedData),
      const Spacer(),
      buildFavoriteButton(clothesDetailedData, context),
    ],
  );

  Widget buildCurrentPrice(DetailedData clothesDetailedData) => Text(
    '${clothesDetailedData.price!.round()}',
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
      fontSize: 14.0,
      height: 1.3,
      fontWeight: FontWeight.bold,
      color: Colors.deepOrange,
    ),
  );

  Widget buildOldPrice(DetailedData clothesDetailedData) => Text(
    '${clothesDetailedData.oldPrice!.round()}',
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

  Widget buildFavoriteButton(DetailedData clothesDetailedData, context) => IconButton(
    onPressed: () {
      int productId = clothesDetailedData.id!;
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
      backgroundColor: ShopCubit.get(context).favorites[clothesDetailedData.id]!
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
