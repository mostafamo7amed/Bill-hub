import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/cubit.dart';
import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/states.dart';
import 'package:bill_hub/shared/components/component.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../styles/icons_broken.dart';
import '../../../model/product.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import 'add_product_view.dart';
import 'edit_product_view.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();

}

class _ProductViewState extends State<ProductView> {

  @override
  void initState() {
    if(InvoiceCubit.getCubit(context).allVendorProducts.isEmpty){
      InvoiceCubit.getCubit(context).GetVendorProducts();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceCubit,InvoiceStates>(
      listener: (context, state) {
        if(state is HideProductSuccessState){
          InvoiceCubit.getCubit(context).GetVendorProducts();
        }
      },
      builder: (context, state) {
        var cubit  = InvoiceCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'المنتجات',
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
            ),
          ),
          body: ConditionalBuilder(
            condition: cubit.allVendorProducts.isNotEmpty,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildProductItem(cubit.allVendorProducts[index],context,index),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 3,
                ),
                itemCount: cubit.allVendorProducts.length),
            fallback: (context) => Center(child: Text('لا توجد منتجات حاليا',style: getSemiBoldStyle(color: ColorManager.black,fontSize: 16),)
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              //add product
              navigateTo(context, AddProductView());
            },
          ),
        );
      },
    );
  }

  Widget buildProductItem(Product model,context,index) => InkWell(
        onTap: () {
          showProductInfoDialog(model,context,index);
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
                        "${model.name}",
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
                        "${model.price} \$",
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
                        "${model.amount}",
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

  Future showProductInfoDialog(Product model,context,index) => showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<InvoiceCubit,InvoiceStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = InvoiceCubit.getCubit(context);
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
                              "${model.name}",
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
                              "${model.price} \$",
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
                              "${model.amount}",
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
                              "حالة المنتج",
                              style: getSemiBoldStyle(
                                  color: ColorManager.darkGray, fontSize: 14),
                            ),
                            model.hide!?
                            Text(
                              "مخفي",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: getSemiBoldStyle(
                                  color: ColorManager.black, fontSize: 14),
                            ):Text(
                              "متاح",
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
                                Navigator.pop(context);
                                navigateTo(context, EditProductView(model,index));
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
                                cubit.HideProducts(productId: model.productId!, hide: !model.hide!, index: index);
                                Navigator.pop(context);
                                },
                              child: model.hide!?
                              Text(
                                "أظهار",
                                overflow: TextOverflow.ellipsis,
                                style: getRegularStyle(
                                    color: ColorManager.white),
                              ):Text(
                                "إخفاء",
                                overflow: TextOverflow.ellipsis,
                                style: getRegularStyle(
                                    color: ColorManager.white),
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
        },
      );
}
