# confluence2bluespice
Migration tool for converting a confluence export to a bluespice import file


# Where from?
In the blog post at the [bluespice webpage](https://bluespice.com/migration-from-confluence-to-bluespice-mediawiki/) was mentioned that there is a script available to convert the confluence export to a file that can be imported to bluespice. The repository is under [this](https://github.com/hallowelt/migrate-confluence) link. Since it is a little bit outdated it didn't run on my ubuntu 22.04 so I decided to create a docker container.

# How to run?
Go to your project folder with the following structure:
./project/input
./project/workspace

Run ```cd ./project```

Run ```docker run -it -v $PWD:/project davidsger/confluence2bluespice```

Now use the following commands to convert the files:

- Run ```migrate-confluence analyze --src input/ --dest workspace/``` to create "working files". After the script has run you can check those files and maybe apply changes if required (e.g. when applying structural changes).
- Run ```migrate-confluence extract --src input/ --dest workspace/``` to extract all contents, like wikipage contents, attachments and images into the workspace
- Run ```migrate-confluence convert --src workspace/ --dest workspace/``` (yes, --src workspace/ ) to convert the wikipage contents from Confluence Storage XML to MediaWiki WikiText
- Run ```migrate-confluence compose --src workspace/ --dest workspace/``` (yes, --src workspace/ ) to create importable data

If you re-run the scripts you will need to clean up the "workspace" directory!
