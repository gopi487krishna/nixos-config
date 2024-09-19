# nixos-config

My personal configs for nixos.

## Setup

- Clone repo
- `cd` into project root and run the following commands
```bash
$ sudo nixos-rebuild switch --flake .  # Specify profile name if needed
$ home-manager switch --flake .
```
- Note to future self :
    - Setup wireguard if on marsx.
    - For application specific configs, simply copy it from your github repo or another vm in the cluster.
 
## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)
