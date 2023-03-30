import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeMenu {
  HomeMenu({
    required this.iconText,
    required this.iconImage,
  });

  String iconText;
  IconData iconImage;
}

List<HomeMenu> homeMenu = [
  HomeMenu(iconText: 'Riwayat Tagihan', iconImage: Icons.list),
  HomeMenu(iconText: 'Tagih', iconImage: Icons.money),
  HomeMenu(iconText: 'Rekapitulasi', iconImage: Icons.dataset),
  HomeMenu(iconText: 'Tambah Akun', iconImage: Icons.person_add),
  HomeMenu(iconText: 'Akun Masyarakat', iconImage: Icons.people_sharp),
  HomeMenu(iconText: 'Profile', iconImage: Icons.person),
];
