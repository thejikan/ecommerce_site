part of 'router.dart';

GoRoute _homeRoutes() {
  return GoRoute(
    path: AppRoutes.product.routePath,
    builder: (context, state) {
      return RepositoryProvider.value(
        value: serviceLocator.getDetailsService(),
        child: ProductsView(),
      );
    },
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.details.routeSubPath,
        builder: (context, state) {
          int id = state.extra as int;
          return RepositoryProvider.value(
            value: serviceLocator.getDetailsService(),
            child: DetailsView(productId: id),
          );
        },
      ),
    ],
  );
}
