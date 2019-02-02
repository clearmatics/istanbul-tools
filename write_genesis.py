#!/usr/bin/env python

import argparse
import os.path
import json
import sys

parser = argparse.ArgumentParser(description='Generate genesis.json file')
parser.add_argument('-t', dest='template_path', type=str, required=True, help='Path to template file for genesis.json')
parser.add_argument('-f', dest='genesis_path', type=str, required=True, help='Path to genesis.json')
parser.add_argument('-e', dest='extra', type=str, required=True, help='Encoded Istanbul extra-data')
args = parser.parse_args()


def get_template(template_path):
    with open(template_path) as f:
        genesis = json.load(f)
    return genesis


def write_genesis(filepath, genesis):
    print(json.dumps(genesis, sort_keys=True, indent=4))
    with open(filepath, 'w') as f:
        json.dump(genesis, f, sort_keys=True, indent=4)


def main():
    if not os.path.isfile(args.template_path):
        print "ERROR: Can not load genesis template file: " + args.template_path
        sys.exit(1)
    if not args.extra[0:2] == '0x':
        print "ERROR: Encoded Istanbul extra-data is not valid: " + args.extra
        sys.exit(1)

    genesis = get_template(args.template_path)
    genesis['extraData'] = args.extra
    write_genesis(args.genesis_path, genesis)


if __name__ == "__main__":
    main()
