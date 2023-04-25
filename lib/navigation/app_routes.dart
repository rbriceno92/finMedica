import 'package:app/features/change_password/presentation/views/change_password_screen.dart';
import 'package:app/features/contact_us/presentation/views/contac_us_screen.dart';
import 'package:app/features/dashboard/presentation/views/dashboard_screen.dart';
import 'package:app/features/directory/data/models/schedule_appointments_screen_params.dart';
import 'package:app/features/directory/presentation/views/choose_payment_method_screen.dart';
import 'package:app/features/directory/presentation/views/directory_screen.dart';
import 'package:app/features/directory/presentation/views/pay_consult_screen.dart';
import 'package:app/features/directory/presentation/views/schedule_appointment_screen.dart';
import 'package:app/features/directory/presentation/views/schedule_appointment_sucess_screen.dart';
import 'package:app/features/forgot_password/data/models/validation_screen_params.dart';
import 'package:app/features/forgot_password/presentation/views/forgot_password_screen.dart';
import 'package:app/features/forgot_password/presentation/views/restore_password_screen.dart';
import 'package:app/features/forgot_password/presentation/views/validation_code_screen.dart';
import 'package:app/features/login/data/models/sign_in_params.dart';
import 'package:app/features/login/presentation/views/sign_in_screen.dart';
import 'package:app/features/my_consults/domain/entities/consult.dart';
import 'package:app/features/my_consults/presentation/views/my_consults_detail_screen.dart';
import 'package:app/features/my_consults/presentation/views/my_consults_screen.dart';
import 'package:app/features/my_coupons/domain/entities/coupon_entity.dart';
import 'package:app/features/my_coupons/presentation/views/my_coupons_bundle_details_screen.dart';
import 'package:app/features/my_coupons/presentation/views/my_coupons_code_screen.dart';
import 'package:app/features/my_coupons/presentation/views/my_coupons_screen.dart';
import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';
import 'package:app/features/my_groups/presentation/views/my_group_add_existing_screen.dart';
import 'package:app/features/my_groups/presentation/views/my_group_member_screen.dart';
import 'package:app/features/my_groups/presentation/views/my_group_screen.dart';
import 'package:app/features/my_groups/presentation/views/my_groups_configuration_screen.dart';
import 'package:app/features/notifications/presentation/views/notifications_screen.dart';
import 'package:app/features/notifications/presentation/views/notifications_settings_screen.dart';
import 'package:app/features/payments/presentation/views/add_payments_method_screen.dart';
import 'package:app/features/payments_history/presentations/views/payment_detail_screen.dart';
import 'package:app/features/payments_history/presentations/views/payments_history_screen.dart';
import 'package:app/features/profile/presentation/views/profile_screen.dart';
import 'package:app/features/signup/domain/entities/sign_up_data.dart';
import 'package:app/features/signup/presentation/views/sign_up_code_screen.dart';
import 'package:app/features/signup/presentation/views/sign_up_form_screen.dart';
import 'package:app/features/signup/presentation/views/sign_up_password_screen.dart';
import 'package:app/features/signup/presentation/views/sign_up_success_screen.dart';
import 'package:app/features/splash_screen.dart';
import 'package:app/features/store/domain/entity/cart_item.dart';
import 'package:app/features/store/presentation/views/store_cart_screen.dart';
import 'package:app/features/store/presentation/views/store_screen.dart';
import 'package:app/features/terms_conditions/presentation/view/terms_conditions_screen.dart';
import 'package:app/features/welcome/presentation/views/welcome_screen.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:flutter/material.dart';

