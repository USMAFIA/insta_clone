import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/widgets/follow_button.dart';
import 'package:provider/provider.dart';
import '../model/user_model.dart' as model;
import '../providers/followers_provider.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../screens/comments_screen.dart';
import '../utills/colors.dart';
import '../utills/utills.dart';
import 'like_animation.dart';

class ReelCard extends StatefulWidget {
  final snapshot;
  const ReelCard({super.key, required this.snapshot});

  @override
  State<ReelCard> createState() => _ReelCardState();
}

class _ReelCardState extends State<ReelCard> {
  int commentLen = 0;
  bool isFollowing = false;
  bool isLikeAnimating = false;
  List<dynamic> likes = [];

  @override
  void initState() {
    super.initState();
    likes = widget.snapshot['likes'] ?? [];
    fetchCommentLen();
    checkFollowStatus(); // Check follow status on screen load
  }

  // Fetch comments length efficiently
  Future<void> fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snapshot['postId'])
          .collection('comments')
          .get();
      setState(() {
        commentLen = snap.docs.length;
      });
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  // Check follow status using the provider to reduce redundant DB calls
  void checkFollowStatus() {
    final followProvider = Provider.of<FollowStatusProvider>(context, listen: false);
    final uid = FirebaseAuth.instance.currentUser!.uid;
    isFollowing = followProvider.isFollowing(widget.snapshot['uid']);
    setState(() {});  // Update UI based on the current follow state
  }

  // Toggle follow/unfollow status
  Future<void> toggleFollowStatus() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final followProvider = Provider.of<FollowStatusProvider>(context, listen: false);

    try {
      if (isFollowing) {
        // Unfollow user
        await FireStoreMethods().followUser(uid, widget.snapshot['uid']);
        followProvider.updateFollowStatus(widget.snapshot['uid'], false);
      } else {
        // Follow user
        await FireStoreMethods().followUser(uid, widget.snapshot['uid']);
        followProvider.updateFollowStatus(widget.snapshot['uid'], true);
      }

      setState(() {
        isFollowing = !isFollowing; // Toggle follow status
      });
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  // Delete the post
  Future<void> deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.UserModel user = Provider.of<UserProvider>(context).getUser;
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          if (likes.contains(user.uid)) {
            likes.remove(user.uid);
          } else {
            likes.add(user.uid);
          }
        });
        FireStoreMethods().likePost(
          widget.snapshot['postId'].toString(),
          user.uid,
          likes,
        );
        setState(() {
          isLikeAnimating = true;
        });
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.snapshot['postUrl'] ?? ''),
                    fit: BoxFit.fill)),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                LikeAnimation(
                  isAnimating: likes.contains(user.uid),
                  smallLike: true,
                  child: InkWell(
                    child: likes.contains(user.uid)
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : const Icon(Icons.favorite_outline, color: Colors.white),
                    onTap: () async {
                      setState(() {
                        if (likes.contains(user.uid)) {
                          likes.remove(user.uid);
                        } else {
                          likes.add(user.uid);
                        }
                      });
                      await FireStoreMethods().likePost(
                        widget.snapshot['postId'].toString(),
                        user.uid,
                        likes,
                      );
                    },
                  ),
                  onEnd: () {
                    setState(() {
                      isLikeAnimating = false;
                    });
                  },
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: Text(likes.length.toString(), style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CommentsScreen(
                        postId: widget.snapshot['postId'].toString(),
                      ),
                    ),
                  ),
                  child: const Icon(Icons.mode_comment_outlined, color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text('$commentLen', style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 10),
                const Icon(Icons.send_outlined, color: Colors.white),
                const SizedBox(height: 20),
                widget.snapshot['uid'].toString() == user.uid
                    ? InkWell(
                  onTap: () {
                    showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: [
                              'Delete',
                            ]
                                .map(
                                  (e) => InkWell(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  child: Text(e),
                                ),
                                onTap: () {
                                  deletePost(widget.snapshot['postId'].toString());
                                  Navigator.of(context).pop();
                                },
                              ),
                            )
                                .toList(),
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.more_horiz, color: Colors.white),
                )
                    : Container(),
                const SizedBox(height: 20),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 16,
                      child: Image.network(widget.snapshot['profImage']),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.snapshot['username'],
                      style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    widget.snapshot['uid'].toString() == user.uid
                        ? FollowButton(
                      width: 80,
                      height: 20,
                      text: 'Delete',
                      backgroundColor: mobileBackgroundColor,
                      textColor: primaryColor,
                      borderColor: Colors.grey,
                      function: () async {
                        showDialog(
                          useRootNavigator: false,
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: ListView(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shrinkWrap: true,
                                children: [
                                  'Delete',
                                ]
                                    .map(
                                      (e) => InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                      child: Text(e),
                                    ),
                                    onTap: () {
                                      deletePost(widget.snapshot['postId'].toString());
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                )
                                    .toList(),
                              ),
                            );
                          },
                        );
                      },
                    )
                        : FollowButton(
                      width: 80,
                      height: 20,
                      text: isFollowing ? 'Follow' : 'Unfollow',
                      backgroundColor: isFollowing ? Colors.blue : Colors.white,
                      textColor: isFollowing ? Colors.white : Colors.black,
                      borderColor: isFollowing ? Colors.blue : Color(0xff2B89A4FF),
                      function: toggleFollowStatus,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                  child: Text(
                    widget.snapshot['description'],
                    style: const TextStyle(color: Colors.white, fontSize: 14,),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
