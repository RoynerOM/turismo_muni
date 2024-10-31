import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_upala/app/spinner/dual_ring.dart';
import 'package:turismo_upala/app/text_field/text_field.dart';
import 'package:turismo_upala/features/image/pages/image_list.dart';
import 'package:turismo_upala/features/lodge/bloc/lodge_bloc.dart';
import 'package:turismo_upala/features/lodge/models/loadge_model.dart';

class AddLodgePage extends StatefulWidget {
  const AddLodgePage({super.key});

  @override
  State<AddLodgePage> createState() => _AddLodgePageState();
}

class _AddLodgePageState extends State<AddLodgePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _logoController = TextEditingController();

  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _ubicacionController = TextEditingController();

  final TextEditingController _serviceController = TextEditingController();
  final List<String> _services = [];

  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _imageFooterController = TextEditingController();
  final List<Map<String, String>> _images = [];

  final TextEditingController _infoController = TextEditingController();
  final List<String> _information = [];

  void clear() {
    _titleController.clear();
    _descriptionController.clear();
    _logoController.clear();
    _telefonoController.clear();
    _websiteController.clear();
    _correoController.clear();
    _ubicacionController.clear();
    _serviceController.clear();
    _imageUrlController.clear();
    _imageFooterController.clear();
    _infoController.clear();
    _services.clear();
    _images.clear();
    _information.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LodgeBloc, LodgeState>(
      listener: (context, state) {
        if (state.react == LodgeReact.postSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Experiencia agregada!')));
          clear();
        }
        if (state.react == LodgeReact.postError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Huvo un error al guardar')),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Nueva Experiencia'),
          ),
          body: Center(
            child: (state.react == React.postLoading)
                ? const Center(
                    child: DualRing(
                      message: 'Guardando',
                    ),
                  )
                : SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 720),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              key: _formKey,
                              child: SizedBox(
                                child: Column(
                                  children: <Widget>[
                                    Input(
                                      labelText: 'Título',
                                      controller: _titleController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Por favor, ingresa un título';
                                        }
                                        return null;
                                      },
                                    ),
                                    Input(
                                      labelText: 'Descripción',
                                      controller: _descriptionController,
                                      minLines: 10,
                                      maxLines: 40,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Por favor, ingresa una descripción';
                                        }
                                        return null;
                                      },
                                    ),
                                    Input(
                                      labelText: 'Logo URL',
                                      controller: _logoController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Por favor, ingresa la URL del logo';
                                        }
                                        return null;
                                      },
                                    ),
                                    // Contacto
                                    const SizedBox(height: 30),
                                    const Row(
                                      children: [
                                        Text(
                                          'Contacto',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Input(
                                      labelText: 'Teléfono',
                                      controller: _telefonoController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Por favor, ingresa el teléfono';
                                        }
                                        return null;
                                      },
                                    ),
                                    Input(
                                      labelText: 'Sitio Web',
                                      controller: _websiteController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Por favor, ingresa el sitio web';
                                        }
                                        return null;
                                      },
                                    ),
                                    Input(
                                      labelText: 'Correo',
                                      controller: _correoController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Por favor, ingresa el correo';
                                        }
                                        return null;
                                      },
                                    ),
                                    Input(
                                      labelText: 'Ubicación',
                                      controller: _ubicacionController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Por favor, ingresa la ubicación';
                                        }
                                        return null;
                                      },
                                    ),
                                    // Servicios
                                    const SizedBox(height: 30),
                                    const Row(
                                      children: [
                                        Text(
                                          'Servicios',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Input(
                                      labelText: 'Servicio',
                                      controller: _serviceController,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_serviceController
                                            .text.isNotEmpty) {
                                          setState(() {
                                            _services
                                                .add(_serviceController.text);
                                            _serviceController.clear();
                                          });
                                        }
                                      },
                                      child: const Text('Agregar Servicio'),
                                    ),
                                    Wrap(
                                      spacing: 8.0,
                                      children: _services
                                          .map((service) =>
                                              Chip(label: Text(service)))
                                          .toList(),
                                    ),
                                    // Imágenes
                                    const SizedBox(height: 30),
                                    const Row(
                                      children: [
                                        Text(
                                          'Imágenes',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Input(
                                      labelText: 'Imagen URL',
                                      controller: _imageUrlController,
                                    ),
                                    Input(
                                      labelText: 'Footer de Imagen',
                                      controller: _imageFooterController,
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ImageListPage(),
                                              ),
                                            );
                                          },
                                          child: const Text('Obtener URL'),
                                        ),
                                        const SizedBox(width: 12),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (_imageUrlController
                                                    .text.isNotEmpty &&
                                                _imageFooterController
                                                    .text.isNotEmpty) {
                                              setState(() {
                                                _images.add({
                                                  'url':
                                                      _imageUrlController.text,
                                                  'pie': _imageFooterController
                                                      .text,
                                                });
                                                _imageUrlController.clear();
                                                _imageFooterController.clear();
                                              });
                                            }
                                          },
                                          child: const Text('Agregar Imagen'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Wrap(
                                      spacing: 8.0,
                                      children: _images
                                          .map((image) => Chip(
                                              deleteIcon:
                                                  const Icon(Icons.delete),
                                              onDeleted: () {
                                                _images.remove(image);
                                                setState(() {});
                                              },
                                              label: Text(
                                                image['pie']!,
                                              )))
                                          .toList(),
                                    ),
                                    // Información
                                    const SizedBox(height: 30),
                                    const Row(
                                      children: [
                                        Text(
                                          'Información',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Input(
                                      labelText: 'Información',
                                      controller: _infoController,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_infoController.text.isNotEmpty) {
                                          setState(() {
                                            _information
                                                .add(_infoController.text);
                                            _infoController.clear();
                                          });
                                        }
                                      },
                                      child: const Text('Agregar'),
                                    ),
                                    Wrap(
                                      spacing: 8.0,
                                      children: _information
                                          .map(
                                              (info) => Chip(label: Text(info)))
                                          .toList(),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // Crear objetos
                                          Lodge lodge = Lodge(
                                            title: _titleController.text,
                                            description:
                                                _descriptionController.text,
                                            logo: _logoController.text,
                                          );

                                          Contact contact = Contact(
                                            telefono: _telefonoController.text,
                                            website: _websiteController.text,
                                            correo: _correoController.text,
                                            ubicacion:
                                                _ubicacionController.text,
                                          );

                                          // Enviar el evento al BLoC
                                          context
                                              .read<LodgeBloc>()
                                              .add(CreateLodgeEvent(
                                                lodge: lodge,
                                                contact: contact,
                                                services: _services
                                                    .map(
                                                        (s) => Service(name: s))
                                                    .toList(),
                                                images: _images
                                                    .map((img) => GalleryImage(
                                                        url: img['url']!,
                                                        footer: img['pie']!))
                                                    .toList(),
                                                information: _information
                                                    .map((info) =>
                                                        Information(info: info))
                                                    .toList(),
                                              ));
                                        }
                                      },
                                      child: const Text('Agregar Experiencia'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
