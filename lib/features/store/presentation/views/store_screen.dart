import 'package:app/core/di/modules.dart';
import 'package:app/features/store/domain/entity/cart_item.dart';
import 'package:app/features/store/presentation/bloc/store_bloc.dart';
import 'package:app/features/store/presentation/bloc/store_events.dart';
import 'package:app/features/store/presentation/bloc/store_state.dart';
import 'package:app/features/store/presentation/widgets/store_item.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/spinner_loading.dart';
import 'package:flutter/material.dart';
import 'package:app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<StoreBloc>()
          ..add(FetchData(
            (message) {
              Future.delayed(const Duration(milliseconds: 100)).then((value) {
                AlertNotification.error(context, message);
              });
            },
          )),
        child: const StoreView());
  }
}

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreBloc, StoreState>(
        listener: (context, state) {
          if (state.loading == LoadingState.show) {
            SpinnerLoading.showDialogLoading(context);
          }
          if (state.loading == LoadingState.close) {
            Navigator.pop(context);
            context.read<StoreBloc>().add(DisposeLoading());
          }
        },
        builder: (context, state) => Scaffold(
              backgroundColor: ColorsFM.primaryLight99,
              appBar: AppBar(
                title: Text(Languages.of(context).services),
                backgroundColor: ColorsFM.green40,
              ),
              body: Column(children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: 155,
                  decoration: const BoxDecoration(
                      color: ColorsFM.green40,
                      shape: BoxShape.rectangle,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(100))),
                  child: Stack(children: [
                    Positioned(
                      bottom: marginStandard,
                      right: -mediumMargin,
                      child: SvgPicture.asset(
                        iconConsults,
                        height: 136,
                        color: ColorsFM.green60.withOpacity(0.4),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        left: 0,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: marginStandard)
                                  .copyWith(top: smallMargin),
                              child: Text(Languages.of(context).services,
                                  style:
                                      TypefaceStyles.poppinsMedium16.copyWith(
                                    color: ColorsFM.green80,
                                  )),
                            ),
                            // const SizedBox(height: extraSmallMargin),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: marginStandard),
                              child: Text(
                                Languages.of(context).storeHeaderTitle,
                                style: TypefaceStyles.poppinsSemiBold22
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: marginStandard,
                                  right: largeMargin * 2,
                                  top: extraSmallMargin),
                              child: Text(
                                Languages.of(context).storeHeaderBody,
                                style: TypefaceStyles.poppinsRegular
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        )),
                  ]),
                ),
                const SizedBox(height: minMargin),
                Expanded(
                  child: ListView.builder(
                      itemCount: state.products.length >> 1,
                      itemBuilder: (context, position) {
                        return renderRow(state.products, position << 1);
                      }),
                ),
                const SizedBox(height: minMargin),
              ]),
            ));
  }

  Widget renderRow(List<CartItem> products, index) {
    return Padding(
      padding: const EdgeInsets.only(
        top: extraSmallMargin,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StoreItem(item: products[index]),
          StoreItem(
              item: products[index + 1],
              hide: products[index + 1].quantity == 0),
        ],
      ),
    );
  }
}
