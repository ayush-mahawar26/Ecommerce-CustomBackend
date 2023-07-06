import 'package:ecommerce_custom_backend/constants/colors.dart';
import 'package:ecommerce_custom_backend/constants/size.config.dart';
import 'package:ecommerce_custom_backend/models/product.model.dart';
import 'package:flutter/material.dart';

class CustomWidget {
  AppColors colors = AppColors();

  customTextFeild(TextEditingController controller, String title,
      {isPass = false}) {
    return TextField(
      controller: controller,
      obscureText: isPass,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide()),
          hintText: title),
    );
  }

  customAccountButton(
      String text, Function func, double width, BuildContext context) {
    return SizedBox(
      width: width,
      child: OutlinedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(SizeConfig.width)))),
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(colors.grey)),
          onPressed: () {
            func();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
          )),
    );
  }

  customMainButton(
      String text, Function func, double width, BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(colors.golden)),
          onPressed: () {
            func();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          )),
    );
  }

  Widget itemWidgets(ProductModel product, BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: SizeConfig.width / 2,
      ),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(product.images![0], fit: BoxFit.cover),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                product.name!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\u{20B9} ${product.price!.toString()}",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_outlined,
                        color: AppColors().golden,
                      ),
                      Text(
                        "4.9",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
