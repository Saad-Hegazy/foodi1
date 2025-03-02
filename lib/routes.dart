import 'package:foodi1/view/screen/address/add.dart';
import 'package:foodi1/view/screen/address/adddetails.dart';
import 'package:foodi1/view/screen/address/view.dart';
import 'package:foodi1/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:foodi1/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:foodi1/view/screen/auth/forgetpassword/success_resetpassword.dart';
import 'package:foodi1/view/screen/auth/forgetpassword/verifycode.dart';
import 'package:foodi1/view/screen/auth/forgetpassword/verifycodesignup.dart';
import 'package:foodi1/view/screen/auth/forgetpassword/verifyemailcodesignup.dart';
import 'package:foodi1/view/screen/auth/login.dart';
import 'package:foodi1/view/screen/auth/signup.dart';
import 'package:foodi1/view/screen/auth/success_sinup.dart';
import 'package:foodi1/view/screen/cart.dart';
import 'package:foodi1/view/widget/changelanguage.dart';
import 'package:foodi1/view/screen/checkout.dart';
import 'package:foodi1/view/screen/homescreen.dart';
import 'package:foodi1/view/screen/items.dart';
import 'package:foodi1/view/screen/language.dart';
import 'package:foodi1/view/screen/myfavorite.dart';
import 'package:foodi1/view/screen/onboarding.dart';
import 'package:foodi1/view/screen/orders/archive.dart';
import 'package:foodi1/view/screen/orders/details.dart';
import 'package:foodi1/view/screen/orders/pending.dart';
import 'package:foodi1/view/screen/productdetails.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'core/constant/routes.dart';
import 'core/middleware/mymiddleware.dart';


List<GetPage<dynamic>>?routes=[
  //Auth
  GetPage(name: "/", page: ()=>const Language(),middlewares: [MyMiddleWare()]),
  GetPage(name: AppRoute.cart, page: () => const Cart()),
  GetPage(name:  AppRoute.login, page: ()=>const Login(),),
  GetPage(name:  AppRoute.signUp, page: ()=>const SignUp() ),
  GetPage(name:  AppRoute.forgetPassword, page: ()=>const ForgetPassword(),),
  GetPage(name:  AppRoute.verifyCode, page: ()=>const VerfiyCode(),),
  GetPage(name: AppRoute.resetPassword, page: ()=>const ResetPassword(),),
  GetPage(name: AppRoute.successResetPassword, page: ()=>const SuccessRestPasword(),),
  GetPage(name:   AppRoute.successSignUp, page: ()=>const SuccessSignUp(),),
  //OnBoarding
  GetPage(name:  AppRoute.OnBoarding, page: ()=>const OnBoarding(),),
  GetPage(name:  AppRoute.changeLanguage, page: ()=>const changeLanguage(),),
  GetPage(name:  AppRoute.verifyCodeSignUp, page: ()=>const VerifyCodeSignUp(),),
  GetPage(name:  AppRoute.verifyEmailCodeSignUp, page: ()=>const VerifyEmailCodeSignUp(),),
  GetPage(name:  AppRoute.homepage, page: ()=>const HomeScreen(),),
  GetPage(name:  AppRoute.items, page: ()=>const Items(),),
  GetPage(name: AppRoute.productdetails, page: () => const ProductDetails()),
  GetPage(name: AppRoute.myfavroite, page: () => const MyFavorite()),
  //
  GetPage(name: AppRoute.addressview, page: () => const AddressView()),
  GetPage(name: AppRoute.addressadd, page: () => const AddressAdd()),
  GetPage(name: AppRoute.addressadddetails, page: () => const AddressAddDetails()),
  GetPage(name: AppRoute.checkout, page: () => const Checkout()),
  GetPage(name: AppRoute.orderspending, page: () => const OrdersPending()),
  GetPage(name: AppRoute.ordersarchive, page: () => const OrdersArchiveView()),
  GetPage(name: AppRoute.ordersdetails, page: () => const OrdersDetails()),
 // GetPage(name: AppRoute.offers, page: () => const OffersView()),
];
