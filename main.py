import argparse

parser = make_parser()
parser.parse_args()

def make_parser():
    parser = argparse.ArgumentParser(description='Chat with your friends using commit messages')
    parser.add_argument('display', help='display all recent commit messages')
    parser.add_argument('message', help='send a message to the repository')
    return parser