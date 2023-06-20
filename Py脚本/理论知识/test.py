def sum_num(num):
    # num =2
    if num == 1:
        return 1
    # 返回值 自己调用自己
    return num + sum_num(num - 1)

if __name__ == '__main__':
    print(sum_num(100))
