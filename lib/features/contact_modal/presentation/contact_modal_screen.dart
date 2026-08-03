import 'dart:ui';

import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/layout/responsive_layout.dart';
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
                    .clamp(280, targetWidth)
                    .toDouble();

            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: compact ? 18 : 28,
                  vertical: compact ? 22 : 30,
                ),
                child: _LuxGlassModal(
                  width: panelWidth,
                  compact: compact,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const _PanelHeader(),
                      SizedBox(height: ResponsiveLayout.space(2.75)),
                      _Field(
                        label: 'Name',
                        hint: 'Who should we thank for this inquiry?',
                        controller: _nameController,
                      ),
                      SizedBox(height: ResponsiveLayout.space(1.5)),
                      _Field(
                        label: 'Email',
                        hint: 'Where do we send the curve deck?',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: ResponsiveLayout.space(1.5)),
                      _Field(
                        label: 'Project Brief',
                        hint:
                            'Tell us what you are building and what success looks like.',
                        controller: _messageController,
                        maxLines: 5,
                      ),
                      SizedBox(height: ResponsiveLayout.space(2)),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: FilledButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Thanks. We will reach out shortly.',
                                ),
                              ),
                            );
                          },
                          child: const Text('Send Message'),
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
    final BorderRadius radius = BorderRadius.circular(28);

    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.curveRed.withValues(alpha: 0.16),
            blurRadius: 48,
            offset: const Offset(0, 22),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: dark ? 0.42 : 0.14),
            blurRadius: 40,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: radius,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: dark
                    ? <Color>[
                        AppColors.surfaceDark.withValues(alpha: 0.88),
                        const Color(0xFF1A1214).withValues(alpha: 0.82),
                      ]
                    : <Color>[
                        Colors.white.withValues(alpha: 0.86),
                        const Color(0xFFF8F4F4).withValues(alpha: 0.78),
                      ],
              ),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: dark ? 0.28 : 0.9),
                  width: 1.2,
                ),
                left: BorderSide(
                  color: Colors.white.withValues(alpha: dark ? 0.16 : 0.55),
                ),
                right: BorderSide(
                  color: AppColors.curveRed.withValues(alpha: 0.18),
                ),
                bottom: BorderSide(
                  color: AppColors.curveRed.withValues(alpha: 0.35),
                  width: 1.2,
                ),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -40,
                  right: -30,
                  child: _GlowSphere(
                    size: 160,
                    color: AppColors.curveRed.withValues(alpha: 0.18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    compact ? 18 : 26,
                    compact ? 18 : 24,
                    compact ? 18 : 26,
                    24,
                  ),
                  child: child,
                ),
              ],
            ),
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
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.textFor(context),
                letterSpacing: 1,
              ),
        ),
        SizedBox(height: ResponsiveLayout.space(1)),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.mutedFor(context),
                ),
            filled: true,
            fillColor: dark
                ? Colors.white.withValues(alpha: 0.06)
                : Colors.white.withValues(alpha: 0.72),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.strokeFor(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: dark ? 0.12 : 0.55),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.curveRed,
                width: 1.2,
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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: dark
              ? const <Color>[
                  Color(0xFF0C0C0E),
                  Color(0xFF141417),
                  Color(0xFF1A1A1F),
                ]
              : const <Color>[
                  Color(0xFFF1F2F5),
                  Color(0xFFE8ECEF),
                  Color(0xFFDEE4EA),
                ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: -120,
            top: -90,
            child: _GlowSphere(
              size: 340,
              color: AppColors.curveRed.withValues(alpha: dark ? 0.28 : 0.2),
            ),
          ),
          Positioned(
            right: -60,
            top: 120,
            child: _GlowSphere(
              size: 220,
              color: AppColors.curveRed.withValues(alpha: dark ? 0.14 : 0.1),
            ),
          ),
          Positioned(
            right: -80,
            bottom: -120,
            child: _GlowSphere(
              size: 380,
              color: (dark ? const Color(0xFF9AA8B5) : const Color(0xFF7A8A99))
                  .withValues(alpha: 0.22),
            ),
          ),
          Positioned(
            left: 80,
            bottom: 40,
            child: _GlowSphere(
              size: 160,
              color: AppColors.curveRed.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowSphere extends StatelessWidget {
  const _GlowSphere({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: <Color>[
                color,
                color.withValues(alpha: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
