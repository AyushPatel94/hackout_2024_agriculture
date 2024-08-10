import 'package:abcd/FoodWasteTechniques/ImprovedStorage.dart';
import 'package:abcd/FoodWasteTechniques/PostHarvestTech.dart';
import 'package:abcd/FoodWasteTechniques/PrecisionAgriculture.dart';
import 'package:abcd/FoodWasteTechniques/SupplyChainOptimization.dart';
import 'package:abcd/FoodWasteTechniques/SustainablePractices.dart';
import 'package:abcd/FoodWasteTechniques/WasteToResource.dart';
import 'package:flutter/material.dart';

class Reducefoodwastingscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reduce Food Waste Techniques',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          children: [
            TechniqueCard(
              icon: Icons.agriculture,
              title: 'Precision Agriculture',
              page: PrecisionAgriculturePage(),
            ),
            TechniqueCard(
              icon: Icons.store_mall_directory,
              title: 'Improved Storage',
              page: ImprovedStoragePage(),
            ),
            TechniqueCard(
              icon: Icons.build,
              title: 'Post-Harvest Tech',
              page: PostHarvestTechPage(),
            ),
            TechniqueCard(
              icon: Icons.sync,
              title: 'Supply Chain Optimization',
              page: SupplyChainOptimizationPage(),
            ),
            TechniqueCard(
              icon: Icons.eco,
              title: 'Sustainable Practices',
              page: SustainablePracticesPage(),
            ),
            TechniqueCard(
              icon: Icons.autorenew,
              title: 'Waste-to-Resource',
              page: WasteToResourcePage(),
            ),
          ],
        ),
      ),
    );
  }
}

class TechniqueCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget page;

  TechniqueCard({
    required this.icon,
    required this.title,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40.0,
                color: Colors.green.shade700,
              ),
              SizedBox(height: 12.0),
              Text(
                title,
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
