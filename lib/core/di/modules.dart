import 'package:app/core/network/client_chopper.dart';
import 'package:app/core/network/connection_status.dart';
import 'package:app/features/change_password/data/services/service_change_password.dart';
import 'package:app/features/change_password/domain/repositories/change_password_repository.dart';
import 'package:app/features/change_password/data/repositories/change_password_repository_impl.dart';
import 'package:app/features/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:app/features/change_password/presentation/bloc/change_password_bloc.dart';
import 'package:app/features/contact_us/data/repositories/contact_us_repository_impl.dart';
import 'package:app/features/contact_us/domain/repository/contact_us_repository.dart';
import 'package:app/features/contact_us/domain/use_case/contact_us_send_data.dart';
import 'package:app/features/contact_us/presentation/bloc/contact_us_bloc.dart';
import 'package:app/features/dashboard/data/services/service_next_consult.dart';
import 'package:app/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:app/features/dashboard/domain/use_cases/get_next_consults.dart';
import 'package:app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:app/features/directory/data/services/directory_services.dart';
import 'package:app/features/directory/domain/repositories/directory_repository.dart';
import 'package:app/features/directory/data/repositories/directory_repository_impl.dart';
import 'package:app/features/directory/domain/use_cases/book_appointment_use_case.dart';
import 'package:app/features/directory/domain/use_cases/discount_consult_use_case.dart';
import 'package:app/features/directory/domain/use_cases/get_clinic_use_case.dart';
import 'package:app/features/directory/domain/use_cases/get_directory_by_specialist.dart';
import 'package:app/features/directory/domain/use_cases/get_directory_by_specialist_and_name.dart';
import 'package:app/features/directory/domain/use_cases/get_specialities.dart';
import 'package:app/features/directory/presentation/bloc/book_appointment/book_appointment_pay_bloc.dart';
import 'package:app/features/directory/presentation/bloc/schedule/schedule_bloc.dart';
import 'package:app/features/forgot_password/data/services/forgot_password_services.dart';
import 'package:app/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:app/features/forgot_password/data/repositories/forgot_password_repository_impl.dart';
import 'package:app/features/forgot_password/domain/use_cases/send_code.dart';
import 'package:app/features/forgot_password/domain/use_cases/send_email.dart';
import 'package:app/features/forgot_password/domain/use_cases/update_password_use_case.dart';
import 'package:app/features/forgot_password/presentation/bloc/forgot_password_screen/forgot_password_bloc.dart';
import 'package:app/features/forgot_password/presentation/bloc/restore_password_screen/restore_password_bloc.dart';
import 'package:app/features/forgot_password/presentation/bloc/validation_code_screen/validation_code_bloc.dart';
import 'package:app/features/frequent_questions/domain/use_case/get_frequent_questions.dart';
import 'package:app/features/login/domain/repositories/sign_in_repository.dart';
import 'package:app/features/login/data/repositories/sign_in_repository_impl.dart';
import 'package:app/features/login/domain/use_cases/sign_in.dart';
import 'package:app/features/login/presentation/bloc/sign_in_bloc.dart';
import 'package:app/features/my_consults/domain/use_cases/doctor_photo_use_case.dart';
import 'package:app/features/my_consults/domain/use_cases/make_consult_private_use_case.dart';
import 'package:app/features/my_consults/domain/use_cases/consult_detail_use_case.dart';
import 'package:app/features/my_consults/domain/use_cases/reschedule_appointment_use_case.dart';
import 'package:app/features/my_consults/presentation/bloc/my_consult_detail_bloc.dart';
import 'package:app/features/my_coupons/data/repositories/my_coupons_repository_impl.dart';
import 'package:app/features/my_coupons/data/services/service_my_coupons.dart';
import 'package:app/features/my_coupons/domain/repository/my_coupons_repository.dart';
import 'package:app/features/my_coupons/domain/use_cases/get_coupon_detail_use_case.dart';
import 'package:app/features/my_coupons/domain/use_cases/my_coupons_code.dart';
import 'package:app/features/my_coupons/domain/use_cases/transfer_coupons_use_case.dart';
import 'package:app/features/my_coupons/presentation/bloc/my_coupons_code_bloc.dart';
import 'package:app/features/my_coupons/presentation/bloc/my_coupons_bloc.dart';
import 'package:app/features/my_consults/data/repositories/consult_repository_impl.dart';
import 'package:app/features/my_consults/domain/use_cases/get_consults.dart';
import 'package:app/features/my_consults/presentation/bloc/my_consult_bloc.dart';
import 'package:app/features/my_coupons/presentation/bloc/my_coupons_detail_bloc.dart';
import 'package:app/features/my_groups/data/repositories/my_groups_repository_impl.dart';
import 'package:app/features/my_groups/domain/repository/my_groups_repository.dart';
import 'package:app/features/my_groups/domain/use_case/my_groups_add_member.dart';
import 'package:app/features/my_groups/domain/use_case/my_groups_fetch_data.dart';
import 'package:app/features/my_groups/domain/use_case/my_groups_fetch_data_filter.dart';
import 'package:app/features/my_groups/domain/use_case/my_groups_new_member.dart';
import 'package:app/features/my_groups/domain/use_case/my_groups_remove_member.dart';
import 'package:app/features/my_groups/domain/use_case/my_groups_transfer_admin.dart';
import 'package:app/features/my_groups/domain/use_case/my_groups_transfer_management.dart';
import 'package:app/features/my_groups/presentation/bloc/my_groups_add_exising_bloc.dart';
import 'package:app/features/my_groups/presentation/bloc/my_groups_bloc.dart';
import 'package:app/features/my_groups/presentation/bloc/my_groups_configuration_bloc.dart';
import 'package:app/features/my_groups/presentation/bloc/my_groups_new_member_bloc.dart';
import 'package:app/features/notifications/domain/repository/notifications_repository.dart';
import 'package:app/features/notifications/domain/use_cases/delete_notification_use_case.dart';
import 'package:app/features/notifications/domain/use_cases/get_notification_use_case.dart';
import 'package:app/features/notifications/domain/use_cases/notify_use_notification_server.dart';
import 'package:app/features/notifications/presentation/bloc/settings/notifications_settings_bloc.dart';
import 'package:app/features/payments/data/repository/payment_methods_repository_impl.dart';
import 'package:app/features/payments/data/repository/payment_repository_impl.dart';
import 'package:app/features/payments/data/services/service_payments.dart';
import 'package:app/features/payments/data/services/service_user_payment_methods.dart';
import 'package:app/features/payments/domain/repositories/payment_methods_repository.dart';
import 'package:app/features/payments/domain/repositories/payment_repository.dart';
import 'package:app/features/payments/domain/use_cases/create_payment_method_use_case.dart';
import 'package:app/features/payments/domain/use_cases/delete_payment_method_use_case.dart';
import 'package:app/features/payments/domain/use_cases/get_payment_config_use_case.dart';
import 'package:app/features/payments/domain/use_cases/get_payment_methods_use_case.dart';
import 'package:app/features/payments/presentation/bloc/add_payment_method_bloc.dart';
import 'package:app/features/payments/presentation/bloc/payment_method_bloc.dart';
import 'package:app/features/payments_history/data/repository/payments_history_repository_impl.dart';
import 'package:app/features/payments_history/domain/repository/payment_history_repository.dart';
import 'package:app/features/payments_history/domain/use_case/payments_history_fetch_data.dart';
import 'package:app/features/payments_history/presentations/bloc/payments_history_bloc.dart';
import 'package:app/features/profile/domain/repositories/user_info_repository.dart';
import 'package:app/features/profile/data/repositories/user_info_repository_impl.dart';
import 'package:app/features/profile/domain/use_cases/get_user_info.dart';
import 'package:app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:app/features/signup/data/services/service_sign_up.dart';
import 'package:app/features/signup/data/services/service_sign_up_verify.dart';
import 'package:app/features/signup/domain/repositories/sign_up_code_repository.dart';
import 'package:app/features/signup/data/repositories/sign_up_code_repository_impl.dart';
import 'package:app/features/signup/domain/repositories/sign_up_repository.dart';
import 'package:app/features/signup/data/repositories/sign_up_repository_impl.dart';
import 'package:app/features/signup/domain/use_cases/sign_up.dart';
import 'package:app/features/signup/domain/use_cases/sign_up_code.dart';
import 'package:app/features/signup/presentation/bloc/sign_up_code_bloc.dart';
import 'package:app/features/signup/presentation/bloc/sign_up_form_bloc.dart';
import 'package:app/features/signup/presentation/bloc/sign_up_password_bloc.dart';
import 'package:app/features/store/data/repository/store_repository_impl.dart';
import 'package:app/features/store/data/services/service_product.dart';
import 'package:app/features/store/domain/repository/store_repository.dart';
import 'package:app/features/store/domain/use_case/payment_create_use_case.dart';
import 'package:app/features/store/domain/use_case/store_fetch_data_use_case.dart';
import 'package:app/features/store/presentation/bloc/store_bloc.dart';
import 'package:app/features/store/presentation/bloc/store_cart_bloc.dart';
import 'package:app/features/terms_conditions/data/services/service_terms_conditions.dart';
import 'package:app/features/terms_conditions/data/repositories/terms_conditions_repository_impl.dart';
import 'package:app/features/terms_conditions/domain/repositories/terms_conditions_repository.dart';
import 'package:app/features/terms_conditions/domain/use_cases/terms_conditions_use_case.dart';
import 'package:app/features/terms_conditions/presentation/bloc/terms_conditions_bloc.dart';
import 'package:app/util/user_preferences_save.dart';
import 'package:chopper/chopper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/confidentiality/presentation/bloc/confidentiality_bloc.dart';
import '../../features/contact_us/data/services/service_contact.dart';
import '../../features/dashboard/domain/repositories/dashboard_repositories.dart';
import '../../features/my_coupons/domain/use_cases/get_coupons_available.dart';
import '../../features/directory/domain/use_cases/get_schedule_doctor.dart';
import '../../features/directory/presentation/bloc/book_appointment/book_appointment_bloc.dart';
import '../../features/directory/presentation/bloc/directory/directory_bloc.dart';
import '../../features/frequent_questions/data/services/service_frequent_questions.dart';
import '../../features/frequent_questions/domain/repositories/frequent_questions_repositories.dart';
import '../../features/frequent_questions/data/repositories/frequent_questions_repositories_impl.dart';
import '../../features/frequent_questions/presentation/bloc/frequent_questions_bloc.dart';
import '../../features/login/data/services/service_login.dart';
import '../../features/my_consults/data/services/services_cancel_consult.dart';
import '../../features/my_consults/data/services/services_consults.dart';
import '../../features/my_consults/data/repositories/cancel_consult_impl.dart';
import '../../features/my_consults/domain/repositories/cancel_consult_repository.dart';
import '../../features/my_consults/domain/repositories/consult_repository.dart';
import '../../features/my_consults/domain/use_cases/cancel_consult.dart';
import '../../features/my_groups/data/services/services_groups.dart';
import '../../features/my_groups/domain/use_case/create_my_groups.dart';
import '../../features/my_groups/domain/use_case/my_groups_list.dart';
import '../../features/notifications/data/repositories/notifications_repository_impl.dart';
import '../../features/notifications/data/services/notifications_service.dart';
import '../../features/notifications/presentation/bloc/notifications_bloc.dart';
import '../../features/payments_history/data/services/service_history.dart';
import '../../features/profile/data/services/service_update_data_user.dart';
import '../../features/profile/domain/repositories/update_data_user_repository.dart';
import '../../features/profile/data/repositories/update_data_user_repository_impl.dart';
import '../../features/profile/domain/use_cases/update_data_user.dart';
import '../../features/refresh_token/data/services/refresh_service.dart';
import '../../features/refresh_token/data/repositories/refresh_repository_impl.dart';
import '../../features/refresh_token/domain/use_case/refresh_use_case.dart';
import '../../features/signup/data/services/service_resend_code.dart';
import '../../features/signup/domain/repositories/resend_code.dart';
import '../../features/signup/data/repositories/resend_code_impl.dart';
import '../../features/signup/domain/use_cases/resend_code.dart';
import '../network/refresh_token_interceptor.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  await Firebase.initializeApp();

  getIt.registerLazySingleton<NetworkStatus>(() => NetworkStatusImpl());

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  getIt.registerLazySingleton(() => RefreshUseCase(
      repository: RefreshTokenRepositoryImpl(
          chopperClient: ClientChopper.buildClientChopper(
              [RefreshService.create()], null, null))));

  getIt.registerLazySingleton(
      () => UserPreferenceDao(sharedPreferences: getIt()));

  getIt.registerLazySingleton<ChopperRefreshAutenticator>(() =>
      ChopperRefreshAutenticator(
          refreshUseCase: getIt(),
          userDao: getIt(),
          sharedPreferences: getIt()));

  getIt.registerSingleton<ChopperClient>(
    ClientChopper.buildClientChopper([
      ServiceLogin.create(),
      ServiceForgotPassword.create(),
      ServiceSignUp.create(),
      ServiceSignUpVerify.create(),
      ServiceChangePassword.create(),
      ServiceTermsConditions.create(),
      ServiceUpdateDataUser.create(),
      ServiceNextConsult.create(),
      ServiceConsults.create(),
      ServiceFrequentQuestions.create(),
      ServiceResendCode.create(),
      ServiceProduct.create(),
      ServiceHistory.create(),
      ServiceContact.create(),
      ServiceDirectory.create(),
      ServicePayments.create(),
      ServiceUserPaymentMethods.create(),
      ServiceCancelConsults.create(),
      ServiceMyCoupons.create(),
      ServicesGroups.create(),
      ServiceNotification.create()
    ], null, getIt()),
  );

  //data source

  //repositories
  getIt.registerLazySingleton<SignInRepository>(
      () => SignInRepositoryImpl(chopperClient: getIt()));
  getIt.registerLazySingleton<ForgotPasswordRepository>(
      () => ForgotPasswordRepositoryImpl(chopperClient: getIt()));
  getIt.registerLazySingleton<SignUpRepository>(
      () => SignUpRepositoryImpl(chopperClient: getIt()));
  getIt.registerLazySingleton<SignUpCodeRepository>(
      () => SignUpCodeRepositoryImpl(chopperClient: getIt()));
  getIt.registerLazySingleton<ResendCodeRepository>(
      () => ResendCodeRepositoryImpl(chopperClient: getIt()));
  getIt.registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(chopperClient: getIt(), dao: getIt()));
  getIt.registerLazySingleton<ChangePasswordRepository>(
      () => ChangePasswordRepositoryImpl(chopperClient: getIt()));
  getIt.registerLazySingleton<DirectoryRepository>(
      () => DirectoryRepositoryImpl(chopperClient: getIt()));
  getIt.registerLazySingleton<TermsConditionsRepository>(
      () => TermsConditionsRepositoryImpl(chopperClient: getIt()));
  getIt.registerLazySingleton<UserInfoRepository>(
      () => UserInfoRepositoryImpl(dao: getIt()));
  getIt.registerLazySingleton<MyCouponsRepository>(
      () => MyCouponsRepositoryImpl(chopperClient: getIt()));
  getIt.registerLazySingleton<ConsultRepository>(
      () => ConsultRepositoryImpl(dao: getIt(), chopperClient: getIt()));
  getIt.registerLazySingleton<CancelConsultRepository>(
      () => CancelConsultRepositoryImpl(chopperClient: getIt()));
  getIt.registerLazySingleton<MyGroupsRepository>(
      () => MyGroupsRepositoryImpl(chopperClient: getIt(), dao: getIt()));
  getIt.registerLazySingleton<UpdateDataUserRepository>(
      () => UpdateDataUserImpl(chopperClient: getIt()));
  getIt.registerLazySingleton<FrequentQuestionsRepository>(
      () => FrequentQuestionsRepositoryImpl(chopperClient: getIt()));
  getIt.registerLazySingleton<ContactUsRepository>(
      () => ContactUsRepositoryImpl(chopperClient: getIt()));
  getIt.registerLazySingleton<PaymentHistoryRepository>(
      () => PaymentHistoryRepositoryImpl(chopperClient: getIt(), dao: getIt()));
  getIt.registerLazySingleton<StoreRepository>(
      () => StoreRepositoryImpl(chopperClient: getIt()));
  getIt.registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(chopperClient: getIt()));
  getIt.registerLazySingleton<PaymentMethodsRepository>(
      () => PaymentMethodsRepositoryImpl(chopperClient: getIt()));
  getIt.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(chopperClient: getIt()));

  //UseCases
  getIt.registerLazySingleton(() => SignIn(signInRepository: getIt()));
  getIt.registerLazySingleton(
      () => SendEmail(forgotPasswordRepository: getIt()));
  getIt.registerLazySingleton(() => SignUp(signUpRepository: getIt()));
  getIt.registerLazySingleton(() => SignUpCode(repository: getIt()));
  getIt.registerLazySingleton(() => ResendCode(repository: getIt()));
  getIt.registerLazySingleton(() => GetNextConsults(repository: getIt()));
  getIt
      .registerLazySingleton(() => SendCode(forgotPasswordRepository: getIt()));
  getIt.registerLazySingleton(
      () => UpdatePasswordUseCase(forgotPasswordRepository: getIt()));
  getIt.registerLazySingleton(() => ChangePasswordUseCase(repository: getIt()));
  getIt.registerFactory(() => GetDirectory(repository: getIt()));
  getIt.registerFactory(() => GetClinicUseCase(repository: getIt()));
  getIt.registerFactory(() => GetSpecialities(repository: getIt()));
  getIt.registerFactory(
      () => GetDirectoryBySpecialistAndName(repository: getIt()));
  getIt
      .registerLazySingleton(() => TermsConditionsUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetUserInfo(repository: getIt()));
  getIt.registerLazySingleton(() => GetConsults(repository: getIt()));
  getIt.registerLazySingleton(() => MyCouponsCodeUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => MyGroupsFetchDataUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => MyGroupsFetchDataFilteredUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => MyGroupsAddMemberUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => MyGroupsRemoveMemberUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => MyGroupsEditAdminUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => CreateMyGroupsUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => MyGroupsListUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => MyGroupsNewMemberUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => UpdateDataUser(signInRepository: getIt()));
  getIt.registerLazySingleton(
      () => ContactUsSendDataUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => FrequentQuestionsUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => MyGroupsTransferManagementUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => PaymentHistoryFetchDataUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => StoreFetchDataUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => ConsultDetailUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => CancelConsultUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetScheduleUseCase(repository: getIt()));
  getIt
      .registerLazySingleton(() => BookAppointmentUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => GetCouponsAvailableUseCase(repository: getIt()));
  getIt
      .registerLazySingleton(() => DiscountConsultUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => GetPaymentConfigUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => CreatePaymentIntentUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => GetPaymentMethodsUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => CreatePaymentMethodUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => DeletePaymentMethodUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => RescheduleAppointmentUseCase(repository: getIt()));
  getIt
      .registerLazySingleton(() => GetNotificationUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => MakeConsultPrivateUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => TransferCouponUseCase(repository: getIt()));
  getIt
      .registerLazySingleton(() => GetCouponDetailUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => DoctorPhotoUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => DeleteNotificationUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => NotifyUseNotificationServer(repository: getIt()));

  //Blocs
  getIt.registerFactory(
      () => SignInBloc(signIn: getIt(), sharedPreferences: getIt()));
  getIt.registerFactory(() => ForgotPasswordBloc(sendEmail: getIt()));
  getIt.registerFactory(() => ValidationCodeBloc(sendCode: getIt()));
  getIt.registerFactory(
      () => RestorePasswordBloc(updatePasswordUseCase: getIt()));
  getIt.registerFactory(() => SignUpFormBloc(signUp: getIt()));
  getIt.registerFactory(() => SignUpPasswordBloc());
  getIt.registerFactory(
      () => SignUpCodeBloc(signUpCode: getIt(), resendCode: getIt()));
  getIt.registerFactory(() => DashboardBloc(
        nextConsults: getIt(),
        preferenceDao: getIt(),
        paymentConfigUseCase: getIt(),
        myGroupsFetchDataUseCase: getIt(),
        doctorPhotoUseCase: getIt(),
      ));
  getIt.registerFactory(
      () => ChangePasswordBloc(changePasswordUseCase: getIt()));
  getIt.registerFactory(() => TermsConditionsBloc(
      termsConditionsUseCase: getIt(), signUpUseCase: getIt()));
  getIt.registerFactory(() => DirectoryBloc(
      getSpecialities: getIt(),
      getDirectory: getIt(),
      getDirectoryBySpecialistAndName: getIt(),
      userInfo: getIt(),
      getClinicUseCase: getIt()));
  getIt.registerFactory(() => NotificationsSettingsBloc());
  getIt.registerFactory(() => ProfileBloc(
      userInfo: getIt(), updateData: getIt(), sharedPreferences: getIt()));
  getIt.registerFactory(() => MyCouponsBloc(
        getCouponsAvailableUseCase: getIt(),
        userDao: getIt(),
        myGroupsFetchDataUseCase: getIt(),
        myGroupsListUseCase: getIt(),
        transferCouponUseCase: getIt(),
        getCouponDetailUseCase: getIt(),
      ));
  getIt.registerFactory(() =>
      MyConsultsBloc(getConsults: getIt(), makeConsultPrivateUseCase: getIt()));
  getIt.registerFactory(() => MyCouponsCodeBloc(myCouponsCodeUseCase: getIt()));
  getIt.registerFactory(() => MyGroupsBloc(
      myGroupsFetchDataUseCase: getIt(),
      myGroupsRemoveMemberUseCase: getIt(),
      myGroupsEditAdminUseCase: getIt(),
      myGroupsListUseCase: getIt(),
      createMyGroupsUseCase: getIt(),
      userDao: getIt()));
  getIt.registerFactory(() => MyGroupsAddExistingBloc(
      myGroupsFetchDataFilteredUseCase: getIt(),
      myGroupsAddMemberUseCase: getIt()));
  getIt.registerFactory(
      () => MyGroupsNewMemberBloc(myGroupsNewMemberUseCase: getIt()));
  getIt.registerFactory(
      () => ContactUsBloc(contactUsSendDataUseCase: getIt(), dao: getIt()));
  getIt.registerFactory(
      () => FrequentQuestionsBloc(frequentQuestionsUseCase: getIt()));
  getIt.registerFactory(() =>
      MyGroupsConfigurationBloc(myGroupsTransferManagementUseCase: getIt()));
  getIt
      .registerFactory(() => ScheduleBloc(useCase: getIt(), userInfo: getIt()));
  getIt.registerFactory(
    () => MyConsultDetailBloc(
      consultDetailUseCase: getIt(),
      userInfo: getIt(),
      rescheduleAppointmentUseCase: getIt(),
      cancelConsultUseCase: getIt(),
      getCouponsAvailableUseCase: getIt(),
      bookAppointmentUseCase: getIt(),
      discountConsultUseCase: getIt(),
      doctorPhotoUseCase: getIt(),
    ),
  );
  getIt.registerFactory(
      () => PaymentsHistoryBloc(paymentHistoryFetchDataUseCase: getIt()));
  getIt.registerFactory(() => ConfidentialityBloc());
  getIt.registerFactory(() => StoreBloc(storeFetchDataUseCase: getIt()));
  getIt.registerFactory(() => BookAppointmentBloc(useCase: getIt()));
  getIt.registerFactory(() =>
      StoreCartBloc(createPaymentIntentUseCase: getIt(), userDao: getIt()));
  getIt.registerFactory(() => PaymentMethodsBloc(
      dao: getIt(),
      getPaymentMethodsUseCase: getIt(),
      deletePaymentMethodUseCase: getIt()));
  getIt.registerFactory(() => AddPaymentMethodBloc(
        dao: getIt(),
        createPaymentMethodUseCase: getIt(),
      ));
  getIt.registerFactory(() => BookAppointmentPayBloc(
        userDao: getIt(),
        storeFetchDataUseCase: getIt(),
        createPaymentIntentUseCase: getIt(),
        bookAppointmentUseCase: getIt(),
      ));

  getIt.registerFactory(() => NotificationsBloc(
      useCase: getIt(),
      preferenceDao: getIt(),
      deleteNotificationUseCase: getIt(),
      notifyServerViewedNotificationUseCase: getIt()));
  getIt.registerFactory(() =>
      MyCouponsDetailBloc(getCouponDetailUseCase: getIt(), userDao: getIt()));
}
