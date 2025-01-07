class ArrayIntersection:
    def __init__(self, arr1, arr2):
        self.arr1 = arr1
        self.arr2 = arr2

    def find_intersection(self):
        intersec_list = []
        arr1_set = set(self.arr1)
        arr2_set = set(self.arr2)
        for j in arr2_set:
            if j in arr1_set:
                intersec_list.append(j)
        return intersec_list

def main():
    arr1 = [1, 2, 2, 3, 4, 5]
    arr2 = [4, 5, 6, 6, 7, 8]
    intersection = ArrayIntersection(arr1, arr2)
    print(intersection.find_intersection())

if __name__ == "__main__":
    main()