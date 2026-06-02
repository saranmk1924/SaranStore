import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  final _formKey = GlobalKey<FormState>();
  void addProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppPalette.white, width: 1),
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
          backgroundColor: AppPalette.secondaryColor,
          title: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    splashColor: AppPalette.transparent,
                    highlightColor: AppPalette.transparent,
                    hoverColor: AppPalette.transparent,
                    onTap: () {
                      Navigator.pop(dialogContext);
                    },
                    child: Icon(
                      Icons.close,
                      size: 30,
                      weight: 2,
                      color: AppPalette.primaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                "Add product",
                style: TextStyle(
                  color: AppPalette.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                children: [
                  // SizedBox(height: 10),
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
                    controller: _priceController,
                    labelText: "Price",
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Enter the price";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),

          actions: [
            Center(
              child: SsButton(
                prefixIcon: Icons.add,
                onPressed: () {
                  if (!(_formKey.currentState!.validate())) {
                    return;
                  }

                  context.read<HomeBloc>().add(
                    AddProductEvent(
                      product: ProductEntity(
                        id: 0,
                        title: _titleController.text,
                        thumbnail: _thumbnailController.text,
                        price: double.tryParse(_priceController.text) ?? 0.0,
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
        );
      },
    );
  }
}
