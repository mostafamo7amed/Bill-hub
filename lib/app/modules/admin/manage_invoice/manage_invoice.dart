import 'package:bill_hub/app/model/invoice_item.dart';
import 'package:bill_hub/app/modules/admin/home/home_cubit/cubit.dart';
import 'package:bill_hub/app/modules/admin/home/home_cubit/states.dart';
import 'package:bill_hub/app/modules/vendor/invoice/view_invoice_pdf.dart';
import 'package:bill_hub/shared/components/component.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../styles/icons_broken.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class ManageAdminInvoice extends StatefulWidget {
  ManageAdminInvoice({Key? key}) : super(key: key);

  @override
  State<ManageAdminInvoice> createState() => _ManageAdminInvoiceState();
}

class _ManageAdminInvoiceState extends State<ManageAdminInvoice> {
  var searchController = TextEditingController();
  final items = ['تم السداد', 'لم يتم السداد'];
  String? value;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        var cubit = AdminCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'الفواتير',
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
            ),
          ),
          body: ConditionalBuilder(
            condition: cubit.allInvoices.isNotEmpty,
            builder: (context) => Column(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(right: 10.0, left: 10, bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: searchController,
                              style: getRegularStyle(
                                  color: ColorManager.white, fontSize: 16),
                              decoration: InputDecoration(
                                label: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text('بحث',
                                      style: getRegularStyle(
                                          color: ColorManager.white, fontSize: 16)),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: ColorManager.gray,
                                ),
                                border: const OutlineInputBorder(),
                                labelStyle: getRegularStyle(
                                    color: ColorManager.white, fontSize: 16),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              onChanged: (value) => cubit.search(value),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          /*DropdownButton(
                            dropdownColor: ColorManager.primary,
                            value: value,
                            icon: Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.white,
                              size: 15,
                            ),
                            items: items.map(buildMenuItem).toList(),
                            onChanged: (value) {
                              setState(() {
                                this.value = value;
                              });
                            },
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(child: ManageBillListView())
              ],
            ),
            fallback: (context) => Center(
                child: Text(
                  'لا توجد فواتير حاليا',
                  style: getSemiBoldStyle(color: ColorManager.black, fontSize: 16),
                )),
          ),
        );
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String text) => DropdownMenuItem(
        value: text,
        child: Container(
            color: ColorManager.primary,
            child: Text(
              text,
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 16),
            )),
      );

  Widget ManageBillListView() {
    var cubit =AdminCubit.getCubit(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          searchController.text.isNotEmpty && cubit.searchList.isEmpty
              ? Center(
            child: Column(
              children: [
                Icon(
                  Icons.search_off,
                  size: 30,
                  color: ColorManager.primary,
                ),
                Text(
                  'لا توجد فواتير',
                  style: getSemiBoldStyle(
                      color: ColorManager.darkGray, fontSize: 16),
                ),
              ],
            ),
          )
              : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (searchController.text.isNotEmpty &&
                  cubit.searchList.isNotEmpty) {
                return BillItemBuilder(
                    cubit.searchList[index], context);
              } else {
                return BillItemBuilder(
                    cubit.allInvoices[index], context);
              }
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 2,
            ),
            itemCount: searchController.text.isNotEmpty &&
                cubit.searchList.isNotEmpty
                ? cubit.searchList.length
                : cubit.allInvoices.length,
          ),
        ],
      ),
    );
  }

  Widget BillItemBuilder(InvoiceItem invoiceItem,context) {
    return InkWell(
      onTap: () {
        navigateTo(context, ViewInvoicePdf(invoiceItem.fileUrl!, false,'admin',0,null));
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    IconBroken.Document,
                    size: 32,
                    color: ColorManager.primary,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "رقم الفاتورة",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.gray, fontSize: 12),
                        ),
                        Text(
                          "#${invoiceItem.invoiceNumber}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                invoiceItem.isPaid!
                    ? Text(
                  "تم السداد",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getSemiBoldStyle(
                      color: ColorManager.gray, fontSize: 12),
                )
                    : Text(
                  "لم يتم السداد",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getSemiBoldStyle(
                      color: ColorManager.gray, fontSize: 12),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            )),
      ),
    );
  }

  /*Future showBillInfoDialog(context) => showDialog(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "بيانات الفاتورة",
                      style:
                          getBoldStyle(color: ColorManager.black, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "البائع",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.gray, fontSize: 12),
                        ),
                        Text(
                          "علي احمد",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.black, fontSize: 14),
                        ),
                        Text(
                          "المشتري",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.gray, fontSize: 12),
                        ),
                        Text(
                          "احمد جمال",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.black, fontSize: 14),
                        ),
                        Text(
                          "المشتريات",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.gray, fontSize: 12),
                        ),
                        Text(
                          "لاب توب",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.black, fontSize: 14),
                        ),
                        Text(
                          "الاجمالي",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.gray, fontSize: 12),
                        ),
                        Text(
                          "5700",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.black, fontSize: 14),
                        ),
                        Text(
                          "تاريخ انتهاء الصلاحية",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.gray, fontSize: 12),
                        ),
                        Text(
                          "35 Jun 2023",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.black, fontSize: 14),
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
      );*/
}
