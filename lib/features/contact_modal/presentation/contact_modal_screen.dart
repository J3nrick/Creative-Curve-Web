import 'dart:ui';

import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/layout/responsive_layout.dart';
import 'package:creative_curve_web/shared/widgets/curve_logo.dart';
import 'package:figma_squircle/figma_squircle.dart';
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
            final double targetWidth = compact ? 520 : 640;
            final double panelWidth =
                (constraints.maxWidth - (compact ? 32 : 56))
                    .clamp(280, targetWidth)
                    .toDouble();

            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: compact ? 16 : 24,
                  vertical: compact ? 20 : 28,
                ),
                child: _LuxGlassModal(
                  width: panelWidth,
                  compact: compact,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const _PanelHeader(),
                      SizedBox(height: ResponsiveLayout.space(2.5)),
                      _Field(
                        label: 'Your Name',
                        hint: 'What should we call you?',
                        controller: _nameController,
                      ),
                      SizedBox(height: ResponsiveLayout.space(1.5)),
                      _Field(
                        label: 'Work Email',
                        hint: 'Where can we send the brief & deck?',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: ResponsiveLayout.space(1.5)),
                      _Field(
                        label: 'Project Scope & Goals',
                        hint:
                            'Tell us about your brand, timeline, and what breakthrough looks like.',
                        controller: _messageController,
                        maxLines: 4,
                      ),
                      SizedBox(height: ResponsiveLayout.space(2.5)),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: FilledButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Inquiry received. We will get in touch shortly.',
                                ),
                              ),
                            );
                          },
                          child: const Text('Send Project Brief'),
                        ),
                      ),
                    ],
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

class _LuxGlassModal extends StatelessWidget {
  const _LuxGlassModal({
    required this.width,
    required this.compact,
    required this.child,
  });

  final double width;
  final bool compact;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool dark = AppColors.isDark(context);
    final SmoothBorderRadius radius = SmoothBorderRadius(
      cornerRadius: 26,
      cornerSmoothing: 0.6,
    );

    return Container(
      width: width,
      decoration: ShapeDecoration(
        color: dark
            ? const Color(0xFF141418).withValues(alpha: 0.92)
            : Colors.white.withValues(alpha: 0.92),
        shape: SmoothRectangleBorder(
          borderRadius: radius,
          side: BorderSide(
            color: dark
                ? Colors.white.withValues(alpha: 0.14)
                : Colors.black.withValues(alpha: 0.08),
            width: 1.0,
          ),
        ),
        shadows: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: dark ? 0.4 : 0.08),
            blurRadius: 36,
            offset: const Offset(0, 16),
          ),
          BoxShadow(
            color: AppColors.curveRed.withValues(alpha: dark ? 0.08 : 0.04),
            blurRadius: 28,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipSmoothRect(
        radius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              compact ? 20 : 30,
              compact ? 20 : 28,
              compact ? 20 : 30,
              compact ? 22 : 28,
            ),
            child: child,
          ),
        ),
      ),
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
        Expanded(
          child: CurveLogo(
            height: 26,
            variant: variant,
            semanticLabel: 'Creative Curve logo',
          ),
        ),
        Text(
          'Start A Project',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.mutedFor(context),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
        ),
      ],
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
    final bool dark = AppColors.isDark(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.textFor(context),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: TextStyle(
            color: AppColors.textFor(context),
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.subtleFor(context),
                  fontSize: 13.5,
                ),
            filled: true,
            fillColor: dark
                ? const Color(0xFF1B1B20)
                : const Color(0xFFF6F8FA),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.strokeFor(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.strokeFor(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.curveRed,
                width: 1.5,
              ),
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
        color: AppColors.backgroundFor(context),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: dark
              ? const <Color>[
                  Color(0xFF09090B),
                  Color(0xFF101014),
                  Color(0xFF0D0D10),
                ]
              : const <Color>[
                  Color(0xFFF7F8FA),
                  Color(0xFFEFF1F5),
                  Color(0xFFE9ECF1),
                ],
        ),
      ),
    );
  }
}
