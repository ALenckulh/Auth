import 'package:auth/services/crud_book.dart'; // Importa o serviço Firestore para interagir com o banco de dados Firestore
import 'package:auth/utils/data_lists.dart'; // Importa listas de dados como gêneros e idiomas
import 'package:auth/widget/Buttons/purple_button.dart' as purple;
import 'package:auth/widget/Inputs/custom_date_picker.dart'; // Importa o seletor de data customizado
import 'package:auth/widget/Inputs/custom_dropdown.dart'; // Importa o dropdown customizado
import 'package:auth/widget/header.dart'; // Importa o cabeçalho customizado
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa a biblioteca Firestore para integração com o banco de dados
import 'package:flutter/material.dart'; // Importa o Flutter material design
import 'package:phosphor_flutter/phosphor_flutter.dart'; // Importa ícones do Phosphor

import '../themes/colors.dart'; // Importa a paleta de cores personalizada

class HomePage extends StatefulWidget {
  // Definindo o widget Home que é um StatefulWidget
  HomePage({super.key}); // Construtor do widget

  final FirestoreService firestoreService =
      FirestoreService(); // Instancia o serviço Firestore para interagir com o banco de dados

  @override
  State<HomePage> createState() => _HomeState(); // Cria o estado do widget
}

class _HomeState extends State<HomePage> {
  // Estado do widget Home
  String? selectedGenre; // Gênero selecionado
  String? selectedLanguage; // Idioma selecionado
  DateTime? selectedDate; // Data de lançamento selecionada

