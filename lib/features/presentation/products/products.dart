import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_site/features/model/colorConfig.dart';
import 'package:ecommerce_site/features/presentation/products/bloc/products_cubit.dart';
import 'package:ecommerce_site/features/presentation/products/products_skeleton.dart';
import 'package:ecommerce_site/features/service/detailsService.dart';
import 'package:ecommerce_site/router/appRoutesEnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsViewCubit>(
      create: (context) => ProductsViewCubit(context.read<DetailsService>()),
      child: _ProductsView(),
    );
  }
}

class _ProductsView extends StatelessWidget {
  _ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsViewCubit, ProductsViewState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.isLoading) {
          return const ProductsSkeletonView();
        }
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                const CircleAvatar(
                  child: Icon(Icons.image, color: Colors.black),
                  backgroundColor: Colors.blueGrey,
                ),
              ],
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello,',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const Text(
                  'Anurag KR',
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                ),
              ],
            ),
            actions: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.dehaze, color: Colors.black),
              ),
              const SizedBox(
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
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search_sharp,
                                size: 32.0,
                              ),
                              hintText: 'Search for brand',
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// ad slider
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      sliver: SliverToBoxAdapter(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 1.6,
                            enlargeCenterPage: false,
                            scrollDirection: Axis.horizontal,
                            autoPlay: false,
                            viewportFraction: 1.0,
                            onPageChanged: (index, reason) {
                              // _currentIndex = index;
                              context
                                  .read<ProductsViewCubit>()
                                  .changeDotIndicator();
                            },
                          ),
                          items: ((state.categories).take(4)).map((category) {
                            return Container(
                              color: SelectCategoryColor(category.id),
                              // color: Colors.deepPurple[100],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 24),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Get ${category.name}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 24),
                                            overflow: TextOverflow.visible,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              'Full speed ahead.',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  color: Colors.grey[600]),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                context
                                                    .read<ProductsViewCubit>();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.grey[800],
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  'Shop Now',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.grey[300]),
                                                ),
                                              ),
                                            ),
                                          ),
                                          DotsIndicator(
                                            dotsCount: 4,
                                            position: state.sliderCardNumber,
                                            decorator: DotsDecorator(
                                              color: Colors.grey,
                                              activeColor: Colors.grey[800],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: Image.network(category.image),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    /// filter
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                      sliver: SliverToBoxAdapter(
                        child: SizedBox(
                          height: 50.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.filterList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  context
                                      .read<ProductsViewCubit>()
                                      .changeFilterListNumber(
                                          state.filterList[index].id);
                                },
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Card(
                                    color: (state.filterListNumber == index)
                                        ? Colors.grey[800]
                                        : Colors.grey[200],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      child: Text(
                                        state.filterList[index].name,
                                        style: TextStyle(
                                            color: (state.filterListNumber ==
                                                    index)
                                                ? Colors.grey[300]
                                                : Colors.grey[700],
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'New Arrival',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'See All',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// products
                    SliverPadding(
                      padding: const EdgeInsets.all(16.0),
                      sliver: SliverGrid.count(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.85,
                        children:
                            List.generate(state.productsList.length, (index) {
                          return InkWell(
                            onTap: () {
                              context.go(AppRoutes.details.routePath,
                                  extra: state.productsList[index].id);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              elevation: 4,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                // height: 160,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 140,
                                          color: Colors.white,
                                        ), //Container
                                        Container(
                                          height: 105,
                                          decoration: BoxDecoration(
                                            color: SelectCategoryColor(state
                                                .productsList[index]
                                                .category
                                                .id),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20),
                                                    topLeft:
                                                        Radius.circular(20)),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 16.0),
                                            width: 120,
                                            child: Image.network(state
                                                .productsList[index]
                                                .imageUrls[1]),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16.0, 10.0, 10.0, 0.0),
                                      child: Text(
                                        state.productsList[index].title,
                                        style: const TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, right: 8.0),
                                      child: Text(
                                        state.productsList[index].description,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[700]),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16.0, 4.0, 10.0, 26.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\$ ${state.productsList[index].price}",
                                            style: const TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Icon(
                                            Icons.add_box,
                                            size: 26.0,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    (state.moreButtonClicked)
                        ? ProductsListSkeleton()
                        : const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 10.0,
                            ),
                          ),

                    /// more products
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                        child: (!state.moreButtonClicked)
                            ? Center(
                                child: InkWell(
                                  onTap: () {
                                    context
                                        .read<ProductsViewCubit>()
                                        .addMoreProducts();
                                  },
                                  child: const Text(
                                    'more',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            : const SizedBox(
                                height: 10.0,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }
}
