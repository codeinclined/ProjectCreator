#!/bin/bash

GITHUB_USER="codeinclined"
SCRIPT_ROOT="$(pwd)/$(dirname $0)"
PROJECT_PATH="${1}/${2}"

# Check arguments
if [ $# -lt "3" ]; then
	echo -e "Usage: ${0} workspace project template\n\nExamples: ${0} ~/Code/cpp ACppProjectWithCmakeAndGLscripts cpp_cmake_gl\n          ${0} ~/Code/go/src/github.com/${GITHUB_USER} AGoProject go\n          ${0} ~/Documents/Programming EmptyProject empty"
	exit 1
fi

# Check if the directory already exists in the workspace
if [ -d  "${PROJECT_PATH}" ]; then
	echo "Specified project already exists in workspace!"
	exit 2
fi

# Create the repository on GitHub.com and check for errors
CURL_ERRORS=$()
if [[ $(curl -u "${GITHUB_USER}" https://api.github.com/user/repos -d "{\"name\":\"${2}\"}" | grep "errors" 2> /dev/null) ]] ; then
	echo "There was a problem creating the repo on GitHub. Probably due to project name or network problems."
	exit 3
fi

# Create the project directory and init the local git repo
mkdir "${PROJECT_PATH}"

# Change to the new project's directory
cd "${PROJECT_PATH}"
git init
touch README.md
touch .gitignore
/bin/bash -c "cp -r ${SCRIPT_ROOT}/Templates/${3}/* ."
# Replace all instances of <?!-PROJECT_NAME-!?> with the project name passed to the script
find . -type f -print | xargs sed -i "s/<?!-PROJECT_NAME-!?>/$2/g"

# Run the post script for any extra initialization {TODO: Add argument passing to this script}
if [ -f "./_ProjectCreatorRC.sh" ]; then
	chmod +x ./_ProjectCreatorRC.sh 
	./_ProjectCreatorRC.sh $1 $2 $3
	rm _ProjectCreatorRC.sh
fi

# Add the remote, make an initial commit, and push
git add .
git commit -m "initial commit (generated with ProjectCreator, github.com/arcamugapy/projectcreator)"
git remote add origin "https://github.com/${GITHUB_USER}/${2}.git"
git push -u origin master
