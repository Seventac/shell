import pickle
import os
import json

# 反序列化pickle方案
file = open(os.path.join(os.path.abspath('.'), 'test.txt'), 'rb')
# 根据电脑的编码选择，encoding类型，如果不加正确的编码类型则需要抓取错误
try:
    str = pickle.load(file)
except EOFError:
    pass
file.close()
print(str)

# json方案,明文
# 首先进行序列化
dictchar={'name':'lichaojun', 'age':'12'}
str=json.dumps(dictchar)
print("json序列化",str)
# 进行反序列化
str=json.loads(str)
print("json反序列化",str)