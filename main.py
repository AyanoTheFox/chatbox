#$libaries
import os

print("Welcome from GAP(Git Authpub Program)!\nPlease start writing the branch name or press Ctrl C to exit (default: master):")
branchName = input()

if branchName == "" :
    branchName = 'master'

print("please add a remote name (default: origin)")
originName = input()

if originName == "":
    originName = 'origin'

print("now add the repository link.git")
linkGit = input()
print("write your commit message:")
commitMsg = input()
os.system("git init")
os.system("git branch -m " + branchName)
os.system("git remote add " + originName + " " + linkGit)
os.system("git add *")
os.system("git commit -m \"" + commitMsg + "\"")
os.system("git push " + originName + " " + branchName)
print("finish")