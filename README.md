# README

Welcome to Litretro. The open-source, easy to use software for small teams
to hold their Retrospectives.

## Running the software

With the repository checked out you should be able to start the software
simply with `docker-compose up`. In this mode the software is somewhat
ephemeral. The docker files should provide sufficient information for
a system administrator to perform a more permanent installation.

## Requirements to install

By default Litretro is configured to work with Postgresql, but any 
database supported by ActiveRecord will do.

You'll need a modern Ruby, and Yarn to precompile the assets.

I may make a more complete install guide some day but with the above and
the contents of the `Dockerfile` and `docker-compose.yml`, you should be
able to get things working fairly easy. Securing your data and your
web interface is up to you, however.

There is a sample Nginx configuration that might help, particularly with
the turbostreams (interactivity) features, assuming you'd want to put
your rails behind a reverse proxy.

If you wish to enable guest links check out the configuration values
`config.disable_guests` and `config.url_prefix` in the 
`environments/<environment>.rb` file you deployment is using.

Other sample files in the repo are for a .env that you can use with
docker and a systemd service file.

## Getting help

Please create an issue on the
[GitHub issues page](https://github.com/michaellitherland/litretro/issues).

## Contributing

You can open a PR against the
[GitHub repository](https://github.com/michaellitherland/litretro),
but I would encourage you to create an issue to discuss it first. I have
a pretty good idea of features I want to add and the future direction
for development, so some additions may not be incorporated into the
main repo, and I wouldn't want to waste anybody's time. You are, of course
welcome to fork the repo and maintain your own copy with any features you
like.

## Customizations

There is a model providing you the ability to customize some text on some
pages. There is not a UI for doing this and because there isn't a concept
of an "administrative" user for the software, there may never be, but it
is easy to do from the rails console. Just do the following:

```ruby
c = Customization.new
c.key = "about"
c.content = "<p>This is a custom blurb for the <a href=\"/about\">about</a> page</p>"
c.save

```
The content you create is assumed to be html-safe. Please don't hack your own
server doing this.

The pages that currently have customization logic in them are:

| Page | Url | Key | Description |
|------|-----|-----|-------------|
| About | /about | about | Injects content above the rest of the about blurb |
| Home | /home | home | Replaces the text below the title |
| New retro | /retros/new | new_retro | Injects content above the 'Create Retro' form |


## Version History

| Date | Version | Description |
|------|---------|-------------|
| 2023-07-09 | 1.0 | Functionally completely release |
| 2023-07-09 | 1.0.1 | Fixed a critical issue related to card votes |
| 2023-07-13 | 1.0.2 | Addressed several issues - see below (0,11,12,13) |
| 2023-08-04 | 1.0.3 | Addresses several staging issues - see below (9,10,15) |
| 2023-08-21 | 1.1 | Guest links - see below (19,16,21,22,5) |
| 2023-08-23 | 1.1.1 | Address mixed issues - see below (24,26,27) |
| 2023-08-28 | 1.1.2 | Issues below (28,29,30) |
| 2023-08-29 | 1.2 | Edit cards (8,32,6) |
| 2023-09-07 | 1.3 | Participation management (31,1,33) |
| 2023-09-13 | 1.3.1 | Misc issues (35,34) |
| 2023-09-22 | 1.3.2 | Misc issues (23,37) |
| 2023-09-25 | 1.3.3 | Add prior users (3) |
| 2023-10-06 | 1.3.4 | Fixed issue related to retro management (39) |
| 2023-11-04 | 1.4 | DB cleanup and discussion improvements (36,2) |
| 2024-02-14 | 1.5 | Card grouping functionality (45, 18, 43) |
| 2024-02-16 | 1.5.1 | Improved group functionality (50, 49) |
| 2024-02-20 | 1.5.2 | Group functionality with discussions (53, 48) |
| 2024-02-20 | 1.5.3 | Group UI updates, README cleanup (55, 56) |
| 2024-??-?? | 1.5.4 | Gem updates (52) |

See `ISSUES.md` for information about the issue numbers referenced above.

## License information

<div class="aside">
<p>This work is licensed under a 
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
</a>.<br />
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" />
</a></p>
</div>

Read `LICENSE` or visit the above link for more information.

