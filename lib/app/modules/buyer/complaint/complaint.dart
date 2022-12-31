import 'package:flutter/material.dart';

import '../../../../shared/components/component.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import 'complaint_details_view.dart';

class BuyerComplaint extends StatelessWidget {
  BuyerComplaint({Key? key}) : super(key: key);
  var titleController =TextEditingController();
  var descriptionController =TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'الشكاوي',
            style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
          ),
        ),
        body: Column(children: [
          const SizedBox(
            width: double.infinity,
            child: TabBar(
              labelColor: Colors.red,
              isScrollable: true,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.red,
              indicatorPadding: EdgeInsets.all(15),
              physics: BouncingScrollPhysics(),
              tabs: [
                Tab(text: "إضافة شكوي"),
                Tab(text: "متابعة شكوي"),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                  children: [addNewComplaint(context), viewComplaint(context)]),
            ),
          ),
        ],),
      ),
    );
  }

  Widget addNewComplaint(context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            defaultFormField(
                controller: titleController,
                label: ' عنوان المشكلة ',
                validate: (value) {
                  if(value.isEmpty){
                    return 'من فضلك ادخل عنوان المشكلة ';
                  }
                  return null;
                },
                type: TextInputType.text,
                context: context),
            SizedBox(height: 10,),
            TextFormField(
              controller: descriptionController,
              maxLines: null,
              style: getRegularStyle(color: ColorManager.black,fontSize: 16),
              decoration:InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 8, vertical: 5),
                label:Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(' وصف المشكلة ',
                      style: getRegularStyle(color: ColorManager.black, fontSize: 16)),
                ),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'من فضلك ادخل وصف المشكلة ';
                }
                return null;
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 10,),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(ColorManager.primary),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
              ),
              onPressed: () {
                //ToDo view user
              },
              child: Text(
                "إضافة الشكوي",
                style: getRegularStyle(color: ColorManager.white, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    ),
  );

  Widget viewComplaint(context) => SingleChildScrollView(
    scrollDirection: Axis.vertical,
    physics: const BouncingScrollPhysics(),
    child: Column(
      children: [
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ComplaintItemBuilder(context);
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 2,
            ),
            itemCount: 1 // todo list students
        ),
      ],
    ),
  );

  Widget ComplaintItemBuilder(context) {
    return InkWell(
      onTap: () {
        navigateTo(context, ComplaintBuyerDetailsView());
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
                  child: Image.asset(ImageAssets.complaint,width: 40,height: 40,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "عنوان الشكوي",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  "لم يتم الرد",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getSemiBoldStyle(
                      color: ColorManager.gray, fontSize: 14),
                ),
                SizedBox(width: 10,),
              ],
            )),
      ),
    );
  }
}
