import 'dart:ui';
import 'package:flutter/material.dart';

enum GameResult { victory, defeat }

class GameHistoryTile extends StatelessWidget {
  final GameResult result;
  final String date;
  final String attempts;

  final String gameId;
  final VoidCallback? onTap;

  const GameHistoryTile({
    super.key,
    required this.result,
    required this.date,
    required this.attempts,

    required this.gameId,
    this.onTap,
  });

  bool get _isVictory => result == GameResult.victory;

  Color get _accentColor =>
      _isVictory ? const Color(0xFF00EEFC) : const Color(0xFFFF716C);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A).withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(16),
              border: Border(
                top: BorderSide(
                  color: const Color(0xFF4D4356).withValues(alpha: 0.15),
                ),
              ),
            ),
            child: Row(
              children: [
                _buildResultBadge(),
                const SizedBox(width: 16),
                Expanded(child: _buildDetails(theme)),
                Icon(
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultBadge() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: _accentColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _isVictory ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: _accentColor,
            size: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _isVictory ? 'VICTORY' : 'DEFEAT',
          style: TextStyle(
            fontFamily: 'Space Grotesk',
            fontSize: 8,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: _accentColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDetails(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailLabel('Date', theme),
              const SizedBox(height: 2),
              _buildDetailValue(date, theme),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildDetailLabel('Attempts', theme),
              const SizedBox(height: 2),
              _buildDetailValue(attempts, theme),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF0E0E0E),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFF4D4356).withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            '#$gameId',
            style: TextStyle(
              fontFamily: 'Space Grotesk',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _accentColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailLabel(String text, ThemeData theme) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 9,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
      ),
    );
  }

  Widget _buildDetailValue(String text, ThemeData theme) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}
