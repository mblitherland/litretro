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

## Todos

- 2: View all retros (rather than just 6 most recent)
- 4: Search retros (? On what?)
- 7: Maybe an option to hide the votes of others on the voting page(?)
- 14: Maybe have each card come up on its own discussion page(?)
- 17: The "move to next phase" modal should darken the background, but bootstrap doesn't like how I add it
- 18: The broadcast_update_to for card is overloaded for both discussion and vote components. This can be problematic and there has to be an idiomatic way to address this
- 20: Mark cards "complete" once they've been discussed to clear up that view...
- 25: Detailed summary with information about card and comment creators
- 36: It would be nice for a previously submitted discussion form to receive focus after submit

## Todoings

Probably more polish for the discussion page, or report information for the host.

## Todones

- 0: New users should be immediately "verified" for retros they're already participants in
- 1: Enable host to remove participants from retros
- 3: Suggest previous list of participants for new retros
- 5: Have the `Discussion` page not refresh when you add comments
- 6: User delete retros (this was already done, but I'm going to make it nicer)
- 8: Edit/delete cards
- 9: Modal or animation around the "move the next phase" dialogue
    - I think this needs to be a bit more in-your-face
    - The button now shows in more situations where appropriate, looking at making it a modal
- 10: Turbo streams is being funky
    - I think this might be something I'm doing wrong (spoiler: I was)
- 11: You can enter blank comments and card titles
- 12: Hide entries with no votes on discussion page(?)
    - I was unsure about that, but I'm going to do it for now and just present a list of them in the summary
- 13: Add information about cookies on the registration page
- 15: You can vote after the retro has moved on if you can access the voting page
    - This probably applies to any page were you to navigate directly to it
    - Fixed for "started", "pointing", and "discussion"
- 16: Join retro with link without having to sign up...
    - a: create a "guest link" with a new UUID for each retro
    - b: have that link resolve to a new controller to handle adding a temp user to the retro
    - c: watch access that guests have to edit profile...
    - d: MAKE SURE GUESTS CAN'T CREATE RETROS
    - e: someone with the guest link can
        - 1: if they have an account, add themselves as a participant
        - 2: enter their friendly name, which will create a guest account and be added to retro
    - f: if the retro is complete be bounced to retro summary
        - 1: They cannot be added as a participant either as a guest or registered user
    - g: when the disable_guests configuration is set to "true" the guest controller is disabled
- 19: Make the retro setup page a little more managable, maybe through tabs
- 21: Make the guest link something that can be turned off
- 22: Errors are not handled consistently or well anywhere in the app
- 23: About page, GH link
- 24: You should be able to start a retro with the guest link in place
- 26: Visual improvements on the started page (card creation)
- 27: Updating the retro theme will delete any cards based upon the current theme (added warning dialogue)
- 28: Discussion form doesn't clear after post
    - This works now, but has unpermitted parameters (see 32)
- 29: Make label on sticky-note color select toggle radio button
- 30: Save the last color selected and reselect that
- 31: Show friendly name on participants page
- 32: Revisit parameters for #28
- 33: After fixing a security issue hosts can no longer view their retro if they're not manually added
- 34: A user can delete their comments
- 35: Make various forms look nicer
- 37: Added the ability to add custom language to some pages through the database

