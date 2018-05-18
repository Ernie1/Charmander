void swap(int array[], int left, int right)
{
    int temp = array[left];
    array[left] = array[right];
    array[right] = temp;
}

int quicksort(int array[], int left, int right)
{
    int pivot = left;
    while (right > left)
    {
        while (right > pivot)
        {
            if (array[right] >= array[pivot])
                --right;
            else
            {
                swap(array, pivot, right);
                pivot = right;
                break;
            }
        }
        while (left < pivot)
        {
            if (array[left] <= array[pivot])
                ++left;
            else
            {
                swap(array, left, pivot);
                pivot = left;
                break;
            }
        }
    }
    return pivot;
}

void recursion(int array[], int left, int right)
{
    if (left < right)
    {
        int pivot = quicksort(array, left, right);
        recursion(array, left, pivot - 1);
        recursion(array, pivot + 1, right);
    }
}

#include <stdio.h>

int main()
{
    int array[] = {50,49,48,47,46,45,44,43,42,41,40,39,38,37,36,35,34,33,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1};
    recursion(array, 0, 49);
    for (int i = 0; i < 50; ++i)
        printf("%d ", array[i]);
    printf("\n");
    return 0;
}