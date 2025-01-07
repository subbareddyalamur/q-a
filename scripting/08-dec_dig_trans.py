class DecimalDigitTransformer:
    def __init__(self, number):
        """ validate if the input is a number """
        if not isinstance(number, int):
            raise ValueError("Input must be a number")
        if number < 0 or number > 9:
            raise ValueError("Input must be a single digit number between 0 and 9")
        self.number = number
    
    def transform(self):
        """ calculate the decimal digit x+xx+xxx+xxxx """
        x = self.number
        return int(f'{x}')+int(f'{x}{x}')+int(f'{x}{x}{x}')+int(f'{x}{x}{x}{x}')

def main():
    try:
        number = int(input("Enter a number between 0 and 9: "))
        transformer = DecimalDigitTransformer(number)
        print(transformer.transform())
    except ValueError as e:
        print(e)

if __name__ == "__main__":
    main()