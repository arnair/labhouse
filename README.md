# RankQuest 🏆

AI-powered ranking application built with Flutter. Ask any ranking question and get beautifully visualized results powered by OpenAI ChatGPT.

## Features

- 🎯 **Smart Ranking Queries** - Ask any ranking question and get AI-powered results.
- � **AI Image Generation** - Custom 3D-styled icons DALL-E generated for the top 3 ranking items.
- 🔄 **Infinite Scroll** - Seamlessly load more results as you scroll down.
- ✨ **Premium Aesthetics** - Modern design with glassmorphism, gradients, and micro-animations.
- 🛠️ **Smart Error Handling** - Distinct feedback for network, safety, or unclear topics.

## Architecture

This project follows **Clean Architecture** with the following stack:

- **State Management**: Riverpod (with Code Generation)
- **Networking**: Dio
- **Code Generation**: Freezed, json_serializable, riverpod_generator
- **Navigation**: GoRouter
- **Persistence**: Environment variables via flutter_dotenv
- **UI Components**: Custom neon-styled widgets, Google Fonts

### Project Structure

```
lib/
├── core/                    # Core utilities and shared configuration
│   ├── constants/           # App constants and API endpoints
│   ├── env/                 # Environment variable handling
│   ├── errors/              # Custom exceptions and error handling
│   └── theme/               # Design system (colors, typography)
├── features/                # Feature-based organization
│   ├── home/                # Search and query input logic
│   └── ranking/             # Ranking results, podium, and generation
├── routing/                 # App navigation (GoRouter)
└── widgets/                 # Reusable UI components
```

**Configure OpenAI API Key**

   To use the app, you need to provide your own OpenAI API key.

   1. Create a file named `.env` in the project root directory.
   2. Add your OpenAI API key to the file using the following format:
      ```env
      OPENAI_API_KEY=your_actual_key_here
      ```
   3. Make sure the `.env` file is listed in your `pubspec.yaml` assets (it should already be there).
