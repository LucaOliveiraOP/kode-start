# 🛸 Rick And Morty - SAVE RICK! -  KODE START #3 Edition  🚀
<p align="center">
  <img src="https://github.com/user-attachments/assets/1ceb0605-c5d7-4da5-b46e-e6a4673c86ac" width="400" height="auto" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/c9bb4ff7-50c5-4553-837c-12819ba05719" width="350" />
</p>


<p align="center">
  <img src="https://github.com/user-attachments/assets/eafc82ef-e6f0-45ab-8afa-b587963fff01" width="250" height="auto" />
  <img src="https://github.com/user-attachments/assets/641b2ef3-6d3d-48f1-82c7-725b348f5659" width="109" height="200" />
  <img src="https://github.com/user-attachments/assets/eafc82ef-e6f0-45ab-8afa-b587963fff01" width="250" height="auto" />
</p>

---

## ❓ Bem, por onde começar..?

### Vocês juntaram literalmente um dos meus desenhos favoritos com um desafio na minha linguagem favorita.  
### Então, só tenho a agradecer a vocês. Muito obrigado, me diverti muito e me desafiei também, o aplicativo tem uma série de eventos em cadeia, falas e animações. (onde o Rick vai narrando, tudo isso controlado pelo BloC pattern).

---

### 🛡️ SAVE RICK!?

<p align="center">
  <img src="https://github.com/user-attachments/assets/872b98cf-0840-41e4-8cbd-d246d742c2cf" width="300" alt="Splash Screen GIF" />
</p>

### Na tela de home, Rick está preso em forma de picles... ao clicar nele, o portal some e mostra lupa no canto superior direito.

<p align="center">
  <img src="https://github.com/user-attachments/assets/6d4b1cbd-40f3-4c9c-bfba-ec05d8c82d76" width="300" alt="Splash Screen" />
</p>

---

### 🛸 **Vídeo demonstrando as funcionalidades do app**  
### 🔊 Ligue o som :D

[![Assista ao vídeo](https://i.imgur.com/SeuThumbnail.png)](https://drive.google.com/file/d/1aoFzE-CMA9-WAju8Ld4veJbtVvE37Z4J/view?usp=sharing)

---

## 🛠️ Ferramentas Utilizadas

- <img src="https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png" width="16" alt="Dart logo" style="vertical-align: middle;" /> **Dart**: Linguagem de programação.

- <span style="font-size:16px; vertical-align: middle;">🔄</span> **BloC**: Gerenciamento de estados.

- <img src="https://code.visualstudio.com/assets/images/code-stable.png" width="16" alt="VSCode logo" style="vertical-align: middle;" /> **Visual Studio Code**: IDE utilizada.

- <img src="https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png" width="16" alt="Flutter SDK logo" style="vertical-align: middle;" /> **Flutter SDK**: Framework de desenvolvimento mobile multiplataforma. (versão 3.32.7)

---

## 📚 Documentação

#### Todos os arquivos do projeto estão devidamente documentados e descritos, da forma como aprendemos.

---

### <img src="https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png" width="16" alt="Dart logo" style="vertical-align: middle; margin-right: 6px;" /> home_screen.dart

<p align="center">
  <img src="https://github.com/user-attachments/assets/605bd2af-8e49-4ec7-b8b3-ad9036bf43cc" width="600" alt="Captura de tela 2025-08-13 063657" />
</p>

---

### <img src="https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png" width="16" alt="Dart logo" style="vertical-align: middle; margin-right: 6px;" /> character_bloc.dart

<p align="center">
  <img width="600" height="753" alt="image" src="https://github.com/user-attachments/assets/925eb441-a4f0-4379-8d0f-b8a6fc6b018a" />
</p>

---

### <img src="https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png" width="16" alt="Dart logo" style="vertical-align: middle; margin-right: 6px;" /> character_event.dart

<p align="center">
  <img width="600" height="636" alt="Captura de tela 2025-08-13 071449" src="https://github.com/user-attachments/assets/0793a69a-d750-4044-b593-2ad4fc737887" />
</p>

---

## 📦 Dependências Principais

O projeto utiliza as seguintes bibliotecas no `pubspec.yaml`:

- 🎵 **audioplayers: ^6.5.0**  
  Biblioteca para reprodução de áudio no Flutter, usada para controlar sons de fundo e efeitos sonoros no app.

- 🌐 **dio: ^5.9.0**  
  Cliente HTTP poderoso e fácil de usar para realizar requisições REST, usado para consumir APIs e buscar dados.

- ⚖️ **equatable: ^2.0.7**  
  Facilita a comparação entre objetos no Dart, muito útil para estados e eventos em gerenciamento de estado.

- 🐦 **flutter:**  
  SDK base para o desenvolvimento de aplicativos Flutter.

- 🔄 **flutter_bloc: ^9.1.1**  
  Biblioteca para gerenciamento de estado baseada no padrão Bloc.

- 🖼️ **flutter_svg: ^2.2.0**  
  Permite o uso de imagens SVG no Flutter.

- 🚦 **go_router: ^16.1.0**  
  Gerenciador de rotas para Flutter.

- 🧪 **mocktail: ^1.0.4**  
  Biblioteca para criação de mocks em testes unitários e de integração.

- ✨ **shimmer: ^3.0.0**  
  Widget que cria efeitos de carregamento com animações de brilho.

---

## 🗂️ Estrutura do Projeto

```plaintext
assets/
├── audio/
│   ├── evilmortymightbehere.mp3
│   ├── lockedinportals.mp3
│   ├── mortyrunningaway.mp3
│   ├── requiredsound.mp3
│   ├── searchportalopen.mp3
│   ├── poundsgoingaway.mp3
│   └── thanksforhelp.mp3
├── fonts/
│   └── get_schwifty.ttf
├── images/
│   ├── evilmorty.gif
│   ├── logo.svg
│   ├── pickle_rick.png
│   ├── portal-rick-and-morty.gif
│   └── rick_and_morty_logo.svg

lib/
├── blocs/
│   ├── character_bloc/
│   │   ├── character_bloc.dart
│   │   ├── character_event.dart
│   │   └── character_state.dart
│   └── rick_scene_bloc/
│       ├── rick_scene_bloc.dart
│       ├── rick_scene_event.dart
│       └── rick_scene_state.dart
├── components/
│   ├── app_bar_component.dart
│   ├── character_card.dart
│   ├── loading_card.dart
│   ├── rick_and_portals_animation.dart
│   └── search_icon_button.dart
├── controllers/
│   └── rick_audio_controller.dart
├── data/
│   └── repository.dart
├── models/
│   └── character.dart
├── pages/
│   ├── details_page.dart
│   └── home_page.dart
├── screens/
│   ├── home_page_screen.dart
│   └── splash_screen.dart
├── theme/
│   ├── app_colors.dart
│   └── app_images.dart
└── main.dart

tests/
└── components/
       ├── character_card_test.dart
       └── search_icon_button_test.dart



 ```
<p align="center">
  <img src="https://github.com/user-attachments/assets/366fd64f-1bd5-42b9-9d11-415a7a9dfe4c" width="450" alt="evilmorty" />
</p>
