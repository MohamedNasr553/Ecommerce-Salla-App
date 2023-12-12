import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/models/shop_app/category_details_model.dart';
import 'package:shop_app/shared/components/components.dart';

class PreventCoronaCategory extends StatelessWidget {
  const PreventCoronaCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final preventCoronaDetailedData = ShopCubit.get(context).preventCoronaCategory!.data!.data;
        return Scaffold(
          appBar: AppBar(),
          body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => buildElectronicCategoryItem(preventCoronaDetailedData[index], context),
            separatorBuilder: (context, index) => separator(),
            itemCount: ShopCubit.get(context).preventCoronaCategory!.data!.data.length,
          ),
        );
      },
    );
  }

  Widget buildElectronicCategoryItem(DetailedData preventCoronaDetailedData, context) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 160.0,
          width: double.infinity,
          child: Row(
            children: [
              buildProductImage(preventCoronaDetailedData),
              const SizedBox(width: 10.0),
              Expanded(
                child: buildProductDetails(preventCoronaDetailedData, context),
              ),
            ],
          ),
        ),
      );

  Widget buildProductImage(DetailedData preventCoronaDetailedData) => Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Image.network(
        preventCoronaDetailedData.image!,
        width: 150.0,
        height: 150.0,
      ),
      if (preventCoronaDetailedData.discount != 0)
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

  Widget buildProductDetails(DetailedData preventCoronaDetailedData, context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildProductName(preventCoronaDetailedData),
      buildProductPrice(preventCoronaDetailedData, context),
    ],
  );

  Widget buildProductName(DetailedData preventCoronaDetailedData) => SizedBox(
    height: 108.0,
    child: Text(
      preventCoronaDetailedData.name!,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
    ),
  );

  Widget buildProductPrice(DetailedData preventCoronaDetailedData, context) => Row(
    children: [
      buildCurrentPrice(preventCoronaDetailedData),
      const SizedBox(width: 5.0),
      if (preventCoronaDetailedData.discount != 0)
        buildOldPrice(preventCoronaDetailedData),
      const Spacer(),
      buildFavoriteButton(preventCoronaDetailedData, context),
    ],
  );

  Widget buildCurrentPrice(DetailedData preventCoronaDetailedData) => Text(
    '${preventCoronaDetailedData.price!.round()}',
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
      fontSize: 14.0,
      height: 1.3,
      fontWeight: FontWeight.bold,
      color: Colors.deepOrange,
    ),
  );

  Widget buildOldPrice(DetailedData preventCoronaDetailedData) => Text(
    '${preventCoronaDetailedData.oldPrice!.round()}',
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

  Widget buildFavoriteButton(DetailedData preventCoronaDetailedData, context) => IconButton(
    onPressed: () {
      ShopCubit.get(context).changeFavorites(preventCoronaDetailedData.id!);
      if (ShopCubit.get(context).favorites[preventCoronaDetailedData.id] == true) {
        showToast(
          text: "added to favorites",
          state: ToastStates.SUCCESS,
        );
      }
    },
    icon: CircleAvatar(
      radius: 18.0,
      backgroundColor: ShopCubit.get(context).favorites[preventCoronaDetailedData.id] ?? false
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
