import 'package:flutter/material.dart';
import 'package:amnak/export.dart';
import 'package:flutter_svg/svg.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.title,
    required this.leadingIconPath,
    this.hasBottomDivider = true,
    this.onTap,
  });

  final String title;
  final String leadingIconPath;
  final bool hasBottomDivider;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundColor: decideOnTheme(ke7eaeeColor, kPurple),
            radius: 20.w,
            child: SvgPicture.asset(leadingIconPath),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          //! don't but const here as it will not rebuilt back icon when locale changes
          // ignore: prefer_const_constructors
          trailing: MyBackIcon(),
        ),
        if (hasBottomDivider)
          Divider(
            thickness: 1,
            color: kPrimaryColor.withOpacity(.3),
          ),
      ],
    );
  }
}

class MyBackIcon extends StatelessWidget {
  ///! don't but const here as it will not rebuilt back icon when locale changes
  const MyBackIcon({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: !isEn() ? TextDirection.ltr : TextDirection.rtl,
      child: GestureDetector(
        onTap: onTap,
        child: const Icon(
          Icons.arrow_back,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}

class MyBackButton extends StatelessWidget {
  const MyBackButton({
    super.key,
    this.onTap,
    this.top,
  });
  final void Function()? onTap;
  final double? top;

  @override
  Widget build(BuildContext context) {
    return ResponsivePositioned(
      top: top,
      child: SafeArea(
        top: top == null,
        child: MyBackIcon(onTap: onTap ?? () => context.pop()),
      ),
    );
  }
}
