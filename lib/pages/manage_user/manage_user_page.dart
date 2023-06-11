import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/molekuls/input/search_input.dart';
import 'package:qr_code_app/models/user/user.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/providers/users_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class ManageUserPage extends StatefulWidget {
  const ManageUserPage({super.key});

  @override
  State<ManageUserPage> createState() => _ManageUserPageState();
}

class _ManageUserPageState extends State<ManageUserPage> {
  bool isSwitched = false;
  final UsersProvider _usersProvider = Get.find<UsersProvider>();
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  List<TableRow> makeTableRows({required List<User> users}) {
    final List<TableRow> tableRows = [
      TableRow(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: blackColor,
            ),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              'No',
              style: primaryTextStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              'Nama',
              style: primaryTextStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              "Aksi",
              style: primaryTextStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ];
    for (var index = 0; index < users.length; index++) {
      var item = users[index];
      tableRows.add(
        tableRowMasyarakat(
          name: '${item.name}',
          id: index + 1,
          category: "Kios ACV",
        ),
      );
    }
    return tableRows;
  }

  @override
  void initState() {
    super.initState();

    _usersProvider.getAllMasyarakatBySubDistrictId(
      subDistrictId: _authProvider.authData.user?.subDistrictId,
      pemungutId: _authProvider.getUserId!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Daftar Akun Wajib Retrisbusi",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        children: [
          const SearchInputWidget(),
          CustomButton(
            title: 'Tambah Akun Baru',
            width: 100,
            height: 40,
            fontSize: 14,
            defaultRadiusButton: 10,
            margin: const EdgeInsets.only(
              top: 30,
              bottom: 30,
            ),
            onPressed: () {
              Get.toNamed('/add_user');
            },
          ),
          Obx(
            () => Table(
              textDirection: TextDirection.ltr,
              columnWidths: const {
                0: FixedColumnWidth(30),
                1: FixedColumnWidth(165)
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: makeTableRows(users: _usersProvider.getUserList),
            ),
          ),
        ],
      ),
    );
  }

  TableRow tableRowMasyarakat(
      {required String name, required int id, required String category}) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: blackColor,
          ),
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 15),
          child: Text(
            id.toString(),
            style: blackTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 15, right: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Kios',
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 15),
          child: Row(
            children: [
              CustomButton(
                title: 'Edit',
                width: 60,
                height: 35,
                fontSize: 14,
                defaultRadiusButton: 10,
                onPressed: () {
                  Get.toNamed('/edit_user');
                },
              ),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
