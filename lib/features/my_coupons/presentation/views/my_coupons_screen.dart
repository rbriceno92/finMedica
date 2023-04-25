import 'package:app/core/di/modules.dart';
import 'package:app/features/my_coupons/data/models/remaining_coupons_request.dart';
import 'package:app/features/my_coupons/presentation/bloc/my_coupons_bloc.dart';
import 'package:app/features/my_coupons/presentation/bloc/my_coupons_events.dart';
import 'package:app/features/my_coupons/presentation/bloc/my_coupons_state.dart';
import 'package:app/features/my_coupons/presentation/views/my_coupons_coupon_details_screen.dart';
import 'package:app/features/my_coupons/presentation/widgets/chip_button_header.dart';
import 'package:app/features/my_coupons/presentation/widgets/coupons_list_item.dart';
import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';
import 'package:app/features/my_groups/presentation/widgets/my_groups_transfer_alert.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/filter_button.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/spinner_loading.dart';
import 'package:flutter/material.dart';
import 'package:app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MyCouponsScreen extends StatelessWidget {
  const MyCouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyCouponsBloc>()..add(const InitialLoad()),
      child: const MyCouponsViewStateful(),
    );
  }
}

class MyCouponsViewStateful extends StatefulWidget {
  const MyCouponsViewStateful({super.key});

  @override
  State<MyCouponsViewStateful> createState() => MyCouponsView();
}

