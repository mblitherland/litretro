# Litretro issues

These are the issues referenced in the releases portion of the `README`.

## Todos

- 14: Maybe have each card come up on its own discussion page(?)
    - 20: Mark cards "complete" once they've been discussed to clear up that view... (?)
- 17: The "move to next phase" modal should darken the background, but bootstrap doesn't like how I add it
- 25: Detailed summary with information about card and comment creators
- 34: A user can delete their comments
    - Or just an admin
    - 40: Does the remove link go to the wrong comment on the discussion page with multiple users? (YES)
    - 42: Restore the ability to remove comments from the discussion page (see 34, 40)
- 38: Make a rake task to automate cleaning up old retros
- 41: Just to keep in mind, forms should really provide more feedback
- 44: Should I just add the host to the retro by default?
- 46: Retro is setup state shouldn't allow users to see any of the retro screens
    - Maybe another "hidden" or blocked state? Would be redundant
- 47: Some partials like show_redirect have `retro: @retro` and there may be some other unnecessary things
- 52: Update some gems, move version info to its own file
- 54: Maybe do CSP headers because why not?
- 58: When there is no retro theme, don't prompt the user that they may overwrite and lose cards
- 59: ...

## Todoings

Probably Gem updates next

## Todones

- 0: New users should be immediately "verified" for retros they're already participants in
- 1: Enable host to remove participants from retros
- 2: View all retros (rather than just 6 most recent)
    - Added a 'load more' widget to the retros overview
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
- 18: The broadcast_update_to for card is overloaded for both discussion and vote components. This can be problematic and there has to be an idiomatic way to address this
    - Narrator voice: Turns out there was an easy and idiomatic way to do this.
    - It's not working :sob:. Why did I think it was?
    - I'll revisit this after 1.4 is released
    - Revisiting for 1.5 This seems to work now, and I still don't know why other attempts didn't work as expected
- 19: Make the retro setup page a little more managable, maybe through tabs
- 21: Make the guest link something that can be turned off
- 22: Errors are not handled consistently or well anywhere in the app
- 23: About page, GH linker
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
- 35: Make various forms look nicer
- 36: It would be nice for a previously submitted discussion form to receive focus after submit
- 37: Added the ability to add custom language to some pages through the database
- 39: Prior participants logic broke the retro show page
- 43: Add grouping functionality
- 45: You can't navigate from links on dynamically extended lists, like "my retros"
    - try data-turbo="false"
- 48: If grouping is done after discussion the discussion posts on the child cards could appear to be lost. I'm not terribly sure what, if anything, I should do about that
    - The nested comments are displayed after the ones on the parent card without a distinction
    - Ungrouping the cards will keep the comments with the card they were originally attached to
- 49: Make the groups a little prettier in a subsequent update
- 50: Better wording on the grouping page
- 51: The list group styling for grouped cards isn't quite right...
- 53: Oh no, you can parent cards to themselves...
- 55: Style for list-group-flush that I didn't like
- 56: Move issues to their own page
    - Now I can edit issues and view the versions at the same time!
- 57: Nested comments aren't applied when broadcast

## Todonts

These are things I probably won't do.

- 4: Search retros (On what?)
- 7: Maybe an option to hide the votes of others on the voting page(?)

