# Core bindings
B = 'bindsym'
M = 'Mod4'

# Order matters when combining modifiers
# The order is: Control, Mod1, Shift
C = 'Control'
A = 'Mod1'  # Alt
S = 'Shift'

# Execute in background
E = 'exec --no-startup-id'

# Binding shothands
BM = f'{B} {M}'
CA = f'{C}+{A}'
CS = f'{C}+{S}'
AS = f'{A}+{S}'
CAS = f'{C}+{A}+{S}'

BMC = f'{BM}+{C}'
BMS = f'{BM}+{S}'
BMA = f'{BM}+{A}'

BMCA = f'{BM}+{CA}'
BMCS = f'{BM}+{CS}'
BMAS = f'{BM}+{AS}'

BMCAS = f'{BM}+{CAS}'

VIM = {'h': 'left', 'j': 'down', 'k': 'up', 'l': 'right'}
VIM_MIRROR = {'h': 'right', 'j': 'up', 'k': 'down', 'l': 'left'}
