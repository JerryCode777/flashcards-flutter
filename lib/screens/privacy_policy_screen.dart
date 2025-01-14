import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Política de Privacidad"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Política de Privacidad",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Esta política de privacidad describe cómo manejamos la información personal de los usuarios de nuestra aplicación \"Flashcards para Aprender Inglés\". Al usar esta aplicación, aceptas los términos establecidos en esta política.",
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "1. Información que recopilamos",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Nuestra aplicación no recopila información personal identificable como nombres, direcciones de correo electrónico o datos sensibles. Todos los datos relacionados con el progreso del usuario y configuraciones se almacenan localmente en el dispositivo y no son accesibles por terceros.",
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "2. Uso de la información",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "La información recopilada se utiliza exclusivamente para personalizar la experiencia de aprendizaje dentro de la aplicación. No compartimos datos con terceros ni utilizamos la información con fines comerciales o publicitarios.",
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "3. Seguridad de los datos",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Hemos implementado medidas técnicas y organizativas para proteger los datos almacenados en el dispositivo. Sin embargo, no podemos garantizar una seguridad absoluta debido a posibles vulnerabilidades en los sistemas operativos.",
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "4. Cambios en esta política",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Nos reservamos el derecho de modificar esta política en cualquier momento. Te notificaremos sobre cualquier cambio significativo a través de la aplicación o mediante un aviso en el sitio web.",
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
