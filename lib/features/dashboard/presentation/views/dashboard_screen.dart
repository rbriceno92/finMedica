import 'package:app/core/di/modules.dart';
import 'package:app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:app/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:app/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:app/features/dashboard/presentation/widgets/consult_card.dart';
import 'package:app/features/dashboard/presentation/widgets/dashboard_button.dart';
import 'package:app/features/dashboard/presentation/widgets/skeleton_dashboard.dart';
import 'package:app/navigation/drawer_main.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';

import '../../../../util/colors_fm.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DashboardBloc>()
        ..add(const GettingNextConsults(states: {
          'statesRequired': ['PENDING']
        }))
        ..add(const GetStripeConfig())
        ..add(const GetUserName())
        ..add(GetFirebaseToken()),
      child: DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  DashboardView({Key? key}) : super(key: key);

  var focus = true;
  var loaded = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      bloc: BlocProvider.of<DashboardBloc>(context),
      listenWhen: (prevState, state) {
        return prevState != state;
      },
      builder: (context, state) {
        return !state.isLoading
            ? Scaffold(
                endDrawer: DrawerMain(name: state.name),
                backgroundColor: ColorsFM.primaryLight99,
                appBar: AppBar(
                  centerTitle: false,
                  title: SvgPicture.asset(finMedicaLogo),
                  actions: [
                    SvgPicture.asset(
                      bellIcon,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: marginStandard,
                    ),
                    Builder(builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        icon: SvgPicture.asset(burgerMenuIcon),
                      );
                    }),
                    const SizedBox(
                      width: marginStandard,
                    )
                  ],
                ),
                body: FocusDetector(
                  onFocusGained: () {
                    if (state.refresh == true) {
                      context
                          .read<DashboardBloc>()
                          .add(const GettingNextConsults(states: {
                            'statesRequired': ['PENDING']
                          }));
                      focus = true;
                    }
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const BuildAsset()),
                      Align(
                          alignment: Alignment.center,
                          child: ConsultCard(
                            isEmpty: state.consult?.isEmpty ?? true,
                          )),
                      const DashboardButtons()
                    ],
                  ),
                ),
              )
            : const SkeletonDashboard();
      },
      listener: (context, state) {
        if (state.errorMessage != null) {
          AlertNotification.error(context, state.errorMessage!);
        }
      },
    );
  }
}

class BuildAsset extends StatelessWidget {
  const BuildAsset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage(
        dashboardBg,
      ),
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
    );
  }
}

class BuildAssetSvg extends StatelessWidget {
  const BuildAssetSvg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      finMedicaBottonImage,
      width: MediaQuery.of(context).size.width,
    );
  }
}
