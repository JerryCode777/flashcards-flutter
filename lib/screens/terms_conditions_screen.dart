import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Términos y Condiciones"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Términos y Condiciones",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Bienvenido a nuestra aplicación \"Flashcards para Aprender Inglés\". Al utilizar esta aplicación, aceptas los términos y condiciones que se detallan a continuación. Si no estás de acuerdo con ellos, por favor, no utilices esta aplicación.",
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "1. Uso de la aplicación",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Esta aplicación está diseñada para uso personal y educativo. Está prohibido utilizar la aplicación para actividades ilegales, modificar su contenido sin autorización o distribuirla sin permiso del propietario.",
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "2. Propiedad intelectual",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Todos los derechos sobre el contenido de la aplicación, incluidos los textos, imágenes y diseños, pertenecen a los desarrolladores. No puedes utilizar ningún material sin autorización previa.",
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "3. Limitación de responsabilidad",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "No nos hacemos responsables por problemas técnicos, pérdidas de datos o daños derivados del uso de la aplicación. Usas la aplicación bajo tu propio riesgo.",
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "4. Cambios en los términos",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Nos reservamos el derecho de actualizar estos términos y condiciones en cualquier momento. Los cambios serán notificados mediante la aplicación.",
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
