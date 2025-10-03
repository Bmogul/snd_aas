import 'package:flutter/material.dart';

// Primary Brand Colors
const kSNDCeladon = Color(0xFFBDDEB0);        // Light sage green - backgrounds & accents
const kSNDJade = Color(0xFF5EA66B);           // Medium jade - secondary actions & text
const kSNDYellowGreen = Color(0xFFA2CE4E);    // Bright yellow-green - highlights & focus
const kSNDPigmentGreen = Color(0xFF3FA756);   // Deep green - primary actions & headers
const kSNDWhite = Color(0xFFFFFFFF);          // White - base background

// Celadon Shades (from your palette)
const kSNDCeladon100 = Color(0xFF213817);
const kSNDCeladon200 = Color(0xFF41702F);
const kSNDCeladon300 = Color(0xFF62A846);
const kSNDCeladon400 = Color(0xFF8EC678);
const kSNDCeladon500 = Color(0xFFBDDEB0);     // Main Celadon
const kSNDCeladon600 = Color(0xFFCAE5C0);
const kSNDCeladon700 = Color(0xFFD7EBD0);
const kSNDCeladon800 = Color(0xFFE5F2DF);
const kSNDCeladon900 = Color(0xFFF2F8EF);

// Jade Shades
const kSNDJade100 = Color(0xFF122215);
const kSNDJade200 = Color(0xFF25432A);
const kSNDJade300 = Color(0xFF376540);
const kSNDJade400 = Color(0xFF4A8655);
const kSNDJade500 = Color(0xFF5EA66B);        // Main Jade
const kSNDJade600 = Color(0xFF7EB889);
const kSNDJade700 = Color(0xFF9ECAA6);
const kSNDJade800 = Color(0xFFBFDCC4);
const kSNDJade900 = Color(0xFFDFEDE1);

// Yellow Green Shades
const kSNDYellowGreen100 = Color(0xFF212D0C);
const kSNDYellowGreen200 = Color(0xFF435A19);
const kSNDYellowGreen300 = Color(0xFF648725);
const kSNDYellowGreen400 = Color(0xFF86B331);
const kSNDYellowGreen500 = Color(0xFFA2CE4E); // Main Yellow Green
const kSNDYellowGreen600 = Color(0xFFB5D872);
const kSNDYellowGreen700 = Color(0xFFC7E295);
const kSNDYellowGreen800 = Color(0xFFDAECB9);
const kSNDYellowGreen900 = Color(0xFFECF5DC);

// Pigment Green Shades
const kSNDPigmentGreen100 = Color(0xFF0D2111);
const kSNDPigmentGreen200 = Color(0xFF194322);
const kSNDPigmentGreen300 = Color(0xFF266433);
const kSNDPigmentGreen400 = Color(0xFF328544);
const kSNDPigmentGreen500 = Color(0xFF3FA756); // Main Pigment Green
const kSNDPigmentGreen600 = Color(0xFF5CC172);
const kSNDPigmentGreen700 = Color(0xFF85D195);
const kSNDPigmentGreen800 = Color(0xFFAEE0B9);
const kSNDPigmentGreen900 = Color(0xFFD6F0DC);

// White Shades (Grays for dark text on light backgrounds)
const kSNDWhite100 = Color(0xFF333333);
const kSNDWhite200 = Color(0xFF666666);
const kSNDWhite300 = Color(0xFF999999);
const kSNDWhite400 = Color(0xFFCCCCCC);
const kSNDWhite500 = Color(0xFFFFFFFF);       // Main White

// Light Mode Colors
const kSNDLightBg = Color(0xFFFFFFFF);        // Primary background
const kSNDLightBg2 = Color(0xFFF2F8EF);       // Secondary background (Celadon 900)
const kSNDLightBg3 = Color(0xFFE5F2DF);       // Tertiary background (Celadon 800)
const kSNDLightBorder = Color(0xFFBDDEB0);    // Border color (Celadon)
const kSNDLightTextPrimary = Color(0xFF213817);    // Primary text (Celadon 100)
const kSNDLightTextSecondary = Color(0xFF5EA66B);  // Secondary text (Jade)
const kSNDLightHover = Color(0xFFD7EBD0);     // Hover background (Celadon 700)

// Dark Mode Colors
const kSNDDarkBg = Color(0xFF0D2111);         // Primary background (Pigment Green 100)
const kSNDDarkBg2 = Color(0xFF194322);        // Secondary background (Pigment Green 200)
const kSNDDarkBg3 = Color(0xFF266433);        // Tertiary background (Pigment Green 300)
const kSNDDarkBorder = Color(0xFF328544);     // Border color (Pigment Green 400)
const kSNDDarkTextPrimary = Color(0xFFFFFFFF);     // Primary text (White)
const kSNDDarkTextSecondary = Color(0xFFBDDEB0);   // Secondary text (Celadon)
const kSNDDarkHover = Color(0xFF1F3728);      // Hover background

// Gradient Colors
const kSNDGradientStart = kSNDPigmentGreen;   // #3FA756
const kSNDGradientMiddle = kSNDJade;          // #5EA66B
const kSNDGradientEnd = kSNDYellowGreen;      // #A2CE4E

// Gradient for buttons and accents
const kSNDButtonGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [kSNDPigmentGreen, kSNDJade],
);

const kSNDAccentGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [kSNDJade, kSNDYellowGreen, kSNDCeladon],
);

// Status Colors
const kSNDSuccess = Color(0xFF3FA756);        // Success state (Pigment Green)
const kSNDWarning = Color(0xFFA2CE4E);        // Warning state (Yellow Green)
const kSNDError = Color(0xFFDC3545);          // Error state
const kSNDInfo = Color(0xFF5EA66B);           // Info state (Jade)

// Special Use Colors
const kSNDInputBorder = kSNDCeladon;          // Input border default
const kSNDInputBorderFocus = kSNDYellowGreen; // Input border on focus
const kSNDInputBg = kSNDWhite;                // Input background
const kSNDDisabled = Color(0xFFCCCCCC);       // Disabled elements

// Shadow Colors
const kSNDShadowLight = Color(0x1A000000);    // 10% black - subtle shadows
const kSNDShadowMedium = Color(0x33000000);   // 20% black - card shadows
const kSNDShadowDark = Color(0x4D000000);     // 30% black - prominent shadows

// Glow Effects
const kSNDGlowYellowGreen = Color(0x4DA2CE4E); // 30% Yellow Green glow
const kSNDGlowPigmentGreen = Color(0x4D3FA756); // 30% Pigment Green glow
const kSNDGlowJade = Color(0x4D5EA66B);        // 30% Jade glow

// Background Decorations (for gradient blobs)
const kSNDBlobPrimary = Color(0x33A2CE4E);    // 20% Yellow Green
const kSNDBlobSecondary = Color(0x265EA66B);  // 15% Jade
const kSNDBlobTertiary = Color(0x1A3FA756);   // 10% Pigment Green

// Social Login Button Colors
const kSNDGoogleBg = Color(0xFFFFFFFF);
const kSNDGoogleBorder = kSNDCeladon;
const kSNDAppleBg = Color(0xFF000000);
const kSNDAppleText = Color(0xFFFFFFFF);
