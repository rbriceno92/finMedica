import 'package:app/core/di/modules.dart';
import 'package:app/features/directory/data/models/speciality_model.dart';
import 'package:app/features/directory/presentation/bloc/directory/directory_bloc.dart';
import 'package:app/features/directory/presentation/bloc/directory/directory_event.dart';
import 'package:app/features/directory/presentation/bloc/directory/directory_state.dart';
import 'package:app/features/directory/presentation/widgets/specialist_info.dart';
import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../util/fonts_types.dart';
import '../../../../util/widgets/spinner_loading.dart';

class DirectoryScreen extends StatelessWidget {
  final MyGroupsMember? member;

  const DirectoryScreen({Key? key, this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DirectoryBloc>()
        ..add(LoadUser())
        ..add(const LoadDirectory()),
      child: DirectoryView(
        member: member,
      ),
    );
  }
}

class DirectoryView extends StatelessWidget {
  final MyGroupsMember? member;

  DirectoryView({Key? key, this.member}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DirectoryBloc, DirectoryState>(
      listener: (context, state) {
        if (state.isLoading && !_isThereCurrentDialogShowing(context)) {
          SpinnerLoading.showDialogLoading(context);
        } else if (!state.isLoading && _isThereCurrentDialogShowing(context)) {
          Navigator.pop(context);
        }
        if (state.message.isNotEmpty) {
          Future.delayed(const Duration(milliseconds: 100)).then((value) {
            AlertNotification.error(context, state.message);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorsFM.primaryLight99,
          appBar: AppBar(
            title: Text(Languages.of(context).directory),
            backgroundColor: ColorsFM.green40,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 170,
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.zero,
                  color: ColorsFM.green40,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(100))),
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.bottomRight,
                          child: SvgPicture.asset(iconHospital)),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: marginStandard, right: marginStandard),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                state.clinic?.name ?? '',
                                style: TypefaceStyles.poppinsSemiBold28
                                    .copyWith(
                                        fontSize: 24, color: ColorsFM.green80),
                              ),
                            ),
                            const SizedBox(
                              height: minMargin,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ItemCard(
                                icon: iconLocation,
                                text: state.clinic?.address ?? '',
                                address: true,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: extraLargeMargin),
                              child: Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: marginStandard),
                              child: ItemCard(
                                  icon: iconPhone,
                                  text: state.clinic?.phone ?? '',
                                  phone: true,
                                  instragram: true,
                                  instragramIcon: iconInstagram),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: mediumMargin, horizontal: marginStandard),
                child: DropdownButtonFormField(
                    value: state.specialities.isNotEmpty
                        ? state.specialities.first
                        : null,
                    style: TypefaceStyles.bodyMediumMontserrat
                        .copyWith(color: ColorsFM.primary),
                    focusColor: ColorsFM.primary80,
                    decoration: InputDecoratorLogin.getInputDecorator(
                      Languages.of(context).selectSpeciality,
                      ColorsFM.primary80,
                      ColorsFM.primary80,
                      labelColor: ColorsFM.primary,
                    ),
                    items: state.specialities.map((Speciality items) {
                      return DropdownMenuItem(
                          value: items, child: Text(items.name));
                    }).toList(),
                    onChanged: (Object? newItem) {
                      context.read<DirectoryBloc>().add(
                          LoadDirectoryBySpecialistAndName(
                              specialist: (newItem as Speciality).id,
                              name: state.name));
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: marginStandard),
                child: Text(
                  Languages.of(context).specialists,
                  style: TypefaceStyles.poppinsSemiBold14Primary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: marginStandard, vertical: marginStandard),
                child: SizedBox(
                  height: 48,
                  child: TextFormField(
                    controller: _controller,
                    onFieldSubmitted: (name) {
                      context.read<DirectoryBloc>().add(
                          LoadDirectoryBySpecialistAndName(
                              specialist: state.specialist, name: name));
                    },
                    onChanged: (name) {
                      if (name.isEmpty && state.textSearch) {
                        context.read<DirectoryBloc>().add(
                            LoadDirectoryBySpecialistAndName(
                                specialist: state.specialist, name: name));
                      }
                    },
                    decoration:
                        InputDecoratorDirectory.getInputDecoratorDirectory(() {
                      context.read<DirectoryBloc>().add(
                          LoadDirectoryBySpecialistAndName(
                              specialist: state.specialist,
                              name: _controller.text));
                    }).copyWith(
                      hintText: Languages.of(context).filterByName,
                    ),
                    style: TypefaceStyles.bodyMediumMontserrat
                        .copyWith(color: ColorsFM.primary),
                  ),
                ),
              ),
              Expanded(
                child: state.directory?.doctors.isEmpty == false
                    ? ListView.builder(
                        itemCount: state.directory?.doctors.length,
                        padding: const EdgeInsets.only(bottom: largeMargin),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: marginStandard),
                            child: SpecialistInfo(
                              doctor: state.directory?.doctors[index],
                              position: index,
                              user: member ?? state.user,
                              specialistId: state
                                      .directory?.doctors[index].specialityId ??
                                  1,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              Languages.of(context).noResultsForSearch,
                              style: TypefaceStyles.poppinsSemiBold22.copyWith(
                                color: ColorsFM.blueDark90,
                              ),
                            ),
                          ],
                        ),
                      ),
              )
            ],
          ),
        );
      },
    );
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
}

class ItemCard extends StatelessWidget {
  final String icon;
  final String text;
  final bool phone;
  final bool address;
  final bool instragram;
  final String instragramIcon;

  const ItemCard({
    Key? key,
    required this.icon,
    required this.text,
    this.phone = false,
    this.address = false,
    this.instragram = false,
    this.instragramIcon = '',
  }) : super(key: key);

  String truncateString(String data, int length) {
    return (data.length >= length) ? data.substring(0, length) : data;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(
          width: extraSmallMargin,
        ),
        Flexible(
          child: InkWell(
              onTap: () async {
                if (phone) {
                  await launchUrl(Uri.parse('tel:$text'));
                } else if (address) {
                  MapsLauncher.launchQuery(text);
                }
              },
              child: Text(
                truncateString(text, 45),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TypefaceStyles.bodyMediumMontserrat
                    .copyWith(color: Colors.white),
              )),
        ),
        if (instragram == true)
          Padding(
            padding: const EdgeInsets.only(left: mediumMargin),
            child: InkWell(
              onTap: () {
                launchUrl(
                    Uri.parse('https://www.instagram.com/finmedica/?hl=es'));
              },
              child: SvgPicture.asset(
                iconInstagram,
                width: 16,
                color: Colors.white,
              ),
            ),
          ),
        const SizedBox(
          width: marginStandard,
        ),
      ],
    );
  }
}
