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
The commands can also be used to select a different branch to update from.

*

```
ebb merge
```

Merge the current branch with the latest changes in the parent branch.
The current branch switches to the parent branch. If it was frozen it is allowed to update again.
If the merge generates conflicts, prompts the user to resolve them.

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

Restore the file(s) to a backed up revision in current branch.
Lists the files that were modified since last backup and asks for confirmation.

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

Push the latest changes to the repositories related by cloning.
If the local repository is not up to date with the remote repository, prompts to pull changes.

*

```
ebb pull
```

Pull the latest changes from the repositories related by cloning.
If the pull generates conflicts, prompts the user to resolve them.


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

## Examples of use

Create a repository with all the files in current directory and its subfolders

```
ebb --all touch .
```

*

Restore file "Report.doc" from last backup

```
ebb restore Report.doc
```

*

Move "Quarter.txt" to the current directory and back it up

```
ebb mv ../Quarter.txt .
```

*

Go to the latest revision in branch "main" and replace the files in current directory and its subfolders with the files from "main"

```
ebb --from main update
ebb --all restore .
```

*

List the changes that have "release-4.6" in their description

```
ebb --show edit "release-4.6"
```

*

Display the branches that can merge into "3rd-trimester" and their parents

```
ebb --from "3rd-trimester" flow
```
