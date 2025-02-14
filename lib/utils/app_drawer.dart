import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:products/screens/login/controllers/LoginCubit.dart';
import 'package:products/widgets/space.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.userData != current.userData, // Rebuild only when userData changes
      builder: (context, state) {
        context.watch<LoginCubit>().loadUserSession();
        final userData = context.watch<LoginCubit>().state.userData; // Ensures updates are watched

        return Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  userData != null ? "${userData['firstName']} ${userData['lastName']}" : "Guest",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(userData?['email'] ?? "guest@example.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 40),
                ),
              ),
              const Spacer(),
              ListTile(
                leading: Icon(userData != null ? Icons.logout : Icons.login),
                title: Text(userData != null ? "Logout" : "Login"),
                onTap: () async {
                  if (userData != null) {
                    await context.read<LoginCubit>().logout(); // Ensure logout updates state
                  } else {
                    Get.toNamed('/login');
                  }
                },
              ),
              vSpace(20),
            ],
          ),
        );
      },
    );
  }
}
