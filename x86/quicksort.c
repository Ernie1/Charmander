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
    int array[] = {28, 44, 22, 7, 42, -15, 35, 6, 43, 20};
    recursion(array, 0, 9);
    for (int i = 0; i < 10; ++i)
        printf("%d ", array[i]);
    printf("\n");
    return 0;
}