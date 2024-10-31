import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:turismo_upala/app/footer/custom_footer.dart';
import 'package:turismo_upala/core/utils/device.dart';
import 'package:turismo_upala/core/utils/helpers.dart';
import 'package:turismo_upala/core/utils/hexcolor.dart';
import 'package:turismo_upala/features/attraction/bloc/attraction_bloc.dart';
import 'package:turismo_upala/features/attraction/pages/form_page.dart';
import 'package:turismo_upala/features/home/widgets/about_section.dart';
import 'package:turismo_upala/features/home/widgets/banner.dart';
import 'package:turismo_upala/features/home/widgets/experience_card.dart';
import 'package:turismo_upala/features/home/widgets/service_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.scrollToAbout = false});
  final bool scrollToAbout;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _aboutSectionKey = GlobalKey();

  void _scrollToAboutSection() {
    final context = _aboutSectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToTop() {
    final context = _aboutSectionKey.currentContext;
    if (context != null) {
      _scrollController.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.scrollToAbout) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToAboutSection();
      });
    } else {
      _scrollToTop();
    }
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si el nuevo valor de scrollToAbout es true y el antiguo es false, desplazarse
    if (widget.scrollToAbout && !oldWidget.scrollToAbout) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToAboutSection();
      });
    } else {
      _scrollToTop();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('F5F5DC'),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const BannerHome(),
            Container(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
              width: Device.media(context),
              constraints: const BoxConstraints(maxWidth: 1320),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nuestros Servicios',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Descubre una experiencia turística completa con servicios personalizados que te acercan a la naturaleza y cultura de Upala. Nos encargamos de que tu viaje sea inolvidable, cómodo y sin preocupaciones.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 30,
                      runSpacing: 30,
                      children: [
                        ServiceCard(
                          name: 'Hospedaje',
                          description:
                              'Alojamiento cómodo y acogedor en medio de la belleza natural de Upala. Relájate en un entorno tranquilo y disfruta de una estadía inolvidable.',
                          icon: Icons.bed_outlined,
                        ),
                        ServiceCard(
                          name: 'Alimentación',
                          description:
                              'Disfruta de platos frescos y deliciosos con ingredientes de la región. Vive una experiencia culinaria auténtica con lo mejor de la cocina local.',
                          icon: Icons.local_dining,
                        ),
                        ServiceCard(
                          name: 'Transporte',
                          description:
                              'Te llevamos a tus destinos con seguridad y comodidad. Ofrecemos traslados y recorridos para que disfrutes tu viaje sin complicaciones.',
                          icon: Icons.drive_eta_outlined,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              key: _aboutSectionKey,
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
              width: Device.media(context),
              constraints: const BoxConstraints(maxWidth: 1320),
              child: const QuienesSomosSection(),
            ),
            Container(
              width: Device.media(context),
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
              constraints: const BoxConstraints(maxWidth: 1320),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Experiencias',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Descubre Upala a través de aventuras en la naturaleza, tours de vida silvestre y encuentros con la cultura local. Cada experiencia te conectará con la belleza y autenticidad de la región, creando momentos inolvidables en el corazón de Costa Rica.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: BlocBuilder<AttractionBloc, AttractionState>(
                      builder: (context, state) {
                        if (state.react == React.getLoading) {
                          return Center(
                            child: SpinKitDualRing(
                              color: HexColor('#29a19a'),
                              size: 60,
                            ),
                          );
                        }
                        return Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 30,
                          runSpacing: 30,
                          children: [
                            for (var x in state.attractions)
                              ExperienceCard(
                                service: x.category.toUpperCase(),
                                descripction: x.title,
                                imageUrl: x.imageUrl,
                                json: state.lodges
                                    .firstWhere((l) => l.id == x.lodgeId)
                                    .toJson(),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 80),
                  /*  const DefaultButton(
                    label: 'Descubre Más',
                  )*/
                ],
              ),
            ),
            const CustomFooter(),
          ],
        ),
      ),
      floatingActionButton: (!kIsWeb)
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AttractionsFormPage(),
                  ),
                );
              },
            )
          : null,
    );
  }
}

class DescriptionText extends StatelessWidget {
  const DescriptionText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      '''En Upala, promovemos un turismo que invita a descubrir nuestras maravillas naturales y culturales de manera auténtica y respetuosa. Buscamos compartir la riqueza de nuestra tierra, desde ríos y volcanes hasta tradiciones y sabores locales, para que cada visitante se lleve una experiencia única y significativa.\n
Nuestro objetivo es fomentar un turismo sostenible que contribuya al crecimiento de Upala, apoyando a las comunidades locales y preservando el entorno natural que nos define. Te invitamos a formar parte de esta visión y a descubrir todo lo que Upala tiene para ofrecer.''',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      textAlign: TextAlign.justify,
    );
  }
}
