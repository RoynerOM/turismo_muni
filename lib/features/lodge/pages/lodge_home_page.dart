// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_element

import 'package:flutter/material.dart';
import 'package:turismo_upala/core/utils/device.dart';
import 'package:turismo_upala/features/lodge/models/lodge_list_model.dart';
import 'package:turismo_upala/features/lodge/widgets/image_view.dart';
import 'package:turismo_upala/features/lodge/widgets/vinetas.dart';
import 'package:url_launcher/url_launcher.dart';

class LodgeHomePage extends StatelessWidget {
  const LodgeHomePage({super.key, required this.model});
  final LodgeModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage(
                model.logo,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 40, 12, 80),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Device.media(context),
                child: Text(
                  model.title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: Device.media(context),
                child: Text(
                  model.description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: Device.media(context),
                child: Vinetas(
                  title: 'Servicios',
                  data: model.services,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: Device.media(context),
                child: Vinetas(
                  title: 'Información Adicional',
                  data: model.information,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: Device.media(context),
                child: const Row(
                  children: [
                    Text(
                      'Galería',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: Device.media(context),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 375,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: model.gallery.length,
                    itemBuilder: (context, index) {
                      final item = model.gallery[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FullScreenImage(
                                imageUrl: item.url,
                                footer: item.footer,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Hero(
                                tag: 'imageHero_$index',
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        item.url,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: Text(
                                item.footer,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: Device.media(context),
                child: const Row(
                  children: [
                    Text(
                      'Contacto',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: Device.media(context),
                child: Column(
                  children: [
                    RowContact(
                      title: "Telefono",
                      value: model.contact.phone,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final Uri params = Uri(
                          scheme: 'mailto',
                          path: model.contact.email,
                        );

                        String url = params.toString();
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'No se pudo abrir el correo: ${model.contact.email}';
                        }
                      },
                      child: RowContact(
                        title: "Correo",
                        value: model.contact.email,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        void _launchURL(String url) async {
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'No se pudo abrir el enlace: $url';
                          }
                        }
                      },
                      child: RowContact(
                        title: "Sitio Web",
                        value: model.contact.page,
                      ),
                    ),
                    RowContact(
                      title: "Ubicacion",
                      value: model.contact.place,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RowContact extends StatelessWidget {
  const RowContact({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            '$title:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.name,
    this.selected = false,
    required this.onPressed,
  });
  final String name;
  final bool selected;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    if (!selected) {
      return TextButton(
        onPressed: onPressed,
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.green, Colors.teal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
