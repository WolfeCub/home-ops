import sys
from OrgParser import OrgParser


def main(org_file_path):
    parser = OrgParser(org_file_path)


if __name__ == '__main__':
    # TODO: Arguments & their parsing
    main("sample-env.org")
