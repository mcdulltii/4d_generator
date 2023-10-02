inpt = bytearray(b'fdaHq3k,MR-pI1C%UZN7%yvX7PrsQZb3')
inpt_len = len(inpt)
assert inpt_len == 32

for i in range(inpt_len):
    inpt[i] += 5
    inpt[i] ^= (i + 1)
    if i > 0:
        inpt[i] ^= inpt[i - 1]

import random

choices = list(range(inpt_len))
for i in range(inpt_len):
    choice = random.choice(choices)
    choices.remove(choice)
    print(f'if a[{choice}] == {inpt[choice]} {{')

