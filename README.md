# Treehouse
Treehouse is a playground / an open registry for demoing, viewing and hosting of dTree graphs. Rather than having to build an entire app/site to try out a dTree graph feel free to use this site.

## dTree
[dTree](https://github.com/ErikGartner/dTree) is the open source graph library that powers this site. It is written by the Swedish computer engineering student [Erik Gärtner](https://gartner.io). It builds on top of D3 and works aims at being a simple yet extensive library for building family trees.

## How to create a graph
The best way to use Treehouse is to host your graph data in a [gist](https://gist.github.com). This has the benefits of _reliable data storage_ that is _version controlled_ and _editable_ anytime.

You just replace ```gist.github.com``` with ```treehouse.gartner.io``` in the gist url and shazam you are looking at your tree graph! Easy right?

The gist should have the following files:
- **data.json** *(required)*
- **stylesheet.css** *(required)*
- **readme.md**
- **renderer.handlebars**
- **.treehouse** - This file should contain just the version of dTree.

See [this](https://treehouse.gartner.io/ErikGartner/58e58be650453b6d49d7) example for more.

## Privacy
This site is free and open for everybody. _No_ graph is private though they are all unlisted.

### Data format
The library uses a simple JSON data format to represent the data. Checkout [this](https://treehouse.gartner.io/t/dtree-demo) example or the [GitHub](https://github.com/ErikGartner/dTree) page for more information.

```javascript
[{
  name: "Father",
  class: "overriding-css-class",
  textClass: "overriding-css-class",
  depthOffset: 1,
  marriages: [{
    spouse: {
      name: "Mother",
      class: "overriding-css-class"
    },
    children: [{
      name: "Child",
      class: "child-class"
    }]
  }],
  extra: {}
}]
```

### Stylesheet
A standard css stylesheet is used to style the graph. Specifically it should define how the edges (lines), nodes and text should look. Below is an example. dTree supports custom css classes for both the nodes and the text.

```css
.linage {
    fill: none;
    stroke: black;
}
.marriage {
    fill: none;
    stroke: black;
}
.node {
    background-color: lightblue;
    border-style: solid;
    border-width: 1px;
}
.nodeText{
    font: 10px sans-serif;
}
```

### Custom renderer
When using dTree on your own site you have the possibility to to fully customize how the library renders the text and the node. For security purposes Treehouse uses a custom text renderer that allows for handlebars template to format the node text. For added flexibility the renderer uses [Handlebars Helpers](https://github.com/helpers/handlebars-helpers).

To make the arbitrary HTML safer it is sanitized and allows the following HMTL:
```javascript
allowedTags: [ 'h3', 'h4', 'h5', 'h6', 'blockquote', 'p', 'a', 'ul', 'ol',
  'nl', 'li', 'b', 'i', 'strong', 'em', 'strike', 'code', 'hr', 'br', 'div',
  'table', 'thead', 'caption', 'tbody', 'tr', 'th', 'td', 'pre', 'iframe',
  'img', 'span'],

allowedAttributes: {
  a: ['href', 'name', 'target', 'class'],
  i: ['class'],
  div: ['class'],
  span: ['class'],
  img: ['src', 'class']
}
```

Example template:
```handlebars
<div>
  {{name}} - {{extra.age}}
</div>
```

## License
The MIT License (MIT)

Copyright (c) 2015-2019 Erik Gärtner
