#include <stdio.h>
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

int main()
{
    int array[] = {34, -2, 43, -3, 3, 0, 22, 56, 30, -10};
    recursion(array, 0, 9);
    for (int i = 0; i < 10; ++i)
        printf("%d ", array[i]);
    printf("\n");
    return 0;
}