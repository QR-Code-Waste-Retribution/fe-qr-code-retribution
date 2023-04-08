import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/services/providers/invoice_provider.dart';

class InvoiceRepositories {
  final InvoiceProvider invoiceProvider;

  InvoiceRepositories() : invoiceProvider = InvoiceProvider();

  Future<ResponseAPI> getAllInvoiceUser(_uuid) async {
    ResponseAPI scanQrCodeResponse =
        await invoiceProvider.getInvoiceUser(subDistrictId: 66, uuid: _uuid);
    return scanQrCodeResponse;
  }
}
