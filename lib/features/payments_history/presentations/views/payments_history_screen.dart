import 'package:app/core/di/modules.dart';
import 'package:app/features/payments_history/presentations/bloc/payments_history_bloc.dart';
import 'package:app/features/payments_history/presentations/bloc/payments_history_events.dart';
import 'package:app/features/payments_history/presentations/bloc/payments_history_state.dart';
import 'package:app/features/payments_history/presentations/widgets/payment_list_item.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/enums.dart';
import '../../../../util/widgets/alert_notification.dart';
import '../../../../util/widgets/spinner_loading.dart';

class PaymentsHistoryScreen extends StatelessWidget {
  const PaymentsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PaymentsHistoryBloc>()
        ..add(const FilterBy(filter: FilterSelect.all)),
      child: const PaymentsHistory(),
    );
  }
}

class PaymentsHistory extends StatefulWidget {
  const PaymentsHistory({super.key});

  @override
  State<PaymentsHistory> createState() => _PaymentsHistoryScreenState();
}

class _PaymentsHistoryScreenState extends State<PaymentsHistory> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentsHistoryBloc, PaymentsHistoryState>(
        listener: (context, state) {
          if (state.loading == LoadingState.show) {
            SpinnerLoading.showDialogLoading(context);
          }
          if (state.loading == LoadingState.close) {
            Navigator.pop(context);
            if (state.errorMessage != '') {
              AlertNotification.error(context, state.errorMessage);
              context.read<PaymentsHistoryBloc>().add(DisposeLoading());
            }
          }
        },
        builder: ((context, state) => Scaffold(
              backgroundColor: ColorsFM.primaryLight99,
              appBar: AppBar(
                title: Text(Languages.of(context).paymentsHistory),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(marginStandard)
                        .copyWith(bottom: extraSmallMargin),
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: 32,
                      child: Row(children: [
                        FilterButton(
                          label: Languages.of(context).allText,
                          onPressed: () {
                            context
                                .read<PaymentsHistoryBloc>()
                                .add(const FilterBy(filter: FilterSelect.all));
                          },
                          selected: state.filterSelect == FilterSelect.all,
                        ),
                        const SizedBox(
                          height: extraSmallMargin,
                          width: extraSmallMargin,
                        ),
                        FilterButton(
                            label: Languages.of(context).completedPlural,
                            onPressed: () {
                              context.read<PaymentsHistoryBloc>().add(
                                  const FilterBy(
                                      filter: FilterSelect.succeeded));
                            },
                            selected:
                                state.filterSelect == FilterSelect.succeeded),
                        const SizedBox(
                          height: extraSmallMargin,
                          width: extraSmallMargin,
                        ),
                        FilterButton(
                            label: Languages.of(context).rejected,
                            onPressed: () {
                              context.read<PaymentsHistoryBloc>().add(
                                  const FilterBy(filter: FilterSelect.failed));
                            },
                            selected:
                                state.filterSelect == FilterSelect.failed),
                      ]),
                    ),
                  ),
                  Expanded(
                    child: (state.items?.length ?? 0) != 0
                        ? ListView.separated(
                            shrinkWrap: true,
                            controller: _scrollController,
                            padding: const EdgeInsets.only(
                                left: marginStandard, right: marginStandard),
                            itemCount: state.items?.length ?? 0,
                            itemBuilder: (context, index) {
                              return PaymentListItem(
                                  data: state.items![index],
                                  onPress: () {
                                    Navigator.pushNamed(
                                        context, paymentsHistoryDetailRoute,
                                        arguments: state.items![index]);
                                  });
                            },
                            separatorBuilder: (context, index) => Container(
                                height: 1,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorsFM.primary99, width: 1))))
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: mediumMargin),
                              child: Text(
                                  Languages.of(context).paymentHistoryEmpty,
                                  textAlign: TextAlign.center,
                                  style: TypefaceStyles.poppinsSemiBold22
                                      .copyWith(color: ColorsFM.blueDark90)),
                            ),
                          ),
                  )
                ],
              ),
            )));
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      PaymentsHistoryState state = context.read<PaymentsHistoryBloc>().state;
      if (state.nextPage != null && state.loading != LoadingState.show) {
        context
            .read<PaymentsHistoryBloc>()
            .add(FilterBy(filter: state.filterSelect, page: state.nextPage));
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
