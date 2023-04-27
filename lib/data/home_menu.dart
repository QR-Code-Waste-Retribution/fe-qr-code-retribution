import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMenu {
  HomeMenu(
      {required this.iconText, required this.iconImage, required this.href});

  String iconText;
  IconData iconImage;
  Function href;
}

List<HomeMenu> listHomeMenuPemungut = [
  HomeMenu(
    iconText: 'Riwayat Tagihan',
    iconImage: Icons.list,
    href: () {

    },
  ),
  HomeMenu(
    iconText: 'Tagih',
    iconImage: Icons.money,
    href: () {},
  ),
  HomeMenu(
    iconText: 'Rekapitulasi',
    iconImage: Icons.assignment,
    href: () {},
  ),
  HomeMenu(
    iconText: 'Tambah Akun',
    iconImage: Icons.person_add,
    href: () {},
  ),
  HomeMenu(
    iconText: 'Akun Masyarakat',
    iconImage: Icons.people_sharp,
    href: () {},
  ),
  HomeMenu(
    iconText: 'Profile',
    iconImage: Icons.person,
    href: () {},
  ),
];

List<HomeMenu> listHomeMenuMasyarakat = [
  HomeMenu(
    iconText: 'Bantuan',
    iconImage: Icons.help,
    href: () {},
  ),
  HomeMenu(
    iconText: 'Bayar',
    iconImage: Icons.payment,
    href: () {},
  ),
  HomeMenu(
    iconText: 'History',
    iconImage: Icons.history,
    href: () {},
  ),
  HomeMenu(
    iconText: 'Daftar Kategori',
    iconImage: Icons.menu_book,
    href: () {},
  ),
  HomeMenu(
    iconText: 'Profile',
    iconImage: Icons.person,
    href: () {},
  ),
];

Map<String, List<HomeMenu>> listHomeMenu = {
  'pemungut': listHomeMenuPemungut,
  'masyarakat': listHomeMenuMasyarakat,
};
