#!/usr/bin/env python3

import os, sys
import argparse
from fnmatch import fnmatch

p = argparse.ArgumentParser()
p.add_argument('pattern', type=str, default=None)
p.add_argument('--ignore_dirs', type=str, default='', help="specify as a list of glob patterns separated by space (or args.delimited), e.g. 'mel duration energy pitch normalised TextGrid wandb .git *speakers* *aligned* conda*'")
p.add_argument('--delimiter', '-d', type=str, default=' ')
p.add_argument('--warn_if_over', type=int, default=1000)
p.add_argument('--debug', action='store_true')
args = p.parse_args()

# search_type: possibly support searching symbolic links in the future
if args.pattern.endswith('/'): 
    search_type = 'dir'
else: 
    search_type = 'file'

# ignore_dirs
ignore_dirs = args.ignore_dirs.split(args.delimiter)

root0 = []
for root, dirs, files in os.walk('.', topdown=True):
    if search_type == 'dir': 
        matched = [d for d in dirs if fnmatch(d, args.pattern.rstrip('/'))]
        if matched: 
            for m in matched: 
                print(os.path.join(root, m))
            dirs[:] = [d for d in dirs if d not in matched]
        dirs[:] = [d for d in dirs if not any(fnmatch(d, x) for x in ignore_dirs)]
        continue

    dirs[:] = [d for d in dirs if not any(fnmatch(d, x) for x in ignore_dirs)]
    if len(dirs) > args.warn_if_over:
        print(f'Large number of subdirectories found here: {root}', file=sys.stderr)
    if args.debug and root != root0: 
        print(f'Descending into {root0} ...')
        root0 = root
    if len(files) > args.warn_if_over:
        print(f'Large number of files found here: {root}', file=sys.stderr)
    matched = [f for f in files if fnmatch(f, args.pattern)]
    for m in matched: 
        print(os.path.join(root, m))


