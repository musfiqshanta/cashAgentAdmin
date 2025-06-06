import 'package:get/get.dart';

import '../modules/addNotice/bindings/add_notice_binding.dart';
import '../modules/addNotice/views/add_notice_view.dart';
import '../modules/company/bindings/company_binding.dart';
import '../modules/company/views/company_view.dart';
import '../modules/condition/bindings/condition_binding.dart';
import '../modules/condition/views/condition_view.dart';
import '../modules/depositWithdraw/bindings/deposit_binding.dart';
import '../modules/depositWithdraw/views/deposit_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/options/bindings/options_binding.dart';
import '../modules/options/views/options_view.dart';
import '../modules/paymentMethod/bindings/payment_method_binding.dart';
import '../modules/paymentMethod/views/payment_method_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/user/bindings/user_binding.dart';
import '../modules/user/views/user_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NOTICE,
      page: () => const AddNoticeView(),
      binding: AddNoticeBinding(),
    ),
    GetPage(
      name: _Paths.CONDITION,
      page: () => const ConditionView(),
      binding: ConditionBinding(),
    ),
    GetPage(
      name: _Paths.DEPOSIT,
      page: () => const DepositView(),
      binding: DepositBinding(),
    ),
    GetPage(
      name: _Paths.COMPANY,
      page: () => const CompanyView(),
      binding: CompanyBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_METHOD,
      page: () => const PaymentMethodView(),
      binding: PaymentMethodBinding(),
    ),
    GetPage(
      name: _Paths.OPTIONS,
      page: () => const OptionsView(),
      binding: OptionsBinding(),
    ),
    GetPage(
      name: _Paths.USER,
      page: () => const UserView(),
      binding: UserBinding(),
    ),
  ];
}
