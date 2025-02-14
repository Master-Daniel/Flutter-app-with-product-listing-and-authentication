import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/screens/register/controllers/RegisterCubit.dart';

class RegisterBinding {
  static BlocProvider<RegisterCubit> bind() {
    return BlocProvider(
      create: (context) => RegisterCubit(),
    );
  }
}
