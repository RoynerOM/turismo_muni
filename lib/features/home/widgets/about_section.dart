import 'package:flutter/material.dart';
import 'package:turismo_upala/core/utils/device.dart';

class QuienesSomosSection extends StatelessWidget {
  const QuienesSomosSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Device.media(context),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          // Título de la sección con icono
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.nature, color: Colors.teal[700], size: 28),
              const SizedBox(width: 8),
              Text(
                "¿Quiénes Somos?",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: Colors.teal[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 600;

              return isMobile
                  ? Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage("assets/images/jungle.png"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const Positioned(
                              top: 8,
                              right: 8,
                              child: Icon(Icons.eco,
                                  color: Colors.white, size: 30),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildDescriptionText(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildDescriptionText(),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: Stack(
                            children: [
                              Container(
                                height: 250,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image:
                                        AssetImage("assets/images/jungle.png"),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.teal, width: 2),
                                ),
                              ),
                              const Positioned(
                                top: 8,
                                left: 8,
                                child: Icon(Icons.local_florist,
                                    color: Colors.white, size: 30),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.eco, color: Colors.teal[400], size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "En Upala, promovemos un turismo que invita a descubrir nuestras maravillas "
                "naturales y culturales de manera auténtica y respetuosa. Buscamos compartir la "
                "riqueza de nuestra tierra, desde ríos y volcanes hasta tradiciones y sabores "
                "locales, para que cada visitante se lleve una experiencia única y significativa.\n",
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.eco, color: Colors.teal[400], size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Nuestro objetivo es fomentar un turismo sostenible que contribuya al crecimiento "
                "de Upala, apoyando a las comunidades locales y preservando el entorno natural que "
                "nos define. Te invitamos a formar parte de esta visión y a descubrir todo lo que "
                "Upala tiene para ofrecer.",
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
