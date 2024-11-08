part of 'dialog_bloc.dart';

sealed class DialogEvent extends Equatable {
  const DialogEvent();

  @override
  List<Object> get props => [];
}

class DailogOpenEvent extends DialogEvent {
  // final GlobalKey<NavigatorState> navigatorKey;
  final String title;
  final String? confirmButtonText;
  final Widget content;
  final VoidCallback? onConfirm;
  const DailogOpenEvent(
      {
      // required this.navigatorKey,
      required this.title,
      required this.content,
      this.confirmButtonText,
      this.onConfirm});

  @override
  // TODO: implement props
  List<Object> get props => [title, content, onConfirm!];
}

class DailogHideEvent extends DialogEvent {}
