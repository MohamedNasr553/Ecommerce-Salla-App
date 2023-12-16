import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/models/shop_app/shop_get_favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopFavoriteScreen extends StatelessWidget {
  const ShopFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          body: ListView.separated(
            itemBuilder: (context, index) => buildFavoriteItem(ShopCubit.get(context).getFavoritesModel!.data!.data[index], context),
            separatorBuilder: (context, index) => separator(),
            itemCount: ShopCubit.get(context).getFavoritesModel!.data!.data.length,
          ),
        );
      },
    );
  }

  Widget buildFavoriteItem(DetailedData productDetailedData, context) => Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(productDetailedData.product!.image!),
              width: 150.0,
              height: 150.0,
            ),
            if (productDetailedData.product!.discount != 0)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 10.0,),
        Expanded(
          child: Container(
            height: 160.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100.0,
                  child: Text(
                    productDetailedData.product!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${productDetailedData.product!.price}',
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    if (productDetailedData.product!.discount != 0)
                      Text(
                        '${productDetailedData.product!.oldPrice}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10.0,
                          height: 1.3,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        int productId = productDetailedData.product!.id!;
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
                        backgroundColor: ShopCubit.get(context).favorites[productDetailedData.product!.id]!
                            ? Colors.deepOrange
                            : Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
