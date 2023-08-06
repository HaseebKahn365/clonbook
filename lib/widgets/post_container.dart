import 'package:cached_network_image/cached_network_image.dart';
import 'package:clonbook/config/palette.dart';
import 'package:clonbook/widgets/profile_avatar.dart';
import 'package:clonbook/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../models/post_model.dart';

class PostContainer extends StatelessWidget {
  final Post post;
  const PostContainer({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: isDesktop ? 5.0 : 0.0, vertical: 5.0),
      elevation: isDesktop ? 1.0 : 0.0,
      shape: isDesktop ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)) : null,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _PostHeader(post: post),
                    const SizedBox(height: 4),
                    Text(post.caption),
                    post.imageUrl != null
                        ? const SizedBox.shrink()
                        : const SizedBox(
                            height: 6,
                          ),
                  ],
                ),
              ),
              post.imageUrl != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CachedNetworkImage(imageUrl: post.imageUrl!),
                    )
                  : const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _PostStates(post: post),
              )
            ],
          )),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;
  const _PostHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(
          imageUrl: post.user.imageUrl,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.user.name,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Text(
                    '${post.timeAgo} . ',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const Icon(
                    Icons.public,
                    color: Colors.grey,
                    size: 12,
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
      ],
    );
  }
}

class _PostStates extends StatelessWidget {
  final Post post;
  const _PostStates({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Palette.facebookBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up_alt_rounded,
                size: 10,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 4.0,
            ),
            Expanded(
              child: Text(
                '${post.likes}',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            Text(
              '${post.comments} Comments',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              '${post.shares} Shares',
              style: TextStyle(color: Colors.grey[600]),
            )
          ],
        ),
        const Divider(),
        Row(
          children: [
            _PostButton(
                icon: Icon(MdiIcons.thumbUpOutline, color: Colors.grey[600], size: 20), label: 'Like', onTap: () {}),
            _PostButton(
                icon: Icon(MdiIcons.commentOutline, color: Colors.grey[600], size: 20), label: 'Comment', onTap: () {}),
            _PostButton(
                icon: Icon(MdiIcons.shareOutline, color: Colors.grey[600], size: 25), label: 'Share', onTap: () {}),
          ],
        )
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  const _PostButton({super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 25.0,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              icon,
              const SizedBox(
                width: 4.0,
              ),
              Text(label)
            ]),
          ),
        ),
      ),
    );
  }
}
