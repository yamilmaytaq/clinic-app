import 'package:clinic_app/features/shared/shared.dart';
import 'package:flutter/material.dart';

class PredictiveDiagnosisScreen extends StatelessWidget {
  const PredictiveDiagnosisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: CustomAppBar(
        scaffoldKey: scaffoldKey,
        title: "Diagnostico Predictivo",
      ),
      body: const DiagnosisFlow(),
    );
  }
}

class DiagnosisFlow extends StatefulWidget {
  const DiagnosisFlow({super.key});

  @override
  _DiagnosisFlowState createState() => _DiagnosisFlowState();
}

class _DiagnosisFlowState extends State<DiagnosisFlow> {
  int currentStep = 0;
  bool showResults = false;
  List<String> questions = [
    '¿Alguna vez has sido diagnosticado con hipertensión (presión arterial alta)?',
    '¿Tienes antecedentes familiares de enfermedades cardíacas?',
    '¿Tienes problemas de colesterol alto?',
    '¿Has tenido algún familiar con diabetes?',
    '¿Fumas o has fumado en el pasado?',
    '¿Tienes problemas de obesidad?',
    '¿Tienes antecedentes de enfermedades respiratorias?',
  ];

  // Función para avanzar en las preguntas
  void _answerQuestion(bool answer) {
    setState(() {
      if (currentStep < questions.length - 1) {
        currentStep++; // Avanza a la siguiente pregunta
      } else {
        showResults =
            true; // Muestra la pantalla de resultados al finalizar las preguntas
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget showScreen() {
      if (showResults) {
        return _buildResultsScreen();
      }
      return currentStep == 0 ? _buildIntroScreen() : _buildQuestionScreen();
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          showScreen(),
        ],
      ),
    );
  }

  // Pantalla inicial de introducción
  Widget _buildIntroScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '¿QUÉ ES?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            'El Diagnóstico Predictivo utiliza datos y análisis avanzado para anticipar posibles condiciones de salud antes de que se manifiesten. \n\nRecopila información detallada del paciente, como historial médico, síntomas actuales, y hábitos de vida, para generar predicciones y recomendaciones personalizadas con el objetivo de prevenir enfermedades y mejorar la salud.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              setState(() {
                currentStep = 1; // Inicia el flujo de preguntas
              });
            },
            child: const Text('Iniciar diagnóstico'),
          ),
        ],
      ),
    );
  }

  // Pantalla de preguntas dinámicas
  Widget _buildQuestionScreen() {
    final primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            questions[currentStep], // Muestra la pregunta actual
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _answerQuestion(true), // Respuesta Sí
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, // Cambia el color del botón
                ),
                child: const Text(
                  'Sí',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 20),
              OutlinedButton(
                onPressed: () => _answerQuestion(false), // Respuesta No
                child: const Text('No'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Pantalla de resultados
  Widget _buildResultsScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Resultados del Diagnóstico',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildResultItem(
              '95%',
              'Clamidia',
              'Los síntomas reportados sugieren una alta probabilidad de infección',
              Colors.green.shade100),
          const SizedBox(height: 10),
          _buildResultItem(
              '65%',
              'Gonorrea',
              'Existe una probabilidad significativa de gonorrea basada en los síntomas',
              Colors.yellow.shade100),
          const SizedBox(height: 10),
          _buildResultItem(
              '44%',
              'Sífilis',
              'La probabilidad de infección por sífilis es moderada.',
              Colors.orange.shade100),
          const SizedBox(height: 10),
          _buildResultItem(
              '39%',
              'VPH',
              'Los síntomas son compatibles con una infección por VPH en un nivel bajo',
              Colors.red.shade100),
          const SizedBox(height: 30),
          const Text(
            'Te recomendamos programar una consulta con un cardiólogo para un diagnóstico completo y asesoramiento personalizado.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Acción al presionar el botón Agendar Cita
            },
            child: const Text('Agendar Cita'),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              // Acción para cuidados previos a la consulta
            },
            child: const Text('Cuidados previos a la consulta'),
          ),
        ],
      ),
    );
  }

  // Widget que construye cada resultado
  Widget _buildResultItem(
      String percentage, String condition, String description, Color color) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$percentage $condition',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
