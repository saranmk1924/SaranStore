import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:saranstore/core/common_widget/ss_button.dart';
import 'package:saranstore/core/common_widget/ss_textformfield.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/domain/entity/product_entity.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_bloc.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_event.dart';

class AddProductDialog {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  void addProduct(BuildContext context) {
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
                colors: [AppPalette.primaryColor, AppPalette.transparent],
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
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 16,
                          left: 16,
                          top: 16,
                        ),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [],
                        ),
                      ),
                      Expanded(
                        child: RawScrollbar(
                          padding: EdgeInsets.only(right: 4),
                          controller: _scrollController,
                          thumbColor: AppPalette.orange,
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
                                      "Add product",
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
                                    SsTextformfield(
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      
                                      controller: _priceController,
                                      labelText: "Price",
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return "Enter the price";
                                        }
                                        final regex = RegExp(r'^\d+(\.\d+)?$');

                                        if(!regex.hasMatch(v)){
                                          return "Enter valid price";
                                        }
                                        return null;
                                      },
                                    ),
                                    Center(
                                      child: SsButton(
                                        prefixIcon: Icons.add,
                                        onPressed: () {
                                          if (!(_formKey.currentState!
                                              .validate())) {
                                            return;
                                          }

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
                                            ),
                                          );

                                          Navigator.pop(dialogContext);
                                        },
                                        buttonText: "Add",
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
                    top: 10,
                    right: 10,
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
