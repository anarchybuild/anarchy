# Anarchy - Technical Specification Document

## Table of Contents
1. [Project Overview](#project-overview)
2. [Technology Stack](#technology-stack)
3. [Architecture](#architecture)
4. [Core Features](#core-features)
5. [Database Schema](#database-schema)
6. [Authentication & Authorization](#authentication--authorization)
7. [Blockchain Integration](#blockchain-integration)
8. [AI Image Generation](#ai-image-generation)
9. [API & Services](#api--services)
10. [Frontend Components](#frontend-components)
11. [Security Features](#security-features)
12. [Performance Optimizations](#performance-optimizations)

---

## Project Overview

**Anarchy ** is a decentralized NFT marketplace and AI art generation platform that allows users to:
- Generate AI artwork using multiple models (Flux, Turbo, DreamShaper)
- Mint NFTs on the Moonbeam blockchain with gasless transactions
- Create collections and series of artwork
- Follow artists, like and comment on designs
- Remix artwork using AI style fusion
- Manage profiles with social features

The platform combines Web3 wallet authentication with traditional Supabase authentication, providing flexible onboarding options for both crypto-native and mainstream users.

---

## Technology Stack

### Frontend
- **Framework**: React 18.3.1 with TypeScript
- **Build Tool**: Vite 5.4.1
- **Routing**: React Router DOM 6.26.2
- **State Management**: TanStack Query (React Query) 5.83.0
- **UI Library**: shadcn/ui with Radix UI primitives
- **Styling**: Tailwind CSS 3.4.11 with animations
- **Animation**: Framer Motion 12.23.12
- **Form Handling**: React Hook Form 7.53.0 with Zod validation
- **Blockchain**: Thirdweb SDK 5.103.1
- **Web3**: Ethers.js 6.14.3

### Backend
- **Database**: Supabase (PostgreSQL)
- **Authentication**: Supabase Auth + Web3 wallet signatures
- **Storage**: IPFS via Thirdweb Storage
- **Edge Functions**: Deno (Supabase Functions)
- **AI Services**: Google Gemini AI 1.16.0 + Pollinations API

### Blockchain
- **Chain**: Moonbeam (EVM-compatible)
- **Chain ID**: 1284
- **Native Token**: GLMR
- **Contract**: ERC-721 NFT Smart Contract
- **Contract Address**: `0x6A6BFa3b50255Bc50b64d6b29264c10b5d33d0D5`
- **RPC**: https://rpc.api.moonbeam.network

### DevOps & Tooling
- **Version Control**: Git
- **Package Manager**: npm/bun
- **Linting**: ESLint 9.9.0
- **TypeScript**: 5.5.3
- **Code Splitting**: React lazy loading with Suspense

---

## Architecture

### High-Level Architecture

```
┌─────────────────┐
│   React SPA     │
│   (Frontend)    │
└────────┬────────┘
         │
         ├──────────┐
         │          │
         ▼          ▼
┌────────────┐  ┌────────────────┐
│  Supabase  │  │   Thirdweb     │
│  Backend   │  │   (Web3)       │
└─────┬──────┘  └────────┬───────┘
      │                  │
      ├──────────┐       │
      │          │       │
      ▼          ▼       ▼
┌──────────┐ ┌──────┐ ┌──────────┐
│PostgreSQL│ │ IPFS │ │ Moonbeam │
│ Database │ │      │ │Blockchain│
└──────────┘ └──────┘ └──────────┘
```

### Project Structure

```
anarchy-art-market/
├── src/
│   ├── components/       # React components
│   │   ├── collections/  # Collection management
│   │   ├── common/       # Shared components
│   │   ├── create/       # Design creation UI
│   │   ├── layout/       # Layout components
│   │   ├── nft/          # NFT display & interaction
│   │   ├── notifications/# Notification system
│   │   ├── profile/      # User profile components
│   │   ├── stylefusion/  # AI remix feature
│   │   ├── ui/           # shadcn/ui components
│   │   └── wallet/       # Wallet connection
│   ├── hooks/            # Custom React hooks
│   ├── pages/            # Route pages
│   ├── services/         # API services
│   ├── integrations/     # Third-party integrations
│   ├── config/           # Configuration files
│   ├── types/            # TypeScript types
│   ├── utils/            # Utility functions
│   └── lib/              # Helper libraries
├── supabase/
│   ├── functions/        # Edge functions
│   └── migrations/       # Database migrations
└── public/               # Static assets
```

---

## Core Features

### 1. AI Image Generation

**Technology**: Pollinations API + Google Gemini AI

**Models Available**:
- **Flux**: High-quality, detailed images
- **Turbo**: Fast generation with good quality
- **DreamShaper**: Artistic, creative styles

**Features**:
- Prompt-based generation
- Customizable dimensions (256-2048px)
- Model selection
- Real-time preview
- Base64 image encoding
- Automatic minting integration

**Implementation**:
- Edge Function: `supabase/functions/generate-image/index.ts`
- Service: `src/services/geminiService.ts`
- Hook: `src/hooks/useImageGeneration.tsx`

### 2. NFT Minting (Gasless)

**Blockchain**: Moonbeam
**Standard**: ERC-721

**Features**:
- **Gasless Minting**: Server-side transaction signing
- Automatic IPFS upload (image + metadata)
- Token metadata with attributes
- Transaction tracking
- Multi-format support (wallet + Supabase users)

**Minting Flow**:
1. User generates/uploads image
2. Image uploaded to IPFS via Thirdweb
3. Metadata created with NFT standards
4. Metadata uploaded to IPFS
5. Smart contract `claim()` function called
6. NFT minted to user's wallet address
7. Transaction recorded on-chain

**Implementation**:
- Service: `src/services/thirdwebNFTService.ts`
- Hook: `src/hooks/useNFTMinting.tsx`
- Edge Function: `supabase/functions/gasless-mint/index.ts`
- Contract Config: `src/config/thirdweb.ts`

### 3. Design Management

**Features**:
- Create designs with AI-generated or uploaded images
- Edit design metadata (name, description, license)
- Set privacy (public/private)
- Delete designs
- Organize in series
- Multi-resolution storage (thumbnail, medium, full)

**Database Table**: `designs`
- Stores image URLs (IPFS or Supabase storage)
- User attribution
- Timestamps
- Privacy flags
- Series relationships

### 4. Series System

**Purpose**: Create multiple variations of artwork with locked prompts

**Features**:
- Lock prompt for consistency
- Generate multiple images
- Select/deselect images for publishing
- Publish entire series
- Grid view of series images
- Order indexing

**Database Tables**: `series`, `series_images`

**Workflow**:
1. User enables "Series" mode
2. Sets name, description, and prompt
3. Prompt locks for the series
4. Generate multiple images
5. Select desired images
6. Publish series with selected images

### 5. Collections

**Features**:
- Create named collections
- Add designs to collections
- Remove designs from collections
- Collection preview (first 4 images)
- Collection item count
- Description support

**Database Tables**: `collections`, `collection_items`

**Implementation**:
- Service: `src/services/collectionService.ts`
- Components: `src/components/collections/`

### 6. Style Fusion (Remix)

**Technology**: Google Gemini 2.5 Flash Image Preview

**Features**:
- Upload a portrait
- Generate themed variations
- Multiple theme support
- Regenerate individual images
- Download individual or album
- Polaroid-style presentation
- Animated ghost cards

**Themes**: User-defined (e.g., "pirate", "astronaut", "cyberpunk")

**Album Generation**:
- Composite multiple themed images
- Canvas-based rendering
- Downloadable as single JPEG

**Implementation**:
- Page: `src/pages/StyleFusion.tsx`
- Service: `src/services/geminiService.ts`
- Utils: `src/lib/albumUtils.ts`

### 7. Social Features

#### Following System
- Follow/unfollow users
- View followers list
- View following list
- Follow stats (counts)
- Follow notifications

#### Likes
- Like designs
- Like comments
- Unlike functionality
- Like counts
- User-specific like state

#### Comments & Replies
- Nested comment threads
- Reply to comments
- Delete own comments
- User mentions format: "Display Name @username"
- Avatar display
- Timestamp tracking

#### Notifications
**Types**:
- Like notifications (designs & comments)
- Comment notifications
- Reply notifications
- Follow notifications

**Features**:
- Unread count badge
- Mark as read (individual & bulk)
- Rich notification content
- User profile integration
- Link to source (design/comment)

**Database Table**: `notifications`

### 8. User Profiles

**Profile Types**:
1. **Supabase Users**: Traditional email/password authentication
2. **Wallet Users**: Web3 wallet-only authentication

**Profile Fields**:
- Username (unique, required)
- Display name
- Avatar (IPFS stored)
- Description/Bio
- Location
- Website
- Social links (Twitter, Instagram, LinkedIn, GitHub)
- Created/Updated timestamps
- Username set flag

**Features**:
- Public profile pages (`/user/:username`)
- Private profile management (`/profile`)
- Settings page
- Profile editing
- Avatar upload service
- Username validation

**Database Table**: `profiles`

### 9. Authentication System

**Dual Authentication**:

#### Supabase Authentication
- Email/password
- OAuth providers (configurable)
- Session management
- JWT tokens

#### Web3 Wallet Authentication
- Thirdweb wallet connection
- Multiple wallet support
- Auto-profile creation
- Wallet address as identifier

**Implementation**:
- Hook: `src/hooks/useAuth.tsx`
- Secure Hook: `src/hooks/useSecureAuth.tsx`
- Wallet Hook: `src/hooks/useWallet.tsx`

**Priority**: Supabase auth takes precedence if both exist

### 10. Feed System

**Features**:
- Public feed (all designs)
- User-specific feed (authenticated)
- Infinite scroll
- Lazy loading
- Image optimization (thumbnail → medium → full)
- Masonry grid layout
- Intersection observer for lazy loading

**Implementation**:
- Component: `src/components/nft/FastImageGrid.tsx`
- Page: `src/pages/Index.tsx`
- Hook: `src/hooks/useQuery.ts`

---

## Database Schema

### Core Tables

#### profiles
```sql
- id: uuid (primary key)
- wallet_address: text (unique, required)
- username: text (unique)
- username_set: boolean
- display_name: text
- name: text
- description: text
- avatar_url: text
- location: text
- website: text
- twitter_url: text
- instagram_url: text
- linkedin_url: text
- github_url: text
- created_at: timestamp
- updated_at: timestamp
```

#### designs
```sql
- id: uuid (primary key)
- user_id: uuid (foreign key → profiles)
- name: text (required)
- description: text
- image_url: text
- thumbnail_url: text
- medium_url: text
- license: text
- price: numeric
- private: boolean
- series_id: uuid (foreign key → series)
- created_at: timestamp
- updated_at: timestamp
```

#### series
```sql
- id: uuid (primary key)
- user_id: uuid (required)
- name: text (required)
- description: text
- prompt: text (required)
- model: text
- width: integer
- height: integer
- is_published: boolean
- created_at: timestamp
- updated_at: timestamp
```

#### series_images
```sql
- id: uuid (primary key)
- series_id: uuid (foreign key → series)
- image_url: text (required)
- order_index: integer (required)
- is_selected: boolean
- created_at: timestamp
```

#### collections
```sql
- id: uuid (primary key)
- user_id: uuid (required)
- name: text (required)
- description: text
- created_at: timestamp
- updated_at: timestamp
```

#### collection_items
```sql
- id: uuid (primary key)
- collection_id: uuid (foreign key → collections)
- design_id: uuid (foreign key → designs)
- added_at: timestamp
```

#### comments
```sql
- id: uuid (primary key)
- design_id: uuid (foreign key → designs)
- user_id: uuid (foreign key → profiles)
- parent_id: uuid (foreign key → comments, nullable)
- content: text (required)
- created_at: timestamp
```

#### likes
```sql
- id: uuid (primary key)
- user_id: uuid (required)
- design_id: uuid (foreign key → designs, nullable)
- comment_id: uuid (foreign key → comments, nullable)
- created_at: timestamp
```

#### follows
```sql
- id: uuid (primary key)
- follower_id: uuid (required)
- following_id: uuid (required)
- created_at: timestamp
```

#### notifications
```sql
- id: uuid (primary key)
- user_id: uuid (required)
- from_user_id: uuid (required)
- type: text (like|comment|reply|follow)
- title: text (required)
- message: text (required)
- is_read: boolean
- design_id: uuid (nullable)
- comment_id: uuid (nullable)
- created_at: timestamp
```

#### security_audit_log
```sql
- id: uuid (primary key)
- user_id: uuid (nullable)
- resource_type: text (required)
- resource_id: uuid (nullable)
- action: text (required)
- ip_address: text
- user_agent: text
- created_at: timestamp
```

#### contact_submissions
```sql
- id: uuid (primary key)
- email: text (required)
- comment: text (required)
- created_at: timestamp
```

#### user_roles
```sql
- id: uuid (primary key)
- user_id: uuid (required)
- role: app_role enum (admin|moderator|user)
- created_at: timestamp
```

### Database Functions

#### Profile Functions
- `safe_create_wallet_profile(wallet_addr, profile_username)`: Creates profile for wallet users
- `safe_get_profile_by_wallet(wallet_addr)`: Retrieves profile by wallet address
- `get_profile_by_username(username_param)`: Gets profile by username
- `get_public_profile_data(profile_username)`: Gets public profile data only
- `is_profile_owner(profile_id)`: Checks if current user owns profile
- `is_wallet_profile(profile_id)`: Checks if profile is wallet-based

#### Security Functions
- `can_view_sensitive_profile_data(profile_user_id)`: Permission check for sensitive data
- `safe_validate_storage_access(bucket_name, profile_id)`: Validates storage access
- `log_profile_access(accessed_profile_id, access_type)`: Audit logging
- `sanitize_html_content(content)`: Content sanitization

#### Role Functions
- `has_role(_role, _user_id)`: Checks user role
- `is_valid_wallet_user(check_user_id)`: Validates wallet user

---

## Authentication & Authorization

### Authentication Strategies

#### 1. Supabase Authentication
- Email/password registration
- Session-based authentication
- JWT tokens
- Refresh token rotation

#### 2. Web3 Wallet Authentication
- Thirdweb wallet connection
- Supported wallets: MetaMask, WalletConnect, Coinbase Wallet, etc.
- No password required
- Auto-profile creation on first connection
- Wallet address as primary identifier

### Authentication Flow

```
User Action → Connect Wallet
    ↓
Check Supabase Session
    ↓
[Has Session?]
    ├─ Yes → Use Supabase User ID
    └─ No → Use Wallet Address
        ↓
    Check Profile Exists
        ↓
    [Profile Exists?]
        ├─ Yes → Load Profile
        └─ No → Create Wallet Profile
            ↓
        Grant Access
```

### Authorization Levels

1. **Public**: Unauthenticated users
   - View public designs
   - Browse public profiles
   - Explore feed (limited)

2. **Authenticated**: Wallet or Supabase users
   - Create designs
   - Mint NFTs
   - Like, comment, follow
   - Create collections
   - Full feed access

3. **Owner**: Resource owner
   - Edit own designs
   - Delete own content
   - Manage own collections
   - Edit profile

4. **Admin/Moderator**: (via user_roles table)
   - Content moderation
   - User management
   - System configuration

### Security Features

#### Input Sanitization
- Utility: `src/utils/inputSanitization.ts`
- HTML sanitization
- XSS prevention
- SQL injection protection (via Supabase)

#### Username Validation
- Utility: `src/utils/usernameValidation.ts`
- Length restrictions
- Character whitelist
- Uniqueness check

#### Display Name Validation
- Utility: `src/utils/displayNameValidation.ts`
- Length restrictions
- Special character handling

#### Rate Limiting
- Edge function level (gasless-mint: 5 req/min)
- User/wallet address based
- Sliding window algorithm

#### Audit Logging
- Table: `security_audit_log`
- Tracks sensitive actions
- IP address & user agent logging
- Resource access tracking

---

## Blockchain Integration

### Smart Contract

**Standard**: ERC-721 (NFT)
**Chain**: Moonbeam
**Contract Address**: `0x6A6BFa3b50255Bc50b64d6b29264c10b5d33d0D5`

**Key Functions**:
```solidity
function claim(
    address _receiver,
    uint256 _quantity,
    address _currency,
    uint256 _pricePerToken,
    AllowlistProof _allowlistProof,
    bytes _data
) external payable
```

### Minting Process

**Gasless Minting Architecture**:
1. User initiates mint (frontend)
2. Request sent to Supabase Edge Function
3. Edge function validates user
4. Image + metadata uploaded to IPFS
5. Private key loaded from environment (secure)
6. Transaction signed server-side
7. Transaction broadcast to Moonbeam
8. Confirmation returned to user
9. NFT appears in user's wallet

**Benefits**:
- Zero gas fees for users
- No wallet interaction required
- Faster onboarding
- Reduced friction

**Security**:
- Private key stored in Supabase secrets
- Rate limiting per user
- Input validation
- Wallet address verification

### IPFS Storage

**Provider**: Thirdweb Storage
**Upload Methods**:

1. **Authenticated Upload** (Supabase users):
   - Uses Supabase auth token
   - Service: `src/services/authenticatedIPFSService.ts`

2. **Wallet Upload** (Wallet-only users):
   - Uses Thirdweb client ID
   - Service: `src/services/walletIPFSService.ts`

**Storage Structure**:
```
IPFS
├── Images (PNG/JPEG)
│   └── ipfs://<hash>
└── Metadata (JSON)
    └── ipfs://<hash>
        ├── name
        ├── description
        ├── image (ipfs URI)
        ├── external_url
        └── attributes[]
```

### Metadata Standard

```json
{
  "name": "Design Name",
  "description": "Design description",
  "image": "ipfs://QmHash...",
  "external_url": "https://anarchy-platform.com",
  "attributes": [
    {
      "trait_type": "Creator",
      "value": "username"
    },
    {
      "trait_type": "License",
      "value": "CC BY 4.0"
    },
    {
      "trait_type": "Platform",
      "value": "Anarchy"
    }
  ]
}
```

### Chain Switching

**Implementation**: `src/hooks/useNFTMinting.tsx`

```typescript
const ensureCorrectChain = async () => {
  if (activeChain?.id !== moonbeam.id) {
    await switchChain(moonbeam);
  }
}
```

**Error Handling**:
- Network not found (4902): Guide user to add network
- User rejection: Display friendly message
- Network congestion: Retry logic

---

## AI Image Generation

### Primary Service: Pollinations API

**Endpoint**: `https://image.pollinations.ai/`

**Parameters**:
- `prompt`: Text description
- `model`: flux | turbo | dreamshaper
- `width`: 256-2048px
- `height`: 256-2048px
- `nologo`: true
- `seed`: Random for variation

**Edge Function**: `supabase/functions/generate-image/index.ts`

**Process**:
1. Receive prompt + parameters
2. Encode prompt for URL
3. Fetch image from Pollinations
4. Convert to base64 data URL
5. Return to frontend

### Secondary Service: Google Gemini AI

**Purpose**: Style Fusion (image-to-image)

**Model**: Gemini 2.5 Flash Image Preview

**Capabilities**:
- Image understanding
- Style transfer
- Theme-based remixing
- Portrait transformation

**Implementation**: `src/services/geminiService.ts`

**API Integration**:
- Edge Function: `supabase/functions/generate-styled-image/`
- Secure API key storage
- Base64 image input
- Prompt engineering for quality

### Image Optimization

**Service**: `src/services/imageOptimizationService.ts`

**Features**:
- Generate thumbnails (256x256)
- Generate medium sizes (512x512)
- Maintain aspect ratio
- Canvas-based resizing
- Quality optimization

**Storage Tiers**:
1. **Thumbnail**: Quick loading, grid views
2. **Medium**: Detail views, previews
3. **Full**: Download, minting, high-res

---

## API & Services

### Supabase Edge Functions

#### 1. generate-image
**Path**: `/functions/v1/generate-image`
**Method**: POST
**Auth**: Public (with API key)

**Request**:
```json
{
  "prompt": "A beautiful landscape",
  "model": "flux",
  "width": 1024,
  "height": 1024
}
```

**Response**:
```json
{
  "success": true,
  "imageUrl": "data:image/png;base64,...",
  "prompt": "A beautiful landscape",
  "model": "flux",
  "dimensions": "1024x1024"
}
```

#### 2. gasless-mint
**Path**: `/functions/v1/gasless-mint`
**Method**: POST
**Auth**: Bearer token (optional for wallet users)

**Request**:
```json
{
  "name": "My NFT",
  "description": "NFT description",
  "imageUrl": "data:image/png;base64,...",
  "creator": "username",
  "license": "CC BY 4.0",
  "userAddress": "0x..."
}
```

**Response**:
```json
{
  "success": true,
  "transactionHash": "0x...",
  "metadataUri": "ipfs://...",
  "imageUri": "ipfs://...",
  "contractAddress": "0x...",
  "tokenId": "123"
}
```

#### 3. generate-styled-image
**Path**: `/functions/v1/generate-styled-image`
**Method**: POST
**Auth**: Public

**Request**:
```json
{
  "imageDataUrl": "data:image/png;base64,...",
  "prompt": "Reimagine as a pirate",
  "theme": "pirate"
}
```

**Response**:
```json
{
  "success": true,
  "imageUrl": "data:image/png;base64,..."
}
```

#### 4. authenticated-upload
**Path**: `/functions/v1/authenticated-upload`
**Method**: POST
**Auth**: Bearer token (required)

**Purpose**: Secure IPFS uploads for authenticated users

### Frontend Services

#### Design Service
**File**: `src/services/designService.ts`

**Functions**:
- `createDesign(designData, walletAddress?)`: Create new design
- `updateDesign(designId, updates)`: Update design
- `deleteDesign(designId)`: Delete design
- `getDesignById(designId)`: Fetch single design
- `getUserDesigns(userId)`: Fetch user's designs

#### Collection Service
**File**: `src/services/collectionService.ts`

**Functions**:
- `createCollection(name, description, userId)`: Create collection
- `getUserCollections(userId)`: Fetch user collections
- `addDesignToCollection(collectionId, designId)`: Add design
- `removeDesignFromCollection(collectionId, designId)`: Remove design
- `deleteCollection(collectionId)`: Delete collection
- `isDesignSaved(designId, userId)`: Check if saved

#### Profile Service
**File**: `src/services/profileService.ts`

**Functions**:
- `createWalletProfile(walletAddress)`: Create wallet user profile
- `getProfileByWallet(walletAddress)`: Fetch by wallet
- Profile CRUD operations

#### Like Service
**File**: `src/services/likeService.ts`

**Functions**:
- `toggleDesignLike(designId, userId)`: Like/unlike design
- `toggleCommentLike(commentId, userId)`: Like/unlike comment
- `getDesignLikes(designId, userId?)`: Get like stats
- `getCommentLikes(commentId, userId?)`: Get comment likes

#### Comment Service
**File**: `src/services/commentService.ts`

**Functions**:
- `createComment(designId, content, userId, parentId?)`: Create comment/reply
- `deleteComment(commentId, userId)`: Delete comment
- `fetchCommentsByDesignId(designId)`: Fetch comment thread

#### Follow Service
**File**: `src/services/followService.ts`

**Functions**:
- `followUser(followingId, currentUserId)`: Follow user
- `unfollowUser(followingId, currentUserId)`: Unfollow user
- `getFollowStats(userId, currentUserId?)`: Get follow statistics
- `getFollowers(userId)`: Get followers list
- `getFollowing(userId)`: Get following list

#### Notification Service
**File**: `src/services/notificationService.ts`

**Functions**:
- `createNotification(notification)`: Generic notification creation
- `getNotifications(userId)`: Fetch user notifications
- `getUnreadNotificationCount(userId)`: Get unread count
- `markNotificationAsRead(notificationId)`: Mark single as read
- `markAllNotificationsAsRead(userId)`: Mark all as read
- Helper functions for specific notification types

---

## Frontend Components

### Layout Components

#### Header
**File**: `src/components/layout/Header.tsx`
- Logo/branding
- Navigation links
- Wallet connection button
- Profile button with dropdown
- Notification bell

#### Footer
**File**: `src/components/layout/Footer.tsx`
- Copyright
- Links (Terms, Privacy, Contact)
- Social media links

#### Layout
**File**: `src/components/layout/Layout.tsx`
- Main layout wrapper
- Header + Content + Footer
- Outlet for React Router

#### FloatingPromptBox
**File**: `src/components/layout/FloatingPromptBox.tsx`
- Fixed position prompt input
- Quick creation from anywhere
- Keyboard shortcut support

### NFT Components

#### NFTCard
**File**: `src/components/nft/NFTCard.tsx`
- Image display with lazy loading
- Metadata (title, creator)
- Like button
- Comment button
- Options menu (edit, delete)

#### NFTGrid
**File**: `src/components/nft/NFTGrid.tsx`
- Masonry grid layout
- Responsive columns
- Infinite scroll
- Loading states

#### FastImageGrid
**File**: `src/components/nft/FastImageGrid.tsx`
- Optimized version of NFTGrid
- Progressive image loading (thumbnail → medium → full)
- Intersection observer
- Performance optimized

#### CommentSection
**File**: `src/components/nft/CommentSection.tsx`
- Nested comment threads
- Reply functionality
- Like comments
- Delete own comments

#### LikeButton
**File**: `src/components/nft/LikeButton.tsx`
- Toggle like/unlike
- Optimistic updates
- Animation on like
- Count display

### Profile Components

**Directory**: `src/components/profile/`

Key components:
- `ProfileHeader`: Avatar, name, stats, follow button
- `ProfileTabs`: Designs, Collections, Liked
- `EditProfileForm`: Profile editing
- `FollowButton`: Follow/unfollow with state
- `FollowersList`: Display followers
- `FollowingList`: Display following

### Collection Components

**Directory**: `src/components/collections/`

Key components:
- `CollectionCard`: Display collection preview
- `CreateCollectionDialog`: Modal for creating collections
- `AddToCollectionButton`: Add design to collection

### Create Components

**Directory**: `src/components/create/`

Key components:
- `CreateSidebar`: Sidebar with options
- `ImageUploader`: Upload/drag-drop images
- `AuthCard`: Authentication prompt

### Common Components

**Directory**: `src/components/common/`

Key components:
- `ErrorBoundary`: Catch React errors
- `PageLoader`: Loading spinner for pages
- `SkeletonLoader`: Skeleton screens for loading states
- `ImageWithFallback`: Image with error fallback

### UI Components (shadcn/ui)

**Directory**: `src/components/ui/`

Over 50 components including:
- Button, Input, Textarea, Select
- Dialog, Sheet, Popover, Dropdown
- Card, Avatar, Badge
- Toast, Sonner (notifications)
- Tabs, Accordion, Collapsible
- Progress, Slider, Switch, Checkbox
- And many more...

---

## Security Features

### Input Validation & Sanitization

#### Client-Side
- Form validation with React Hook Form + Zod
- Character whitelists for usernames
- Length restrictions
- Email validation
- URL validation

#### Server-Side
- SQL injection prevention (Supabase parameterized queries)
- HTML sanitization for user content
- File type validation
- File size limits
- Rate limiting

### Authentication Security

- JWT token validation
- Session expiration
- Refresh token rotation
- Secure cookie handling
- CSRF protection (via Supabase)

### Blockchain Security

- Private key encryption in Supabase secrets
- Transaction validation
- Wallet address verification
- Nonce management
- Gas estimation

### API Security

- CORS configuration
- API key protection
- Rate limiting per endpoint
- Request size limits
- Error message sanitization (no stack traces in production)

### Content Security

- XSS prevention
- Content Security Policy headers
- Image validation
- MIME type checking
- User-generated content isolation

### Audit & Monitoring

- Security audit log table
- Action tracking
- Resource access logging
- IP address logging
- User agent tracking
- Timestamp tracking

---

## Performance Optimizations

### Frontend Optimizations

#### Code Splitting
- Lazy loading with React.lazy()
- Route-based code splitting
- Suspense boundaries
- Dynamic imports

#### Image Optimization
- Progressive loading (thumbnail → medium → full)
- Lazy loading with Intersection Observer
- Image preloading for critical content
- Responsive images
- WebP support (where available)

#### State Management
- React Query for server state
- Query caching (5-minute cache time)
- Optimistic updates
- Automatic background refetching
- Query invalidation strategies

#### React Query Configuration
```typescript
{
  staleTime: 2 * 60 * 1000,     // 2 minutes
  gcTime: 5 * 60 * 1000,        // 5 minutes (garbage collection)
  refetchOnWindowFocus: false,
  refetchOnMount: true,
  retry: (failureCount, error) => {
    if (error?.status >= 400 && error?.status < 500) return false;
    return failureCount < 2;
  }
}
```

#### Rendering Optimizations
- Memoization with useMemo and useCallback
- React.memo for expensive components
- Virtualization for long lists (potential)
- Debouncing user inputs
- Throttling scroll events

### Backend Optimizations

#### Database
- Indexed columns (user_id, design_id, etc.)
- Foreign key relationships
- Query optimization
- Connection pooling (Supabase)
- Row-level security policies

#### API
- Edge function cold start minimization
- Response compression
- Efficient JSON serialization
- Parallel requests where possible

#### IPFS
- Pinning strategy
- Gateway optimization
- Retry logic for failed uploads
- Timeout configuration

### Build Optimizations

- Tree shaking
- Minification
- CSS purging (Tailwind)
- Asset optimization
- Source map generation (dev only)

---

## Environment Variables

### Frontend (.env)
```bash
VITE_SUPABASE_URL=<supabase-url>
VITE_SUPABASE_ANON_KEY=<anon-key>
```

### Supabase Secrets
```
SUPABASE_URL
SUPABASE_SERVICE_ROLE_KEY
THIRDWEB_SECRET_KEY
THIRDWEB_CLIENT_ID
GASLESS_MINT_PRIVATE_KEY
GEMINI_API_KEY
```

---

## Deployment

### Frontend Deployment
- **Platform**: Lovable (or Vercel/Netlify)
- **Build Command**: `npm run build`
- **Output Directory**: `dist/`
- **Node Version**: 18+

### Backend Deployment
- **Platform**: Supabase (managed)
- **Database**: Automatic scaling
- **Edge Functions**: Auto-deployed from repository
- **Storage**: IPFS + Supabase Storage

### Blockchain
- **Chain**: Moonbeam (live)
- **Contract**: Already deployed
- **No redeployment needed** for updates

---

## Key Files Reference

### Configuration
- `vite.config.ts`: Vite build configuration
- `tailwind.config.ts`: Tailwind CSS configuration
- `tsconfig.json`: TypeScript configuration
- `components.json`: shadcn/ui configuration

### Core Application
- `src/main.tsx`: Application entry point
- `src/App.tsx`: Root component with routing
- `src/index.css`: Global styles

### Blockchain
- `src/config/thirdweb.ts`: Thirdweb and Moonbeam config
- `src/services/thirdwebNFTService.ts`: NFT minting logic
- `supabase/functions/gasless-mint/index.ts`: Gasless minting

### Database
- `src/integrations/supabase/types.ts`: TypeScript types from DB
- `src/integrations/supabase/client.ts`: Supabase client

### AI Services
- `supabase/functions/generate-image/index.ts`: Image generation
- `supabase/functions/generate-styled-image/index.ts`: Style transfer
- `src/services/geminiService.ts`: Gemini AI integration

---

## Development Workflow

### Local Development
```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Lint code
npm run lint
```

### Database Migrations
```bash
# Create new migration
supabase migration new <migration-name>

# Apply migrations
supabase db push

# Reset database (caution!)
supabase db reset
```

### Type Generation
```bash
# Generate TypeScript types from Supabase schema
supabase gen types typescript --local > src/integrations/supabase/types.ts
```

---

## Future Enhancements (Potential)

1. **Marketplace Features**
   - Buy/sell NFTs
   - Auction system
   - Royalty management
   - Price discovery

2. **Social Features**
   - Direct messaging
   - Group collaborations
   - Challenges/contests
   - Leaderboards

3. **AI Enhancements**
   - More AI models
   - Fine-tuning options
   - Style mixing
   - Prompt suggestions

4. **Mobile App**
   - React Native version
   - Mobile wallet integration
   - Push notifications

5. **Analytics**
   - User analytics dashboard
   - NFT performance tracking
   - Engagement metrics

6. **Multi-chain Support**
   - Additional EVM chains
   - Cross-chain bridging
   - Multi-chain wallet

---

**Document Version**: 1.0
**Last Updated**: October 6, 2025
**Maintained By**: Anarchy Development Team
