import 'package:flutter/material.dart';

class SustainablePracticesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sustainable Practices',style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.green.shade700,
      iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSection(),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView(
                children: [
                  SectionTitle(title: 'Overview'),
                  SizedBox(height: 10.0),
                  Text(
                    'Sustainable agricultural practices focus on producing food in ways that are environmentally friendly, economically viable, and socially responsible. These practices aim to conserve resources, reduce environmental impact, and promote biodiversity.',
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                  ),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Key Practices'),
                  SizedBox(height: 10.0),
                  TechnologyCard(
                    icon: Icons.grass,
                    title: 'Crop Rotation',
                    description: 'Involves alternating the types of crops grown in a specific area to maintain soil health and reduce pests.',
                  ),
                  TechnologyCard(
                    icon: Icons.water_drop,
                    title: 'Water Conservation',
                    description: 'Includes methods like drip irrigation to use water efficiently and avoid wastage.',
                  ),
                  TechnologyCard(
                    icon: Icons.recycling,
                    title: 'Composting',
                    description: 'Turning organic waste into valuable compost to enhance soil fertility.',
                  ),
                  TechnologyCard(
                    icon: Icons.eco,
                    title: 'Agroforestry',
                    description: 'Integrates trees and shrubs into agricultural landscapes to improve biodiversity and soil structure.',
                  ),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Benefits'),
                  SizedBox(height: 10.0),
                  BulletPoint(text: 'Conservation of natural resources.'),
                  BulletPoint(text: 'Reduced environmental impact and carbon footprint.'),
                  BulletPoint(text: 'Improved soil health and fertility.'),
                  BulletPoint(text: 'Enhanced biodiversity and ecosystem stability.'),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Challenges'),
                  SizedBox(height: 10.0),
                  BulletPoint(text: 'Transitioning from conventional to sustainable practices can be challenging.'),
                  BulletPoint(text: 'Initial investment costs may be high.'),
                  BulletPoint(text: 'Requires ongoing education and training for farmers.'),
                  BulletPoint(text: 'Market demand for sustainably produced goods may fluctuate.'),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'How to Implement'),
                  SizedBox(height: 10.0),
                  BulletPoint(text: 'Start with small-scale trials of sustainable practices to assess their effectiveness.'),
                  BulletPoint(text: 'Invest in water-saving technologies such as drip irrigation.'),
                  BulletPoint(text: 'Implement crop rotation and diversify crops to maintain soil health.'),
                  BulletPoint(text: 'Incorporate agroforestry practices to boost biodiversity.'),
                  BulletPoint(text: 'Seek support and training from agricultural extension services.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.eco,
          size: 80.0,
          color: Colors.green.shade700,
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: Text(
            'Sustainable Practices',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.green.shade700,
      ),
    );
  }
}

class TechnologyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  TechnologyCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 40.0,
              color: Colors.green.shade700,
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green.shade700,
            size: 18.0,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16.0, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}