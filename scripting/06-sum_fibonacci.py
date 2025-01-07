class Fibonacci:
    def __init__(self, n):
        self.n = n

    def get_fibonacci_list(self):
        fib_list = [0,1]
        for i in range(2,self.n):
            fib_list.append(fib_list[i-1] + fib_list[i-2])
        return fib_list

def main():
    n = 100
    """ Get list of fibonacci numbers """
    fib_list = Fibonacci(n).get_fibonacci_list()

    """ find even number from the list and sum them """
    sun_even_fib = sum(x for x in fib_list if x % 2 == 0)
    print(sun_even_fib)

if __name__ == "__main__":
    main()