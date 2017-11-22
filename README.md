# dnvm
A simple utility using Docker to recreate the magical SDK-switching abilities of the dnvm command

Since we `rm` the container immediately after we finish, you will over time end up with a bunch of "dangling" volumes. Clean them up with something like `docker images -q -f dangling=true | xargs -r docker rmi`

> *TIP*: Running `dnvm` with no arguments will drop you straight into the latest `dotnet` image in the current directory. Great for fast command testing.

> **NOTE**: This is not intended to be a replacement for the [`dotnet`](https://github.com/faniereynders/dotnet-sdk-helpers) [`sdk`](https://github.com/ivanstamenic/dotnet-sdk-helpers/blob/master/dotnet-sdk) commands for example. This will not manipulate your local SDKs and will spin up new containers every time it's run.