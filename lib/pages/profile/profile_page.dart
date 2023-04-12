import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: secondaryColor,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     size: 20,
        //   ),
        //   onPressed: (() {
        //     setState(() {
        //       Navigator.pop(context);
        //     });
        //   }),
        // ),
        title: Text(
          "Profile",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Text('Profile'),
      ) 
    );
  }
}