import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';
import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

class MyGroupsConfigurationState extends Equatable {
  final List<MyGroupsMember> members;
  final String filter;
  final LoadingState loading;
  final MyGroupsMember? selectMember;

  const MyGroupsConfigurationState(
      {this.members = const [],
      this.filter = '',
      this.loading = LoadingState.dispose,
      this.selectMember});

  MyGroupsConfigurationState copyWith(
          {List<MyGroupsMember>? members,
          String? filter,
          LoadingState? loading,
          MyGroupsMember? selectMember}) =>
      MyGroupsConfigurationState(
          members: members ?? this.members,
          filter: filter ?? this.filter,
          loading: loading ?? this.loading,
          selectMember: selectMember ?? this.selectMember);

  @override
  List<Object?> get props => [selectMember, members, filter, loading];
}
