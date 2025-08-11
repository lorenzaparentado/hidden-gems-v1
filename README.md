# Hidden Spots - Flutter App

A Flutter mobile application for discovering and sharing hidden gems in your city. Built following the design specifications for a cozy, calm exploration app inspired by hiking/GORP culture meets urban journaling.

## ✅ IMPLEMENTATION STATUS - V1 COMPLETE

This app has been **fully implemented** following the detailed launch guide with:
- **Complete Supabase integration** ready for backend
- **State management** with Provider pattern
- **Premium features infrastructure** for future monetization
- **Philadelphia seed data** with 10+ curated spots
- **Web-first responsive design** with mobile support

---

## Map Integration (flutter_map + MapBox)

This app uses flutter_map with MapBox tiles for map functionality. To set up:

1. **Get a MapBox Access Token**:
   - Sign up at [mapbox.com](https://mapbox.com)
   - Create a new access token (public token is sufficient)
   - Copy your public access token

2. **Update Configuration**:
   - Replace the `mapboxAccessToken` in `lib/config/app_config.dart` with your token
   - The app uses flutter_map with MapBox tile layers for better stability

3. **Features**:
   - **Interactive Map**: MapBox-powered tiles with flutter_map
   - **Custom Markers**: Category-specific colored markers for spots
   - **Real-time Filtering**: Map updates when categories are selected
   - **Current Location**: GPS positioning with smooth map movement
   - **Cross-platform**: Works on Android, iOS, and Web

---

## Features

### 🏠 Core Features (SLC - Simple Launch Candidate)

- **Home Screen**: Browse recent spots with category filtering ✅ **IMPLEMENTED**
- **Map View**: Interactive map with categorized pins ✅ **IMPLEMENTED** 
- **Add Spot**: Full spot creation with photo upload and location detection ✅ **IMPLEMENTED**
- **Bookmarks**: Save and organize your favorite spots ✅ **IMPLEMENTED**
- **Profile**: User stats, account management, and sign out ✅ **IMPLEMENTED**

### 📱 Categories

- **Quiet**: Peaceful spots for meditation and reflection ✅
- **Nature**: Green spaces and outdoor sanctuaries ✅
- **Art**: Creative spaces, galleries, and artistic experiences ✅
- **Views**: Stunning vistas and photo opportunities ✅

### 🌟 Premium Features (V2 Ready)

- **Escape Now**: Instant nearby recommendations with premium upsell ✅
- **Unlimited Bookmarks**: Beyond free tier limits ✅
- **Premium Spots**: Exclusive curator-selected locations ✅
- **Advanced Filters**: Additional discovery options ✅

---

## 🚀 Implementation Details

### Backend Integration
- **Supabase Service**: Complete CRUD operations for spots, users, bookmarks
- **Authentication**: Email/password with profile management
- **Real-time Updates**: Ready for live data synchronization
- **Image Storage**: Supabase storage integration for spot photos

### State Management
- **AuthProvider**: User authentication and profile state
- **SpotsProvider**: Spot discovery, bookmarks, visit tracking
- **Location Service**: GPS integration with Philadelphia fallback

### UI/UX System
- **Material Design 3**: Modern, accessible interface
- **Responsive Layout**: Web-first with mobile adaptation
- **Premium Badges**: Visual indicators for premium content
- **Category System**: 8 distinct spot categories with iconography

### Philadelphia Launch Data
The app includes **10 carefully curated Philadelphia spots**:
- Love Park Secret Garden
- Race Street Pier Sunrise Spot  
- Elfreth's Alley Hidden Courtyard
- Reading Terminal Rooftop Garden
- Whiskey Bar Hidden Speakeasy
- Schuylkill Banks Secret Trail
- Magic Gardens Hidden Passage
- Fishtown Coffee Rooftop
- Penn's Landing Hammock Grove
- Northern Liberties Vinyl Vault

---

## 🔧 Development Setup

### Prerequisites
1. Flutter SDK (latest stable)
2. Supabase account and project
3. VS Code with Flutter extension

### Quick Start
```bash
flutter pub get
flutter run -d web-server --port 8080
```

### Supabase Configuration
Update `lib/config/app_config.dart`:
```dart
static const String supabaseUrl = 'YOUR_SUPABASE_PROJECT_URL';
static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
```

### VS Code Tasks
- **Flutter: Run Web** - Development server
- **Build Flutter App** - Production build

---

## 🏗️ Architecture

```
lib/
├── config/app_config.dart        # Supabase & app configuration
├── models/                       # Data models (Spot, UserProfile)
├── services/                     # Backend integration services
├── providers/                    # State management (Auth, Spots)
├── screens/                      # UI screens (Home, Auth, etc.)
├── widgets/                      # Reusable UI components
└── utils/seed_data.dart          # Philadelphia spots data
```

### Key Components
- **Spot Model**: Complete data structure with premium features
- **Category System**: 8 spot types with filtering
- **Premium Infrastructure**: Ready for subscription monetization
- **Location Awareness**: GPS with distance calculations

---

## 📊 Launch Readiness

### ✅ V1 Complete
- [x] Core app functionality
- [x] Supabase backend integration
- [x] User authentication system
- [x] Philadelphia seed data
- [x] Premium feature infrastructure
- [x] Web deployment ready

### 🎯 Next Steps (Production)
1. **Database Setup**: Deploy Supabase schema
2. **Authentication**: Configure auth providers
3. **Content**: Load Philadelphia seed data
4. **Deployment**: Host on Vercel/Netlify
5. **Analytics**: Add user tracking

### 💰 V2 Monetization Ready
- Stripe/RevenueCat integration points
- Premium feature gating system
- Subscription management UI
- Advanced analytics infrastructure

---

## Design Philosophy

The app follows a **cozy, calm exploration** aesthetic inspired by:
- Hiking and GORP (Good Ol' Raisins and Peanuts) culture
- Urban journaling and field guides
- Discovery-focused rather than algorithmic
- Community-driven content
- Peaceful, never rushed user experience

## Contributing

This is a personal project implementing the design specifications from the documentation. Future contributions welcome for:
- Backend integration
- Map functionality
- Performance optimizations
- Accessibility improvements

## License

[To be determined]
