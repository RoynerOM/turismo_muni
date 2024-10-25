import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServiceForm extends StatefulWidget {
  const ServiceForm({super.key});

  @override
  State<ServiceForm> createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<TextEditingController> galleryControllers = [];
  List<TextEditingController> servicesControllers = [];
  List<TextEditingController> informacionesKeyControllers = [];
  List<TextEditingController> informacionesValueControllers = [];
  List<TextEditingController> contactoKeyControllers = [];
  List<TextEditingController> contactoValueControllers = [];

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Construir la galería
      List<Map<String, String>> gallery = galleryControllers.map((controller) {
        return {"url": controller.text, "footer": ""};
      }).toList();

      // Construir la lista de servicios adicionales
      List<String> services = servicesControllers.map((controller) {
        return controller.text;
      }).toList();

      // Construir informaciones
      List<Map<String, String>> informaciones = [];
      for (int i = 0; i < informacionesKeyControllers.length; i++) {
        informaciones.add({
          "key": informacionesKeyControllers[i].text,
          "value": informacionesValueControllers[i].text,
        });
      }

      // Construir contactos
      List<Map<String, String>> contacto = [];
      for (int i = 0; i < contactoKeyControllers.length; i++) {
        contacto.add({
          "key": contactoKeyControllers[i].text,
          "value": contactoValueControllers[i].text,
        });
      }

      // Construir el objeto JSON
      Map<String, dynamic> newService = {
        "title": titleController.text,
        "description": descriptionController.text,
        "gallery": gallery,
        "services": services,
        "informaciones": informaciones,
        "contacto": contacto,
      };

      // Enviar solicitud POST a la API
      final response = await http.post(
        Uri.parse('http://tudominio.com/api/service_api.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(newService),
      );

      if (response.statusCode == 200) {
        print('Servicio agregado con éxito');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Servicio agregado con éxito')));
      } else {
        print('Error al agregar servicio');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al agregar servicio')));
      }
    }
  }

  void addGalleryField() {
    setState(() {
      galleryControllers.add(TextEditingController());
    });
  }

  void addServiceField() {
    setState(() {
      servicesControllers.add(TextEditingController());
    });
  }

  void addInformacionField() {
    setState(() {
      informacionesKeyControllers.add(TextEditingController());
      informacionesValueControllers.add(TextEditingController());
    });
  }

  void addContactoField() {
    setState(() {
      contactoKeyControllers.add(TextEditingController());
      contactoValueControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Servicio Turístico'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la descripción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text('Galería de Imágenes'),
              for (var i = 0; i < galleryControllers.length; i++)
                TextFormField(
                  controller: galleryControllers[i],
                  decoration: InputDecoration(labelText: 'URL Imagen ${i + 1}'),
                ),
              ElevatedButton(
                onPressed: addGalleryField,
                child: const Text('Añadir Imagen'),
              ),
              const SizedBox(height: 20),
              const Text('Servicios Adicionales'),
              for (var i = 0; i < servicesControllers.length; i++)
                TextFormField(
                  controller: servicesControllers[i],
                  decoration: InputDecoration(labelText: 'Servicio ${i + 1}'),
                ),
              ElevatedButton(
                onPressed: addServiceField,
                child: const Text('Añadir Servicio'),
              ),
              const SizedBox(height: 20),
              const Text('Informaciones Adicionales'),
              for (var i = 0; i < informacionesKeyControllers.length; i++)
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: informacionesKeyControllers[i],
                        decoration:
                            InputDecoration(labelText: 'Clave ${i + 1}'),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: informacionesValueControllers[i],
                        decoration:
                            InputDecoration(labelText: 'Valor ${i + 1}'),
                      ),
                    ),
                  ],
                ),
              ElevatedButton(
                onPressed: addInformacionField,
                child: const Text('Añadir Información'),
              ),
              const SizedBox(height: 20),
              const Text('Contacto'),
              for (var i = 0; i < contactoKeyControllers.length; i++)
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: contactoKeyControllers[i],
                        decoration: InputDecoration(
                            labelText: 'Clave Contacto ${i + 1}'),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: contactoValueControllers[i],
                        decoration: InputDecoration(
                            labelText: 'Valor Contacto ${i + 1}'),
                      ),
                    ),
                  ],
                ),
              ElevatedButton(
                onPressed: addContactoField,
                child: const Text('Añadir Contacto'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
