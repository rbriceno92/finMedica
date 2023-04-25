import 'package:app/features/my_consults/domain/entities/consult.dart';
import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final List<Consult>? consult;
  final bool isLoading;
  final String? errorMessage;
  final Map states;
  final String name;
  final bool refresh;
  final LoadingState loading2;
  final bool? isAdmin;
  final String token;
  final String? link;

  const DashboardState(
      {this.consult,
      this.isLoading = true,
      this.errorMessage = '',
      this.states = const {},
      this.name = '',
      this.refresh = false,
      this.loading2 = LoadingState.dispose,
      this.isAdmin,
      this.token = '',
      this.link});

  DashboardState copyWith(
      {List<Consult>? consult,
      bool? isLoading,
      String? errorMessage,
      Map? states,
      String? name,
      bool? refresh,
      LoadingState? loading2,
      bool? isAdmin,
      String? token,
      String? link}) {
    return DashboardState(
        consult: consult ?? this.consult,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage,
        states: states ?? this.states,
        name: name ?? this.name,
        refresh: refresh ?? this.refresh,
        loading2: loading2 ?? this.loading2,
        isAdmin: isAdmin ?? this.isAdmin,
        token: token ?? this.token,
        link: link ?? this.link);
  }

  @override
  List<Object?> get props => [
        consult,
        isLoading,
        errorMessage,
        states,
        name,
        refresh,
        loading2,
        isAdmin,
        token,
        link
      ];
}
