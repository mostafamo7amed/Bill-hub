import 'package:bill_hub/app/model/product.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../styles/icons_broken.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import 'invoice_cubit/cubit.dart';
import 'invoice_cubit/states.dart';

class CustomerProducts extends StatefulWidget {
  CustomerProducts({Key? key}) : super(key: key);

  @override
  State<CustomerProducts> createState() => _CustomerProductsState();
}

class _CustomerProductsState extends State<CustomerProducts> {
  var formKay = GlobalKey<FormState>();
  var amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceCubit, InvoiceStates>(
      listener: (context, state) {
        if(state is InvoiceRemoveProductToListState){
          if(InvoiceCubit.getCubit(context).customerProducts.isEmpty){
            InvoiceCubit.getCubit(context).change3(false);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'معلومات المشتريات',
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showAddProductDialog(context);
            },
            child: Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  viewProducts(context),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Text(
                          'الاجمالي : ',
                          style: getSemiBoldStyle(
                              color: ColorManager.black, fontSize: 16),
                        ),
                        Text(
                          '${InvoiceCubit.getCubit(context).total}',
                          style: getSemiBoldStyle(
                              color: ColorManager.black, fontSize: 16),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget viewProducts(context) => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildProductItem(
                      InvoiceCubit.getCubit(context).customerProducts[index],
                      context,
                      index);
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 2,
                    ),
                itemCount: InvoiceCubit.getCubit(context)
                    .customerProducts
                    .length,
                ),
          ],
        ),
      );

  Widget buildProductItem(Product product, context, index) => Card(
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
                      "${product.name}",
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
                      "${product.price}",
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
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "الكمية",
                      style: getSemiBoldStyle(
                          color: ColorManager.darkGray, fontSize: 14),
                    ),
                    Text(
                      "${product.amount}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: getSemiBoldStyle(
                          color: ColorManager.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  InvoiceCubit.getCubit(context).removeProductToList(index);
                },
                color: ColorManager.error,
                icon: Icon(
                  IconBroken.Delete,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      );

  Future showAddProductDialog(context) => showDialog(
        context: context,
        builder: (context) {
          var  cubit =InvoiceCubit.getCubit(context);
          return BlocConsumer<InvoiceCubit,InvoiceStates>(
           listener: (context, state) {
             if(state is GetProductPriceSuccessState){
               int amount = int.parse(amountController.text);
               cubit.addProductToList(
                   Product('1',cubit.value, cubit.price, amount,false));
               cubit.change3(true);
               amountController.text = '';
               Navigator.pop(context);
             }
           },
            builder: (context, state) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKay,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "أختر المنتج",
                            style: getBoldStyle(
                                color: ColorManager.black, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "أسم المنتج: ",
                                style: getSemiBoldStyle(
                                    color: ColorManager.darkGray, fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: DropdownButton(
                                  dropdownColor: ColorManager.lightPrimary,
                                  value: cubit.value,
                                  isExpanded: true,
                                  icon: Icon(
                                    Icons.arrow_drop_down_outlined,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  items: cubit.allProducts.map(buildMenuItem).toList(),
                                  style: getSemiBoldStyle(
                                      color: ColorManager.black, fontSize: 16),
                                  onChanged: (value) {
                                    cubit.changeDropDown(value!);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "الكمية: ",
                                style: getSemiBoldStyle(
                                    color: ColorManager.darkGray, fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: TextFormField(
                                    controller: amountController,
                                    keyboardType: TextInputType.number,
                                    style: getRegularStyle(
                                        color: ColorManager.black, fontSize: 16),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'من فضلك أدخل الكمية';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
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
                                  if (formKay.currentState!.validate()) {
                                    var cubit =InvoiceCubit.getCubit(context);
                                    cubit.getProductPrice(cubit.value!);
                                  }
                                },
                                child: ConditionalBuilder(
                                  condition: state is! GetProductPriceLoadingState,
                                  builder: (context) => Text(
                                    "إضافة",
                                    style: getRegularStyle(
                                        color: ColorManager.white, fontSize: 16),
                                  ),
                                  fallback: (context) => const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
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
                ),
              );
            },
          );
        },
      );

  DropdownMenuItem<String> buildMenuItem(String text) => DropdownMenuItem(
        value: text,
        child: Container(
            child: Text(
          text,
          style: getSemiBoldStyle(color: ColorManager.black, fontSize: 16),
        )),
      );
}
