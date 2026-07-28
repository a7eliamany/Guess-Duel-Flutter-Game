import 'dart:math';
import 'package:flutter/material.dart';

class HudParticlesBackground extends StatefulWidget {
  final bool isWin;
  const HudParticlesBackground({super.key, required this.isWin});

  @override
  State<HudParticlesBackground> createState() => _HudParticlesBackgroundState();
}

class _Particle {
  double x;
  double y;
  double size;
  double speed;
  double opacity;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

class _HudParticlesBackgroundState extends State<HudParticlesBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    for (int i = 0; i < 20; i++) {
      _particles.add(_createRandomParticle(initial: true));
    }

    _controller.addListener(_updateParticles);
  }

  _Particle _createRandomParticle({bool initial = false}) {
    return _Particle(
      x: _random.nextDouble(),
      y: initial ? _random.nextDouble() : 1.1,
      size: _random.nextDouble() * 3 + 2,
      speed: _random.nextDouble() * 0.002 + 0.0008,
      opacity: _random.nextDouble() * 0.35 + 0.1,
    );
  }

  void _updateParticles() {
    if (!mounted) return;
    setState(() {
      for (var particle in _particles) {
        particle.y -= particle.speed;
        if (particle.y < -0.1) {
          particle.x = _random.nextDouble();
          particle.y = 1.1;
          particle.speed = _random.nextDouble() * 0.002 + 0.0008;
          particle.opacity = _random.nextDouble() * 0.35 + 0.1;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_updateParticles);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ParticlesPainter(_particles, widget.isWin),
      size: Size.infinite,
    );
  }
}

class _ParticlesPainter extends CustomPainter {
  final List<_Particle> particles;
  final bool isWin;
  _ParticlesPainter(this.particles, this.isWin);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var particle in particles) {
      paint.color = isWin
          ? const Color(0xFF8AB4FF).withValues(alpha: particle.opacity)
          : const Color(0xFFFFB4AB).withValues(alpha: particle.opacity);
      canvas.drawCircle(
        Offset(particle.x * size.width, particle.y * size.height),
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlesPainter oldDelegate) => true;
}
