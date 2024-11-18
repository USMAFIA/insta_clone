import 'package:flutter/cupertino.dart';

class FollowStatusProvider extends ChangeNotifier {
  Map<String, bool> _followStatus = {};

  bool isFollowing(String userId) {
    return _followStatus[userId] ?? false;
  }

  void updateFollowStatus(String userId, bool status) {
    _followStatus[userId] = status;
    notifyListeners();
  }
}
