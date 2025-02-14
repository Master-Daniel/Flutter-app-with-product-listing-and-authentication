import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/screens/login/controllers/LoginCubit.dart';

class LoginBinding {
  static BlocProvider<LoginCubit> bind() {
    return BlocProvider(
      create: (context) => LoginCubit(),
    );
  }
}
