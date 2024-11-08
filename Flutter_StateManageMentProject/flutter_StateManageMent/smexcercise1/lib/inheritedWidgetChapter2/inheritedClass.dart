class Api {
  // String? dateAndTime;
  String? getDateAndTime() {
    String dateAndTime = DateTime.now().toIso8601String();
    return dateAndTime;

    // return Future.delayed(
    //   const Duration(seconds: 0),
    //   () => DateTime.now().toIso8601String(),
    // ).then((value) {
    //   dateAndTime = value;
    //   return value;
    // });
  }
}
