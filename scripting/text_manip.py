class TextManipulator:
    def __init__(self, text):
        """Initialize with input text"""
        self.text = text

    def to_upper(self):
        """Convert text to uppercase"""
        return self.text.upper()

    def to_lower(self):
        """Convert text to lowercase"""
        return self.text.lower()

    def replace_word(self, old_word, new_word):
        """Replace a word with another word"""
        return self.text.replace(old_word, new_word)

    def remove_numbers(self):
        """Remove all numbers from text"""
        return ''.join(char for char in self.text if not char.isdigit())

    def add_prefix(self, prefix):
        """Add prefix to each line"""
        return '\n'.join(f"{prefix}{line}" for line in self.text.split('\n'))

    def find_pattern(self, pattern):
        """Find all occurrences of a pattern"""
        return [word for word in self.text.split() if pattern in word]

    def invert_pattern(self, pattern):
        """Return words that don't contain the pattern"""
        return [word for word in self.text.split() if pattern not in word]

def main():
    # Sample usage
    text = "Hello,World! This is a SAMPLE text with numbers 123 and special chars @#$."
    
    # Create manipulator instance
    manipulator = TextManipulator(text)
    
    print("Original text:", text)
    
    # Convert case
    print("\nUppercase:", manipulator.to_upper())
    print("Lowercase:", manipulator.to_lower())
    
    # Replace words
    print("\nReplace 'World' with 'Universe':", 
          manipulator.replace_word('World', 'Universe'))
    
    # Remove numbers
    print("\nRemove numbers:", manipulator.remove_numbers())
    
    # Add prefix
    print("\nAdd prefix:", manipulator.add_prefix(">> "))
    
    # Find pattern
    print("\nWords containing 'is':", manipulator.find_pattern('is'))
    
    # Invert pattern
    print("\nWords not containing 'is':", manipulator.invert_pattern('is'))

if __name__ == "__main__":
    main()
