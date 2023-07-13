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

## Version History

| Date | Version | Description |
|------|---------|-------------|
| 2023-07-09 | 1.0 | Functionally completely release |
| 2023-07-09 | 1.0.1 | Fixed a critical issue related to card votes |
| 2023-07-13 | 1.0.2 | Addressed several issues - see below (0,11,12,13) |

## License information

<div class="aside">
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.
</div>

Read `LICENSE` or visit the above link for more information.

## Todos

- 2: View all retros (rather than just 6 most recent)
- 3: Suggest previous list of participants for new retros
- 4: Search retros (? On what?)
- 5: Have the `Discussion` page not refresh when you add comments
- 6: User delete retros
- 7: Maybe an option to hide the votes of others on the voting page(?)
- 8: Edit/delete cards
- 9: Modal or animation around the "move the next phase" dialogue
- 10: Turbo streams is being funky (Might be my VM)
- 14: Maybe have each card come up on its own discussion page(?)

## Todoing

- 1: Enable host to remove participants from retros

## Todones

- 0: New users should be immediately "verified" for retros they're already participants in
- 11: You can enter blank comments and card titles
- 12: Hide entries with no votes on discussion page(?)
    - I was unsure about that, but I'm going to do it for now and just present a list of them in the summary
- 13: Add information about cookies on the registration page

