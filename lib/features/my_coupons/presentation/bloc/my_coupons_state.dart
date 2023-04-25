import 'package:app/features/my_coupons/domain/entities/coupon_entity.dart';
import 'package:app/features/my_groups/domain/entities/my_groups_admin.dart';
import 'package:app/features/my_groups/domain/entities/my_groups_info.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/models/model_user.dart';
import 'package:equatable/equatable.dart';

enum FilterSelect {
  all(0x0),
  package(0x1),
  bonus(0x2),
  refund(0x4),
  transfer(0x8),
  membership(0x10);

  const FilterSelect(this.value);
  final int value;
}

const List<Coupon> couponsEmpty = [];

class MyCouponsState extends Equatable {
  final int availableConsults;
  final List<Coupon> coupons;
  final int filterSelect;
  final LoadingState loading;
  final String errorMessage;
  final MyGroupsInfo? groupsInfo;
  final MyGroupsAdmin? admin;
  final int totalPages;
  final ModelUser? user;

  const MyCouponsState({
    this.availableConsults = 0,
    this.coupons = couponsEmpty,
    this.filterSelect = 0,
    this.loading = LoadingState.dispose,
    this.errorMessage = '',
    this.groupsInfo,
    this.admin,
    this.totalPages = 0,
    this.user,
  });

  MyCouponsState copyWith({
    int? availableConsults,
    List<Coupon>? coupons,
    int? filterSelect,
    LoadingState? loading,
    String? errorMessage,
    MyGroupsInfo? groupsInfo,
    MyGroupsAdmin? admin,
    int? totalPages,
    ModelUser? user,
  }) =>
      MyCouponsState(
        availableConsults: availableConsults ?? this.availableConsults,
        coupons: coupons ?? this.coupons,
        filterSelect: filterSelect ?? this.filterSelect,
        loading: loading ?? this.loading,
        errorMessage: errorMessage ?? this.errorMessage,
        groupsInfo: groupsInfo ?? this.groupsInfo,
        admin: admin ?? this.admin,
        totalPages: totalPages ?? this.totalPages,
        user: user ?? this.user,
      );

  @override
  List<Object?> get props => [
        availableConsults,
        coupons,
        filterSelect,
        loading,
        errorMessage,
        groupsInfo,
        admin,
        totalPages,
        user,
      ];
}
