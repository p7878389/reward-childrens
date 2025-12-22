# UI Style Guide: Soft Gamified Theme v2

This document provides updated design prompts and specifications based on the latest iteration of the "Children Rewards" application. The style emphasizes a **warm, non-threatening, and paper-like** aesthetic suitable for children and families.

## 1. Core Visual Dictionary

| Element | Description | Tailwind Class | Hex Value |
| :--- | :--- | :--- | :--- |
| **Theme** | Warm Minimalist, Soft, Rounded | N/A | N/A |
| **Primary Color** | Cheerful Energy Yellow | `bg-primary` | `#FAC638` |
| **Background** | Warm Off-White (Paper) | `bg-background-light` | `#F8F8F5` |
| **Surface** | Cream White (Cards) | `bg-card-warm` | `#FFFCF5` |
| **Text (Dark)** | Soft Dark Brown | `text-text-main` | `#4A3B2A` |
| **Text (Light)** | Light Brown / Beige | `text-text-sub` | `#8C805F` |

## 2. Component Design Prompts

### 🖼️ Backgrounds & Containers
*   **Page Background**: Not pure white. Use a very subtle warm beige (`#F8F8F5`) to reduce eye strain and create a physical paper quality.
*   **Main Container**: A centered mobile-view container (`max-w-md`) with a heavy shadow (`shadow-2xl`) to simulate a floating device or card on the desktop.

### 💳 Cards & Surfaces

#### Hero Balance Card (The "Wallet")
*   **Style**: Vibrant, high-contrast, playful.
*   **Visuals**: Solid Primary Yellow background with subtle white geometric circles (20% opacity) in corners for texture.
*   **Shadow**: **Glow Shadow**. A colored, diffuse shadow matching the primary color (`rgba(250, 198, 56, 0.15)`), creating a sunny, glowing effect.
*   **Content**: Large, white, bold typography (`font-extrabold`) for the balance figure.

#### Stats Grid Cards
*   **Style**: Clean, informative, slight elevation.
*   **Visuals**: White background with a faint gray border.
*   **Accent**: A 4px colored strip (`h-1`) at the very top (Green for Earned, Red for Spent).
*   **Icon**: Floating in a circular bubble with a 10% opacity tint of the accent color.

#### History List Items
*   **Style**: Horizontal, clickable strips.
*   **Background**: `bg-card-warm` (`#FFFCF5`). Distinct from the page background but warmer than pure white.
*   **Interaction**: On hover, the border changes to a faint primary yellow (`border-primary/20`), simulating a "focus" light.
*   **Icon**: A large, rounded-square container (`rounded-xl`) with a pale yellow background (`bg-primary/10`).

### 🎛️ Filter Controls (Segmented Control)
*   **Concept**: A "Soft Switch" rather than harsh buttons.
*   **Track (Container)**: `rounded-xl` with a **tinted warm background** (`bg-primary/10`). This connects the control visually to the brand color without being overwhelming.
*   **Active State**: A physical button aesthetic. `bg-card-warm` (Cream), `shadow-sm`, and bold dark text. It looks like a card sliding on a track.
*   **Inactive State**: Subtle text (`text-text-sub`). On hover, it darkens slightly with a very faint yellow tint (`hover:bg-primary/5`).

### ✍️ Typography
*   **Font**: `Plus Jakarta Sans`.
*   **Characteristics**: High x-height, geometric, open counters. Feels modern and friendly.
*   **Hierarchy**:
    *   **Balance**: 5xl Extrabold (The hero number).
    *   **Headers**: xl Bold (Page titles).
    *   **Labels**: xs Semibold Uppercase (Tracking wide).

## 3. Tailwind Configuration Snippet

```javascript
// Current working configuration for this theme
colors: {
  primary: "#FAC638",          // Energy Yellow
  "background-light": "#f8f8f5", // Warm Paper
  "text-main": "#4a3b2a",      // Soft Brown
  "text-sub": "#8c805f",       // Beige Text
  "card-warm": "#fffcf5",      // Cream Card Surface
  success: "#88c458",          // Soft Green
  danger: "#ff8fa3"            // Soft Pink/Red
},
boxShadow: {
  soft: "0 4px 20px -2px rgba(250, 198, 56, 0.15)", // The Yellow Glow
  card: "0 2px 10px rgba(0, 0, 0, 0.03)"            // The Subtle Lift
},
borderRadius: {
  xl: "1.5rem", // 24px - Used for Hero Card
  lg: "1rem",   // 16px - Used for Standard Cards
  DEFAULT: "0.5rem"
}
```