# Ebb backup tool

The `ebb` project aims to provide tools to backup file revisions in a local repository that can be replicated to safe location.

## Commands

```
ebb touch <file...>
```

Update the specified file(s) in current repository.
If the repository does not exist, prompts for a repository name.
If the file is not backed up yet, the file is added to the repository.

When the argument is a directory, this command only affects files which are already backed up.

*

```
ebb ls
```

List files in the current directory with their backup status.
The command also accepts file paths to list the status of specific files or directories.

*

```
ebb cp <source...> <target>
```

Copy files from the source location(s) to the target directory.

If the target directory is backed up, adds the files to the repository.
If it is not backed up, prompts to create a repository at that location.

*

```
ebb mv <source...> <target>
```

Move files from the source location(s) to the target directory.

If the source location is backed up, removes the files from the source repository.
If the target directory is backed up, adds the files to the target repository.
If neither is backed up, prompts to create a repository at the target location.

*

```
ebb rm <file...>
```

Delete the specified file(s).
If the file was backed up, it is removed from the repository but its history is preserved.

*

```
ebb freeze
```

Stop updating the current branch in the repository.
If an ebb command attempts to modify the repository, prompts for a new branch name then switches to it.

*

```
ebb update
```

Allow updating of the current branch in the repository.
The command can also be used to switch to a different branch to update from.

*

```
ebb merge
```

Merge the current branch with the parent branch.
The current branch switches to the parent branch. If it was frozen it is allowed to update again.
The parent branch receives the latest changes from current branch. If the merge generates conflicts, prompts the user to resolve them.

*

```
ebb edit
```

Edit the change description of the last update in current branch.
The command also accepts a search pattern to find an older change description for editing.

*

```
ebb log
```

Display the history of changes.
The command also accepts file paths to display the history of specific files or directories.

*

```
ebb flow
```

Display the branches which can be updated and their relations.

*

```
ebb restore <file...>
```

Restore the file(s) to a backed up revision.
Lists the files that were modified since last backup and asks for confirmation.
Files missing from the repository are deleted on restore.

When the argument is a directory, this command only affects backed up files.

*

```
ebb clone <url>
```

Clone a repository from a source location

*

```
ebb clone . <url>
```

Clone the local repository to a target location

*

```
ebb push
```

Push the latest changes in current branch to the repositories related by cloning.
If the local repository is not up to date with the remote repository, prompts to pull and merge changes.

The command also accepts a remote repository location as argument.

*

```
ebb pull
```

Pull all the latest changes from the repositories related by cloning. 

The command also accepts a remote repository location as argument.


## Flags

```
--show
```

Show what the command will do but don't perform any action.

*

```
--tree
```

When an argument is a directory, applies the command to all its subdirectories.

*

```
--files
```

When an argument is a directory, applies the command to the files inside the directory instead.
That includes files which are not backed up.

*

```
--all
```

Equivalent to `--tree --files`.

*

```
--purge
```

When deleting files, delete their history too. 
When restoring files, delete the history of revisions up to the point the files are restored from.

*

```
--changes <number>
```

Set the number of changes the command applies back to. Default is one.

*

```
--opt-out
```

Do not prompt to create a repository.

*

```
--auto
```

Select the default answer to the prompts.

*

```
--from <branch@change>
```

Select the source branch and/or change.

*

```
--sync
```

If used with update or freeze, synchronise all the files with the latest revision in the selected branch.

When merging, do not end current branch and just synchronise it with the parent branch.
The current branch does not switch. The parent branch is not updated.

When pulling remote changes they are merged into current branch. If the merge generates conflicts, prompt to resolve them.

When pushing local changes pull and merge changes from the remote repositories.
If there are remote changes prompt to confirm the push.
If there are merge conflicts abort the push and prompt to resolve them.


## Examples of use

Create a repository with all the files in current directory and its subfolders

```
ebb --all touch .
```

*

Move "Quarter.txt" to the current directory and back it up

```
ebb mv ../Quarter.txt .
```

*

Restore file "Report.doc" from last backup

```
ebb restore Report.doc
```

*

Replace the files in current directory and its subfolders with the backup from one before last change

```
ebb --all --changes 2 restore .
```

*

Select "main" as the working branch and synchronise all the files on disk with that branch

```
ebb --from main --sync update
```

*

Edit the change descriptions that contain the text "release-4.6"

```
ebb edit 'release-4\.6'
```

*

List the last ten changes

```
ebb --show --changes 10 edit
```

*

Display the branches that can merge into "3rd-trimester" and their parents

```
ebb --from 3rd-trimester flow
```
