import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_site/features/model/colorConfig.dart';
import 'package:ecommerce_site/features/presentation/details/bloc/details_cubit.dart';
import 'package:ecommerce_site/features/presentation/details/details_skeleton.dart';
import 'package:ecommerce_site/features/service/detailsService.dart';
import 'package:ecommerce_site/router/appRoutesEnum.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({Key? key, required this.productId}) : super(key: key);

  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsViewCubit>(
      create: (context) =>
          DetailsViewCubit(context.read<DetailsService>(), productId),
      child: _DetailsView(),
    );
  }
}

class _DetailsView extends StatelessWidget {
  _DetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsViewCubit, DetailsViewState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.isLoading) {
          return const DetailsSkeletonView();
        }
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              onTap: () {
                context.go(AppRoutes.product.routePath);
              },
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
            ),
            title: const Center(
                child: Text(
              'Details',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
            )),
            actions: [
              Icon(
                Icons.favorite_border,
                color: Colors.grey[800],
                size: 32.0,
              ),
            ],
            backgroundColor: SelectCategoryColor(state.categoryId),
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
                              color: SelectCategoryColor(state.categoryId),
                            ),

                            // Center(
                            //   child: Container(
                            //     child: (state.categoryImage.isEmpty)
                            //         ? const Icon(
                            //             Icons.image,
                            //             size: 360,
                            //           )
                            //         : Padding(
                            //             padding:
                            //                 const EdgeInsets.only(top: 20.0),
                            //             child: Image.network(
                            //               state.imageUrls[1],
                            //               width: 280,
                            //             ),
                            //           ),
                            //   ),
                            // ),
                            CarouselSlider(
                              options: CarouselOptions(
                                aspectRatio: 1.25,
                                enlargeCenterPage: false,
                                scrollDirection: Axis.horizontal,
                                autoPlay: false,
                                viewportFraction: 1.0,
                                onPageChanged: (index, reason) {
                                  context
                                      .read<DetailsViewCubit>()
                                      .changeDotIndicator();
                                },
                              ),
                              items: (state.imageUrls).map((category) {
                                return Center(
                                  child: Container(
                                    child: (state.categoryImage.isEmpty)
                                        ? const Icon(
                                            Icons.image,
                                            size: 360,
                                          )
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20.0),
                                            child: Image.network(
                                              category,
                                              width: 280,
                                            ),
                                          ),
                                  ),
                                );
                              }).toList(),
                            ),

                            Positioned(
                              left: 10,
                              top: 100,
                              child: DotsIndicator(
                                dotsCount: 4,
                                position: state.sliderCardNumber,
                                axis: Axis.vertical,
                                decorator: DotsDecorator(
                                  color: Colors.grey,
                                  activeColor: Colors.grey[800],
                                ),
                              ),
                            )
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
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                state.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 24),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  '\$ ${state.price}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 24),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// description
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: ExpandableText(
                          state.description,
                          expandText: 'more',
                          collapseText: 'show less',
                          maxLines: 4,
                          linkColor: Colors.grey[900],
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.grey[700]),
                        ),
                      ),
                    ),

                    /// Product color text
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                        child: Text(
                          'Color Available',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 22),
                        ),
                      ),
                    ),

                    /// different color product options
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          height: 80.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Align(
                                alignment: Alignment.center,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.blueGrey,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    child: Icon(
                                      Icons.image,
                                      size: 50,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    /// buy button
                    SliverPadding(
                      padding: const EdgeInsets.all(8.0),
                      sliver: SliverToBoxAdapter(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Buy Now',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey[400]),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[900],
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
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
      },
    );
  }
}
