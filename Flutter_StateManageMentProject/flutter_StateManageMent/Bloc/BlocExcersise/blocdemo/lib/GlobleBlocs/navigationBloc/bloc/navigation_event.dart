part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent {}

class GlobalNavigationPushNamedEvent extends NavigationEvent {
  final String routeName;

  GlobalNavigationPushNamedEvent({required this.routeName});
}

class GlobalNavigationpushNamedAndRemoveUntilEvent extends NavigationEvent {
  final String routeName;

  GlobalNavigationpushNamedAndRemoveUntilEvent({
    required this.routeName,
  });
}

class GlobalNavigationpushReplacementNamedEvent extends NavigationEvent {
  final String routeName;

  GlobalNavigationpushReplacementNamedEvent({
    required this.routeName,
  });
}

class GlobleNavigationPop extends NavigationEvent {}
