import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:saranstore/core/common_widget/ss_button.dart';
import 'package:saranstore/core/common_widget/ss_snackbar.dart';
import 'package:saranstore/core/common_widget/ss_textformfield.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/domain/entity/category_entity.dart';
import 'package:saranstore/feature/home/domain/entity/product_entity.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_bloc.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_event.dart';

class AddProductDialog {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final _formKey = GlobalKey<FormState>();
  void addProduct({
    required BuildContext context,
    required CategoryEntity selectedCategory,
    required TextEditingController searchProductController,
    required int id,
    required double rating,
    required String title,
    required String thumbnail,
    required double price,
  }) {
    _titleController.text = title;
    _thumbnailController.text = thumbnail;
    _priceController.text = price != -1 ? price.toString() : '';
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: AppPalette.transparent,
          child: Form(
            key: _formKey,
            child: GlassmorphicContainer(
              width: 310,
              height: 420,
              borderRadius: 12,
              linearGradient: LinearGradient(
                colors: [AppPalette.primaryColor, AppPalette.black],
              ),

              border: 4,
              blur: 3,
              borderGradient: LinearGradient(
                colors: [AppPalette.secondaryColor, AppPalette.orange],
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    // spacing: 10,
                    children: [
                      Expanded(
                        child: RawScrollbar(
                          padding: EdgeInsets.only(right: 4),
                          controller: _scrollController,
                          thumbColor: AppPalette.scrollThumbColor,
                          thickness: 4,
                          radius: Radius.circular(6),
                          child: Center(
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 16,
                                  left: 16,
                                  bottom: 25,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 20,
                                  children: [
                                    Text(
                                      title.isNotEmpty
                                          ? "Edit product"
                                          : "Add product",
                                      style: TextStyle(
                                        color: AppPalette.secondaryColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SsTextformfield(
                                      controller: _titleController,
                                      labelText: "Title",
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return "Enter the title";
                                        }
                                        return null;
                                      },
                                    ),
                                    SsTextformfield(
                                      controller: _thumbnailController,
                                      labelText: "Thumbnail URL",
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return "Enter the thumbnail url";
                                        }
                                        return null;
                                      },
                                    ),
                                    Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        SsTextformfield(
                                          suffix: Tooltip(
                                            message:
                                                '-> Only one decimal place is allowed\n-> Max length allowed: 7\n-> Digits & a decimal only allowed',
                                            child: Icon(
                                              Icons.info_outline,
                                              color: AppPalette.orange,
                                            ),
                                          ),
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                decimal: true,
                                              ),

                                          controller: _priceController,
                                          labelText: "Price",
                                          maxLength: 7,
                                          validator: (v) {
                                            if (v == null || v.isEmpty) {
                                              return "Enter the price";
                                            }
                                            final regex = RegExp(
                                              r'^\d+(\.\d)?$',
                                            );

                                            if (!regex.hasMatch(v)) {
                                              return "Enter valid price";
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: SsButton(
                                        prefixIcon: title.isNotEmpty
                                            ? Icons.edit
                                            : Icons.add,
                                        onPressed: () {
                                          if (title.isNotEmpty) {
                                            if (!(_formKey.currentState!
                                                .validate())) {
                                              return;
                                            }

                                            context.read<HomeBloc>().add(
                                              EditProductEvent(
                                                updatedProduct: ProductEntity(
                                                  id: id,
                                                  title: _titleController.text,
                                                  thumbnail:
                                                      _thumbnailController.text,
                                                  price:
                                                      double.tryParse(
                                                        _priceController.text,
                                                      ) ??
                                                      0.0,
                                                  rating: rating,
                                                ),
                                              ),
                                            );
                                            Navigator.pop(dialogContext);
                                            SsSnackbar().show(
                                              context: context,
                                              message:
                                                  "Product edited successfully :)",
                                            );
                                          } else {
                                            if (!(_formKey.currentState!
                                                .validate())) {
                                              return;
                                            }

                                            searchProductController.clear();

                                            context.read<HomeBloc>().add(
                                              AddProductEvent(
                                                product: ProductEntity(
                                                  id: 0,
                                                  title: _titleController.text,
                                                  thumbnail:
                                                      _thumbnailController.text,
                                                  price:
                                                      double.tryParse(
                                                        _priceController.text,
                                                      ) ??
                                                      0.0,
                                                  rating: 0.0,
                                                ),
                                                selectedCategory:
                                                    selectedCategory,
                                              ),
                                            );

                                            Navigator.pop(dialogContext);
                                          }
                                        },
                                        buttonText: title.isNotEmpty
                                            ? "Edit"
                                            : "Add",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: InkWell(
                      splashColor: AppPalette.transparent,
                      highlightColor: AppPalette.transparent,
                      hoverColor: AppPalette.transparent,
                      onTap: () {
                        Navigator.pop(dialogContext);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 17,
                            backgroundColor: AppPalette.secondaryColor,
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: AppPalette.primaryColor,
                          ),
                          Icon(
                            Icons.close,
                            size: 23,
                            fontWeight: FontWeight.w100,
                            color: AppPalette.secondaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
