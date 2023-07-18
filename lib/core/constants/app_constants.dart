import 'package:flutter/material.dart';
import 'package:qr_code_app/models/payment_method_page.dart';
import 'package:qr_code_app/models/doku/virtual_account/virtual_account.dart';

class AppConstants {
  static const String apiUrlServer = 'http://34.142.240.225/api';
  static const String apiUrlLocal = 'http://localhost:8000/api';
  static const String apiUrlNgrok =
      'https://e847-36-79-30-172.ngrok-free.app/api';

  static const String wbServerPort = '8000';
  static const String urlSocketLocal = 'http://localhost:$wbServerPort/';
  static const String urlSocketServer = 'http://34.142.240.225:$wbServerPort/';
  static const String urlSocketNgrok = 'http://34.142.240.225:$wbServerPort/';

  static const int apiTimeout = 5000; // milliseconds

  static const String dokuRedirectCheckout = 'qr_code_app//';
  static const String dokuRedirectCheckoutCancel = 'qr_code_app//';

  static const Map<String, String> headerHome = {
    'pemungut':
        'Selamat datang sebagai petugas di Aplikasi Retribusi Sampah Kabupaten',
    'masyarakat': 'Selamat datang di Aplikasi Retribusi Sampah Kabupaten',
  };

  static PrefPaymentMethodPage preferencesPaymentMethodPage =
      PrefPaymentMethodPage(
    pemungut: RolePayment(
      header: 'Ayo Tagih dan kumpulkan  Retribusi Sampah',
      titleBody: 'Ayo Tagih dan kumpulkan  Retribusi Sampah',
      option: [
        Option(
          title: 'Tagih Iuran Retribusi Sampah',
          body:
              'Klik card ini untuk melakukan pemungutan retribusi sampah rutin setiap bulannya',
          targetUrl: '/scan_qr_code',
        ),
        Option(
          title: 'Tagih Iuran Retribusi Tambahan',
          body:
              'Klik card ini untuk  melakukan pemungutan tambahan di luar wajib retribusi perbulan',
          targetUrl: '/additional_retribution',
        ),
      ],
    ),
    masyarakat: RolePayment(
      header: 'Ayo Bayar Retribusi Sampah Anda :)',
      titleBody: 'Pilih Metode Pembayaran',
      option: [
        Option(
          title: 'Pembayaran Tunai',
          body:
              'Pastikan anda sedang bersama Petugas Pemungut Retribusi Sampah',
          targetUrl: '/generate_qr_code',
        ),
        Option(
          title: 'Pembayaran NonTunai',
          body: '',
          targetUrl: '/non_cash_payment',
        ),
      ],
    ),
  );

  static List<VirtualAccount> virtualAccountList = [
    VirtualAccount(
      name: 'BRI',
      icon: Image.asset(
        'assets/icons/bri.png',
        width: 30,
      ),
      typeVA: 'BRI_VA',
      fullName: 'Bank Rakyat Indonesia',
    ),
    VirtualAccount(
      name: 'BNI',
      icon: Image.asset(
        'assets/icons/bni.png',
        width: 30,
      ),
      typeVA: 'BNI_VA',
      fullName: 'Bank Negara Indonesia',
    ),
    VirtualAccount(
      name: 'Bank Mandiri',
      icon: Image.asset(
        'assets/icons/mandiri.png',
        width: 30,
      ),
      typeVA: 'Mandiri_VA',
      fullName: 'Bank Mandiri',
    ),
    VirtualAccount(
      name: 'CIMB',
      icon: Image.asset(
        'assets/icons/cimb.png',
        width: 30,
      ),
      typeVA: 'CIMB_VA',
      fullName: 'Bank CIMB Niaga',
    ),
    VirtualAccount(
      name: 'Danamon',
      icon: Image.asset(
        'assets/icons/danamon.png',
        width: 30,
      ),
      typeVA: 'Danamon_VA',
      fullName: 'Bank Danamon',
    ),
  ];
}
