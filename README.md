# learn-dojo-custom-elements

This project attemps to follow the "Dojo Custom Elements Guide" at
https://dojo.io/learn/custom-elements/introduction .

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
