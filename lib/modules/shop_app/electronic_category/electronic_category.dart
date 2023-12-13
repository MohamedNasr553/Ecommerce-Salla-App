import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/models/shop_app/category_details_model.dart';
import 'package:shop_app/shared/components/components.dart';

class ElectronicCategory extends StatelessWidget {
  const ElectronicCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final electronicDetailedData = ShopCubit.get(context).electronicCategoryModel!.data!.data;
        return Scaffold(
          appBar: AppBar(),
          body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => buildElectronicCategoryItem(electronicDetailedData[index], context),
            separatorBuilder: (context, index) => separator(),
            itemCount: ShopCubit.get(context).electronicCategoryModel!.data!.data.length,
          ),
        );
      },
    );
  }

  Widget buildElectronicCategoryItem(DetailedData electronicDetailedData, context) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 160.0,
          width: double.infinity,
          child: Row(
            children: [
              buildProductImage(electronicDetailedData),
              const SizedBox(width: 10.0),
              Expanded(
                child: buildProductDetails(electronicDetailedData, context),
              ),
            ],
          ),
        ),
      );

  Widget buildProductImage(DetailedData electronicDetailedData) => Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Image.network(
        electronicDetailedData.image!,
        width: 150.0,
        height: 150.0,
      ),
      if (electronicDetailedData.discount != 0)
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

  Widget buildProductDetails(DetailedData electronicDetailedData, context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildProductName(electronicDetailedData),
      buildProductPrice(electronicDetailedData, context),
    ],
  );

  Widget buildProductName(DetailedData electronicDetailedData) => SizedBox(
    height: 108.0,
    child: Text(
      electronicDetailedData.name!,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
    ),
  );

  Widget buildProductPrice(DetailedData electronicDetailedData, context) => Row(
    children: [
      buildCurrentPrice(electronicDetailedData),
      const SizedBox(width: 5.0),
      if (electronicDetailedData.discount != 0)
        buildOldPrice(electronicDetailedData),
      const Spacer(),
      buildFavoriteButton(electronicDetailedData, context),
    ],
  );

  Widget buildCurrentPrice(DetailedData electronicDetailedData) => Text(
    '${electronicDetailedData.price!.round()}',
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
      fontSize: 14.0,
      height: 1.3,
      fontWeight: FontWeight.bold,
      color: Colors.deepOrange,
    ),
  );

  Widget buildOldPrice(DetailedData electronicDetailedData) => Text(
    '${electronicDetailedData.oldPrice!.round()}',
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

  Widget buildFavoriteButton(DetailedData electronicDetailedData, context) => IconButton(
    onPressed: () {
      int productId = electronicDetailedData.id!;
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
      backgroundColor: ShopCubit.get(context).favorites[electronicDetailedData.id]!
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
