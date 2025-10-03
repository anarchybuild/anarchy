## Dependencies Overview

- **AI Layer (Pollinations.ai)**  
  The app uses the [Pollinations.ai API](https://pollinations.ai/) to generate images from natural language prompts.  
  - Input: user-provided text prompt  
  - Output: AI-generated image URL  
  - Usage: API is called directly from the backend to ensure rate-limit handling and consistent output  

- **Authentication & Web3 Layer (Thirdweb)**  
  The app leverages [Thirdweb Account Abstraction](https://thirdweb.com/account-abstraction) to provide social login.  
  - Users can log in with familiar OAuth providers (Google, Twitter, etc.)  
  - A smart wallet is automatically created and linked to the user’s account  
  - Enables gasless transactions and Web3 interactions without exposing private key complexity  

## Data Flow

1. User logs in via **Thirdweb social login**  
2. The system provisions an **account abstracted wallet** for the user  
3. User submits a text prompt for image generation  
4. The backend relays the request to **Pollinations.ai API**  
5. The generated image is returned to the user and can be linked to their wallet/account  

## Key Benefits

- **Frictionless Onboarding:** No need for users to manage seed phrases or wallets manually  
- **AI-Powered Creativity:** Dynamic images generated on demand via Pollinations.ai  
- **Web3-Ready Accounts:** Users have smart wallets from the start, enabling on-chain integrations in future modules