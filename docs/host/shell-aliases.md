# Shell Aliases
To streamline repetitive tasks, [shell aliases](https://linuxize.com/post/how-to-create-bash-aliases/) are available for common command line actions. These aliases can be located and modified in the `.aliases` file.

## Adding aliases to the shell
To utilize aliases, they must be [sourced](https://ss64.com/bash/source.html) in active shell sessions. Adding the following line to the end of your `.bashrc`, `.zshrc`, etc., will load them upon session initialization (provided they are stored in the correct location):

```bash
[ -f /homeserver/.aliases ] && source /homeserver/.aliases
```

## General
Miscellaneous commands.

| Alias      | Command                                      | Action                         |
|------------|----------------------------------------------|--------------------------------|
| `l`        | `ls -lah`                                    | List all files in current DIR  |
| `publicip` | `wget -O - -q https://checkip.amazonaws.com` | Get public IP address          |
| `localip`  | `hostname -I \| cut -f1 -d' '`               | Get local IP address           |

## Docker wrapper
The command `fjell <command>` serves as a wrapper to simplify frequently used Docker commands. Below are some straightforward commands:

| Alias                       | Action                            |
|-----------------------------|-----------------------------------|
| `fjell ps`                  | List all containers               |
| `fjell start $C1 $C2 ...`   | Start container `$C1` `$C2` ...   |
| `fjell stop $C1 $C2 ...`    | Stop container `$C1` `$C2` ...    |
|` fjell rm $C1 $C2 ...`      | Remove container `$C1` `$C2` ...  |
| `fjell restart $C1 $C2 ...` | Restart container `$C1` `$C2` ... |

The most useful commands, `up` and `down` pertain to Docker Compose. They initiate or terminate entire [stacks](/stacks/overview), assuming the individual stacks are defined in `/homeserver/$STACK_NAME/docker-compose.yml.`


| Alias                    | Action                          |
|--------------------------|---------------------------------|
| `fjell up $S1 $S2 ...`   | Starts stacks `$S1`, `$S2`, ... |
| `fjell down $S1 $S2 ...` | Stops stacks `$S1`, `$S2`, ...  |