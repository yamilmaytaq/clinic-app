import 'package:clinic_app/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clinic_app/features/shared/shared.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final primaryColor = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.1),
              // Icon Banner
              _Header(height: size.height * 0.2),

              Container(
                height: size.height * 0.8 - (size.height * 0.1),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(150)),
                ),
                child: const _LoginForm(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final double height;
  const _Header({required this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/logo-cies-horizontal.png",
      height: height,
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyles = Theme.of(context).textTheme;
    final light = Theme.of(context).primaryColorLight;
    final primaryColor = Theme.of(context).primaryColor;

    final width = MediaQuery.of(context).size.width;

    final loginForm = ref.watch(loginFormProvider);

    ref.listen(
      authProvider,
      (previous, next) {
        if (next.errorMessage.isEmpty) return;
        showSnackbar(context, next.errorMessage);
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            'Inicio de Sesión',
            style: textStyles.titleLarge?.copyWith(
              color: light,
              fontSize: MediaQuery.of(context).size.width * 0.08,
            ),
          ),
          const SizedBox(height: 50),
          CustomTextFormField(
            label: 'Correo Electrónico',
            keyboardType: TextInputType.emailAddress,
            labelFontSize: width * 0.05,
            inputFontSize: width * 0.045,
            padding: EdgeInsets.symmetric(
              vertical: width * 0.03,
              horizontal: width * 0.03,
            ),
            onChanged: ref.read(loginFormProvider.notifier).onEmailChanged,
            errorMessage:
                loginForm.isFormPosted ? loginForm.email.errorMessage : null,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            labelFontSize: width * 0.05,
            inputFontSize: width * 0.045,
            padding: EdgeInsets.symmetric(
              vertical: width * 0.03,
              horizontal: width * 0.03,
            ),
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
            onFieldSubmitted: (_) =>
                ref.read(loginFormProvider.notifier).onFormSubmit(),
            errorMessage:
                loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Ingresar',
              buttonColor: light,
              textColor: primaryColor,
              fontSize: width * 0.04,
              onPressed: loginForm.isPosting
                  ? null
                  : ref.read(loginFormProvider.notifier).onFormSubmit,
            ),
          ),
          const Spacer(flex: 2),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     const Text('¿No tienes cuenta?'),
          //     TextButton(
          //         onPressed: () => context.push('/register'),
          //         child: const Text('Crea una aquí'))
          //   ],
          // ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
