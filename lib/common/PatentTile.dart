import 'package:flutter/material.dart';

class PatentTile extends StatelessWidget {
  const PatentTile(
      {super.key,
      required this.patentName,
      required this.imagePath,
      required this.description,
      required this.owner});

  final String patentName;
  final String owner;
  final String imagePath;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  patentName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.network(
                  imagePath,
                  width: 40,
                  height: 40,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(owner),
            const SizedBox(height: 5),
            Text(
              description,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
