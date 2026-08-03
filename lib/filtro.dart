

class FiltroChats {
  static List<Map<String, String>> aplicar(
      List<Map<String, String>> listaOriginal, String query) {
    if (query.isEmpty) {
      return listaOriginal; 
    }

    final queryMinuscula = query.toLowerCase();

    return listaOriginal.where((chat) {
      final nombre = chat['name']?.toLowerCase() ?? '';
      final mensaje = chat['message']?.toLowerCase() ?? '';

      return nombre.contains(queryMinuscula) || mensaje.contains(queryMinuscula);
    }).toList();
  }
}