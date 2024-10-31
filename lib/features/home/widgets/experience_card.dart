import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:turismo_upala/core/utils/device.dart';
import 'package:turismo_upala/features/lodge/models/lodge_list_model.dart';
import 'package:turismo_upala/features/lodge/pages/lodge_home_page.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({
    super.key,
    required this.service,
    required this.descripction,
    this.imageUrl = 'assets/images/jungle.png',
    required this.json,
  });
  final String service;
  final String descripction;
  final String imageUrl;
  final Map<String, dynamic> json;
  @override
  Widget build(BuildContext context) {
    if (Device.isSmallScreen(context) || Device.media(context) == 540) {
      return Stack(
        children: [
          Positioned(
            top: 20,
            left: 0,
            right: 1,
            child: Container(
              height: 480,
              constraints: const BoxConstraints(maxWidth: 500),
              margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: <Color>[
                    Color(0xff27AFE8),
                    Color(0xff2CD97B),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 480,
            constraints: const BoxConstraints(maxWidth: 540),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 232,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        imageUrl,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          service.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF68AC45),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          descripction,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LodgeHomePage(
                                  model: LodgeModel.fromJson(json),
                                ),
                              ),
                            );
                          },
                          icon: Row(
                            children: [
                              const Icon(
                                Icons.arrow_circle_right,
                                color: Colors.black,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Leer'.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }
    return Stack(
      children: [
        Positioned(
          top: 20,
          left: 0,
          child: Container(
            width: 600,
            height: 232,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1),
                colors: <Color>[
                  Color(0xff27AFE8),
                  Color(0xff2CD97B),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: Device.media(context) > 540 ? 600 : 375,
          height: 232,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                width: 275,
                height: 232,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      imageUrl,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        service.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF68AC45),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        descripction,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LodgeHomePage(
                                model: LodgeModel.fromJson(json),
                              ),
                            ),
                          );
                        },
                        icon: Row(
                          children: [
                            const Icon(
                              Icons.arrow_circle_right,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Leer'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
