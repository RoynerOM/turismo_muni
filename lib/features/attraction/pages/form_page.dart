import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_upala/app/spinner/dual_ring.dart';
import 'package:turismo_upala/app/text_field/text_field.dart';
import 'package:turismo_upala/features/attraction/bloc/attraction_bloc.dart';
import 'package:turismo_upala/features/attraction/models/attraction_model.dart';
import 'package:turismo_upala/features/image/pages/image_list.dart';

class AttractionsFormPage extends StatefulWidget {
  const AttractionsFormPage({super.key});

  @override
  State<AttractionsFormPage> createState() => _AttractionsFormPageState();
}

class _AttractionsFormPageState extends State<AttractionsFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageController = TextEditingController();
  final _serviceController = TextEditingController();
  int id = 0;

  void clear() {
    _titleController.clear();
    _categoryController.clear();
    _imageController.clear();
    _serviceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttractionBloc, AttractionState>(
      listener: (context, state) {
        if (state.react == React.postSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Experiencia agregada!')));
          clear();
          context.read<AttractionBloc>().add(LoadAttractionEvent());
          Navigator.pop(context);
        }
        if (state.react == React.postError) {
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
                                    InputSelect(
                                      controller: _serviceController,
                                      labelText: 'Experiencia Relacionada',
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Por favor, selecciona una experiencia';
                                        }
                                        return null;
                                      },
                                      options: [
                                        for (var x in state.lodges)
                                          Option(
                                            value: x.title,
                                            index: int.parse(x.id),
                                          )
                                      ],
                                      onChanged: (Option? x) {
                                        if (x != null) {
                                          setState(() {
                                            id = x.index!;
                                          });
                                        }
                                      },
                                    ),
                                    Input(
                                      labelText: 'Título',
                                      minLines: 2,
                                      maxLines: 5,
                                      controller: _titleController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Por favor, ingresa un título';
                                        }
                                        return null;
                                      },
                                    ),
                                    Input(
                                      labelText: 'Categoria',
                                      controller: _categoryController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Por favor, ingresa una categoria';
                                        }
                                        return null;
                                      },
                                    ),
                                    Input(
                                      labelText: 'Imagen URL',
                                      controller: _imageController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Por favor, ingresa la URL del logo';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),
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
                                            if (_formKey.currentState!
                                                .validate()) {
                                              AttractionsModel model =
                                                  AttractionsModel(
                                                title: _titleController.text,
                                                lodgeId: id.toString(),
                                                category:
                                                    _categoryController.text,
                                                imageUrl: _imageController.text,
                                                id: '',
                                              );

                                              context
                                                  .read<AttractionBloc>()
                                                  .add(CreateAttractionEvent(
                                                    lodge: model,
                                                  ));
                                            }
                                          },
                                          child:
                                              const Text('Agregar Experiencia'),
                                        ),
                                      ],
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
