import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/shop_search_model.dart';
import 'package:shop_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopSearchScreen extends StatelessWidget {
  ShopSearchScreen({super.key});

  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state){},
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextFormField(
                      validate: (value){
                        if(value!.isEmpty){
                          return "Enter text to search";
                        }
                        return null;
                      },
                      controller: searchController,
                      type: TextInputType.text,
                      labelText: 'Search',
                      prefix: Icons.search,
                      onFieldSubmitted: (text){
                        SearchCubit.get(context).search(
                          text: searchController.text,
                        );
                      }
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    if(state is ShopSearchLoadingState)
                      const LinearProgressIndicator(color: Colors.deepOrange,),
                    const SizedBox(
                      height: 15.0,
                    ),
                    if(state is ShopSearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildSearchItem(SearchCubit.get(context).searchModel!.data!.data[index]),
                          separatorBuilder: (context, index) => separator(),
                          itemCount: SearchCubit.get(context).searchModel!.data!.data.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(DetailedSearchDataModel detailedSearchModel) => Padding(
    padding: const EdgeInsetsDirectional.only(
      end: 10.0,
      top: 10.0,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: NetworkImage(
            detailedSearchModel.image!,
          ),
          width: 150.0,
          height: 150.0,
        ),
        const SizedBox(width: 5.0,),
        Expanded(
          child: Container(
            height: 180.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100.0,
                  child: Text(
                    detailedSearchModel.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${detailedSearchModel.price!.round()}',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 14.0,
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
