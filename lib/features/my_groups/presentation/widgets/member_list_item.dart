import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MemberListItem extends StatelessWidget {
  final bool? configuration;
  final bool? isSelected;
  final MyGroupsMember member;
  final void Function(MyGroupsMember member)? onIconPress;
  final void Function(MyGroupsMember member)? onItemPress;
  final String icon;
  final Color iconColor;

  const MemberListItem(
      {super.key,
      this.configuration,
      required this.member,
      this.onIconPress,
      this.onItemPress,
      required this.icon,
      this.isSelected,
      this.iconColor = ColorsFM.neutral95});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onItemPress != null) onItemPress!(member);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          border: Border.all(color: ColorsFM.neutral99, width: 1),
        ),
        padding: const EdgeInsets.only(
            left: mediumMargin,
            right: marginStandard,
            top: extraSmallMargin - 1,
            bottom: extraSmallMargin - 1),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.fullName(),
                  style: TypefaceStyles.poppinsRegular.copyWith(
                      fontWeight: FontWeight.w600, color: ColorsFM.primary),
                ),
                Text(
                  '${member.gender == Genders.f ? Languages.of(context).female : Languages.of(context).male} - ${member.age} ${Languages.of(context).years}',
                  style: TypefaceStyles.poppinsRegular11
                      .copyWith(color: ColorsFM.neutralColor),
                )
              ],
            ),
            if (icon.isNotEmpty && configuration == null) showIcons(),
            if (configuration == true && member.isVerified == true) showIcons()
          ],
        ),
      ),
    );
  }

  showIcons() {
    return GestureDetector(
      onTap: () {
        onIconPress!(member);
      },
      child: isSelected != null
          ? isSelected != false
              ? renderIcon()
              : SvgPicture.asset(
                  colorBlendMode: BlendMode.modulate,
                  icon,
                  height: 24,
                  color: iconColor,
                )
          : renderIcon(),
    );
  }

  renderIcon() {
    return SvgPicture.asset(
      icon,
      height: 24,
      color: iconColor,
    );
  }
}
