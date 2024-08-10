import 'package:flutter/material.dart';

class WasteToResourcePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Waste-to-Resource',
          style: TextStyle(
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
                    'The Waste-to-Resource approach focuses on converting agricultural and organic waste into valuable resources. This includes methods for recycling, composting, and converting waste into energy or new products, thereby reducing environmental impact and promoting sustainability.',
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                  ),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Key Technologies'),
                  SizedBox(height: 10.0),
                  TechnologyCard(
                    icon: Icons.recycling,
                    title: 'Composting',
                    description:
                        'Turning organic waste into nutrient-rich compost for soil enrichment.',
                  ),
                  TechnologyCard(
                    icon: Icons.power,
                    title: 'Biogas Production',
                    description:
                        'Converting organic waste into biogas for energy production.',
                  ),
                  TechnologyCard(
                    icon: Icons.coffee_maker,
                    title: 'Waste-to-Energy',
                    description:
                        'Using waste materials to generate heat or electricity.',
                  ),
                  TechnologyCard(
                    icon: Icons.build,
                    title: 'Upcycling',
                    description:
                        'Transforming waste materials into new, higher-value products.',
                  ),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Benefits'),
                  SizedBox(height: 10.0),
                  BulletPoint(text: 'Reduces waste sent to landfills.'),
                  BulletPoint(
                      text:
                          'Conserves natural resources and reduces environmental impact.'),
                  BulletPoint(
                      text:
                          'Provides alternative sources of energy and materials.'),
                  BulletPoint(
                      text:
                          'Enhances soil health and reduces the need for chemical fertilizers.'),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'Challenges'),
                  SizedBox(height: 10.0),
                  BulletPoint(
                      text:
                          'Initial investment in technology and infrastructure.'),
                  BulletPoint(
                      text: 'Requires proper management and maintenance.'),
                  BulletPoint(
                      text:
                          'Public acceptance and behavior change may be needed.'),
                  BulletPoint(
                      text: 'Potential for contamination in waste streams.'),
                  SizedBox(height: 20.0),
                  SectionTitle(title: 'How to Implement'),
                  SizedBox(height: 10.0),
                  BulletPoint(
                      text:
                          'Start with a pilot project to test waste-to-resource technologies.'),
                  BulletPoint(
                      text:
                          'Invest in composting and biogas systems suitable for your scale.'),
                  BulletPoint(
                      text:
                          'Collaborate with waste management companies for efficient processes.'),
                  BulletPoint(
                      text:
                          'Educate stakeholders on the benefits and use of converted resources.'),
                  BulletPoint(
                      text:
                          'Monitor and evaluate the impact to optimize processes.'),
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
          Icons.recycling,
          size: 80.0,
          color: Colors.green.shade700,
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: Text(
            'Waste-to-Resource',
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
