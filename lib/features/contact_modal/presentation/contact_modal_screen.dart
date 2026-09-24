import 'dart:ui';

import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/layout/responsive_layout.dart';
import 'package:creative_curve_web/shared/widgets/curve_logo.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ContactModalScreen extends StatefulWidget {
  const ContactModalScreen({super.key});

  @override
  State<ContactModalScreen> createState() => _ContactModalScreenState();
}

class _ContactModalScreenState extends State<ContactModalScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final Set<String> _selectedDisciplines = <String>{
    'Brand Architecture',
    'Commercial Cinematography',
  };

  String _selectedTimeline = '2-Week Sprint';
  String _selectedBudget = 'Growth (₱100k - ₱250k)';
  bool _submitted = false;
  bool _emailCopied = false;

  static const List<String> _availableDisciplines = <String>[
    'Brand Architecture',
    'Commercial Cinematography',
    'Food & Culinary Styling',
    'Motion & Animation',
    'Performance Web Platform',
    'Social Growth Loops',
  ];

  static const List<String> _timelineOptions = <String>[
    '2-Week Sprint',
    '4-Week Milestone',
    'Quarterly Retainer',
  ];

  static const List<String> _budgetOptions = <String>[
    'Emerging (₱50k - ₱100k)',
    'Growth (₱100k - ₱250k)',
    'Enterprise (₱250k+)',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _copyStudioEmail() {
    Clipboard.setData(const ClipboardData(text: 'hello@creativecurve.ph'));
    setState(() => _emailCopied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _emailCopied = false);
    });
  }

  void _submitBrief() {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please provide your name and work email.'),
          backgroundColor: AppColors.curveRed,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    setState(() {
      _submitted = true;
    });
  }

  void _resetForm() {
    setState(() {
      _submitted = false;
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    });
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
            final double targetWidth = compact ? 560 : 700;
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
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 320),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    child: _submitted
                        ? _SubmissionSuccessView(
                            name: _nameController.text.trim(),
                            disciplines: _selectedDisciplines.toList(),
                            timeline: _selectedTimeline,
                            budget: _selectedBudget,
                            onReset: _resetForm,
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const _PanelHeader(),
                              const SizedBox(height: 8),
                              Text(
                                'Initiate Studio Project Brief',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.textFor(context),
                                    ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Configure your project parameters or dispatch a brief directly to our leadership squad.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.mutedFor(context),
                                      height: 1.45,
                                    ),
                              ),
                              const SizedBox(height: 20),

                              // Quick Direct Email Action
                              _DirectEmailBanner(
                                emailCopied: _emailCopied,
                                onCopy: _copyStudioEmail,
                              ),
                              const SizedBox(height: 22),

                              // Scope & Discipline Selection
                              const Text(
                                '1. SELECT CRAFT DISCIPLINES',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                  color: AppColors.curveRed,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _availableDisciplines.map((d) {
                                  final bool selected =
                                      _selectedDisciplines.contains(d);
                                  return _ScopeChip(
                                    label: d,
                                    selected: selected,
                                    onTap: () {
                                      setState(() {
                                        if (selected) {
                                          if (_selectedDisciplines.length > 1) {
                                            _selectedDisciplines.remove(d);
                                          }
                                        } else {
                                          _selectedDisciplines.add(d);
                                        }
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 20),

                              // Sprint Timeline Selector
                              const Text(
                                '2. DESIRED DELIVERY CADENCE',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                  color: AppColors.curveRed,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _timelineOptions.map((t) {
                                  final bool selected = _selectedTimeline == t;
                                  return _ScopeChip(
                                    label: t,
                                    selected: selected,
                                    onTap: () =>
                                        setState(() => _selectedTimeline = t),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 20),

                              // Budget Tier Selector
                              const Text(
                                '3. ESTIMATED INVESTMENT TIER',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                  color: AppColors.curveRed,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _budgetOptions.map((b) {
                                  final bool selected = _selectedBudget == b;
                                  return _ScopeChip(
                                    label: b,
                                    selected: selected,
                                    onTap: () =>
                                        setState(() => _selectedBudget = b),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 24),

                              // Contact Input Fields
                              const Text(
                                '4. CONTACT & PROJECT DETAILS',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                  color: AppColors.curveRed,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _Field(
                                label: 'Your Name / Company',
                                hint: 'e.g. Alex Rivera, Founder of Solita',
                                controller: _nameController,
                              ),
                              SizedBox(height: ResponsiveLayout.space(1.5)),
                              _Field(
                                label: 'Work Email',
                                hint: 'Where can our strategists send the proposal deck?',
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: ResponsiveLayout.space(1.5)),
                              _Field(
                                label: 'Project Scope Notes & Objectives (Optional)',
                                hint:
                                    'Tell us about your brand vision, key milestones, and target deliverables.',
                                controller: _messageController,
                                maxLines: 3,
                              ),
                              const SizedBox(height: 26),

                              // Submit Action Button
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: FilledButton.icon(
                                  onPressed: _submitBrief,
                                  icon: const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 16,
                                  ),
                                  label: Text(
                                    'Dispatch Project Brief (${_selectedDisciplines.length} Disciplines • $_selectedTimeline)',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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

class _ScopeChip extends StatelessWidget {
  const _ScopeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
          decoration: ShapeDecoration(
            color: selected
                ? AppColors.curveRed.withValues(alpha: isDark ? 0.2 : 0.12)
                : (isDark
                    ? Colors.white.withValues(alpha: 0.04)
                    : const Color(0xFFF0F2F5)),
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 999,
                cornerSmoothing: 0.6,
              ),
              side: BorderSide(
                color: selected
                    ? AppColors.curveRed.withValues(alpha: 0.65)
                    : AppColors.strokeFor(context),
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected) ...[
                const Icon(
                  Icons.check_rounded,
                  size: 13,
                  color: AppColors.curveRed,
                ),
                const SizedBox(width: 5),
              ],
              Text(
                label,
                style: TextStyle(
                  color: selected
                      ? (isDark ? Colors.white : AppColors.curveRed)
                      : AppColors.textFor(context),
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DirectEmailBanner extends StatelessWidget {
  const _DirectEmailBanner({
    required this.emailCopied,
    required this.onCopy,
  });

  final bool emailCopied;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1B1B20) : const Color(0xFFF3F5F8),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.strokeFor(context), width: 1.0),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.curveRed.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.alternate_email_rounded,
              size: 15,
              color: AppColors.curveRed,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Prefer a direct email or invitation to pitch?',
                  style: TextStyle(
                    color: AppColors.mutedFor(context),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'hello@creativecurve.ph',
                  style: TextStyle(
                    color: AppColors.textFor(context),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: onCopy,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              minimumSize: const Size(0, 32),
            ),
            icon: Icon(
              emailCopied ? Icons.check_rounded : Icons.copy_rounded,
              size: 13,
            ),
            label: Text(
              emailCopied ? 'Copied' : 'Copy',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubmissionSuccessView extends StatelessWidget {
  const _SubmissionSuccessView({
    required this.name,
    required this.disciplines,
    required this.timeline,
    required this.budget,
    required this.onReset,
  });

  final String name;
  final List<String> disciplines;
  final String timeline;
  final String budget;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 12),
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.curveRed.withValues(alpha: 0.14),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.curveRed.withValues(alpha: 0.4),
              width: 1.5,
            ),
          ),
          child: const Icon(
            Icons.check_rounded,
            color: AppColors.curveRed,
            size: 32,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Brief Dispatched Successfully',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.textFor(context),
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Thank you, $name. Our project management lead (Krystal) and creative director (JP) will review your scope within 24 business hours.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.mutedFor(context),
                height: 1.45,
              ),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.elevatedSurfaceFor(context),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.strokeFor(context), width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'LOGGED PARAMETERS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: AppColors.curveRed,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '• Disciplines: ${disciplines.join(", ")}',
                style: TextStyle(
                  color: AppColors.textFor(context),
                  fontSize: 12.5,
                  height: 1.4,
                ),
              ),
              Text(
                '• Delivery Cadence: $timeline',
                style: TextStyle(
                  color: AppColors.textFor(context),
                  fontSize: 12.5,
                  height: 1.4,
                ),
              ),
              Text(
                '• Investment Tier: $budget',
                style: TextStyle(
                  color: AppColors.textFor(context),
                  fontSize: 12.5,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: onReset,
              child: const Text('Configure Another Brief'),
            ),
            const SizedBox(width: 14),
            FilledButton(
              onPressed: () => context.go('/gallery'),
              child: const Text('Explore Vault Assets'),
            ),
          ],
        ),
        const SizedBox(height: 12),
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
            ? const Color(0xFF141418).withValues(alpha: 0.94)
            : Colors.white.withValues(alpha: 0.94),
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.curveRed.withValues(
              alpha: AppColors.isDark(context) ? 0.14 : 0.08,
            ),
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Text(
            'Q2/Q3 PROJECT INTAKE',
            style: TextStyle(
              color: AppColors.curveRed,
              fontWeight: FontWeight.w800,
              fontSize: 10,
              letterSpacing: 1.2,
            ),
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
                letterSpacing: 0.6,
                fontSize: 12.5,
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
                  fontSize: 13,
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
