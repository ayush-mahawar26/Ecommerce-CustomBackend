import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_custom_backend/constants/colors.dart';
import 'package:ecommerce_custom_backend/constants/size.config.dart';
import 'package:ecommerce_custom_backend/cubits/add.product.cubit.dart';
import 'package:ecommerce_custom_backend/cubits/auth.cubit.dart';
import 'package:ecommerce_custom_backend/cubits/states/add.product.state.dart';
import 'package:ecommerce_custom_backend/utils/utils.dart';
import 'package:ecommerce_custom_backend/widgets/custom.widget.dart';
import 'package:ecommerce_custom_backend/widgets/snackbar.dart';
import 'package:ecommerce_custom_backend/widgets/user_widgets/crousel.images.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  TextEditingController title = TextEditingController();

  TextEditingController descp = TextEditingController();

  TextEditingController price = TextEditingController();

  TextEditingController quantity = TextEditingController();

  TextEditingController category = TextEditingController();

  List<File> images = [];

  @override
  void dispose() {
    title.dispose();
    descp.dispose();
    price.dispose();
    category.dispose();
    quantity.dispose();
    super.dispose();
  }

  selectImages() async {
    var results = await AppUtils().pickImages();
    setState(() {
      images = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        centerTitle: true,
        backgroundColor: AppColors().selectedItems,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.width / 2,
                child: GestureDetector(
                  onTap: () {
                    selectImages();
                  },
                  child: (images.isEmpty)
                      ? DottedBorder(
                          radius: const Radius.circular(20),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.folder),
                                Text("Upload Product Images")
                              ],
                            ),
                          ))
                      : CarouselSlider(
                          items: images.map((e) {
                            return Builder(builder: ((context) {
                              return SizedBox(
                                height: 200,
                                width: SizeConfig.width,
                                child: Image.file(e),
                              );
                            }));
                          }).toList(),
                          options: CarouselOptions(
                              height: 200, viewportFraction: 1)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomWidget().customTextFeild(title, "Title"),
              const SizedBox(
                height: 15,
              ),
              CustomWidget().customTextFeild(descp, "Description"),
              const SizedBox(
                height: 15,
              ),
              CustomWidget().customTextFeild(price, "Price"),
              const SizedBox(
                height: 15,
              ),
              CustomWidget().customTextFeild(quantity, "Quantity"),
              const SizedBox(
                height: 15,
              ),
              CustomWidget().customTextFeild(category, "Category"),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<ProductAddCubit, AddProductState>(
                  builder: (context, state) {
                if (state is AddingProductState) {
                  return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors().darkGold),
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ));
                }

                return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors().darkGold),
                    ),
                    onPressed: () async {
                      AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
                      ProductAddCubit productAdd =
                          BlocProvider.of<ProductAddCubit>(context);

                      await productAdd.addTheProduct(
                          authCubit.user.username.toString(),
                          title.text,
                          descp.text,
                          int.parse(price.text),
                          int.parse(quantity.text),
                          images,
                          category.text);
                    },
                    child: const Center(
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text("Add Product")),
                    ));
              }, listener: (context, state) {
                if (state is AddingErrorState) {
                  ShowMessage().showSnackBar(state.err, context);
                }

                if (state is AddedProductState) {
                  ShowMessage().showSnackBar("Product is added", context);
                  Navigator.pop(context);
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
