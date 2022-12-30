import 'package:bill_hub/shared/components/component.dart';
import 'package:flutter/material.dart';
import '../../../../styles/icons_broken.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import 'add_product_view.dart';

class ProductView extends StatelessWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'المنتجات',
          style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
        ),
      ),
      body: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildProductItem(context),
          separatorBuilder: (context, index) => const SizedBox(
                height: 3,
              ),
          itemCount: 3),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //add product
          navigateTo(context, AddProductView());
        },
      ),
    );
  }

  Widget buildProductItem(context) => InkWell(
        onTap: () {
          showProductInfoDialog(context);
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    IconBroken.Buy,
                    size: 30,
                    color: ColorManager.primary,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "أسم المنتج",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                      Text(
                        "لاب توب",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: getSemiBoldStyle(
                            color: ColorManager.black, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "السعر",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                      Text(
                        "5900\$",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: getSemiBoldStyle(
                            color: ColorManager.black, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الكمية المتاحة",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                      Text(
                        "12",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: getSemiBoldStyle(
                            color: ColorManager.black, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Future showProductInfoDialog(context) => showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "بيانات المنتج",
                      style:
                          getBoldStyle(color: ColorManager.black, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "أسم المنتج",
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 14),
                        ),
                        Text(
                          "لاب توب",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: getSemiBoldStyle(
                              color: ColorManager.black, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "السعر",
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 14),
                        ),
                        Text(
                          "5900\$",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: getSemiBoldStyle(
                              color: ColorManager.black, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "الكمية المتاحة",
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 14),
                        ),
                        Text(
                          "12",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: getSemiBoldStyle(
                              color: ColorManager.black, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.green)),
                          onPressed: () {
                            //ToDo view user
                            navigateTo(context, AddProductView());
                          },
                          child: Text(
                            "تعديل",
                            style: getRegularStyle(color: ColorManager.white),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        TextButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red)),
                          onPressed: () {
                            //ToDo block user
                          },
                          child: Text(
                            "إخفاء",
                            style: getRegularStyle(color: ColorManager.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
