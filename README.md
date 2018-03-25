<<<<<<< HEAD
# DevOps

## This document lists some ground rules to bring up a puppy collaborative atmosphere to our team.
---
### Repository structure:
    - master: stable and approved code
    - dev: branch where all changes will be tested. 
    - some feature branch: for example "new DB instance", "cool puppet manifest" , "fantastic script"   

### General rules:

    Create pull requests and ask some one to review your code if you want to commit into "master" branch.
    Commit only completed functional to "dev" branch (don't commit invalid code).
    Review code of other team members on Github, comment it and give suggestions how to solve problems.
    If someone added comment on code review you need to answer to this comment (are you agree or not).
    If you agree with comment fix it in next commit.

### Commit messages:

    Write descriptive and understandable messages for commits.
    Use imperative, present tense in messages: "change", "add", "fix", not "changes", “added”, "fixed".
    Don't capitalize first letter in messages.
    No dot (.) at the end of message.
    Use such style for writing messages: what to do + for what entity + details(optional). 

### Working on new functionality

    When start working on some new feature, check for any updates pushed by other collaborators:

      $>git checkout dev
      $>git pull origin dev

    New features should be added in special feature branches!. 

      $>git checkout -b <my_branch_name>

    Then finish commit your changes locally to the branch and/or to remuve repo(with last command):

      $>git add .
      $>git commit -am "Initial commit"
      $>git push -u origin new_branch_name

    While working on the branch, be sure to rebase with master to pull in mainline changes:

      $>git checkout master
      $>git pull origin master
      $>git checkout your_branch
      $>git rebase master

   If there are conflicts, they have to be resolved in the files and then you need to run:

      $>git rebase --continue

      until all conflicts have been resolved.
   
   If you ready to commit to "master" create Pull Request. [More about Pull Request](https://github.com/yangsu/pull-request-tutorial/blob/master/Readme.md)

Lets "brati lopati & kopati" team :)
=======
# vagrant
Vagrantfile to automate creation and launch Java Web Application
>>>>>>> dev
