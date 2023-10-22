import 'package:ecommerce_site/features/presentation/details/details.dart';
import 'package:ecommerce_site/features/presentation/products/products.dart';
import 'package:ecommerce_site/features/service/serviceLocator.dart';
import 'package:ecommerce_site/main.dart';
import 'package:ecommerce_site/router/appRoutesEnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'appRoutes.dart';

typedef PopViewCallback = void Function(bool result);

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(title: 'Flutter Demo Home Page');
      },
      redirect: (BuildContext context, GoRouterState state) async {
        // return AppRoutes.success.routePath;
        // return AppRoutes.bookAppointment.routePath;
        // return AppRoutes.details.routePath;
        return AppRoutes.product.routePath;
      },
    ),
    _homeRoutes(),
  ],
);
