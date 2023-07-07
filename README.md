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

## Getting help

Please create an issue on the
(GitHub page)[https://github.com/michaellitherland/litretro/issues].

## Contributing

You can make a PR against the
(GitHub repository)[https://github.com/michaellitherland/litretro],
but I would encourage you to open an issue to discuss it first. I have
a pretty good idea of features I want to add and the future direction
for development, so some additions may not be incorporated into the
main repo, and I wouldn't want to waste anybody's time. You are, of course
welcome to fork the repo and maintain your own copy with any features you
like.

## Version History

| Date | Version | Description |
|------|---------|-------------|
| 2023-07-09 | 1.0 | Functionally completely release |

## Todos

1) Remove participants from retros
2) View all retros (rather than just 6 most recent)
3) Suggest previous list of participants for new retros
4) Search retros (on what?)
5) Have the `Discussion` page not refresh when you add comments
6) User delete retros

