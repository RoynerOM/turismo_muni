import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:turismo_upala/core/utils/device.dart';
import 'package:turismo_upala/core/utils/hexcolor.dart';
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
              image: CachedNetworkImageProvider(
                model.logo,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                      textAlign: TextAlign.justify,
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
                                    child: CachedNetworkImage(
                                      progressIndicatorBuilder:
                                          (context, url, progress) =>
                                              SpinKitDualRing(
                                        color: HexColor('#29a19a'),
                                        size: 60,
                                      ),
                                      imageBuilder: (_, builder) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(
                                              item.url,
                                            ),
                                          ),
                                        ),
                                      ),
                                      imageUrl: item.url,
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
                          onTap: () async {
                            if (await canLaunch(model.contact.page)) {
                              await launch(model.contact.page);
                            } else {
                              throw 'No se pudo abrir el enlace: ${model.contact.page}';
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
        ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
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
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
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
