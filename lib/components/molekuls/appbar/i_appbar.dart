import 'package:flutter/material.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class IAppBar extends AppBar {
  IAppBar._(
      {required Key? key,
      required List<Widget>? actions,
      required Widget? title,
      required double? titleSpacing,
      required bool? centerTitle,
      bool automaticallyImplyLeading = true,
      required PreferredSizeWidget? bottom,
      required Color? backgroundColor,
      required Widget? leading,
      required Widget? flexibleSpace,
      required IconThemeData? iconTheme,
      Color? shadowColor,
      double? elevation})
      : super(
            titleSpacing: titleSpacing,
            key: key,
            actions: actions,
            title: title,
            centerTitle: centerTitle,
            backgroundColor: backgroundColor,
            automaticallyImplyLeading: automaticallyImplyLeading,
            leading: leading,
            bottom: bottom,
            iconTheme: iconTheme,
            shadowColor: shadowColor,
            elevation: elevation,
            flexibleSpace: flexibleSpace);

  factory IAppBar.primary({Key? key, required String title}) {
    return IAppBar._(
      key: key,
      centerTitle: true,
      backgroundColor: primaryColor,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
        onPressed: () {},
      ),
      actions: const [],
      title: Text(
        title,
        style: primaryTextStyle.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
          color: whiteColor,
          fontSize: 16,
        ),
      ),
      bottom: null,
      flexibleSpace: null,
      iconTheme: null,
      titleSpacing: null,
    );
  }

  factory IAppBar.transparent({
    Key? key,
    Function()? onTapLeading,
  }) {
    return IAppBar._(
      key: key,
      centerTitle: true,
      elevation: 0,
      backgroundColor: transparent,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: blackColor,
        ),
        onPressed: () {
          onTapLeading!();
        },
      ),
      actions: const [],
      bottom: null,
      flexibleSpace: null,
      iconTheme: null,
      titleSpacing: null,
      title: null,
    );
  }
}
