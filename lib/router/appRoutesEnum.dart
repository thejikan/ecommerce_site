import 'package:ecommerce_site/router/routesHelperClass.dart';

class AppRoutes {
  static const product = RoutesBase(
    name: "product",
    routePath: "/product",
    routeSubPath: "product",
  );
  static const details = RoutesBase(
    name: "details",
    routePath: '/product/details',
    routeSubPath: "details",
  );

}
