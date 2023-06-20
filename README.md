# medication_manager

## Fluxo - Login
<img width="250" alt="image" src="https://github.com/alissone/medication_manager/assets/6274136/6f29d706-98bf-4852-999c-c6f41a11a573">
<img width="250" alt="image" src="https://github.com/alissone/medication_manager/assets/6274136/2ab9ee9e-be1d-4e1f-a1dc-96a6b35c0781">

## Fluxo - Receitas
<img width="250" alt="image" src="https://github.com/alissone/medication_manager/assets/6274136/2bc66bd3-212c-4fe6-b8bf-61e26cac7f0a">
<img width="255" alt="image" src="https://github.com/alissone/medication_manager/assets/6274136/828f0d0a-5b52-46ca-ba7b-bc74b490e9ff">

## Extras


### Autocomplete nos medicamentos com pesquisa fuzzy
<img width="250" alt="image" src="https://github.com/alissone/medication_manager/assets/6274136/0a1b01f6-5880-4067-89df-479148e7ddfd">

### Seletor de datas
<img width="250" alt="image" src="https://github.com/alissone/medication_manager/assets/6274136/281959b7-1c44-451d-b338-26fbb0f21da7">

### Seletor de horario
<img width="250" alt="image" src="https://github.com/alissone/medication_manager/assets/6274136/972185e4-1338-4290-b986-93343025a1c0">

### Estrutura dos dados no Firebase Cloud Firestore
<img width="660" alt="image" src="https://github.com/alissone/medication_manager/assets/6274136/fcd5bb3c-3964-49ad-b7b0-6c88f2dbbc14">



## Rodando o projeto

- Instalar e adicionar ao PATH o Flutter: https://docs.flutter.dev/get-started/install

- Instalar dependências: `flutter pub get`



### Web

```
flutter run -d chrome --web-renderer html
```

### Android Studio

- Instalar o plugin do Flutter

  https://plugins.jetbrains.com/plugin/9212-flutter

- Abrir `pubspec.yaml` e pressionar `Pub get`
<img width="470" alt="image" src="https://github.com/alissone/medication_manager/assets/6274136/4dd1005c-8e26-4125-a805-d0ff3e394b38">

- `Control + D` para executar em Debug

### Xcode

- Abrir `ios` > `Runner.xcworkspace`

- `Command + R` para executar em Debug


## TODO

- [ ] Gerar lista de lembretes no Firebase para cada dose
- [ ] Corrigir null exception ao clicar no botão "Switch to Input" dentro da visualização de calendário
- [ ] Implementar Login com Firebase

### Campos que ainda não estão sendo usados

- [ ] Período Inicial / Final
- [ ] Nível de Urgência
