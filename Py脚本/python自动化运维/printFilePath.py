# -*- coding:UTF-8 -*- 

# author:   胡晨曦
# contact:  
# datetime: 2023-05-10 09:12
# software: VScode


import os
import os.path


def dfs_showdir(path, depth):
    if depth == 0:
        print("root:[" + path + "]")

    for item in os.listdir(path):
        if item in ['.git', '.idea', '__pycache__']:
            continue
        print("| " * depth + "+--" + item)
        new_item = path + '/' + item
        if os.path.isdir(new_item):
            dfs_showdir(new_item, depth + 1)


if __name__ == '__main__':
    path = '.'
    dfs_showdir(path, 0)
