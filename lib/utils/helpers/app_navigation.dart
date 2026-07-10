import 'package:flutter/material.dart';

class AppNavigator<T> {
  AppNavigator.of(
      this.context, {
        bool rootNavigator = false,
      }) : rootNav = rootNavigator {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  final BuildContext context;
  final bool rootNav;

  static const Duration _transitionDuration = Duration(
    milliseconds: 500,
  );

  PageRouteBuilder<T> _fadeRoute(Widget child) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, _, _) => child,
      transitionDuration: _transitionDuration,
      reverseTransitionDuration: _transitionDuration,
      transitionsBuilder: (_, animation, _, page) {
        return FadeTransition(
          opacity: animation,
          child: page,
        );
      },
    );
  }

  Future<T?> push(Widget child) {
    return Navigator.of(
      context,
      rootNavigator: rootNav,
    ).push<T>(_fadeRoute(child));
  }

  Future<T?> pushReplacement(Widget child) {
    return Navigator.of(
      context,
      rootNavigator: rootNav,
    ).pushReplacement<T, T>(_fadeRoute(child));
  }

  Future<T?> pushReplacementNamed(String route) {
    return Navigator.of(
      context,
      rootNavigator: rootNav,
    ).pushReplacementNamed<T, T>(route);
  }

  Future<T?> pushAndRemoveUntil(Widget child) {
    return Navigator.of(
      context,
      rootNavigator: rootNav,
    ).pushAndRemoveUntil<T>(
      _fadeRoute(child),
          (_) => false,
    );
  }

  void pop([T? result]) {
    Navigator.of(
      context,
      rootNavigator: rootNav,
    ).pop<T>(result);
  }

  bool canPop() {
    return Navigator.of(
      context,
      rootNavigator: rootNav,
    ).canPop();
  }

  Future<bool> maybePop([T? result]) {
    return Navigator.of(
      context,
      rootNavigator: rootNav,
    ).maybePop<T>(result);
  }
}