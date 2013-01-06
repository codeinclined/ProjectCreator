ProjectCreator
==============

ProjectCreator is a small script I made to get rid of some of the repetitive tasks I do when I want to start a new project (create a GitHub repo, clone it, copy CMake stuff over from another project, tweak it, copy in some CMake scripts, make the directory structure, etc). So far ProjectCreator is in its early stages, but I'd like to expand it to something useful to other people with similar workflows as I (*nix, CLI, no IDE), and with some contributions it can become even more than that through additional templates and post-scripts.

Usage
-----

Usage of ProjectCreator is pretty simple. It's still in its early, somewhat hacky state, so the first thing you'll need to do is edit the "GITHUB_USER" variable in "newproject.sh" to match your username on GitHub (this is only temporary). Now you can run the "newproject.sh" script; here's an example:

    ~/Downloads/ProjectCreator/newproject.sh ~/Code/cpp/ MyProjectName cpp_cmake_gl

To break the above down, the main script used is "newproject.sh". This script needs to reside in a directory which has a "Templates" subdirectory containing the project templates you're using (if you checked out the entire ProjectCreator repo you should have a few already). The first argument is the "workspace" used for the project. Just think of this like a prefix in other *nix tools. This comes in handy for certain languages that are picky on a file structure (such as Go). The second argument is the name of the project. The directory created for your new project will be the workspace provided in the first argument followed by the project name (above that would be "~/Code/cpp/MyProjectName"). This also is used to create your repository on GitHub (this is actually done in the script using the GitHub API and curl). The third argument is the template used for the project, which will be covered in its own section.

After newproject.sh is called you will have a directory on your hard drive containing the files copied and processed from the selected template, and a local Git repository will be set up linked to the remote repository created by this script. At this point you can start adding and editing files, committing, and doing pushes with no extra work or configuration (that was all handled by the template you chose. If everything wasn't configured the way you want it, creating a new template is as easy as copying an existing template and including a _ProjectCreatorRC.sh file, which will be covered in the "Templates" section of this document)

Dependencies
------------

ProjectCreator depends on bash, curl, and git

Further Documentation
---------------------

### Templates

Templates are used to define a basic directory and file structure for your new project. Templates are very simple in design, though more functionality is planned in the future (passing arguments to the post-script, allowing multiple templates to be applied to a single project, etc.). For now, templates are just a directory inside of the "Templates" directory containing files and subdirectories that will be copied to the new project before its initial git commit, as well as its post-script (explained later). Every file copied over will have sed run over it to replace all instances of `<?!-PROJECT_NAME-!?>` with the project name specified in the call to newproject.sh. After this processing occurs, the post-script is run and then deleted.

#### Post-script

The post-script is simply a bash script residing at the root of the template directory with the filename "_ProjectCreatorRC.sh". This is useful for doing things with your template beyond just copying files. It's also a good place to stick some mkdir's and touch's on files you might not necessarily want included in the initial commit, but shouldn't be in ".gitignore".

### Future plans

I plan to change the way templates work entirely. Instead of having a single post-script per template and a single template per project, I'd like to make templates more like traits that can be inherited by the project. For instance, instead of assuming everyone uses GitHub, a template could be made for GitHub projects that creates the repo, creates a .gitignore, etc. If you use SVN on Google Code instead, a template could be used for that instead. Then you'd apply a second template to the project for the language(s) used, such as a cpp one. After that you might want to apply a particular editor or IDE's files in as another template. Finally, you might apply a template for working on a GPL project that'll include `LICENSE`, `AUTHORS`, etc. files with the GPL included in (or BSD, Apache, CC, Mozilla, your company's own license, etc). Templates in this design would have pre- and post-scripts. Right now, I'm sure this script could already be useful for people who work on code in a similar way as I do, but expanding it to reach the functionality I just mentioned would make it a very interesting and easy tool to use (though I'm sure I'm not the first to make it).

Contact Info
------------

You can contact me (Josh Taylor) via http://github.com/arcamugapy or taylor.joshua88 AT gmail.com
