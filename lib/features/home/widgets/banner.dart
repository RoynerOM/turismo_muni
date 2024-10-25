import 'package:flutter/material.dart';
import 'package:turismo_upala/app/buttons/default_button.dart';

class BannerHome extends StatelessWidget {
  const BannerHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 600,
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 80),
      decoration: const BoxDecoration(
        color: Color(0xFF0B2347),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              'https://muniupala-my.sharepoint.com/:i:/g/personal/rmeza_muniupala_go_cr/EefkBW3a8TpEtH8EfnvkZ_AB0cU7LaRJzUBdQVaMsRs4VA?e=UOZ7bS'),
        ),
      ),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 1320),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 378),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cuantivante de arriba abajo'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2CD97B),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Cantón de Upala.'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Se encuentra dividido en 8 distritos. Fue fundado el 17 de marzo de 1970. Su cabecera y ciudad más importante es Upala. El cantón de Upala está constituido geológicamente por materiales de los períodos Terciario y Cuaternario, siendo las rocas volcánicas del Cuaternario las que predominan en la región.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  DefaultButton(
                    onTap: () {},
                    label: 'Conocer Más',
                  )
                ],
              ),
            ),
            Container(
              width: 600,
              height: 500,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/banner2.png',
                  ),
                ),
              ),
              constraints: const BoxConstraints(maxWidth: 578),
            )
          ],
        ),
      ),
    );
  }
}
