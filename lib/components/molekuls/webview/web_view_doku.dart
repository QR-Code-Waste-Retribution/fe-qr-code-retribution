import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/core/constants/app_constants.dart';
import 'package:qr_code_app/core/constants/storage.dart';
import 'package:qr_code_app/services/providers/transaction_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class WebViewDoku extends StatefulWidget {
  final String url;
  final int transactionId;

  const WebViewDoku({
    super.key,
    required this.url,
    required this.transactionId,
  });

  @override
  State<WebViewDoku> createState() => _WebViewDokuState();
}

class _WebViewDokuState extends State<WebViewDoku> {
  late final WebViewController controller;
  final TransactionProvider _transactionProvider =
      Get.find<TransactionProvider>();

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url
              .startsWith('http://${AppConstants.dokuRedirectCheckout}')) {
            List<int?> arrInvoiceId =
                StorageReferences().getInvoiceIdArrayFromLocalStorage();
            int transactionId = widget.transactionId;

            _transactionProvider.updateStatusTransaction(
                arrInvoiceId: arrInvoiceId, transactionId: transactionId);

            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(
        Uri.parse(widget.url.replaceAll('"', '')),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: secondaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: (() {
            Get.back();
          }),
        ),
        title: Text(
          "Pembayaran Non Cash",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
