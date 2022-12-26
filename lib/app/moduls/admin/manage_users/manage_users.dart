import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class ManageUsers extends StatelessWidget {
  const ManageUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إدارة البائعين',style: getSemiBoldStyle(color: ColorManager.white,fontSize: 20),),
      ),
      body: UserListView(),
    );
  }
  Widget UserListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return UserItemBuilder(context);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
              itemCount: 10 // todo list students
          ),
        ],
      ),
    );
  }

  Widget UserItemBuilder(context) {
    return InkWell(
      onTap: () => showUserInfoDialog(context),
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
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "محمود محمد علي",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 16),
                        ),
                        Text(
                          "اسم الشركة",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.gray, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  style: const ButtonStyle(
                      backgroundColor:
                      MaterialStatePropertyAll(Colors.green)),
                  onPressed: () {
                    //ToDo view user
                  },
                  child: Text(
                    "قبول",
                    style: getRegularStyle(color: ColorManager.white),
                  ),
                ),
                const SizedBox(width:5,),
                TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  onPressed: () {
                    //ToDo block user
                  },
                  child: Text(
                    "حظر",
                    style: getRegularStyle(color: ColorManager.white),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),

              ],
            )),
      ),
    );
  }

  Future showUserInfoDialog(context) => showDialog(
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
                  "بيانات البائع",
                  style: getBoldStyle(
                      color: ColorManager.black, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "أسم البائع",
                      style: getSemiBoldStyle(
                          color: ColorManager.gray, fontSize: 14),
                    ),
                    Text(
                      "محمود محمد علي",
                      style: getSemiBoldStyle(
                          color: ColorManager.black, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اسم الشركة",
                      style: getSemiBoldStyle(
                          color: ColorManager.gray, fontSize: 14),
                    ),
                    Text(
                      "الصفا",
                      style: getSemiBoldStyle(
                          color: ColorManager.black, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "هاتف الشركة",
                      style: getSemiBoldStyle(
                          color: ColorManager.gray, fontSize: 14),
                    ),
                    Text(
                      "+92873656789",
                      style: getSemiBoldStyle(
                          color: ColorManager.black, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "البريد الإلكتروني للشركة",
                      style: getSemiBoldStyle(
                          color: ColorManager.gray, fontSize: 14),
                    ),
                    Text(
                      "example23@example.org",
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
                      },
                      child: Text(
                        "قبول",
                        style: getRegularStyle(color: ColorManager.white),
                      ),
                    ),
                    const SizedBox(width:15,),
                    TextButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red)),
                      onPressed: () {
                        //ToDo block user
                      },
                      child: Text(
                        "حظر",
                        style: getRegularStyle(color: ColorManager.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
