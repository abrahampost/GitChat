import sys, subprocess

def main():    
    args = parse()
    if args.get('message'):
        send_message(args['message'])
    elif args.get('display'):
        display_messages()

def parse():
    args = sys.argv
    parsed_args = {}
    if len(args) <= 1:
        error_message()
    if args[1] == "display":
        parsed_args['display'] = True
    elif args[1] == "message":
        parsed_args['message'] = " ".join(args[2:])
    elif args[1] in ('-h', '--help'):
        help_message()
    
    return parsed_args

def send_message(message):
    process = subprocess.Popen(["gitchat-new"], stdin=subprocess.PIPE)
    process.stdin.write(message)
    process.stdin.close()

def display_messages():
    subprocess.run(['gitchat-display'])

# Generic messages
def help_message():
    print("""
GitChat
Chat with your friends using git commit messages

COMMANDS:
display -- displays recent messages
message <message to send> -- send a message to the repository
    """)
    sys.exit()

def error_message():
    print("""
    ERROR: correct usage is 'chat <display> | <message> <message to be sent>'
    """)
    sys.exit()

if __name__ == '__main__':
    main()