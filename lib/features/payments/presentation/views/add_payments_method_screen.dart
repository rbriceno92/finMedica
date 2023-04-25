import 'package:app/core/di/modules.dart';
import 'package:app/features/payments/presentation/bloc/add_payment_method_bloc.dart';
import 'package:app/features/payments/presentation/bloc/add_payment_method_events.dart';
import 'package:app/features/payments/presentation/bloc/add_payment_method_state.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/button_text_widgets.dart';
import 'package:app/util/widgets/spinner_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class AddPaymentMethodScreen extends StatelessWidget {
  const AddPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddPaymentMethodBloc>()..add(LoadUser()),
      child: const AddPaymentMethodView(),
    );
  }
}

class AddPaymentMethodView extends StatefulWidget {
  const AddPaymentMethodView({
    super.key,
  });

  @override
  AddPaymentMethodViewState createState() => AddPaymentMethodViewState();
}

class AddPaymentMethodViewState extends State<AddPaymentMethodView> {
  final controller = CardFormEditController();

  @override
  void initState() {
    controller.addListener(update);
    super.initState();
  }

  void update() => setState(() {});
  @override
  void dispose() {
    controller.removeListener(update);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPaymentMethodBloc, AddPaymentMethodState>(
      listener: (context, state) {
        if (state.loading == LoadingState.show) {
          SpinnerLoading.showDialogLoading(context);
        }
        if (state.loading == LoadingState.close) {
          Navigator.pop(context);
          if (state.errorMessage.isNotEmpty) {
            AlertNotification.error(context, state.errorMessage);
          }
          if (state.successMessage.isNotEmpty) {
            //AlertNotification.success(context, state.successMessage);
            Navigator.pop(context, state.successMessage);
          }
          context.read<AddPaymentMethodBloc>().add(DisposeLoading());
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: ColorsFM.primaryLight99,
        appBar: AppBar(
          title: Text(Languages.of(context).configuration),
        ),
        body: Padding(
            padding: const EdgeInsets.all(marginStandard),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    Languages.of(context).addPaymentMethod,
                    style: TypefaceStyles.poppinsSemiBold22
                        .copyWith(color: ColorsFM.primary),
                  ),
                  const SizedBox(height: largeDivision),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: marginStandard),
                        child: CardFormField(
                          controller: controller,
                          style: CardFormStyle(
                              backgroundColor: Colors.white,
                              borderColor: ColorsFM.neutral90,
                              borderRadius: 8,
                              borderWidth: 1,
                              fontSize: 14,
                              placeholderColor: ColorsFM.neutral90,
                              textColor: ColorsFM.neutralDark,
                              textErrorColor: ColorsFM.errorColor),
                        ),
                      ),
                    ),
                  ),
                  ButtonText(
                    text: Languages.of(context).add,
                    onPressed: !controller.details.complete
                        ? null
                        : () {
                            context
                                .read<AddPaymentMethodBloc>()
                                .add(CreatePaymentMethod());
                          },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  )
                ])),
      ),
    );
  }
}
