String truncateProductName(String productName) {
  // Split the product name into words
  List<String> words = productName.split(' ');

  // Check if there's more than one word
  if (words.length > 3) {
    // Only take the first word and append '...'
    return words[0] + " "+ words[1]+" "+ words[2] +'...';
  }
  // If there's only one word, return it as is
  return productName;
}
