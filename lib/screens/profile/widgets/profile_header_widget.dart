import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guess_duel/constants/app_avatars.dart';
import 'package:guess_duel/cubit/profile/profile_cubit.dart';
import 'package:guess_duel/screens/profile/widgets/user_name_text_field.dart';
import 'package:intl/intl.dart';

/// Profile Header Widget displaying user avatar with gradient glow border,
/// online status indicator, name, handle, join date, and rank badge.
class ProfileHeaderWidget extends HookWidget {
  final String username;
  final int createdAt;
  final String avatarID;
  final String firebaseID;
  final bool isLoading;
  final bool isEditing;

  const ProfileHeaderWidget({
    super.key,
    required this.username,
    required this.createdAt,
    required this.avatarID,
    required this.firebaseID,
    required this.isEditing,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = useTextEditingController(
      text: username,
    );

    const primaryCyan = Color(0xFF00F0FF);

    const onSurfaceVariant = Color(0xFFB9CACB);

    const surfaceBg = Color(0xFF0F131E);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar with gradient border and online indicator
        SizedBox(
          width: 112,
          height: 112,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Gradient outer ring
              GestureDetector(
                onTap: () {
                  context.read<ProfileCubit>().avatarOnTap();
                },
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Center(
                        child: SvgPicture.asset(
                          AppAvatars.getAvatarById(avatarID).assetPath,
                        ),
                      ),
                // .animate(
                //   autoPlay: true,
                //   onPlay: (controller) {
                //     controller.repeat(reverse: true);
                //   },
                // )
                // .shimmer(
                //   duration: 2.seconds,
                //   delay: 1.seconds,
                //   curve: Curves.easeInCubic,
                // ),
              ),

              // Online status indicator dot
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: surfaceBg,
                  ),
                  child: Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryCyan,
                        boxShadow: [
                          BoxShadow(
                            color: primaryCyan.withValues(alpha: 0.85),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // User Display Name
        UserNameHandlerWidget(
          isEditing: isEditing,
          usernameController: usernameController,
          username: username,
        ),
        // ID & Join Date
        Column(
          children: [
            RichText(
              text: TextSpan(
                text: 'ID  ',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: onSurfaceVariant,
                ),
                children: [
                  TextSpan(
                    text: firebaseID,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: primaryCyan,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: 'Player since ',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: onSurfaceVariant,
                ),
                children: [
                  TextSpan(
                    text: DateFormat.yMMMMd().format(
                      DateTime.fromMillisecondsSinceEpoch(createdAt),
                    ),
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
