import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_header.dart';
import 'package:qr_code_app/components/molekuls/invoice/invoice_card.dart';
import 'package:qr_code_app/components/molekuls/invoice/invoice_paid_card.dart';
import 'package:qr_code_app/models/invoice/invoice_model.dart';
import 'package:qr_code_app/routes/init.dart';
import 'package:qr_code_app/services/providers/auth/auth_provider.dart';
import 'package:qr_code_app/services/providers/transaction/invoice_provider.dart';
import 'package:qr_code_app/services/providers/pagination_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class MasyarakatHome extends StatefulWidget {
  const MasyarakatHome({
    Key? key,
    required this.device,
  }) : super(key: key);

  final Size device;
  @override
  State<MasyarakatHome> createState() => _MasyarakatHomeState();
}

class _MasyarakatHomeState extends State<MasyarakatHome> {
  final AuthProvider _authProvider = Get.find<AuthProvider>();
  final InvoiceProvider _invoiceProvider = Get.find<InvoiceProvider>();
  final PaginationProvider paginationProvider = Get.find<PaginationProvider>();

  Size device = const Size(0, 0);

  @override
  void initState() {
    super.initState();
    _invoiceProvider.getInvoiceUserByUserId(
        userId: _authProvider.authData.user?.id);
  }

  @override
  Widget build(BuildContext context) {
    device = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'Ayooo, Jangan lupa membayar kewajiban retribusi anda untuk Toba yang lebih indah dan bersih',
          style: blackTextStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomHeader(text: 'Informasi Iuran'),
        // Informasi Iuran
        Obx(
          () => _invoiceProvider.getStatusInvoice()
              ? Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor,
                        blurRadius: 5,
                        offset: const Offset(2, 3.5),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 7),
                  padding: const EdgeInsets.all(15),
                  width: device.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Tagihan Anda Sudah Lunas',
                        textAlign: TextAlign.left,
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Image.asset('assets/image/invoice_success_paid_off.png'),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              paginationProvider.currentIndex.value = 3;
                            },
                            child: Text(
                              'Lihat history >',
                              textAlign: TextAlign.right,
                              style: priceTextStyle.copyWith(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12.5),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor,
                            blurRadius: 5,
                            offset: const Offset(2, 3.5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Tagihan anda',
                                  style: blackTextStyle.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: ' belum lunas',
                                  style: alertTextStyle.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Jumlah tagihan',
                                style: blackTextStyle,
                              ),
                              Text(
                                '${_invoiceProvider.getTotalInvoicePrice()} -',
                                style: blackTextStyle.copyWith(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    paginationProvider.updateCurrentIndex(2),
                                child: Text(
                                  'Lakukan Pembayaran >',
                                  textAlign: TextAlign.end,
                                  style: priceTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Detail Iuran
                    const CustomHeader(text: 'Detail Iuran'),
                    SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            _invoiceProvider.getInvoiceList.invoice.length,
                        itemBuilder: (context, index) {
                          Invoice item =
                              _invoiceProvider.getInvoiceList.invoice[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Tagihan ${index + 1}',
                                    style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              item.status == 1
                                  ? InvoicePaidCard(
                                      categoryName: item.category.name!,
                                    )
                                  : InvoiceCard(
                                      invoice: item,
                                    ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
