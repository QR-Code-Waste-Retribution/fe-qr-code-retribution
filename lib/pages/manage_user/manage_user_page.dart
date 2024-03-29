import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/molekuls/input/search_input_custom.dart';
import 'package:qr_code_app/models/user/user.dart';
import 'package:qr_code_app/routes/init.dart';
import 'package:qr_code_app/services/providers/auth/auth_provider.dart';
import 'package:qr_code_app/services/providers/manage_user/users_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/utils/alert_dialog_custom.dart';
import 'package:qr_code_app/utils/long_string_format.dart';

class ManageUserPage extends StatefulWidget {
  static const routeName = '/manage_user_page';

  const ManageUserPage({super.key});

  @override
  State<ManageUserPage> createState() => _ManageUserPageState();
}

class _ManageUserPageState extends State<ManageUserPage> {
  final UsersProvider _usersProvider = Get.find<UsersProvider>();
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  List<TableRow> makeTableRows(
      {required List<User> users, required int? from}) {
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
          index: index,
          number: (from! - 1) + (index + 1),
          masyarakatId: item.id!,
          category: '${item.category?.map((e) => e.name).join(',')}',
        ),
      );
    }

    return tableRows;
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData({int page = 1}) {
    _usersProvider.getAllMasyarakatBySubDistrictId(
        pemungutId: _authProvider.getUserId!, page: page);
  }

  Future<void> changeSelectedStatusMasyarakat({
    required int userId,
    required int index,
    required bool status,
  }) async {
    _usersProvider.isSwitchedList[index] = status;
    _usersProvider.changeStatusMasyarakatSelected(userId: userId);
  }

  TableRow tableRowMasyarakat({
    required String name,
    required int index,
    required int number,
    required String category,
    required int masyarakatId,
  }) {
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
            number.toString(),
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
              SizedBox(
                height: 20,
                child: Text(
                  StringFormat().longStringFormat(text: category),
                  style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.w500, fontSize: 12),
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
                  Get.toNamed(
                    Pages.editUserPage,
                    arguments: {
                      'id': masyarakatId,
                    },
                  );
                },
              ),
              Switch(
                value: _usersProvider.isSwitchedList[index],
                onChanged: (value) {
                  AlertDialogCustom.showAlertDialog(
                    context: context,
                    onYes: () {
                      return changeSelectedStatusMasyarakat(
                        userId: masyarakatId,
                        index: index,
                        status: value,
                      );
                    },
                    title: "Ubah status $name",
                    content: 'Apakah anda yakin?',
                  );
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
          CustomButton(
            title: 'Tambah Akun Baru',
            width: 100,
            height: 40,
            fontSize: 14,
            defaultRadiusButton: 10,
            onPressed: () {
              Get.toNamed('/add_user');
            },
          ),
          const SizedBox(
            height: 15,
          ),
          SearchInputCustom(
            onChange: (String str) {},
            onSearch: () {
              _usersProvider.searchMasyarakat(
                pemungutId: _authProvider.getUserId!,
                page: 1,
              );
            },
            controller: _usersProvider.searchController.value,
            hintText: 'Cari masyarakat',
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(
            () {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Table(
                    textDirection: TextDirection.ltr,
                    columnWidths: const {
                      0: FixedColumnWidth(30),
                      1: FixedColumnWidth(155)
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: makeTableRows(
                        from: _usersProvider.getUsersPaginationMeta?.from,
                        users: _usersProvider.getUsersPaginationRecords!),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          initData(
                            page: _usersProvider.getPreviousPage(),
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black45,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chevron_left,
                            color: whiteColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${_usersProvider.getUsersPaginationMeta?.currentPage}",
                        style: primaryTextStyle.copyWith(
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          initData(
                            page: _usersProvider.getNextPage(),
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black45,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chevron_right,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Halaman ${_usersProvider.getUsersPaginationMeta?.currentPage} dari ${_usersProvider.getUsersPaginationMeta?.lastPage}',
                    style: primaryTextStyle.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Menampilkan ${_usersProvider.getUsersPaginationMeta?.from} sampai ${_usersProvider.getUsersPaginationMeta?.to} dari ${_usersProvider.getUsersPaginationMeta?.total} pengguna',
                    style: primaryTextStyle.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
