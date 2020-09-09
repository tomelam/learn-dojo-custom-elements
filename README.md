# learn-dojo-custom-elements

This project attemps to follow the "Dojo Custom Elements Guide" at
https://dojo.io/learn/custom-elements/introduction .
That document might not be a complete introduction.
See the discussion at
https://discord.com/channels/471607790213922816/471607790213922818/752980268930957422 .
Other documents that might help are:

1. https://github.com/dojo/cli-build-widget
2. https://dojo.io/learn/creating-widgets/introduction
3. https://dojo.io/blog/version-7-dojo
4. https://next.dojo.io/blog/version-7-dojo

## Create a scaffold skeleton widget library

The section "Building Custom Elements" in the "Dojo Custom Elements Guide"
says "Dojo widgets can be built as custom elements
using the `@dojo/cli-build-widget` command,"
but does not say how to create a Dojo widget.
Antody Gluber (@agluber on
[the Dojo channel on Discord](https://discord.com/channels/471607790213922816/471607790213922818); https://github.com/agubler)
suggested creating a scaffold skeleton widget library as follows:
``  npm i -g cli-create-widget
  dojo create widget --name <widgetName>
```

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