class MyCouponsView extends State<MyCouponsViewStateful> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyCouponsBloc, MyCouponsState>(
      listener: (context, state) {
        if (state.loading == LoadingState.show &&
            !_isThereCurrentDialogShowing(context)) {
          SpinnerLoading.showDialogLoading(context);
        }
        if (state.loading == LoadingState.close &&
            _isThereCurrentDialogShowing(context)) {
          Navigator.popUntil(
              context, (route) => route.settings.name == myCouponsRoute);
          context.read<MyCouponsBloc>().add(DisposeLoading());
        }
        if (state.errorMessage.isNotEmpty) {
          Future.delayed(const Duration(milliseconds: 100)).then((value) {
            AlertNotification.error(context, state.errorMessage);
          });
        }
      },
      builder: ((context, state) {
        var filterList = state.filterSelect == FilterSelect.all.value
            ? state.coupons
            : state.coupons
                .where((e) => e.type.value & state.filterSelect > 0)
                .toList();
        return Scaffold(
          backgroundColor: ColorsFM.primaryLight99,
          appBar: AppBar(
            title: Text(Languages.of(context).myCoupons),
            backgroundColor: ColorsFM.primary,
          ),
          body: Column(children: [
            Container(
              clipBehavior: Clip.hardEdge,
              height: 173,
              decoration: const BoxDecoration(
                  color: ColorsFM.primary,
                  shape: BoxShape.rectangle,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(100))),
              child: Stack(children: [
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: SvgPicture.asset(iconHeaderLeaf)),
                Positioned(
                  top: extraSmallMargin,
                  left: largeDivision,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            state.availableConsults == 1
                                ? Languages.of(context).availableOne
                                : Languages.of(context).available,
                            style: TypefaceStyles.poppinsRegular39),
                        const SizedBox(
                          height: extraSmallMargin,
                        ),
                        Text(
                            '${state.availableConsults} ${state.availableConsults == 1 ? Languages.of(context).consults : Languages.of(context).consults}',
                            style: TypefaceStyles.poppinsSemiBold22
                                .copyWith(color: ColorsFM.green60)),
                        const SizedBox(
                          height: extraSmallMargin,
                        ),
                        Row(
                          children: [
                            ChipButtonHeader(
                              label: Languages.of(context).addText,
                              onSelected: (_) {
                                Navigator.pushNamed(context, myCouponsAddRoute);
                              },
                              icon: iconPlus,
                            ),
                            if (state.groupsInfo != null) ...[
                              const SizedBox(width: extraSmallMargin),
                              ChipButtonHeader(
                                label: Languages.of(context).trasnferText,
                                onSelected: (_) {
                                  if (state.availableConsults <= 0) {
                                    return;
                                  }
                                  if (state.groupsInfo!.isAdmin) {
                                    Navigator.of(context)
                                        .pushNamed(myGroupsRoute,
                                            arguments: myCouponsRoute)
                                        .then((member) {
                                      if (member is MyGroupsMember) {
                                        context
                                            .read<MyCouponsBloc>()
                                            .add(TransferCoupon(
                                                member: member,
                                                onSucces: (coupon) {
                                                  Future.delayed(const Duration(
                                                          milliseconds: 100))
                                                      .then((_) =>
                                                          showGeneralDialog(
                                                            context: context,
                                                            barrierColor:
                                                                ColorsFM
                                                                    .neutral30
                                                                    .withOpacity(
                                                                        0.7),
                                                            barrierDismissible:
                                                                false,
                                                            barrierLabel:
                                                                'Coupon detail',
                                                            pageBuilder:
                                                                (contex, __,
                                                                    ___) {
                                                              return MyCouponsCouponDetailsScreen(
                                                                coupon: coupon,
                                                                isSended: true,
                                                              );
                                                            },
                                                          ));
                                                }));
                                      }
                                    });
                                  } else {
                                    showDialog<bool?>(
                                            context: context,
                                            builder: (context) =>
                                                MyGroupsTransferAlert(
                                                    name: state.admin!
                                                        .fullName()))
                                        .then((accept) {
                                      if (accept != null && accept) {
                                        context.read<MyCouponsBloc>().add(
                                            TransferCoupon(onSucces: (coupon) {
                                          Future.delayed(const Duration(
                                                  milliseconds: 100))
                                              .then((_) => showGeneralDialog(
                                                    context: context,
                                                    barrierColor: ColorsFM
                                                        .neutral30
                                                        .withOpacity(0.7),
                                                    barrierDismissible: false,
                                                    barrierLabel:
                                                        'Coupon detail',
                                                    pageBuilder:
                                                        (contex, __, ___) {
                                                      return MyCouponsCouponDetailsScreen(
                                                        coupon: coupon,
                                                        isSended: true,
                                                      );
                                                    },
                                                  ));
                                        }));
                                      }
                                    });
                                  }
                                },
                                icon: iconTransfer,
                              )
                            ]
                          ],
                        )
                      ]),
                ),
              ]),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(marginStandard),
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 32,
                child: Row(children: [
                  FilterButton(
                    label: Languages.of(context).allText,
                    onPressed: () {
                      context
                          .read<MyCouponsBloc>()
                          .add(const FilterBy(FilterSelect.all));
                    },
                    selected: state.filterSelect == 0,
                  ),
                  const SizedBox(
                    height: extraSmallMargin,
                    width: extraSmallMargin,
                  ),
                  FilterButton(
                      label: Languages.of(context).packageText,
                      onPressed: () {
                        context
                            .read<MyCouponsBloc>()
                            .add(const FilterBy(FilterSelect.package));
                      },
                      selected:
                          state.filterSelect & FilterSelect.package.value > 0),
                  const SizedBox(
                    height: extraSmallMargin,
                    width: extraSmallMargin,
                  ),
                  FilterButton(
                      label: Languages.of(context).bonusText,
                      onPressed: () {
                        context
                            .read<MyCouponsBloc>()
                            .add(const FilterBy(FilterSelect.bonus));
                      },
                      selected:
                          state.filterSelect & FilterSelect.bonus.value > 0),
                  const SizedBox(
                    height: extraSmallMargin,
                    width: extraSmallMargin,
                  ),
                  FilterButton(
                      label: Languages.of(context).refundsText,
                      onPressed: () {
                        context
                            .read<MyCouponsBloc>()
                            .add(const FilterBy(FilterSelect.refund));
                      },
                      selected:
                          state.filterSelect & FilterSelect.refund.value > 0),
                  const SizedBox(
                    height: extraSmallMargin,
                    width: extraSmallMargin,
                  ),
                  FilterButton(
                      label: Languages.of(context).transferredText,
                      onPressed: () {
                        context
                            .read<MyCouponsBloc>()
                            .add(const FilterBy(FilterSelect.transfer));
                      },
                      selected:
                          state.filterSelect & FilterSelect.transfer.value > 0),
                  // const SizedBox(
                  //   height: extraSmallMargin,
                  //   width: extraSmallMargin,
                  // ),
                  // FilterButton(
                  //     label: Languages.of(context).membershipText,
                  //     onPressed: () {
                  //       context
                  //           .read<MyCouponsBloc>()
                  //           .add(const FilterBy(FilterSelect.membership));
                  //     },
                  //     selected:
                  //         state.filterSelect & FilterSelect.membership.value >
                  //             0),
                ]),
              ),
            ),
            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.only(bottom: marginStandard),
                itemCount: filterList.length,
                itemBuilder: (context, index) {
                  var coupon = filterList[index];
                  return CouponsListItem(
                    coupon: coupon,
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: marginStandard),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ]),
        );
      }),
    );
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      MyCouponsState state = context.read<MyCouponsBloc>().state;
      int currentPage =
          (state.coupons.length / remainingConsultsQueryLimit).ceil();
      if (currentPage < state.totalPages &&
          state.loading == LoadingState.dispose) {
        context.read<MyCouponsBloc>().add(FetchData(page: currentPage + 1));
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