import '../features/confidentiality/presentation/views/confidentiality_screen.dart';
import '../features/directory/data/models/book_appointment_params.dart';
import '../features/frequent_questions/presentation/view/frequent_questions_screen.dart';
import '../features/my_groups/domain/entities/my_groups_info.dart';
import '../features/my_groups/presentation/bloc/my_groups_events.dart';
import '../features/profile/presentation/views/profile_code_screen.dart';
import '../features/payments/presentation/views/payments_methods_screen.dart';
import '../features/payments_history/domain/entities/payment_record.dart';
import '../util/models/model_user.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case welcomeRoute:
      return PageRouteBuilder(
          settings: routeSettings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const WelcomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, -1.0);
            const end = Offset.zero;
            const curve = Curves.easeInSine;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          });
    case splashRoute:
      return MaterialPageRoute(
          builder: (context) => const SplashScreen(), settings: routeSettings);
    case signInRoute:
      var params = routeSettings.arguments != null
          ? routeSettings.arguments as SignInParams
          : SignInParams(changePassword: false, sessionEnd: false);
      return MaterialPageRoute(
          builder: (context) => SignInScreen(
              changedPassword: params.changePassword,
              sessionEnd: params.sessionEnd),
          settings: routeSettings);
    case signUproute:
      return PageRouteBuilder(
          settings: routeSettings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SignUpScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInSine;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          });
    case validationRoute:
      return MaterialPageRoute(
          builder: (context) {
            ValidationScreenParams params =
                routeSettings.arguments as ValidationScreenParams;
            return ValidationCodeScreen(email: params.email, name: params.name);
          },
          settings: routeSettings);
    case forgotPasswordRoute:
      return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
          settings: routeSettings);
    case restorePasswordRoute:
      return MaterialPageRoute(
          builder: (context) =>
              RestorePasswordScreen(token: routeSettings.arguments as String),
          settings: routeSettings);
    case signUpPasswordRoute:
      return MaterialPageRoute(
          builder: (context) => SignUpPasswordScreen(
                form: routeSettings.arguments as SignUpData,
              ),
          settings: routeSettings);
    case signUpCode:
      return MaterialPageRoute(
          builder: (context) => SignUpCodeScreen(
                params: routeSettings.arguments as SignUpCodeParams,
              ),
          settings: routeSettings);
    case successRoute:
      return MaterialPageRoute(
          builder: (context) => const SingUpSuccess(), settings: routeSettings);
    case dashboardRoute:
      return MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
          settings: routeSettings);
    case changePasswordRoute:
      return MaterialPageRoute(
          builder: (context) => const ChangePasswordScreen(),
          settings: routeSettings);
    case termsConditionsRoote:
      return MaterialPageRoute(
          builder: (context) {
            return TermsConditionsScreen(
                routeSettings.arguments as TCScreenArgs);
          },
          settings: routeSettings);
    case directoryRoute:
      return MaterialPageRoute(
          builder: (context) => DirectoryScreen(
                member: routeSettings.arguments as MyGroupsMember?,
              ),
          settings: routeSettings);
    case myGroupMemberCodeScreem:
      return MaterialPageRoute(
          builder: (context) => ProfileCodeScreen(
                user: routeSettings.arguments as ModelUser?,
              ),
          settings: routeSettings);
    case paymentRoute:
      return MaterialPageRoute(
          builder: (context) => const PaymentMethodsScreen(),
          settings: routeSettings);
    case storeRoute:
      return MaterialPageRoute(
          builder: (context) => const StoreScreen(), settings: routeSettings);
    case storeCartRoute:
      return MaterialPageRoute(
          builder: (context) => StoreCartScreen(
                item: routeSettings.arguments as CartItem,
              ),
          settings: routeSettings);
    case notificationsSettingsRoute:
      return MaterialPageRoute(
          builder: (context) => const NotificationsSettingsScreen(),
          settings: routeSettings);
    case profileRoute:
      return MaterialPageRoute(
          builder: (context) => const ProfileScreen(), settings: routeSettings);
    case myCouponsRoute:
      return MaterialPageRoute(
          builder: (context) => const MyCouponsScreen(),
          settings: routeSettings);
    case myConsultsRoute:
      return MaterialPageRoute(
        builder: (context) => const MyConsultsScreen(),
        settings: routeSettings,
      );
    case myConsultsDetailRoute:
      return MaterialPageRoute(
        builder: (context) => MyConsultDetailScreen(
          consult: routeSettings.arguments as Consult,
        ),
        settings: routeSettings,
      );
    case myCouponsAddRoute:
      return MaterialPageRoute(
          builder: (context) => const MyCouponsCodeScreen(),
          settings: routeSettings);
    case myCouponsBundleDetailsRoute:
      return MaterialPageRoute(
          builder: (context) => MyCouponsBundleDetailsScreen(
              bundle: (routeSettings.arguments as Coupon)),
          settings: routeSettings);
    case myGroupsRoute:
      return MaterialPageRoute(
          builder: (context) =>
              MyGroupsScreen(routeParent: routeSettings.arguments as String?),
          settings: routeSettings);
    case myGroupsExistingUserRoute:
      return MaterialPageRoute(
          builder: ((context) {
            final args =
                ModalRoute.of(context)!.settings.arguments as ScreenArguments;
            return MyGroupsAddExistingScreen(
              admin: (args.admin as MyGroupsInfo),
            );
          }),
          settings: routeSettings);
    case myGroupsMemberRoute:
      return MaterialPageRoute(
          builder: (context) {
            final args = ModalRoute.of(context)!.settings.arguments
                as MyGroupsMemberScreenArgs;
            return MyGroupsMemberScreen(
              info: args.info,
              member: args.member,
            );
          },
          settings: routeSettings);
    case myGroupsConfigurationRoute:
      return MaterialPageRoute(
          builder: (context) => MyGroupsConfigurationScreen(
              members: (routeSettings.arguments as List<MyGroupsMember>?)),
          settings: routeSettings);
    case confidentialityScreen:
      return MaterialPageRoute(
          builder: ((context) => const ConfidentialityScreen()),
          settings: routeSettings);
    case scheduleAppointmentRoute:
      return MaterialPageRoute(
          builder: ((context) => ScheduleAppointmentScreen(
              params: (routeSettings.arguments
                  as ScheduleAppointmentsScreenParams))),
          settings: routeSettings);
    case contactUsRoute:
      return MaterialPageRoute(
          builder: (context) => const ContactUsScreen(),
          settings: routeSettings);
    case frequentQuestionsRoute:
      return MaterialPageRoute(
          builder: ((context) => const FrequentQuestionsScreen()));
    case paymentsHistoryRoute:
      return MaterialPageRoute(
          builder: ((context) => const PaymentsHistoryScreen()));
    case paymentsHistoryDetailRoute:
      return MaterialPageRoute(
          builder: ((context) => PaymentDetailScreen(
                record: routeSettings.arguments as PaymentRecord,
              )));
    case choosePaymentMethodRoute:
      return MaterialPageRoute(
          builder: ((context) => ChoosePaymentMethodScreen(
              timeBooked: routeSettings.arguments as BookAppointmentParams)));
    case payConsultRoute:
      return MaterialPageRoute(
          builder: ((context) => PayConsultScreen(
              timeBooked: routeSettings.arguments as BookAppointmentParams)));
    case scheduleAppointmentSuccessRoute:
      return MaterialPageRoute(
          builder: ((context) => ScheduleAppointmentSuccessScreen(
                isPaid: (routeSettings.arguments as bool?) ?? false,
              )));
    case addPaymentMethodRoute:
      return MaterialPageRoute(
          builder: ((context) => const AddPaymentMethodScreen()));
    case notificationsScreenRoute:
      return MaterialPageRoute(
          builder: ((context) => const NotificationsScreen()));
    default:
      return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(), settings: routeSettings);
  }
}
