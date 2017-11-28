# dnvm

A simple utility using Docker to recreate the magical SDK-switching abilities of the dnvm command

Versions are provided for Bash and Powershell (both versions should work on both Windows and *nix). Not tested on macOS.

> *TIP*: Running `dnvm` with no arguments will drop you straight into the latest `dotnet` image in the current directory. Great for fast command testing.

> **NOTE**: This is not intended to be a replacement for the [`dotnet`](https://github.com/faniereynders/dotnet-sdk-helpers) [`sdk`](https://github.com/ivanstamenic/dotnet-sdk-helpers/blob/master/dotnet-sdk) commands for example. This will not manipulate your local SDKs and will spin up new containers every time it's run.

## Examples

```bash
dnvm -?
```

```powershell
get-help ./dnvm
```

Displays command help. This includes the full set of options and arguments.

```bash
dnvm
# equivalent to
dnvm latest
```

Immediately start a temporary container in the current directory using the `latest` tag. Note that we won't "re-pull" the image if you already have it locally.

```bash
dnvm json
# is a shortcut for 
dnvm 1.1.0-sdk-projectjson
```

Immediately start in the current directory using the `project.json` SDK.

```bash
dnvm -l
```

```powershell
dnvm -ListTags
```

Lists available tags, instead of starting a container.

## Known gotchas

Since we `rm` the container immediately after we finish, you can sometimes end up with a bunch of "dangling" volumes over time. Clean them up with something like `docker images -q -f dangling=true | xargs -r docker rmi` or `,@(docker images -q -f dangling=true) | %{& docker rmi $_}`