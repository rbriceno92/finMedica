import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonDashboard extends StatelessWidget {
  const SkeletonDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            height: height / 2,
            width: width,
            color: ColorsFM.neutral95,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: marginStandard),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          alignment: AlignmentDirectional.topStart,
                          height: 32,
                          width: 145,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    Row(
                      children: const [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: extraSmallMargin,
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(shape: BoxShape.circle),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginStandard),
              child: Card(
                color: ColorsFM.neutral99,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 260,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                      shape: BoxShape.circle,
                                      width: 32,
                                      height: 32),
                                ),
                                SkeletonLine(
                                  style: SkeletonLineStyle(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: minMargin,
                                          vertical: extraSmallMargin),
                                      alignment: AlignmentDirectional.topStart,
                                      height: 14,
                                      width: 124,
                                      borderRadius: BorderRadius.circular(6)),
                                )
                              ],
                            ),
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: extraSmallMargin,
                                      vertical: extraSmallMargin),
                                  alignment: AlignmentDirectional.topStart,
                                  height: 14,
                                  width: 54,
                                  borderRadius: BorderRadius.circular(6)),
                            )
                          ],
                        ),
                        getItemConsultSkeleton(),
                        getItemConsultSkeleton()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getItemConsultSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: extraSmallMargin),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusRoundedButton),
                topRight: Radius.circular(cornerRounded),
                bottomRight: Radius.circular(cornerRounded),
                bottomLeft: Radius.circular(cornerRounded))),
        elevation: 0,
        color: Colors.white,
        child: SizedBox(
          height: 88,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [DataSkeleton(), DataSkeleton()],
              )),
              Container(
                width: 94,
                color: ColorsFM.neutral95,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget DataSkeleton() {
    return Padding(
      padding: const EdgeInsets.only(left: minMargin),
      child: Row(
        children: [
          const SkeletonAvatar(
            style: SkeletonAvatarStyle(
                shape: BoxShape.circle, width: 32, height: 32),
          ),
          const SizedBox(
            width: extraSmallMargin,
          ),
          Column(
            children: [
              SkeletonLine(
                style: SkeletonLineStyle(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    alignment: AlignmentDirectional.topStart,
                    height: 14,
                    width: 140,
                    borderRadius: BorderRadius.circular(6)),
              ),
              const SizedBox(
                height: minMargin,
              ),
              SkeletonLine(
                style: SkeletonLineStyle(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    alignment: AlignmentDirectional.topStart,
                    height: 8,
                    width: 140,
                    borderRadius: BorderRadius.circular(6)),
              )
            ],
          )
        ],
      ),
    );
  }
}
