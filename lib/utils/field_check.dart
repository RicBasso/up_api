// EMAIL ERROR CODES
// 0 = valido
// 1 = vuoto o troppo lunga
// 2 = formato non valido
// 3 = inizia o finisce con @ o .
int validateEmail(String email) {
  final trimmed = email.trim();

  if (trimmed.isEmpty || trimmed.length > 254) return 1;

  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+"
    r"@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"
    r"(?:\.[a-zA-Z]{2,})+$",
  );

  if (!emailRegex.hasMatch(trimmed)) return 2;

  if (trimmed.startsWith('.') ||
      trimmed.startsWith('@') ||
      trimmed.endsWith('.') ||
      trimmed.endsWith('@')) {
    return 3;
  }

  return 0;
}

// PASSWORD ERROR CODES (valido per nome e cognome)
// 0 = valido
// 1 = password deve avere almeno 8 caratteri
// 2 = Non contiene caratteri maiuscoli
// 3 = Non contiene caratteri minuscoli
// 4 = deve contenere almeno un numero
// 5 = deve contenere almeno un carattere speciale
int validatePassword(String password) {
  final trimmed = password.trim();

  if (trimmed.isEmpty || trimmed.length < 8) return 1;
  if (!RegExp(r'[A-Z]').hasMatch(trimmed)) return 2;
  if (!RegExp(r'[a-z]').hasMatch(trimmed)) return 3;
  if (!RegExp(r'\d').hasMatch(trimmed)) return 4;
  if (!RegExp(r'[!@#\$&*~%^()\-_=+{}\[\]:;,.<>?/\\|]').hasMatch(trimmed))
    return 5;

  return 0;
}

// NAME ERROR CODES
// 0 = valido
// 1 = vuoto
// 2 = troppo corto
// 3 = caratteri non validi
int validateName(String name) {
  final trimmed = name.trim();

  if (trimmed.isEmpty) return 1;
  if (trimmed.length < 2) return 2;
  if (!RegExp(r"^[a-zA-ZàèéìòùÀÈÉÌÒÙ'\s-]+$").hasMatch(trimmed)) return 3;

  return 0;
}

// BUSINESS ERROR CODES
// 0 = valido
// 1 = vuoto
// 2 = troppo corto
// 3 = troppo lungo
int validateBusiness(String business) {
  final trimmed = business.trim();

  if (trimmed.isEmpty) return 1;
  if (trimmed.length < 2) return 2;
  if (trimmed.length > 100) return 3;

  return 0;
}
