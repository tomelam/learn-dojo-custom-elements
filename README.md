# learn-dojo-custom-elements

This project attempts to follow the
["Dojo Custom Elements
Guide"](https://dojo.io/learn/custom-elements/introduction).
That document might not be a complete tutorial.
See the discussion at
https://discord.com/channels/471607790213922816/471607790213922818/752980268930957422 .
Other documents that might help are:

1. https://dojo.io/learn/overview/components-of-a-dojo-application
2. https://github.com/dojo/cli-build-widget
3. https://dojo.io/learn/creating-widgets/introduction Be sure to visit all the subsections ("Widget fundamentals, Rendering widgets, Configuring widgets through properties, Enabling interactivity, Managing state, Best practic development)
of the "creating Widgets Guide" in the third-level navigation list at the top or right of the page.
4. https://dojo.io/blog/version-7-dojo
5. https://next.dojo.io/blog/version-7-dojo
6. https://dojo.io/blog/version-7-dojo-widgets
7. https://dojo.io/blog/version-6-dojo
8. https://github.com/dojo/cli

## Create a widget library scaffold

The "Building Custom Elements" section in the
["Dojo Custom Elements
Guide"](https://dojo.io/learn/custom-elements/introduction)
says "Dojo widgets can be built as custom elements
using the `@dojo/cli-build-widget` command,"
but does not say how to create a Dojo widget.
Anthony Gubler (@agluber on
[the Dojo channel on Discord](https://discord.com/channels/471607790213922816/471607790213922818);
[agubler](https://github.com/agubler) on Github)
suggested creating a widget library scaffold as follows:
```  npm i -g cli-create-widget
  dojo create widget --name my-widget-lib
```
He said "At that point you should [have] a skeleton project
that you can build widgets from using the scripts defined in the package json.
These scripts are run by calling npm run followed by the script name."
Here is the "scripts" section of package.json created by running
`dojo create widget --name my-widget-lib`:
```
"scripts": {
	"dev": "dojo build app -m dev -w -s",
	"build": "npm-run-all -s clean build:**",
	"build:prepare": "shx mkdir .temp-dist",
	"build:ce": "dojo build widget && shx cp -r output/dist .temp-dist/",
	"build:lib": "dojo build widget -t lib && shx cp -r output/dist/** .temp-dist",
	"build:lib:legacy": "dojo build widget -t lib -l && shx cp -r output/dist/** .temp-dist",
	"build:themes": "dojo build theme && shx cp -r output/theme/* .temp-dist/theme",
	"build:meta": "shx cp package.json .temp-dist && shx cp README.md .temp-dist",
	"build:finalize": "shx rm -rf output/dist && shx mv .temp-dist/ output/dist",
	"clean": "shx rm -rf .temp-dist",
	"docs": "dojo build app -f docs=true",
	"test": "dojo test",
	"test:headless": "dojo build widget -m unit && dojo test -u -c headless"
},
```


The ["Dojo Creating Widgets
Guide"](https://dojo.io/learn/creating-widgets/introduction)
does not mention how to use the command `dojo create widget`,
but gives a link to the CLI command module
[@dojo/cli-create-widget](https://github.com/dojo/cli-create-widget),
which holds the code and documentation for the `dojo create widget` command.

## A quickstart to building Dojo custom elements

Each of the following scripts in the current directory checks prerequisite
setup and, if the setup has been done, executes a command from the
"Dojo Building Guide" or notifies the user about the setup.
They are meant to be executed in the order given here.

1. `check-tools.sh` in the current project checks whether Node,
`@dojo/cli-create-app`, and `typescript` have been installed so
that they can be used in the project.

2. `build.sh` initializes the current project using the command
`dojo create widget --name learn-dojo-custom-elements`.

3. `build-dist.sh` creates an application bundle and outputs the results
to the `output/dist` directory.

4. `serve-and-watch.sh` starts a web server on port 9999 and makes Dojo's
build tool rebuild the application whenever when the application's
source files change.

5. `test.sh` runs the application's unit and functional tests.

dojo create widget --name hero-widget-lib

## Create the HTML

The file `index.html` was created and put into the directory `src`,
guessed from copying the location of the working application example
https://github.com/tomelam/learn-dojo-custom-elements .
Its content is
```
<html>
  <head>
    <link rel="stylesheet" href="ref-hero.css">
  </head>
  <body>
    <script async src="ref-hero.js"></script>
  </body>
</html>
```

## Create the widget

The file `Hero.tsx` was created and put into the directory `src/widgets`,
relative to the current directory, where the `.dojorc` file will also be put.
Its content is
```
import { create, tsx } from '@dojo/framework/core/vdom';
import * as css from './styles/Hero.m.css';

export interface HeroProperties {
    title: string;
    image: string;
}

const factory = create().properties<HeroProperties>();
export default factory(function Hero({ properties }) {
    const { title, image } = properties();

    return (
        <div classes={css.hero}>
            <img classes={css.image} src={image} />
            <h1 classes={css.title}>{title}</h1>
        </div>
    );
});
```

## Configure the building of the widget as a custom element

The file `.dojorc` was created and put into the current directory.
Its content is
```
{
    "build-widget": {
        "prefix": "ref",
        "widgets": ["src/widgets/Hero"]
    }
}
```
