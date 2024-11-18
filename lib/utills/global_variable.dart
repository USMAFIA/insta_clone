import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/reel_screen.dart';
import '../screens/search_screen.dart';

const webScreenSize = 600;
const String collectionUser = 'user';
class GlobalVariable{
  static homeItems(BuildContext context) {
    return [
      const FeedScreen(),
      const SearchScreen(),
      const AddPostScreen(),
      const ReelScreen(),
      ProfileScreen(
        uid: Provider.of<UserProvider>(context, listen: false).getUser.uid,
      ),
    ];
  }

}