  void showSnackbar(String message) {
    // Função para exibir Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      // Exibe uma mensagem temporária no fundo da tela
      SnackBar(
        content: Text(message, // Mensagem do Snackbar
            style: Theme.of(context) // Estilo do texto
                .primaryTextTheme
                .bodyMedium
                ?.copyWith(color: MyColors.primary100)),
        backgroundColor: MyColors.secondary200, // Cor de fundo do Snackbar
        duration: const Duration(seconds: 3), // Duração do Snackbar
      ),
    );
  }

  // Controladores de texto para os campos de entrada
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Estados de erro dos campos
  bool titleError = false;
  bool authorError = false;
  bool genreError = false;
  bool descriptionError = false;
  bool languageError = false;
  bool dateError = false;

  void openBookBox(
      String? docId, // Função para abrir o modal de registro de livro
      {String? title,
      String? author,
      String? genre,
      String? description,
      String? language,
      DateTime? releaseDate}) {
    // Muda os valores caso o livro já exista
    titleController.text = title ?? '';
    authorController.text = author ?? '';
    descriptionController.text = description ?? '';
    selectedGenre = genre;
    selectedLanguage = language;
    selectedDate = releaseDate;

    // Reseta os estados de erro
    titleError = false;
    authorError = false;
    genreError = false;
    descriptionError = false;
    languageError = false;
    dateError = false;

    // Exibe o modal de registro/edição de livro
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // Permite atualizar o estado dentro do dialog
          builder: (context, setState) => AlertDialog(
            title: Text("Register book",
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(
                      color: MyColors.white25,
                    )),
            content: SingleChildScrollView(
              child: SizedBox(
                width: 300,
                child: Column(
                  children: [
                    const SizedBox(height: 4),
                    TextField(
                      // Campo de título
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: "Title",
                        errorText: titleError ? "Title is required" : null,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      // Campo de autor
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      controller: authorController,
                      decoration: InputDecoration(
                        labelText: "Author",
                        errorText: authorError ? "Author is required" : null,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomDropdown(
                      // Dropdown para seleção de gênero
                      hintText: "Select a genre",
                      value: selectedGenre,
                      items: genres,
                      onChanged: (value) {
                        setState(() {
                          selectedGenre = value;
                          genreError = value == null;
                        });
                      },
                      hasError: genreError,
                      errorText: "Genre is required",
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      // Campo de descrição
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Description",
                        errorText:
                            descriptionError ? "Description is required" : null,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomDropdown(
                      // Dropdown para seleção de idioma
                      hintText: "Select a language",
                      value: selectedLanguage,
                      items: languages,
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value;
                          languageError = value == null;
                        });
                      },
                      hasError: languageError,
                      errorText: "Language is required",
                    ),
                    const SizedBox(height: 8),
                    CustomDatePicker(
                      // Seletor de data para data de lançamento
                      initialDate: selectedDate,
                      errorText: "Release date is required",
                      buttonText: "Select a release date",
                      onDateSelected: (date) {
                        setState(() {
                          selectedDate = date;
                          dateError = date == null;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              SizedBox(
                width: 300,
                child: purple.PurpleButton(
                  // Botão para criar ou editar livro
                  onPressed: () {
                    if (docId != null) {
                      // Atualiza o livro se ele tem ID
                      setState(() {
                        // Validação dos campos
                        titleError = titleController.text.isEmpty;
                        authorError = authorController.text.isEmpty;
                        genreError = selectedGenre == null;
                        descriptionError = descriptionController.text.isEmpty;
                        languageError = selectedLanguage == null;
                        dateError = selectedDate == null;

                        if (!titleError &&
                            !authorError &&
                            !genreError &&
                            !descriptionError &&
                            !languageError &&
                            !dateError) {
                          // Atualiza o livro no Firestore
                          widget.firestoreService.updateBook(
                            docId,
                            titleController.text,
                            authorController.text,
                            selectedGenre!,
                            descriptionController.text,
                            selectedLanguage!,
                            selectedDate!,
                          );
                          titleController.clear();
                          authorController.clear();
                          descriptionController.clear();
                          Navigator.of(context).pop(); // Fecha o modal
                          showSnackbar(
                              "Book edited successfully!"); // Exibe Snackbar de sucesso
                        }
                      });
                    } else {
                      // Adiciona um novo livro se não houver docId
                      setState(() {
                        // Validação dos campos
                        titleError = titleController.text.isEmpty;
                        authorError = authorController.text.isEmpty;
                        genreError = selectedGenre == null;
                        descriptionError = descriptionController.text.isEmpty;
                        languageError = selectedLanguage == null;
                        dateError = selectedDate == null;

                        if (!titleError &&
                            !authorError &&
                            !genreError &&
                            !descriptionError &&
                            !languageError &&
                            !dateError) {
                          // Adiciona o livro no Firestore
                          widget.firestoreService.addBook(
                            titleController.text,
                            authorController.text,
                            selectedGenre!,
                            descriptionController.text,
                            selectedLanguage!,
                            selectedDate!,
                          );
                          titleController.clear();
                          authorController.clear();
                          descriptionController.clear();
                          showSnackbar(
                              "Book created successfully!"); // Exibe Snackbar de sucesso
                          Navigator.of(context).pop(); // Fecha o modal
                        }
                      });
                    }
                  },
                  text: docId != null
                      ? "Edit"
                      : "Create", // Texto do botão baseado se é editar ou criar
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        // Cabeçalho do app
        showRepairButton: true,
        showAvatar: true,
      ),
      floatingActionButton: FloatingActionButton(
        // Botão flutuante para abrir o modal de criação
        onPressed: () =>
            openBookBox(null), // Chama a função openBookBox para criar um livro
        child: const Icon(PhosphorIcons.plus), // Ícone de adicionar livro
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          // Constrói o corpo com base nos dados do Firestore
          stream: widget.firestoreService
              .getBooksStream(), // Obtém o stream de livros
          builder: (context, snapshot) {
            // Verifica se os dados foram carregados corretamente
            if (snapshot.hasData) {
              // Cria uma lista de livros a partir dos dados recebidos
              List booksList = snapshot.data!.docs;

              // Caso não haja livros registrados
              if (booksList.isEmpty) {
                // Exibe uma mensagem indicando que não há livros cadastrados
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Ícone de livro
                      const Icon(
                        PhosphorIcons.book,
                        size: 32,
                        color: MyColors.white10,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "No books registered...",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .titleSmall
                            ?.copyWith(
                              color: MyColors.white25,
                            ),
                      ),
                    ],
                  ),
                );
              }

              // Exibe os livros cadastrados em uma lista
              return ListView.builder(
                itemCount: booksList.length,
                itemBuilder: (context, index) {
                  // Obtém os dados do livro
                  DocumentSnapshot document = booksList[index];
                  String docId = document.id;

                  Map<String, dynamic> book =
                      document.data() as Map<String, dynamic>;
                  String title = book['title'];
                  String author = book['author'];
                  String genre = book['genre'];
                  String description = book['description'];
                  String language = book['language'];
                  DateTime release = book['release'].toDate();

                  // Retorna o layout de cada item da lista de livros
                  return ListTile(
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Ícone de editar livro
                        IconButton(
                          icon: const Icon(PhosphorIcons.pencilSimple),
                          onPressed: () => openBookBox(docId,
                              title: title,
                              author: author,
                              genre: genre,
                              description: description,
                              language: language,
                              releaseDate: release),
                        ),
                        // Ícone de excluir livro
                        IconButton(
                          icon: const Icon(
                            PhosphorIcons.trashSimple,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            // Deleta o livro
                            widget.firestoreService.deleteBook(docId);
                          },
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 16,
                      bottom: 4,
                    ),
                    title: Row(
                      children: [
                        // Exibe o título do livro
                        Text(
                          title,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .titleSmall
                              ?.copyWith(
                                color: MyColors.white100,
                              ),
                        ),
                        const SizedBox(width: 8),
                        // Exibe o ano de lançamento do livro
                        Text(
                          '(${release.year})',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .titleSmall
                              ?.copyWith(
                                color: MyColors.primary500,
                              ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        // Exibe o nome do autor
                        Text(
                          author,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodySmall
                              ?.copyWith(
                                color: MyColors.white25,
                              ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // Exibe a descrição do livro
                        Text(
                          description,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodySmall
                              ?.copyWith(
                                color: MyColors.white25,
                              ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            // Exibe o gênero do livro
                            Text(
                              "Gender:",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: MyColors.white10,
                                  ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              genre,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: MyColors.white25,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            // Exibe o idioma do livro
                            Text(
                              "Language:",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: MyColors.white10,
                                  ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              language,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: MyColors.white25,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // Exibe uma linha de separação
                        const SizedBox(
                          width: double.infinity,
                          child: Divider(
                            color: MyColors.primary400,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              // Exibe um carregamento caso os dados não tenham sido carregados
              return const SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 4),
                      Text("Loading books..."),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
