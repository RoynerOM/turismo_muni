import 'package:flutter/material.dart';
import 'package:turismo_upala/app/buttons/default_button.dart';
import 'package:turismo_upala/core/utils/device.dart';
import 'package:turismo_upala/features/home/widgets/banner.dart';
import 'package:turismo_upala/features/home/widgets/experience_card.dart';
import 'package:turismo_upala/features/home/widgets/service_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              width: Device.media(context),
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
              constraints: const BoxConstraints(maxWidth: 1320),
              child: const Column(
                children: [
                  Row(
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
                  SizedBox(height: 24),
                  Text(
                    'Descubre Upala a través de aventuras en la naturaleza, tours de vida silvestre y encuentros con la cultura local. Cada experiencia te conectará con la belleza y autenticidad de la región, creando momentos inolvidables en el corazón de Costa Rica.',
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
                        ExperienceCard(
                          service: 'Hospedaje',
                          descripction:
                              '6 of the best Italian Carnivals beyond Venice, from north to south',
                        ),
                        ExperienceCard(
                          service: 'Alimentación',
                          descripction:
                              '6 of the best Italian Carnivals beyond Venice, from north to south',
                        ),
                        ExperienceCard(
                          service: 'Transporte',
                          descripction:
                              '6 of the best Italian Carnivals beyond Venice, from north to south',
                        ),
                        ExperienceCard(
                          service: 'Transporte',
                          descripction:
                              '6 of the best Italian Carnivals beyond Venice, from north to south',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 80),
                  DefaultButton(
                    label: 'Descubre Más',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
