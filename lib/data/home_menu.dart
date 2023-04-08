import 'package:flutter/material.dart';

class HomeMenu {
  HomeMenu({
    required this.iconText,
    required this.iconImage,
  });

  String iconText;
  IconData iconImage;
}

List<HomeMenu> listHomeMenuPemungut = [
  HomeMenu(iconText: 'Riwayat Tagihan', iconImage: Icons.list),
  HomeMenu(iconText: 'Tagih', iconImage: Icons.money),
  HomeMenu(iconText: 'Rekapitulasi', iconImage: Icons.dataset),
  HomeMenu(iconText: 'Tambah Akun', iconImage: Icons.person_add),
  HomeMenu(iconText: 'Akun Masyarakat', iconImage: Icons.people_sharp),
  HomeMenu(iconText: 'Profile', iconImage: Icons.person),
];

List<HomeMenu> listHomeMenuMasyarakat = [
  HomeMenu(iconText: 'Bantuan', iconImage: Icons.help),
  HomeMenu(iconText: 'Bayar', iconImage: Icons.payment),
  HomeMenu(iconText: 'History', iconImage: Icons.history),
  HomeMenu(iconText: 'Daftar Kategori', iconImage: Icons.menu_book),
  HomeMenu(iconText: 'Profile', iconImage: Icons.person),
];

Map<String, List<HomeMenu>> listHomeMenu = {
  'pemungut': listHomeMenuPemungut,
  'masyarakat': listHomeMenuMasyarakat,
};

