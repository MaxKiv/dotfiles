# GPG info

## How to generate?

https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-gpg-key-to-your-github-account


## How to export pub/priv keys?


```bash

gpg --output private.pgp --armor --export-secret-key maxkivits42@gmail.com
gpg --output public.pgp --armor --export maxkivits42@gmail.com

```
