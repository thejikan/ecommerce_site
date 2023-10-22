import 'package:ecommerce_site/features/model/colorConfig.dart';
import 'package:ecommerce_site/features/model/skeleton.dart';
import 'package:ecommerce_site/features/presentation/details/bloc/details_cubit.dart';
import 'package:ecommerce_site/features/presentation/products/bloc/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsSkeletonView extends StatelessWidget {
  const DetailsSkeletonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsViewCubit, DetailsViewState>(
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
      leading: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Skeleton(
          width: 20,
        ),
      ),
      title: const Center(
        child: Skeleton(
          width: 150,
          height: 24,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Skeleton(
            width: 30,
            height: 16,
          ),
        ),
      ],
      backgroundColor: SelectCategoryColor(0),
    ),
    backgroundColor: Colors.white,
    body: Column(
      children: [
        Expanded(
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              /// image
              SliverToBoxAdapter(
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 340,
                        color: Colors.white,
                      ), //Container
                      Container(
                        height: 240,
                        color: SelectCategoryColor(0),
                      ),

                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 60),
                          child: Skeleton(
                            width: 260,
                            height: 240,
                          ),
                        ),
                      ),
                    ], //<Widget>[]
                  ), //Stack
                ),
              ),

              /// product and price
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Skeleton(
                            width: 100,
                            height: 32,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 4, 0, 4),
                          child: Skeleton(
                            width: 120,
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// description
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Skeleton(
                    height: 120,
                  ),
                ),
              ),

              /// Product color text
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                  child: Skeleton(
                    height: 30,
                  ),
                ),
              ),

              /// different color product options
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 80.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Skeleton(
                              width: 80,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              /// buy button
              const SliverPadding(
                padding: EdgeInsets.all(8.0),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Skeleton(
                      height: 50,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
