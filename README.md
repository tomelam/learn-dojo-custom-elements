# learn-dojo-custom-elements

This project attempts to follow the
["Dojo Custom Elements
Guide"](https://dojo.io/learn/custom-elements/introduction),
and possibly fill in some gaps in it to constitute a quickstart example project.
It is believed to be accurate as of September 9, 2020,
but the guide will probably evolve quickly.
The guide is a bit hard to find on the [Dojo website](https://dojo.io/)
if the web browser's window width is less than about 1,130 pixels,
but increasing the browser width to more than about 1,130 pixels
causes the second-level navigation list to move from the top to the left side,
where the link to the guide is easy to notice.
The guide might not be a complete tutorial, but
be sure to visit all its subsections ("Introduction",
"Setting a Widget's Properties", "Custom Element Slots", and "Using Themes")
in the third-level navigation list at the top or right side of the page.
A discussion at
https://discord.com/channels/471607790213922816/471607790213922818/752980268930957422
might fill in some gaps.

Other documents that might help to learn how to work with
Dojo custom elements are:

1. https://dojo.io/learn/overview/components-of-a-dojo-application
2. https://github.com/dojo/cli-build-widget
3. https://dojo.io/learn/creating-widgets/introduction
Be sure to visit all the subsections ("Introduction", "Widget fundamentals",
"Rendering widgets", "Configuring widgets through properties",
"Enabling interactivity", "Managing state", and "Best practice development")
of the "creating Widgets Guide" in the third-level navigation list
at the top or right of the page.
4. https://dojo.io/blog/version-7-dojo
5. https://next.dojo.io/blog/version-7-dojo
6. https://dojo.io/blog/version-7-dojo-widgets
7. https://dojo.io/blog/version-6-dojo
8. https://github.com/dojo/cli

## Create a Dojo widget library scaffold

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
Here is the "scripts" section of `package.json` created by running
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
However, in this project Anthony Gubler's advice to call
`npm run <script-name>` is followed, which anyway calls `dojo create widget`
if called as `npm run build`.

## A quickstart to creating a widget-project scaffold and building an example widget

Follow these steps in the current directory:

1. Run `check-tools.sh` in the current directory to check whether Node,
`@dojo/cli-create-widget`, and `typescript` have been installed so
that they can be used in the project.

2. Run `create.sh` in the current directory to create
a Dojo widget template using the command
`dojo create widget --name learn`.
The command will create a widget template for the building of a Button widget.
The output code can be used as a template to help programmers write
other widgets.

4. Run `build.sh` to compile the widget into a custom element.
The directory `output` will be created under the project's main directory.

5. Create a web page using the custom element.
In this directory, the file `button-example.html` uses the `learn` widget
as a custom element.

## Use the scaffold for a new widget

This example attempts to follow the ["Dojo Custom Elements
Guide"](https://dojo.io/learn/custom-elements/introduction),
but it doesn't work.

### Use the scaffold for a new widget - write the HTML

Create a file `index.html` in the directory `src` in the project directory.
Let its content be
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

## Use the scaffold for a new widget - write the widget

Create the file `Hero.tsx` in the directory `src/widgets`,
in the project directory, where the `.dojorc` file will also be put.
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

### Use the scaffold for a new widget - check the configuration

After following the quickstart steps above,
edit the configuration file, `learn/.dojorc`
to set it up for building the widget as a custom element.
It should contain the stanza
```
"build-widget": {
    "prefix": "ref",
    "widgets": ["src/widgets/Hero"]
}
```
