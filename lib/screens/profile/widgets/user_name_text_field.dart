import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/cubit/profile/profile_cubit.dart';
import 'package:remixicon/remixicon.dart';

class UserNameHandlerWidget extends HookWidget {
  final bool isEditing;

  final String username;

  final TextEditingController usernameController;

  const UserNameHandlerWidget({
    super.key,
    required this.isEditing,
    required this.usernameController,

    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    final width = useState((username.length * 24) + 20);
    final isValidUsername = useState(true);
    String? validator(String? value) {
      if (value!.trim().isEmpty) {
        return "Username cannot be empty";
      } else if (value.trim().length > 15) {
        return "Username cannot be longer than 15 characters";
      } else if (value.trim().length < 2) {
        return "Username cannot be shorter than 2 characters";
      }
      return null;
    }

    void onSumbit() {
      if (validator(usernameController.text.trim()) != null) {
        isValidUsername.value = false;
        return;
      }
      if (usernameController.text.trim() == username.trim()) {
        context.read<ProfileCubit>().updateIsEditing();
        return;
      }
      context.read<ProfileCubit>().updateUsername(
        usernameController.text.trim(),
      );
    }

    void toggleEditing() {
      usernameController.text = username;
      if (!isEditing) {
        width.value = (username.length * 24) + 20;
      }

      isValidUsername.value = true;
      context.read<ProfileCubit>().updateIsEditing();
    }

    const onSurface = Color(0xFFDFE2F2);
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Visibility(
              visible: false,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: IconButton(
                iconSize: 24,
                onPressed: null,
                icon: Icon(RemixIcons.edit_2_line),
              ),
            ),

            !isEditing
                ? Flexible(
                    child: Text(
                      usernameController.text,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: onSurface,
                        letterSpacing: -0.5,
                      ),
                    ),
                  )
                : Flexible(
                    child: AnimatedContainer(
                      duration: 0.2.seconds,
                      width: width.value.toDouble(),
                      child: _UserNameTextField(
                        controller: usernameController,
                        onChanged: (value) {
                          isValidUsername.value = true;
                          width.value = (value.length * 24) + 20;
                        },
                        onFieldSubmitted: (_) {
                          onSumbit();
                        },
                      ),
                    ),
                  ),

            if (isEditing) ...[
              IconButton(
                iconSize: 30,
                onPressed: onSumbit,
                icon: const Icon(RemixIcons.check_line),
                color: Colors.green,
              ),
              IconButton(
                iconSize: 25,
                onPressed: toggleEditing,
                icon: const Icon(RemixIcons.close_line),
                color: Colors.red,
              ),
            ] else ...[
              IconButton(
                iconSize: 24,
                onPressed: toggleEditing,
                icon: const Icon(RemixIcons.edit_2_line),
                color: Colors.tealAccent,
              ),
            ],
          ],
        ),
        AnimatedOpacity(
          opacity: isValidUsername.value ? 0 : 1,
          duration: 300.milliseconds,
          child: AnimatedSize(
            duration: 300.milliseconds,
            child: (isValidUsername.value)
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      validator(usernameController.text.trim()) ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _UserNameTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;

  const _UserNameTextField({
    required this.controller,
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      controller: controller,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      style: GoogleFonts.spaceGrotesk(
        fontSize: 26,
        fontWeight: FontWeight.w700,

        letterSpacing: -0.5,
      ),
      textAlign: TextAlign.center,
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        isDense: true,
      ),
    );
  }
}
