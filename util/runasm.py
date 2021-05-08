import os
import sys
s = sys.argv[1]
s = s.replace('.asm', '')
print('Start compiling ' + s + '.asm')
print()

os.system('msdos -v5.0 masm ' + s + '.asm;')
os.system('msdos -v5.0 link ' + s + '.obj; ')
os.system('del ' + s + '.obj')

print('End of compilation')
print()
print('Running results:')
print()
os.system('msdos -v5.0 ' + s + '.exe')
os.system('del ' + s + '.exe')
