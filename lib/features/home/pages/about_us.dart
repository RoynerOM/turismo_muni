import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cantón de Upala'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSection(),
            Section(
              title: 'Datos Generales',
              content:
                  '''Costa Rica es uno de los países con mayor diversidad a nivel mundial, siendo estimado alrededor del 6% de la biodiversidad del planeta. Esta característica, ha convertido a la nación en un referente internacional en temas de conservación, sostenibilidad e innovación, además de presentar grandes atractivos turísticos en todo el territorio nacional.\n
El país posee gran variedad de vida silvestre, debido en parte a su posición geográfica entre los continentes de América del Norte y del Sur, su clima neotropical y su amplia variedad de hábitats. Una de las principales fuentes de la biodiversidad fue el puente que permitió la mezcla de la flora y la fauna de los dos continentes.\n
Atesora el cuatro por ciento de las especies que se estima que existen en el planeta. Cientos de estas especies son endémicas de Costa Rica, lo que significa que no existen en ningún otro lugar del mundo, según el Ministerio de ambiente y energía. Estas especies endémicas incluyen ranas, serpientes, lagartijas, pinzones, colibríes, gofres, ratones, cíclidos y gobios, entre muchos más.\n
La variedad de ecosistemas dentro del país, selvas tropicales, los bosques caducifolios, la costa del Atlántico y el Pacífico, los bosques nubosos y los manglares están representados a lo largo de las 19,730 millas cuadradas de la masa de tierra de Costa Rica. Las regiones ecológicas son doce zonas climáticas. Esta variación proporciona numerosos nichos que están llenos de una diversidad de especies. 
''',
              images: [
                /* 'assets/rincon1.jpg',
                'assets/rincon2.jpg',
                'assets/rincon3.jpg',*/
              ],
            ),
            Section(
              title: 'Upala',
              content:
                  '''Upala, cantón número trece de la provincia de Alajuela posee una extensión de 1580.67 km², es el segundo cantón más extenso de la provincia de Alajuela. Upala posee una extensión de 158.000 hectáreas con una amplia y diversa conformación del paisaje histórico. La división del territorio en ocho distritos se encuentra en dos tipos de zonas distintas: la zona baja o las llanuras y la zona alta.
El territorio posee ríos navegables y áreas boscosas junto con explotación agropecuaria. En la zona alta existen dos valles con partes que incluyen la cordillera de Guanacaste, estas cubiertas de bosques. El clima en Upala es tropical (estación seca y lluviosa). El invierno va de mayo a enero o febrero y la estación seca de marzo a mayo, con algunas precipitaciones esporádicas ocasionadas por los empujes fríos del norte. La precipitación es variable, en promedio oscila entre 2000-3000 mm/año.  Dada su diversidad territorial, el clima es variable con temperaturas desde 22°C hasta arriba de los 30°C.
Una de sus características es la diversidad de bosques, bosque húmedo tropical al norte y al este, la de transición a prehúmedo, bosque muy húmedo premontano y bosque muy húmedo tropical y bosque pluvial premontano. \n
En la historia de Upala, el río representa elementos que establecieron los cimientos del cantón, su principal fuente de trabajo era por medio de ellos y hoy representan un alto valor de atracción hacía el turismo. En primer lugar, el agua representa la riqueza ecológica y paisajista, también para la agricultura, la ganadería, el transporte, la pesca, el turismo y la energía.\n
Upala centro desde sus inicios era un sitio atractivo para los migrantes por la diversidad de sus actividades, no solo la agricultura, sino también la industria artesanal. El suelo estaba consagrado en bosques, pastos, charrales y poca agricultura. Este poblado ha sido concebido como el sitio de encuentro entre las dos nacionalidades, los nicaragüenses que llegaron por vía fluvial de norte a sur y los costarricenses que cruzaron montañas para habitar estos bosques y luego llanuras.
Las Zonas de protección abarcan áreas como los humedales y las Áreas Silvestres Protegidas (ASP). La superficie total de humedales es de alrededor de 171 km2, ubicados principalmente en el norte del cantón. Estos humedales son de tipo lacustre (laguna) y palustre (pantano herbáceo). Algunos de ellos como Arrozal Buenavista, El Delirio o La Puebla; todos ellos en el Refugio de Vida Silvestre Estatal “Corredor Fronterizo”.\n
El 16,7% de la superficie del cantón corresponde a Áreas Silvestres Protegidas (ASP), lo cual abarca 264 km2, según informe elaborado en 2022 por la Dirección de Cambio Climático del Ministerio de Ambiente y Energía de Costa Rica (DCC MINAE). Entre estas áreas destacan los Parques Nacionales Rincón de la Vieja (79,9 km2), el Parque Nacional de Guanacaste (23,5 km2) y Volcán Tenorio (15,6 km2); los Refugios Nacionales de Vida Silvestre Corredor Fronterizo (85,5 km2) y Lagunas Las Camelias (0,65 km2); y la Zona Protectora Miravalles (58,5 km2).
''',
              images: [
                /* 'assets/rincon1.jpg',
                'assets/rincon2.jpg',
                'assets/rincon3.jpg',*/
              ],
            ),
            Section(
              title: 'Parque Nacional Volcán Tenorio',
              content:
                  '''Localizado sobre la Cordillera Volcánica de Guanacaste, en los distritos de Bijagua, Buena Vista, San Rafael y Cote de la provincia de Alajuela, y los distritos Arenal, Tierras Morenas y Palmira de la provincia de Guanacaste. \n
Las zonas de vida, son el Bosque muy Húmedo Tropical, Bosque muy Húmedo Tropical transición a Premontano, Bosque Pluvial Premontano, que es la de mayor extensión en el parque; bosque Pluvial Montano Bajo y bosque muy Húmedo Premontano. Posee una flora muy variada, sobresaliendo una alta diversidad de palmas, heliconias, helechos, bromelias y orquídeas, entre otras. En cuanto a los árboles sobresalen los aguacatillos, sapotes, pilones, lauráceas, marías, robles y el jícaro danto, el cual es endémico de esta cordillera. \n
Entre la fauna presente está: Puma (Felis concolor) León breñero (Felis yegouaroundi) Danta (Tapirus bairdii) Saíno (Tajacu pecari) Mono cariblanco (Cebus capucinus) manigordo (Leopardus pardalis) Guatuza (Dasyprocta punctata) caucel (Leopardus wiedii) Tepescuintle (Agouti paca) Tolomuco (Eira barbara) Pava (Penelope purpurarcens) el Pájaro Sombrilla (Cephalopterus glabricolis) el Ave Sol (Eurypyga helias) serpientes como la Mata Buey, Terciopelo, Mano de Piedra, Bocaracá, Béquer, Coral, Bejuquillas, etc.
''',
              images: [
                'assets/images/tenorio.png'
                /* 'assets/rincon1.jpg',
                'assets/rincon2.jpg',
                'assets/rincon3.jpg',*/
              ],
            ),
            Section(
              title: 'Parque Nacional Rincón de la Vieja',
              content:
                  '''Su extensión es de 14.300 hectáreas. Se encuentra dividido en dos sectores de visitación turística: Las Pailas y Santa María. Ambos sectores tienen atractivos interesantes debido a la variedad de sus ecosistemas y en los cuales sobresalen las manifestaciones volcánicas.\n
Este Parque Nacional protege cuencas hidrográficas muy importantes, ya que el macizo Rincón de la Vieja forma parte de la línea divisoria de aguas, entre el Caribe y Pacífico, de la zona noroeste del país; y aquí nacen 32 ríos, entre ellos el Colorado, Blanco y Ahogados. A su vez se protege la mayor población existente en estado silvestre de la guaria morada, (flor nacional de nuestro país). Se suma también, la importancia de proteger la actividad volcánica característica de la zona y sus atractivos geológicos.\n
Sin régimen de protección se encuentran los corredores biológicos, de vital importancia en el cantón como vía de comunicación y de intercambio entre especies entre las áreas de especial protección y el resto del territorio.\n
− C11. Tenorio Miravalles
− C15. Rincón Cacao
− C17. Miravalles Rincón de la Vieja
− C19. Ruta Los Maleku Medio Queso
− C20. Las Camelias
− C21. Rincón Rain Forest
''',
              images: [
                'assets/images/rincon.jpg'
                /* 'assets/rincon1.jpg',
                'assets/rincon2.jpg',
                'assets/rincon3.jpg',*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/snake.jpg',
          width: double.infinity,
          height: 300.0,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          height: 300.0,
          color: Colors.black.withOpacity(0.5),
        ),
        const Positioned(
          bottom: 20.0,
          left: 20.0,
          child: Text(
            'Descubre Upala y sus maravillas naturales',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        /*  BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        )*/
      ],
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final String content;
  final List<String> images;

  const Section({
    super.key,
    required this.title,
    required this.content,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Text(
            content,
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 10.0),
          GallerySection(images: images),
        ],
      ),
    );
  }
}

class GallerySection extends StatelessWidget {
  final List<String> images;

  const GallerySection({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: images.map((image) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              image,
              height: 280.0,
            ),
          );
        }).toList(),
      ),
    );
  }
}
