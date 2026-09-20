# ⚡ Creative Curve Studios — Digital HQ

<div align="center">

![Creative Curve Logo](assets/branding/logored.png)

**"Because straightforward is too predictable."**

*A multidisciplinary digital creative agency powered by storytellers, strategists, and curve crafters.*

[![Flutter](https://img.shields.io/badge/Flutter-3.24+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.4+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![State Management](https://img.shields.io/badge/Riverpod-2.5+-4A90E2?style=for-the-badge)](https://riverpod.dev)
[![Routing](https://img.shields.io/badge/Go__Router-14.2+-00ADD8?style=for-the-badge)](https://pub.dev/packages/go_router)
[![Deployment](https://img.shields.io/badge/Vercel-Deployed-black?style=for-the-badge&logo=vercel&logoColor=white)](https://vercel.com)
[![UI Geometry](https://img.shields.io/badge/Figma-Squircle_G2-F24E1E?style=for-the-badge&logo=figma&logoColor=white)](https://pub.dev/packages/figma_squircle)

[Live Features](#-feature-tour) • [Architecture](#-architecture--directory-structure) • [Design System](#-design-system--aesthetics) • [Getting Started](#-getting-started--local-development) • [Deployment](#-production-build--deployment)

---

</div>

## 📖 Executive Overview

**Creative Curve Studios** is a high-impact digital creative agency that thrives on unconventional strategy, cinematic storytelling, and bespoke visual design systems. We operate on the core belief that straightforward brands become invisible in crowded markets. We engineer the **Curve** — the unexpected trajectory that captures attention, drives organic velocity, and transforms ambitious brands into category leaders.

This repository contains the complete source code for the **Creative Curve Studios Web Application**, engineered with **Flutter Web**, styled using **Apple-grade macOS Liquid Glassmorphism**, and powered by **Riverpod** and **GoRouter**.

---

## 🌟 Key Highlights & Value Proposition

- 💎 **Bespoke macOS Liquid Glass Aesthetics**: Precision-crafted squircle geometry (`figma_squircle`), backdrop blur shaders (`ImageFilter.blur`), specular highlight strokes, and ambient glow physics.
- 🌓 **Dynamic Dual Theme Engine**: Flawless system-aware Dark & Light mode switcher with zero layout shift, calibrated with custom HSL tokens.
- 🎬 **Cinematic Asset Vault**: 15 authentic high-definition agency assets mapped across interactive portfolios, team showcases, and strategic frameworks.
- ⚡ **Fluid Shared-Axis Transitions**: Vertical 700ms `SharedAxisTransition` page transitions with `Curves.easeOutQuart` damping.
- 📱 **Adaptive Cross-Platform Layout**: Responsive shell dynamically toggling between a macOS-style pinned `SideNavBar` on desktop and an intuitive bottom/drawer navigation on mobile.
- 🚀 **One-Click Vercel CI/CD**: Automated deployment pipeline with headless Flutter SDK setup and SPA rewrite routing.

---

## 🏛️ Architecture & Directory Structure

The project follows a modular, feature-first Clean Architecture pattern designed for high maintainability, testability, and scalability.

```text
lib/
├── core/
│   ├── constants/
│   │   ├── app_assets.dart         # Semantic asset catalog (15 authentic assets + branding)
│   │   └── app_colors.dart         # Dual-theme design tokens & context color resolvers
│   ├── routing/
│   │   └── router.dart             # GoRouter configuration with SharedAxis page transitions
│   └── theme/
│       ├── app_theme.dart          # Light/Dark Material 3 ThemeData with Google Fonts
│       └── theme_mode_provider.dart # Riverpod ThemeNotifier for persistent theme switching
│
├── features/
│   ├── home/                       # Flagship interactive studio landing page
│   │   └── presentation/
│   │       ├── home_screen.dart    # 8-section cinematic studio walkthrough
│   │       └── widgets/
│   │           └── home_hero_section.dart # macOS Interactive Studio Deck & hero narrative
│   ├── services/
│   ├── service_grid/               # Capabilities & service offerings matrix
│   │   └── presentation/
│   │       └── service_grid_screen.dart
│   ├── gallery/                    # Studio asset vault & interactive lightbox
│   │   ├── data/
│   │   │   └── gallery_catalog.dart # Strongly-typed categorized gallery registry
│   │   └── presentation/
│   │       └── gallery_screen.dart
│   ├── team/                       # The Crafters Collective showcase
│   │   ├── application/
│   │   │   ├── team_provider.dart  # Riverpod provider for team member profiles
│   │   │   └── team_provider.g.dart
│   │   ├── domain/
│   │   │   └── team_member.dart    # Immutable model with bios, specialties, and hobbies
│   │   └── presentation/
│   │       └── team_screen.dart    # Dual-portrait toggle (Anthem vs. Clean Portrait)
│   ├── contact_modal/              # Ultra-luxurious glass project brief modal
│   │   └── presentation/
│   │       └── contact_modal_screen.dart
│   ├── contact/                    # Direct project inquiry module
│   ├── crafters/                   # Collective highlight components
│   ├── hero/                       # Hero presentation elements
│   ├── performance/                # Conversion & metric components
│   └── tools/                      # Interactive utilities
│
├── shared/
│   ├── effects/
│   │   └── mac_shimmer_loader.dart # Skeleton loading state visualizer
│   ├── interactions/
│   │   └── cursor_magnet_scope.dart # Magnetic hover cursor physics
│   ├── layout/
│   │   ├── main_layout.dart        # Shell layout coordinating SideNavBar & MobileFrame
│   │   ├── responsive_layout.dart  # Breakpoint utilities & spatial scale helpers
│   │   └── widgets/
│   │       └── side_nav_bar.dart   # Floating macOS-style vertical navigation rail
│   └── widgets/
│       ├── curve_cta_button.dart   # Standardized interactive button with hover states
│       ├── curve_logo.dart         # Brand vector logo with Red/White dynamic variants
│       ├── curve_nav_item.dart     # Navigation link component
│       ├── deck_image_placeholder.dart # Image fallback container
│       ├── liquid_glass_image_card.dart # Squircle glass card with Lightbox inspection
│       ├── liquid_glass_panel.dart # Backdrop-filtered glass container
│       ├── mac_cached_image.dart   # Network/Asset image caching engine
│       └── mac_squircle_panel.dart # Smooth squircle base panel
│
├── src/
│   └── app.dart                    # Root MaterialApp.router setup
└── main.dart                       # Application entrypoint with ProviderScope
```

---

## 🚀 Feature Tour

### 1. 🏠 Studio Home (`/`)
An 8-part narrative experience guiding visitors from brand introduction to project kickoff:
1. **Interactive Studio Hero Deck**: macOS-styled interactive window featuring a 4-slide animated carousel showcasing the agency's core manifesto.
2. **Strategic Bento Grid ("Built for Category Dominance")**: Modular capability cards highlighting high-velocity workflows, conversion architecture, and bespoke visual identity.
3. **Strategic Paradigm ("Straight Lines vs. The Creative Curve")**: Side-by-side comparison demonstrating why linear, conventional branding falls flat while curve-driven execution dominates.
4. **Commercial Spotlight (Solita's Bakehouse)**: Multi-angle case study showing culinary photography, commercial color grading, and social conversion numbers.
5. **Execution Blueprint (4-Phase Engine)**:
   - `01. Discovery & Brand DNA`
   - `02. Creative Direction & Prototyping`
   - `03. Production & Cinematic Craft`
   - `04. Deployment & Momentum Loops`
6. **Brand Manifesto & Core Values**: The four immutable pillars: *Transparent*, *Respectful*, *Data-driven*, and *Purpose-driven*.
7. **The Crafters Collective**: Meet the founders with direct bio tabs and role breakdowns.
8. **macOS-Style Studio Terminal CTA**: Terminal-styled interactive briefing card with instant contact triggers.

---

### 2. 🎨 Capabilities & Services (`/services`)
A structured grid of full-spectrum creative offerings:
- 🎨 **Design Creation & Direction**: Visual design systems, campaign concepts, and brand touchpoints.
- 🎬 **Film & Video Editing**: Cinematic color grading, editorial rhythm, and commercial post-production.
- ⚡ **Motion Graphics & Animation**: Kinetic title sequences, animated brand moments, and tempo-tuned UI motion.
- 📈 **Social Media Strategy & Loops**: Distribution calendar orchestration and performance-aware content loops.
- 💻 **Website & Digital Experience**: High-speed, responsive digital flagship web applications.
- 👑 **Brand Identity & Positioning**: Naming, tone of voice, visual rules, and market positioning.

---

### 3. 🖼️ Gallery & Asset Vault (`/gallery`)
An interactive visual archive featuring filterable categories:
- **Categories**: `All`, `Team & Squad`, `Client Work`, `Framework & Process`, `Philosophy & Values`, `Brand Identity`.
- **Interactive Lightbox**: Click on any asset to open an immersive, high-resolution modal preview with backdrop blur, aspect ratio preservation, and technical asset metadata.

---

### 4. 👥 The Crafters Collective (`/team`)
In-depth profiles of the core studio founders:
- **Krystal** — *Project Manager & Operations Lead* (Workflow orchestrator, high-impact delivery, Disney princess spirit).
- **Zyle** — *Sales & Content Strategist* (Distribution systems, market velocity, golf & strategic gaming).
- **Erika** — *Creative Director & Design Lead* (Brand architecture, typography systems, oil painting & fine arts).
- **JP** — *Media Producer & Cinematographer* (Cinematic visual storytelling, commercial photography, specialty coffee & anime).
- **Interactive Portrait Switcher**: Toggle seamlessly between the *Anthem Sunglasses* portrait and the *Clean Studio Portrait*.

---

### 5. 📬 Atmospheric Contact Studio (`/contacts`)
A glassmorphic briefing modal (`_LuxGlassModal`) equipped with:
- Name, Email, and Multi-line Project Scope fields.
- Backdrop blur (`24px sigma`) and specular lighting border.
- One-tap brief submission with snackbar confirmation feedback.

---

## 🎨 Design System & Aesthetics

### Color Palette

| Token | Light Mode | Dark Mode | Usage |
|:---|:---:|:---:|:---|
| **Curve Red** | `#FF3B30` | `#FF3B30` | Primary brand accent & active states |
| **Curve Red Hover** | `#FF5449` | `#FF5449` | Micro-interaction hover feedback |
| **Background** | `#F7F8FA` | `#09090B` | Root scaffold canvas |
| **Surface** | `#FFFFFF` | `#141417` | Glass card surfaces & side navigation |
| **Elevated Surface**| `#FDFCFC` | `#1B1B20` | Modal panels & elevated containers |
| **Text Primary** | `#0F1013` | `#F4F4F6` | Display headlines and high-contrast labels |
| **Text Muted** | `#5E6572` | `#9898A4` | Subheadings and body descriptions |
| **Stroke / Border** | `#E2E4E9` | `#242429` | Fine 1px squircle outlines |

### Typography

- **Headlines & Displays**: `Space Grotesk` (Google Fonts) — Editorial, tech-forward, high-impact tracking.
- **Body & UI Controls**: `Inter` (Google Fonts) — Hyper-legible at all screen densities, neutral, and balanced.

### Geometry & Curvature
- Powered by `figma_squircle` utilizing Apple's **G2 Continuous Curvature** formula (`cornerSmoothing: 0.6`).
- Eliminates harsh transitions between straight lines and arc corners, producing true Apple-grade hardware/software harmony.

---

## 💻 Technology Stack & Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.1      # Robust, compile-safe reactive state management
  riverpod_annotation: ^2.3.5   # Annotation support for modern Riverpod code generation
  go_router: ^14.2.1            # Declarative URL routing with deep-linking & shell support
  figma_squircle: ^0.6.3        # Smooth G2 squircle corner clipping and borders
  google_fonts: ^6.2.1          # Inter & Space Grotesk typography
  animations: ^2.0.11           # SharedAxisTransition & container transformations
  cached_network_image: ^3.4.1  # Fast in-memory & disk network image cache
  shimmer: ^3.0.0               # Shimmer effects for loading states

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0         # Official Flutter lint rules
  build_runner: ^2.4.12         # Code generation orchestrator
  riverpod_generator: ^2.4.3    # Automatic Riverpod provider code generation
```

---

## 🛠️ Getting Started & Local Development

### Prerequisites
- **Flutter SDK**: `>= 3.24.0` ([Install Guide](https://docs.flutter.dev/get-started/install))
- **Dart SDK**: `>= 3.4.0`
- **Google Chrome**: Recommended browser for Flutter Web debugging

### Installation & Run

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/Creative-Curve-Web.git
   cd Creative-Curve-Web
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Generate Code (Riverpod Providers)**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Launch Local Development Server**:
   ```bash
   flutter run -d chrome
   ```
   > 💡 The app will start on an ephemeral local port (e.g., `http://localhost:50000`).

---

## 📦 Production Build & Deployment

### Manual Web Build
To compile an optimized, minified production build for web hosting:

```bash
flutter build web --release --base-href /
```
The compiled static assets will be located in the `build/web/` directory.

---

### Vercel Deployment

The project includes pre-configured Vercel build files:
- `vercel.json`: Handles SPA fallback rewrites to `/index.html` and designates `build/web` as the output directory.
- `vercel-build.sh`: Automatically clones the Flutter stable channel, enables web support, fetches dependencies, and executes the production release build.

#### Deploy via Vercel CLI:
```bash
npm i -g vercel
vercel
```

#### Vercel Configuration Reference (`vercel.json`):
```json
{
  "version": 2,
  "buildCommand": "bash ./vercel-build.sh",
  "outputDirectory": "build/web",
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/$1"
    },
    {
      "src": "/.*",
      "dest": "/index.html"
    }
  ]
}
```

---

## 🖼️ Asset Catalog Reference

All visual assets in `assets/` are categorized in `AppAssets`:

| Asset Key | Path | Description |
|:---|:---|:---|
| `logoRed` | `assets/branding/logored.png` | Primary red brand logo |
| `logoWhite` | `assets/branding/logowhite.png` | White brand logo for dark backgrounds |
| `favicon` | `assets/branding/favicon_full_192.png` | High-res browser icon (192x192) |
| `valuesManifesto` | `assets/gallery/01_lifestyle_grid.png` | Core Values Manifesto ("We Set Them") |
| `curveWaveBanner` | `assets/gallery/02_food_grid.png` | Brand Philosophy Wave Banner |
| `heroStraightforward` | `assets/gallery/03_hero_home1.png` | Hero Narrative I ("Too Predictable") |
| `heroStudioRed` | `assets/gallery/04_hero_home2.png` | Hero Narrative II (Crimson Splash Mark) |
| `heroDiscoverCurve` | `assets/gallery/05_hero_home3.png` | Hero Narrative III ("Discover Curve") |
| `heroWhoAreWe` | `assets/gallery/06_hero_home4.png` | Hero Narrative IV ("Who Are We?") |
| `labPillars` | `assets/gallery/07_team_group.png` | The Creative Lab Growth Framework |
| `createTheCurveSlogan` | `assets/gallery/08_krystal.png` | Studio Slogan Signature |
| `profileJp` | `assets/gallery/09_jp.png` | JP Profile Card (Media Producer) |
| `profileZyle` | `assets/gallery/10_zyle.png` | Zyle Profile Card (Content Strategist) |
| `profileErika` | `assets/gallery/11_erika.png` | Erika Profile Card (Creative Director) |
| `teamAnthemSunglasses` | `assets/gallery/12_discover_curve.png` | The Crafters Collective Anthem Portrait |
| `portfolioCulinary` | `assets/gallery/13_because_straight.png` | Culinary & Lifestyle Client Showcase |
| `teamCleanPortrait` | `assets/gallery/14_who_are_we.png` | Clean High-Res Studio Portrait |
| `profileKrystal` | `assets/gallery/15_values.png` | Krystal Profile Card (Project Manager) |

---

## 👥 Meet The Team

<div align="center">

| **Krystal** | **Zyle** | **Erika** | **JP** |
|:---:|:---:|:---:|:---:|
| **Project Manager** | **Sales & Content Strategist** | **Creative Director** | **Media Producer** |
| *Operations & Delivery* | *Client Velocity & Growth* | *Brand & Visual Systems* | *Cinematography & Polish* |

</div>

---

## 📄 License & Credits

© 2026 **Creative Curve Studios**. All rights reserved.  
Crafted with passion by the **Creative Curve Crafters Collective**.
