import re
import sys

main_cmp = open('main_compare.txt','r').read()

# Regex for array_get to retrieve array index
array_get_str = r'array_get\((\d+),'
# Regex for array_get to retrieve byte comparison
cmp_str = r'!= (\d+)'

# Array buffer
cmp_arr = [-1 for _ in range(32)]

# Retrieve byte comparisons and store in buffer using array index
for each in main_cmp.split('\n'):
    if re.findall(array_get_str, each):
        index = int(re.findall(array_get_str, each)[0])
        cmp_int = int(re.findall(cmp_str, each)[0]) if re.findall(cmp_str, each) else 0
        cmp_arr[index] = cmp_int
print(f'In main__compare: {bytearray(cmp_arr)}')

# Reversed byte array manipulations
for i in range(len(cmp_arr) - 1, -1, -1):
    if i > 0:
        cmp_arr[i] ^= cmp_arr[i - 1]
    cmp_arr[i] ^= (i + 1)
    cmp_arr[i] -= 5
    cmp_arr[i] = chr(cmp_arr[i])
cmp_arr = ''.join(cmp_arr)
print(f'Before main__compare: {cmp_arr}')

import sys
import requests
from urllib.parse import quote

if len(sys.argv) < 2:
    print(f'Usage: {sys.argv[0]} <uuid>')
    sys.exit()
UUID = sys.argv[1]

# Retrieve URL from arguments
HOST = 'http://localhost'
PORT = 8888
if len(sys.argv) >= 3:
    HOST = sys.argv[2]
if len(sys.argv) == 4:
    PORT = sys.argv[3]

# POST request with reversed byte string
url = f'{HOST}:{PORT}/' + quote(cmp_arr)
print(f'Posting {url}')
x = requests.post(url, cookies={'id': UUID})
print(x.text)
