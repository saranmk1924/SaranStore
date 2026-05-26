import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/core/common_widget/loader.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_bloc.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_state.dart';
import 'package:saranstore/feature/home/presentation/widgets/product_card.dart';

class MobileHomeView extends StatefulWidget {
  @override
  State<MobileHomeView> createState() => _MobileHomeViewState();
}

class _MobileHomeViewState extends State<MobileHomeView> {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.primaryColor,
      appBar: AppBar(
        backgroundColor: AppPalette.primaryColor,
        elevation: 0,
        title: Stack(
          alignment: Alignment.center,
          children: [
            /// Left & Right Items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/pngs/app_logo.png',
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ),

                const Icon(Icons.shopping_cart_outlined, color: Colors.white),
              ],
            ),

            /// Center Title
            ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [AppPalette.secondaryColor, AppPalette.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: const Text(
                'SaranStore',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: Loader());
          }

          if (state is HomeError) {
            return Center(child: Text(state.message));
          }

          if (state is HomeLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppPalette.primaryColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppPalette.white, width: 2),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: AppPalette.white),
                        SizedBox(width: 10),
                        Text(
                          'Search products',
                          style: TextStyle(color: AppPalette.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: RawScrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    radius: const Radius.circular(50),
                    thickness: 5,
                    padding: EdgeInsets.only(right: 1),
                    thumbColor: AppPalette.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        controller: _scrollController,
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
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
