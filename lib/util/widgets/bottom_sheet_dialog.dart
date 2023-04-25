import 'package:app/features/profile/presentation/views/profile_screen.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../generated/l10n.dart';
import '../dimens.dart';
import '../validators.dart';

class BottomSheetDialogHelper {
  static Future<String?> showModalBottom(BuildContext profileContext,
      String title, TypeFieldProfile typeFieldProfile) {
    String result = '';
    var maskFormatter = MaskTextInputFormatter(
        mask: '## #### ####',
        filter: {'#': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(marginStandard),
            topRight: Radius.circular(marginStandard),
          ),
        ),
        context: profileContext,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: SizedBox(
                    height: 284,
                    width: double.infinity,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: marginStandard),
                        child: SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 2,
                                width: 65,
                                color: ColorsFM.blackIndicator,
                              ),
                              Text(
                                'Editar $title',
                                style: TypefaceStyles.poppinsMedium16
                                    .copyWith(color: ColorsFM.primary),
                              ),
                              TextFormField(
                                inputFormatters:
                                    typeFieldProfile == TypeFieldProfile.phone
                                        ? [maskFormatter]
                                        : null,
                                onChanged: (text) {
                                  if (typeFieldProfile ==
                                      TypeFieldProfile.phone) {
                                    result = maskFormatter.unmaskText(text);
                                  } else if (typeFieldProfile ==
                                      TypeFieldProfile.email) {
                                    result = text;
                                  }
                                  setState(() {});
                                },
                                decoration:
                                    InputDecoratorLogin.getInputDecorator(
                                        title,
                                        ColorsFM.neutralColor,
                                        ColorsFM.textInputError,
                                        labelColor: ColorsFM.neutralDark),
                              ),
                              ElevatedButton(
                                  onPressed: getOnPressed(
                                      result, typeFieldProfile, context),
                                  child:
                                      Text(Languages.of(context).saveChanges))
                            ],
                          ),
                        ),
                      ),
                    )),
              );
            },
          );
        });
  }

  static Function()? getOnPressed(
      String text, TypeFieldProfile fieldProfile, BuildContext context) {
    if (text.isNotEmpty) {
      if (fieldProfile == TypeFieldProfile.email &&
          Validators.isEmailString(text)) {
        return () {
          Navigator.of(context).pop(text);
        };
      } else if (fieldProfile == TypeFieldProfile.phone &&
          Validators.isPhoneNumber(text) &&
          text.length == 10) {
        return () {
          Navigator.of(context).pop(text);
        };
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
