import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMenu {
  HomeMenu(
      {required this.iconText, required this.iconImage, required this.href});

  String iconText;
  IconData iconImage;
  String href;
}

List<HomeMenu> listHomeMenuPemungut = [
  HomeMenu(
    iconText: 'Riwayat Pembayaran',
    iconImage: Icons.list,
    href: '/history_payment_pemungut',
  ),
  HomeMenu(
    iconText: 'Tagih',
    iconImage: Icons.money,
    href: '/history_payment_pemungut',
  ),
  HomeMenu(
    iconText: 'Rekapitulasi',
    iconImage: Icons.assignment,
    href: '/history_payment_pemungut',
  ),
  HomeMenu(
    iconText: 'Tambah Akun',
    iconImage: Icons.person_add,
    href: '/history_payment_pemungut',
  ),
  HomeMenu(
    iconText: 'Akun Masyarakat',
    iconImage: Icons.people_sharp,
    href: '/history_payment_pemungut',
  ),
  HomeMenu(
    iconText: 'Profile',
    iconImage: Icons.person,
    href: '/history_payment_pemungut',
  ),
];

List<HomeMenu> listHomeMenuMasyarakat = [
  HomeMenu(
    iconText: 'Bantuan',
    iconImage: Icons.help,
    href: '/history_payment_pemungut',
  ),
  HomeMenu(
    iconText: 'Bayar',
    iconImage: Icons.payment,
    href: '/history_payment_pemungut',
  ),
  HomeMenu(
    iconText: 'History',
    iconImage: Icons.history,
    href: '/history_payment_pemungut',
  ),
  HomeMenu(
    iconText: 'Daftar Kategori',
    iconImage: Icons.menu_book,
    href: '/list_categories',
  ),
  HomeMenu(
    iconText: 'Profile',
    iconImage: Icons.person,
    href: '/history_payment_pemungut',
  ),
];

Map<String, List<HomeMenu>> listHomeMenu = {
  'pemungut': listHomeMenuPemungut,
  'masyarakat': listHomeMenuMasyarakat,
};
