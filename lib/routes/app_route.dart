import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_list/routes/routes.dart';
import 'package:to_do_list/screens/screens.dart';

final navigationKey = GlobalKey<NavigatorState>();

final appRoutes = [
  GoRoute(
      path:RouteLocation.home,
      parentNavigatorKey: navigationKey,
    builder:  HomeScreen.builder
  ),
  GoRoute(
      path:RouteLocation.createTask,
      parentNavigatorKey: navigationKey,
      builder:  CreateTaskScreen.builder
  )
];