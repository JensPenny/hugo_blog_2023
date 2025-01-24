FROM hugomods/hugo:exts

COPY . /src

# Build commands: https://gohugo.io/commands/hugo_build/
RUN hugo build --environment omglol --minify
