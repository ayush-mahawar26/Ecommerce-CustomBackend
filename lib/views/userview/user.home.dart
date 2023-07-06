import 'package:ecommerce_custom_backend/constants/colors.dart';
import 'package:ecommerce_custom_backend/constants/global.variable.dart';
import 'package:ecommerce_custom_backend/constants/size.config.dart';
import 'package:ecommerce_custom_backend/models/product.model.dart';
import 'package:ecommerce_custom_backend/widgets/custom.widget.dart';
import 'package:ecommerce_custom_backend/widgets/user_widgets/crousel.images.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserHome extends StatelessWidget {
  UserHome({super.key});

  final TextEditingController _itemSearch = TextEditingController();

  ProductModel product = ProductModel(
      name: "laptop",
      description: "goosd lap",
      price: 75000,
      quantity: 10,
      images: [
        "https://static.langimg.com/thumb/93654834/touch-screen-laptop-under-30000-rupees-93654834.jpg?imgsize=34856&width=700&height=525&resizemode=75"
      ],
      category: "Electronics");

  Widget customSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: SizeConfig.width / 8,
        child: Card(
          elevation: 2,
          child: TextField(
            controller: _itemSearch,
            decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                suffixIcon: const Icon(Icons.camera_alt_rounded),
                hintText: "Search Amazon.in",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors().grey)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors().grey)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors().grey)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors().grey))),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppColors().blue, AppColors().lblue])),
          width: SizeConfig.width,
          height: SizeConfig.width / 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: customSearchBox()),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.mic,
                        size: SizeConfig.width / 16,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: SizeConfig.width / 8,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppColors().lightBlue, AppColors().lightestBlue])),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Deliver to - Ayush , Maidan garhi",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ),
        SizedBox(
            height: SizeConfig.width / 5,
            child: ListView.builder(
                itemExtent: SizeConfig.width / 5,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: GlobalVariables.categoryImages.length,
                itemBuilder: (context, index) {
                  return categoryItemsWidget(
                      img: GlobalVariables.categoryImages[index]["image"]
                          .toString(),
                      text: GlobalVariables.categoryImages[index]["title"],
                      context: context);
                })),
        CrouselImageWidget(
          images: GlobalVariables.carouselImages,
        ),

        // Deal Of the day
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                "Deal Of the Day",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomWidget().itemWidgets(product, context)
      ],
    ));
  }
}

Widget categoryItemsWidget(
    {required String img, required text, required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Column(
      children: [
        Container(
          width: SizeConfig.width / 9,
          height: SizeConfig.width / 9,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Image.asset(
              img,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12),
        )
      ],
    ),
  );
}
