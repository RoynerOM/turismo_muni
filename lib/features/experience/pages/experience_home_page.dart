import 'package:flutter/material.dart';
import 'package:turismo_upala/core/utils/device.dart';
import 'package:turismo_upala/features/experience/widgets/image_view.dart';
import 'package:turismo_upala/features/experience/widgets/vinetas.dart';

class ExperienceHomePage extends StatefulWidget {
  const ExperienceHomePage({super.key});

  @override
  State<ExperienceHomePage> createState() => _ExperienceHomePageState();
}

class _ExperienceHomePageState extends State<ExperienceHomePage> {
  final pages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NavItem(
              name: 'Inicio',
              selected: true,
              onPressed: () {},
            ),
            NavItem(
              name: 'Nuestros Servicios',
              onPressed: () {},
            ),
            NavItem(
              name: 'Quienes Somos',
              onPressed: () {},
            ),
          ],
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
                child: const Text(
                  'Sendero al Cerro Utyum',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: Device.media(context),
                child: const Text(
                  'Para subir el Cerro Utyum, hay que llegar a la Comunidad de Olán, misma que pertenece al Territorio Indígena de Salitre y se ubica a unos 30 kilómetros de Buenos Aires Centro. El camino es en lastre y barro, por lo que se solo se puede acceder en vehículos de doble tracción o en motocicletas montañeras de alto cilindraje, preferiblemente. Aunque el camino es algo brusco, los paisajes que se aprecian en el recorrido, son muy hermosos, empieza con vistas de sabanas y el Río Ceibo en el Territorio Indígena de Ujarrás, y con forme se va ascendiendo, el clima y el tipo de bosque van variando.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: Device.media(context),
                child: const Vinetas(
                  title: 'Servicios',
                  data: [
                    "Hospedaje",
                    "Tours de chocolate",
                    "Laboratorio Cientifico",
                    "Ecoturismo",
                    "Tecnologia e innovación",
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: Device.media(context),
                child: const Vinetas(
                  title: 'Información Adicional',
                  data: [
                    "Hospedaje",
                    "Tours de chocolate",
                    "Laboratorio Cientifico",
                    "Ecoturismo",
                    "Tecnologia e innovación",
                  ],
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
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const FullScreenImage(
                                imageUrl:
                                    'https://cdn.pixabay.com/photo/2023/08/24/00/58/horse-8209533_1280.jpg',
                                footer: 'Pie de foto',
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Hero(
                                tag: 'imageHero_$index',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    'https://cdn.pixabay.com/photo/2023/08/24/00/58/horse-8209533_1280.jpg',
                                    fit: BoxFit.cover,
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
                              child: const Text(
                                'Pie de foto',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black87),
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
                    for (var x in ["Whatsapp", "Whatsapp", "Whatsapp"])
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              '$x:',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              '75 metros este de la antiguo parque',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      )
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
