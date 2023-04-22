import 'package:flutter/material.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class ManageUserPage extends StatefulWidget {
  const ManageUserPage({super.key});

  @override
  State<ManageUserPage> createState() => _ManageUserPageState();
}

class _ManageUserPageState extends State<ManageUserPage> {
  bool isSwitched = false;

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
          Container(
            decoration: BoxDecoration(
              color: backgroundColor6,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.only(left: 15),
            child: Center(
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: primaryTextStyle.copyWith(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Cari nama, kategori, dll',
                        hintStyle: subtitleTextStyle.copyWith(fontSize: 15),
                        contentPadding: const EdgeInsets.only(top: 15.0),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.clear,
                            size: 20,
                            color: blackColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
            onPressed: () {},
          ),
          Table(
            textDirection: TextDirection.ltr,
            columnWidths: const {
              0: FixedColumnWidth(30),
              1: FixedColumnWidth(165)
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
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
              TableRowMasyarakat(),
              TableRowMasyarakat(),
            ],
          ),
        ],
      ),
    );
  }

  TableRow TableRowMasyarakat() {
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
            '1',
            style: blackTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 15, right: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ahmad Sianipars Parapatsss sadasd',
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
                onPressed: () {},
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
