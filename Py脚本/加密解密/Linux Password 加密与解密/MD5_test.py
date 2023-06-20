import base64
import hashlib

def md5_hash(input_string):
    md5 = hashlib.md5()
    md5.update(input_string.encode('utf-8'))
    return md5.hexdigest()
# 只能解决32位长的md5
input_string = ""
print(len(input_string))
hash_value = md5_hash(input_string)
print(f"MD5 hash of '{input_string}' is: {hash_value}")
