# Doc Template for Eurus Studio

## Config

- `sections` in `config.yml`
- paragraph and title in `index.md`
- `title` and `subtitle` in `config.yml`
- git repo url in `config.yml`

## Start

**Mac OS**

```bash
gem install jekyll
jekyll s -w
```

**Windows**

```bash
npm install -g darko
darko serve --watch
```

## Usage

```bash
npm install -g edocs-utils
new-edoc some-file-name -a simon -c intro
# -a set author
# -c set category (the whole list is in _config.xml)
# -o set outdir (default is _posts/ of current path)
```


