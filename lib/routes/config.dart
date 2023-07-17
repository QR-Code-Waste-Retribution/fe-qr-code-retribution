part of './init.dart';

class Pages {
  static const String loginPage = '/';
  static const String homePage = '/home';
  static const String recapitulationPage = '/recapitulation';
  static const String invoicePage = '/invoice';
  static const String scanQRCodePage = '/scan_qr_code';
  static const String generateQRCodePage = '/generate_qr_code';
  static const String additionalRetributionPage = '/additional_retribution';
  static const String manageUserPage = '/manage_user_page';
  static const String nonCashPaymentPage = '/non_cash_payment';
  static const String virtualAccountListPage = '/virtual_account_page';
  static const String printerPortablePage = '/printer_portable_page';
  static const String invoicePaymentsDetailsPage = '/invoice_payments_details';
  static const String addUserPage = '/add_user';
  static const String editUserPage = '/edit_user';
  static const String historyPaymentPemungutPage = '/history_payment_pemungut';
  static const String changePasswordPage = '/change_password';
  static const String editProfilePage = '/edit_profile';
  static const String forgetPasswordPage = '/forget_password';
  static const String listCategoriesPage = '/list_categories';
  static const String virtualAccountPayPage = '/virtual_account_pay_page';

  static final List<GetPage> pages = [
    GetPage(
      name: loginPage,
      page: () => const LoginPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: homePage,
      page: () => const HomePagination(),
      transition: Transition.fade,
    ),
    GetPage(
      name: recapitulationPage,
      page: () => const RecapitulationPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: invoicePage,
      page: () => const InvoicePeoplePage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: scanQRCodePage,
      page: () => const QRCodeScannerPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: generateQRCodePage,
      page: () => const QRCodeGeneratorPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: additionalRetributionPage,
      page: () => const AdditionalRetributionPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: manageUserPage,
      page: () => const ManageUserPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: nonCashPaymentPage,
      page: () => const NonCashPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: virtualAccountListPage,
      page: () => const VirtualAccountListPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: printerPortablePage,
      page: () => PrinterPortablePage(
        onPrint: () {},
      ),
      transition: Transition.fade,
    ),
    GetPage(
      name: invoicePaymentsDetailsPage,
      page: () => const PaymentDetails(),
      transition: Transition.fade,
    ),
    GetPage(
      name: addUserPage,
      page: () => const AddUserPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: editUserPage,
      page: () => EditUserPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: historyPaymentPemungutPage,
      page: () => const HistoryPaymentPemungutPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: changePasswordPage,
      page: () => ChangePasswordPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: editProfilePage,
      page: () => const EditProfilePage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: forgetPasswordPage,
      page: () => const ForgetPasswordPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: listCategoriesPage,
      page: () => const ListCategoriesPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: virtualAccountPayPage,
      page: () => const VirtualAccountPayPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: OtpInputStagePage.routeName,
      page: () => OtpInputStagePage(),
      transition: Transition.fade,
    ),
  ];
}
