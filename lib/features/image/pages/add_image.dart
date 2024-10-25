import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:turismo_upala/features/image/bloc/image_bloc.dart';

class AddImagePage extends StatefulWidget {
  const AddImagePage({super.key});

  @override
  State<AddImagePage> createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  final TextEditingController _footerController = TextEditingController();
  XFile? _selectedImage;
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generador de Enlace de Imágenes'),
      ),
      body: BlocConsumer<ImageBloc, ImageState>(
        listener: (context, state) {
          if (state is ImageUploadSuccess) {
            setState(() {
              _imageUrl = state.imageUrl;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Imagen subida con éxito')),
            );
          }
          if (state is ImageUploadFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error al subir la imagen')),
            );
          }
        },
        builder: (context, state) {
          if (state is ImageLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  if (_selectedImage != null)
                    Container(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Image.file(
                        File(_selectedImage!.path),
                      ),
                    ),
                  Container(
                    width: 480,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: TextField(
                      controller: _footerController,
                      decoration:
                          const InputDecoration(labelText: 'Pie de foto'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        _selectedImage = image;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 480,
                      constraints: const BoxConstraints(maxWidth: 480),
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      decoration: BoxDecoration(
                          color: const Color(0xFFE8E7F7),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        'Seleccionar Imagen',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocListener<ImageBloc, ImageState>(
                    listener: (context, state) {},
                    child: UploadButton(
                        selectedImage: _selectedImage,
                        footerController: _footerController),
                  ),
                  if (_imageUrl != null) ...[
                    const SizedBox(height: 20),
                    const Text('Enlace generado:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () {
                        // Copiar enlace al portapapeles
                        if (_imageUrl != null) {
                          Clipboard.setData(ClipboardData(text: _imageUrl!));
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Enlace copiado al portapapeles')),
                        );
                      },
                      child: Text(
                        _imageUrl!,
                        style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class UploadButton extends StatelessWidget {
  const UploadButton({
    super.key,
    required XFile? selectedImage,
    required TextEditingController footerController,
  })  : _selectedImage = selectedImage,
        _footerController = footerController;

  final XFile? _selectedImage;
  final TextEditingController _footerController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_selectedImage != null) {
          BlocProvider.of<ImageBloc>(context)
              .add(UploadImage(_selectedImage!.path, _footerController.text));
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: 480,
        constraints: const BoxConstraints(maxWidth: 480),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
            color: const Color(0xFF0142FF),
            borderRadius: BorderRadius.circular(20)),
        child: const Text(
          'Subir Imagen',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
