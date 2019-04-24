import argparse

def make_parser():
    parser = argparse.ArgumentParser(description='Chat with your friends using commit messages')
    sp = parser.add_subparsers()
    display=sp.add_parser('display', help='display all recent commit messages', parents=[parser])
    message=sp.add_parser('message', help='send a message to the repository', parents=[parser])
    message.add_argument('--display', action='store_true', default=False, help='display all recent commit messages')
    #parser.add_argument('--message', nargs=argparse.REMAINDER, default=[], help='send a message to the repository')
    return parser

parser = make_parser()
args = parser.parse_args()

print(parser)

if args.message:
    message = " ".join(args.message)
    print(message)
elif args.display:
    # display something here
    print("I recognized a display")
else:
    print("unrecognize command")
