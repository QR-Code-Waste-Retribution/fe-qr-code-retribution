import 'package:flutter/material.dart';
import 'package:qr_code_app/models/payment_method_page.dart';
import 'package:qr_code_app/models/virtual_account.dart';

class AppConstants {
  static const String apiUrlServer = 'http://35.213.170.85/api';
  static const String apiUrlLocal = 'http://localhost:8000/api';
  static const int apiTimeout = 5000; // milliseconds

  static const Map<String, String> headerHome = {
    'pemungut':
        'Selamat datang sebagai petugas di Aplikasi Retribusi Sampah Kabupaten Toba',
    'masyarakat': 'Selamat datang di Aplikasi Retribusi Sampah Kabupaten Toba',
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
      icon: Image.asset('assets/image/invoice_success_paid_off.png'),
    ),
    VirtualAccount(
      name: 'BNI',
      icon: Image.asset('assets/image/invoice_success_paid_off.png'),
    ),
    VirtualAccount(
      name: 'Bank Mandiri',
      icon: Image.asset('assets/image/invoice_success_paid_off.png'),
    ),
    VirtualAccount(
      name: 'CIMB',
      icon: Image.asset('assets/image/invoice_success_paid_off.png'),
    ),
    VirtualAccount(
      name: 'Danamon',
      icon: Image.asset('assets/image/invoice_success_paid_off.png'),
    ),
  ];
}
