import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/path_router.dart';
import 'package:remindbless/data/models/data_home.dart';
import 'package:remindbless/data/models/products/product_item.dart';
import 'package:remindbless/presentation/screens/home_screen.dart';
import 'package:remindbless/presentation/widgets/common/ticket_common.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

import 'extension_home_child_screen.dart';

extension ExtensionHomeTwoScreen on HomeScreenState{
  Widget viewSquareSaleWidget() {

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: SizedBox(
        height: 120,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: itemsCategoryYouChoose.length,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final item = itemsCategoryYouChoose[index];

            return SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    /// IMAGE
                    Positioned.fill(
                      child: Image.asset(
                        item["imageUrl"],
                        fit: BoxFit.cover,
                        cacheWidth: 1080,
                      ),
                    ),

                    /// TEXT OVERLAY
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        color: Colors.black.withOpacity(0.45),
                        child: UnitText(text: item["title"],maxLines: 2, fontSize: 14,fontFamily: Assets.sfProSemibold,
                          color: Colors.white)
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget viewPageForYou(List<ProductItem>? listProduct){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      child: GridView.builder(
        padding: const EdgeInsets.only(bottom: 90),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5,
          childAspectRatio: 110 / 170, // tỷ lệ width/height mỗi item
        ),
        itemCount: listProduct?.length ?? 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(
                  context,
                  PathRouter.productDetailScreen,
                  arguments: {
                    'product': listProduct?[index],
                  },
                );
              },
              child: CouponCard(
                height: double.infinity,
                width: double.infinity,
                curvePosition: 160,
                curveRadius: 15,
                borderRadius: 10,
                decoration: BoxDecoration(color: Colors.white),
                firstChild: firstChildPageForYou(listProduct?[index]),
                borderColor: Colors.black12,
                secondChild: secondChildPageForYou(listProduct?[index]),
              ),
            ),
          );
        },
      ),
    );
  }


  Widget viewPageTopDeals(){
    return SizedBox();
  }

}