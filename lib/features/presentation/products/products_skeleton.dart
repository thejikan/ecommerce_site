import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_site/features/model/skeleton.dart';
import 'package:ecommerce_site/features/presentation/products/bloc/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsSkeletonView extends StatelessWidget {
  const ProductsSkeletonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsViewCubit, ProductsViewState>(
      builder: (context, state) {
        return _skeletonStructure();
      },
    );
  }
}

Widget _skeletonStructure() {
  return Scaffold(
    appBar: AppBar(
      elevation: 0,
      leading: Row(
        children: const [
          SizedBox(
            width: 16,
          ),
          CircleSkeleton(
            size: 40,
          ),
        ],
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Skeleton(
              width: 80,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Skeleton(
              width: 150,
            ),
          ),
          // ),
        ],
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Skeleton(
            width: 30,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Skeleton(
            width: 30,
            height: 16,
          ),
        ),
        SizedBox(
          width: 12,
        ),
      ],
      backgroundColor: Colors.white,
    ),
    body: Column(
      children: [
        Expanded(
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              /// search
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  child: Skeleton(
                    width: 320,
                    height: 40,
                  ),
                ),
              ),

              /// ad slider
              SliverPadding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                sliver: SliverToBoxAdapter(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 1.6,
                      enlargeCenterPage: false,
                      scrollDirection: Axis.horizontal,
                      autoPlay: false,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {},
                    ),
                    items: [1, 2, 3, 4].map((category) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 4),
                        child: Skeleton(
                          width: 360,
                          height: 160,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              /// filter
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 4),
                          child: Skeleton(
                            width: 100,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              /// products above text
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                        child: Skeleton(
                          width: 60,
                          height: 30,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                        child: Skeleton(
                          width: 60,
                          height: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// products
              ProductsListSkeleton(),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget ProductsListSkeleton() {
  return SliverPadding(
    padding: const EdgeInsets.all(16.0),
    sliver: SliverGrid.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      childAspectRatio: 1 / 1.5,
      children: List.generate(10, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          child: Skeleton(),
        );
      }),
    ),
  );
}
