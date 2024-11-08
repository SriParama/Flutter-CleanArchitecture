part of 'snackbar_bloc.dart';

@immutable
sealed class SnackbarEvent extends Equatable {}

class GlobleSnackbarEvent extends SnackbarEvent {
  final String snackMessage;
  final Color snackbgColor;
  final Color snackTextColor;
  GlobleSnackbarEvent(
      {required this.snackMessage,
      required this.snackbgColor,
      required this.snackTextColor});

  @override
  // TODO: implement props
  List<Object?> get props => [snackMessage, snackbgColor, snackTextColor];
}
