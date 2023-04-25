import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class GettingNextConsults extends DashboardEvent {
  final Map states;

  const GettingNextConsults({required this.states});

  @override
  List<Object?> get props => [states];
}

class GetUserName extends DashboardEvent {
  const GetUserName();

  @override
  List<Object?> get props => [];
}

class GetStripeConfig extends DashboardEvent {
  const GetStripeConfig();

  @override
  List<Object?> get props => [];
}

class SetRefresh extends DashboardEvent {
  final bool refresh;

  const SetRefresh({required this.refresh});

  @override
  List<Object?> get props => [refresh];
}

class DisposeLoading extends DashboardEvent {
  @override
  List<Object?> get props => [];
}

class GetMyGroupInfo extends DashboardEvent {
  @override
  List<Object?> get props => [];
}

class GetFirebaseToken extends DashboardEvent {
  @override
  List<Object?> get props => [];
}
