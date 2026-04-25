import 'dart:ui';

import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/widgets/curve_logo.dart';
import 'package:flutter/material.dart';

class ContactModalScreen extends StatefulWidget {
  const ContactModalScreen({super.key});

  @override
  State<ContactModalScreen> createState() => _ContactModalScreenState();
}

class _ContactModalScreenState extends State<ContactModalScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool compact = MediaQuery.sizeOf(context).width < 980;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        const _AtmosphereBackground(),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double targetWidth = compact ? 540 : 680;
            final double panelWidth =
                (constraints.maxWidth - (compact ? 36 : 56))
                    .clamp(280, targetWidth);

            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.symmetric(
                    horizontal: compact ? 18 : 28, vertical: compact ? 22 : 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                    child: Container(
                      width: panelWidth,
                      decoration: BoxDecoration(
                        color: AppColors.isDark(context)
                            ? AppColors.surfaceDark.withValues(alpha: 0.86)
                            : Colors.white.withValues(alpha: 0.82),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: AppColors.strokeFor(context)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.16),
                            blurRadius: 34,
                            offset: const Offset(0, 18),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(compact ? 18 : 26,
                            compact ? 18 : 24, compact ? 18 : 26, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const _PanelHeader(),
                            const SizedBox(height: 22),
                            _Field(
                              label: 'Name',
                              hint: 'Who should we thank for this inquiry?',
                              controller: _nameController,
                            ),
                            const SizedBox(height: 12),
                            _Field(
                              label: 'Email',
                              hint: 'Where do we send the curve deck?',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 12),
                            _Field(
                              label: 'Project Brief',
                              hint:
                                  'Tell us what you are building and what success looks like.',
                              controller: _messageController,
                              maxLines: 5,
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Thanks. We will reach out shortly.')),
                                  );
                                },
                                child: const Text('Send Message'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _PanelHeader extends StatelessWidget {
  const _PanelHeader();

  @override
  Widget build(BuildContext context) {
    final CurveLogoVariant variant = AppColors.isDark(context)
        ? CurveLogoVariant.white
        : CurveLogoVariant.red;

    return Row(
      children: <Widget>[
        const _MacTrafficLights(),
        const SizedBox(width: 14),
        Expanded(
          child: CurveLogo(
            height: 28,
            variant: variant,
            semanticLabel: 'Creative Curve logo',
          ),
        ),
        Text(
          'Get Info',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.mutedFor(context),
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

class _MacTrafficLights extends StatelessWidget {
  const _MacTrafficLights();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        _Dot(color: Color(0xFFFF5F57)),
        SizedBox(width: 6),
        _Dot(color: Color(0xFFFFBD2E)),
        SizedBox(width: 6),
        _Dot(color: Color(0xFF28C840)),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.maxLines = 1,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.textFor(context),
                letterSpacing: 1,
              ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.mutedFor(context)),
            filled: true,
            fillColor: AppColors.isDark(context)
                ? AppColors.surfaceDark.withValues(alpha: 0.86)
                : Colors.white.withValues(alpha: 0.92),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.strokeFor(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.strokeFor(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppColors.curveRed, width: 1.2),
            ),
          ),
        ),
      ],
    );
  }
}

class _AtmosphereBackground extends StatelessWidget {
  const _AtmosphereBackground();

  @override
  Widget build(BuildContext context) {
    final bool dark = AppColors.isDark(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: dark
              ? const <Color>[
                  Color(0xFF0C0C0E),
                  Color(0xFF141417),
                  Color(0xFF1A1A1F)
                ]
              : const <Color>[
                  Color(0xFFF1F2F5),
                  Color(0xFFE8ECEF),
                  Color(0xFFDEE4EA)
                ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: -120,
            top: -90,
            child: _BlurBall(
              size: 320,
              color: AppColors.curveRed.withValues(alpha: 0.22),
            ),
          ),
          Positioned(
            right: -80,
            bottom: -120,
            child: _BlurBall(
              size: 360,
              color: const Color(0xFF9AA8B5).withValues(alpha: 0.25),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlurBall extends StatelessWidget {
  const _BlurBall({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          width: size,
          height: size,
          color: color,
        ),
      ),
    );
  }
}
