import 'package:bill_hub/app/model/vendor.dart';
import 'package:bill_hub/app/modules/vendor/create_account/vendor_registration_cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterVendorCubit extends Cubit<RegisterVendorStates> {
  RegisterVendorCubit() : super(InitStates());

  static RegisterVendorCubit getCubit(context) => BlocProvider.of(context);

  String? services;
  String? companyType;
  List<dynamic> states=[];
  List<dynamic> servicesItems = [
    {'id':1 ,'name':'مجال المقاولات'},
    {'id':2 ,'name':'مجال الأثاث'},
    {'id':3 ,'name':'خدمات عامة وهوايات و أجهزة ومعدات'},
    {'id':4 ,'name':'خدمات السيارات'},
    {'id':5 ,'name':'مجال المالبس'},
    {'id':6 ,'name':'مجال التكنولوجيا والحساب الألي'},
    {'id':7 ,'name':'مجال التدريب وخدمة الطالب'},
    {'id':8 ,'name':'مجال المواد الغذائية'},
    {'id':9 ,'name':'مجال العطور والبخور والهدايا'},
    {'id':10 ,'name':' مجالات تجارية أخرى'},
  ];
  List<dynamic> companyTypes=[
    {'id':1 ,'name':'مقاولات وخدمات','parentId':1},
    {'id':2 ,'name':'مقاولات فلل ومباني','parentId':1},
    {'id':3 ,'name':'معمل تحليل تربة وطرق','parentId':1},
    {'id':4 ,'name':'مقاول إنشاء مصانع','parentId':1},
    {'id':5 ,'name':'مقاولات تجديد وترميم','parentId':1},
    {'id':6 ,'name':'مقاول تجديد ديكور','parentId':1},
    {'id':7 ,'name':'مقاول هدم وإزالة أنقاض','parentId':1},
    {'id':8 ,'name':'مكتب استقدام','parentId':1},
    {'id':9 ,'name':'مكتب بيع عقارات خارج المملكة','parentId':1},
    {'id':10 ,'name':'توريد بطحاء خرسانة اسمنت وبلاط أرضيات','parentId':1},
    {'id':11 ,'name':'توريد حديد التسليح','parentId':1},

    {'id':1 ,'name':'مركز غسيل أثاث منزلي','parentId':2},
    {'id':2 ,'name':'مركز تصميم الستائر','parentId':2},
    {'id':3 ,'name':'مركز صيانة أجهزة كهربائية','parentId':2},
    {'id':4 ,'name':'مركز صيانة أجهزة تبريد','parentId':2},
    {'id':5 ,'name':'مركز غسيل سجاد وموكيت','parentId':2},
    {'id':6 ,'name':'مركز تنجيد أثاث وباطرمة','parentId':2},
    {'id':7 ,'name':'مركز تأجير لوازم مناسبات','parentId':2},
    {'id':8 ,'name':'مركز نقل الأثاث','parentId':2},
    {'id':9 ,'name':'مركز لتجديد الأثاث','parentId':2},
    {'id':10 ,'name':'مركز رسم لوحات فنية وتحفث','parentId':2},
    {'id':11,'name':'ورشة حياكة اللوحات الكانافا','parentId':2},

    {'id':1 ,'name':'مركز صيانة أجهزة كهربائية','parentId':3},
    {'id':2 ,'name':'مركز صيانة أجهزة تبريد وتكييف','parentId':3},
    {'id':3 ,'name':'مركز للاستفادة من الطاقة الشمسية في المترلة','parentId':3},
    {'id':4 ,'name':'مركز خراطة معادن','parentId':3},
    {'id':5 ,'name':'مركز أشعة','parentId':3},
    {'id':6 ,'name':'مركز صيانة حاسب آلي','parentId':3},
    {'id':7 ,'name':'مركز إصلاح ساعات','parentId':3},
    {'id':8 ,'name':'ورشة صيانة واصلاح طلمبات المياه','parentId':3},
    {'id':9 ,'name':'مركز صيانة شبكات كمبيوتر وسنترالات','parentId':3},
    {'id':10 ,'name':'مركز تدريب حرفي','parentId':3},

    {'id':1 ,'name':'مركز خدمات سيارات (غيار زيت، إطارات)','parentId':4},
    {'id':2 ,'name':'مركز كهربائي سيارات','parentId':4},
    {'id':3 ,'name':'مركز خدمة سريعة للسيارات','parentId':4},
    {'id':4 ,'name':'مركز ميكانيكي سيارات','parentId':4},
    {'id':5 ,'name':'مركز تربيط سيارات','parentId':4},
    {'id':6 ,'name':'مركز عكوس وأذرعة','parentId':4},
    {'id':7 ,'name':'مركز جيربكسات','parentId':4},
    {'id':8 ,'name':'مركز خدمة فرامل','parentId':4},
    {'id':9 ,'name':'مركز خدمات تبريد وتكييف للسيارات','parentId':4},
    {'id':10 ,'name':'مركز تثمين السيارات المستخدمة','parentId':4},

    {'id':1 ,'name':'مغسلة ملابس','parentId':5},
    {'id':2 ,'name':'معرض دوري للمنتجات المنرلية','parentId':5},
    {'id':3 ,'name':'توصيل بضائع من تجار الجملة إلى تجار التجزئة','parentId':5},

    {'id':1 ,'name':'مركز صيانة حاسب آلي','parentId':6},
    {'id':2 ,'name':'مركز تجديد الكمبيوتر وبيع الأجهزة المستخدمة','parentId':6},
    {'id':3 ,'name':'مركز تقديم خدمة إنترنت (مثل نسما وأول نت)','parentId':6},
    {'id':4 ,'name':'مركز عمل عروض التدريب','parentId':6},
    {'id':5 ,'name':'سيارة متنقلة لصيانة الكمبيوتر','parentId':6},
    {'id':6 ,'name':'مركز رسم وتصميم رسوم متحركة -.(3D Max)','parentId':6},
    {'id':7 ,'name':'مركز برمجة أوراكل وقواعد بيانات','parentId':6},
    {'id':8 ,'name':'مركز عمل أفلام كرتون إسلامية','parentId':6},
    {'id':9 ,'name':'موقع تجارة سيارات على الإنترنت','parentId':6},
    {'id':10 ,'name':'موقع استشارات طبية على الإنترنت','parentId':6},

    {'id':1 ,'name':'مركز تدريب لغة إنجليزية','parentId':7},
    {'id':2 ,'name':'مركز تدريب كمبيوتر','parentId':7},
    {'id':3 ,'name':'مركز تدريب إدارة','parentId':7},
    {'id':4 ,'name':'مركز تدريب مهارات وقدرات','parentId':7},
    {'id':5 ,'name':'مركز تدريب غوص','parentId':7},
    {'id':6 ,'name':'مركز تدريب أعمال إنشاءات ومقاولات','parentId':7},
    {'id':7 ,'name':'مركز تدريب فندقة وسياحة','parentId':7},
    {'id':8 ,'name':'مركز تدريب كمال أجسام','parentId':7},
    {'id':9 ,'name':'مركز تدريب عن طريق الإنترنت (التعلم عن بعد)','parentId':7},
    {'id':10 ,'name':'مركز تدريب لغات أوروبية','parentId':7},

    {'id':1 ,'name':'مطاعم بنظام الامتياز التجاري “فرنشايز”','parentId':8},
    {'id':2 ,'name':'مطعم بخاري','parentId':8},
    {'id':3 ,'name':'مطعم اكلات هندية','parentId':8},
    {'id':4 ,'name':'مطعم كباب مشوي','parentId':8},
    {'id':5 ,'name':'مطعم أكلات لبنانية','parentId':8},
    {'id':6 ,'name':'مطعم مأكولات جاوية','parentId':8},
    {'id':7 ,'name':'مطعم مأكولات يابانية','parentId':8},
    {'id':8 ,'name':'مطعم سمك','parentId':8},
    {'id':9 ,'name':'مطعم مقليات (سمبوسة، كبيبة، طعمية)','parentId':8},
    {'id':10 ,'name':'مطعم بيتزا','parentId':8},

    {'id':1 ,'name':'محل بيع عود وبخور','parentId':9},
    {'id':2 ,'name':'محل بيع هدايا وعطور','parentId':9},

    {'id':1 ,'name':'محل بيع أدوات الشواء (فحم وحطب وغيرها)','parentId':10},
    {'id':2 ,'name':'قرطاسية وأدوات مدرسية','parentId':10},
    {'id':3 ,'name':'محل خاص بالبالونات (الهيدروجين)','parentId':10},
    {'id':4 ,'name':'محل بيع مستحضرات التجميل (للسيدات)','parentId':10},
    {'id':5 ,'name':'وكالة (سوبر سيل) الخاص بالبنشر','parentId':10},
    {'id':6 ,'name':'شركة صرافة وتحويل اموال','parentId':10},
    {'id':7 ,'name':'تسجيلات إسلامية','parentId':10},
    {'id':8 ,'name':'معرض مزادات','parentId':10},
    {'id':9 ,'name':'معرض تحف قديمة','parentId':10},
    {'id':10 ,'name':'استديو تصوير','parentId':10},
    {'id':11 ,'name':'محل توزيع أنابيب غاز','parentId':10},
    {'id':12 ,'name':'محل بيع خردة','parentId':10},
    {'id':13 ,'name':'معرض آلات حاسبة وساعات','parentId':10},
    {'id':14 ,'name':'معرض بيع البذور والأسمدة','parentId':10},

  ];



  changeDropDown(String value) {
    this.services = value;
    emit(ChangeDropDownState());
  }


  changeCompanyDropDown(String value) {
    this.companyType = value;
    emit(ChangeCompanyDropDownState());
  }


  changeCompanyType(String value){
    states = companyTypes.where(
            (element) => element['parentId'].toString()==value.toString(),
    ).toList();
    companyType =null;
    emit(ChangeCompanyListState());
  }





  void createVendorAccount({
    required String userType,
    required String email,
    required String name,
    required String phone,
    required String id,
    required String companyName,
    required String companyType,
    required String employment,
    required String blockReason,
    required bool isBlocked,
  }) {
    emit(CreateVendorLoadingState());
    Vendor vendorModel =Vendor(id, name, email, phone, companyName, companyType, employment, isBlocked, blockReason);
      FirebaseFirestore.instance
          .collection(userType)
          .doc(id)
          .set(vendorModel.toMap()!)
          .then((value) {
        emit(CreateVendorSuccessState(id));
      }).catchError((e) {
        emit(CreateVendorErrorState());
      });
  }
}
