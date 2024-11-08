import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie_cubit/auth_cookie_cubit.dart';

class IpoScreen extends StatefulWidget {
  const IpoScreen({super.key});

  @override
  State<IpoScreen> createState() => _IpoScreenState();
}

class _IpoScreenState extends State<IpoScreen> {
  @override
  void initState() {
    context.read<AuthCookieCubit>().loggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('IPO'),
    );
  }
}
