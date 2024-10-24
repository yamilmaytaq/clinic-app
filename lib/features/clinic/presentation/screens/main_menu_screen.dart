import 'package:clinic_app/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: CustomAppBar(scaffoldKey: scaffoldKey),
      body: const _OptionsClinic(),
    );
  }
}

class _OptionsClinic extends StatelessWidget {
  const _OptionsClinic();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          _Header(),

          const SizedBox(height: 20),

          // Menu Buttons
          const _MenuButtons(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      width: size.width * 0.7,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: primaryColor,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        'Clinica de prueba',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: primaryColor,
          overflow: TextOverflow.clip,
        ),
        softWrap: true,
      ),
    );
  }
}

class _MenuButtons extends StatelessWidget {
  const _MenuButtons();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _menuButton(
                'Diagnóstico Predictivo',
                Icons.check_circle,
                primaryColor,
                onTap: () => context.push("/predictive-diagnosis"),
              ),
              _menuButton(
                  'Agendamiento de citas', Icons.calendar_today, primaryColor),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _menuButton(
                  'Consultas y pre-consultas', Icons.edit, primaryColor),
              _menuButton('Seguimiento y Monitorización',
                  Icons.medical_services, primaryColor),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _menuButton('Historial médico', Icons.file_copy, primaryColor),
              _menuButton(
                  'Información y Educación', Icons.lightbulb, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuButton(String title, IconData icon, Color color,
      {Function? onTap}) {
    return GestureDetector(
      onTap: () {
        if (onTap == null) return;
        onTap();
      },
      child: Expanded(
        child: Container(
          width: 120,
          height: 120,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
