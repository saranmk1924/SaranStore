import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/core/common_widget/ss_textformfield.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_bloc.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_event.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_state.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/add_product_dialog.dart';
import 'package:saranstore/feature/home/presentation/widgets/product_card.dart';

class ProductsView extends StatelessWidget {
  final ScrollController productsScrollController;
  final TextEditingController searchProductController;
  final HomeLoaded state;
  const ProductsView({
    super.key,
    required this.productsScrollController,
    required this.searchProductController,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: SsTextformfield(
                controller: searchProductController,
                labelText: 'Search product',
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<HomeBloc>().add(
                        FetchCategoriesEvent(isFromProductsList: true),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: AppPalette.secondaryColor,
                      child: Icon(
                        Icons.arrow_back_sharp,
                        color: AppPalette.primaryColor,
                        size: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Text(
                    state.selectedCategory?.name ?? '',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppPalette.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),

            Expanded(
              child: RawScrollbar(
                controller: productsScrollController,
                thumbVisibility: true,
                radius: const Radius.circular(50),
                thickness: 5,
                padding: EdgeInsets.only(right: 1),
                thumbColor: AppPalette.secondaryColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    controller: productsScrollController,
                    primary: false,
                    itemCount: state.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.68,
                        ),
                    itemBuilder: (context, index) {
                      final product = state.products[index];

                      return ProductCard(product: product);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 20,

          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppPalette.orange.withValues(alpha: 0.2),
                  blurRadius: 15,
                  spreadRadius: 20,
                ),
              ],
            ),
            child: FloatingActionButton(
              backgroundColor: AppPalette.secondaryColor,
              foregroundColor: AppPalette.black,
              elevation: 20,
              onPressed: () {
                AddProductDialog().addProduct(
                  context: context,
                  selectedCategory: state.selectedCategory!,
                );
                // ProductEntity product = ProductEntity(
                //   id: 10,
                //   title: "CM Vijay",
                //   thumbnail: "https://pbs.twimg.com/profile_images/1837200576779563009/EcHkTM-M_400x400.jpg",
                //   https://ritzmagazineimages.b-cdn.net/uploads/2020/05/ajith-kumar.jpg
                //   price: 10.8,
                //   rating: 5.0,
                // );

                // context.read<HomeBloc>().add(
                //   AddProductEvent(product: product),
                // );
              },
              child: Icon(Icons.add, fontWeight: FontWeight.w500, size: 35),
            ),
          ),
        ),
      ],
    );
  }
}
