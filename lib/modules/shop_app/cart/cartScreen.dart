import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/models/shop_app/shop_get_cart_model.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopCartScreen extends StatelessWidget {
  const ShopCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => buildCartItem(ShopCubit.get(context).getCartModel!.data!.cartItems[index], context),
                  separatorBuilder: (context, index) => separator(),
                  itemCount: ShopCubit.get(context).getCartModel!.data!.cartItems.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "TOTAL",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '\$',
                              style: TextStyle(
                                color: Colors.deepOrange.shade400,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 2.0,),
                            Text(
                              '${ShopCubit.get(context).getCartModel!.data!.total}',
                              style: TextStyle(
                                color: Colors.deepOrange.shade400,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    defaultButton(
                      width: 200.0,
                      height: 50.0,
                      function: (){},
                      text: 'Checkout',
                      fontSize: 18.0,
                      radius: 10.0,
                      color: Colors.deepOrange.shade400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildCartItem(CartItems cartItems, context) => Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(cartItems.product!.image!),
              width: 150.0,
              height: 150.0,
            ),
            if (cartItems.product!.discount != 0)
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
                  height: 60.0,
                  child: Text(
                    cartItems.product!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${cartItems.product!.price}',
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    if (cartItems.product!.discount != 0)
                      Text(
                        '${cartItems.product!.oldPrice}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          height: 1.3,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 30.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: (){
                        // Validation
                        if(ShopCubit.get(context).quantity > 1){
                          ShopCubit.get(context).decreaseQuantity();
                        }
                      },
                      icon: const Icon(
                        Icons.remove,
                      ),
                    ),
                    Container(
                      width: 30.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(7.0)),
                        color: Colors.deepOrange[200],
                      ),
                      child: Center(
                        child: Text(
                          '${ShopCubit.get(context).quantity}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        ShopCubit.get(context).increaseQuantity();
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),

                    const Spacer(),
                    IconButton(
                      onPressed: (){
                        int productId = cartItems.product!.id!;
                        ShopCubit.get(context).changeCart(productId);
                        showToast(
                          text: ShopCubit.get(context).cart[productId]!
                              ? "Added to cart"
                              : "Removed from cart",
                          state: ToastStates.SUCCESS,
                        );
                      },
                      icon: const Icon(
                        Icons.delete_outline_rounded,
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