import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/widgets/reel_card.dart';

class ReelScreen extends StatefulWidget {
  const ReelScreen({super.key});

  @override
  State<ReelScreen> createState() => _ReelScreenState();
}

class _ReelScreenState extends State<ReelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reels',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        backgroundColor: const Color(0x00111111),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.camera_alt_outlined,
              size: 30,
              weight: 40,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: FirebaseFirestore.instance.collection('posts').get(),
            builder: (context, snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    final snapshot = snapshots.data!.docs[index];
                    return ReelCard(snapshot: snapshot);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
