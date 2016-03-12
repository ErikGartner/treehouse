# Treehouse
Treehouse is a playground / an open registry for demoing, viewing and hosting of dTree graphs. Rather than having to build an entire app/site to try out a dTree graph feel free to use this site.

## Privacy and data safety
This site is free and open for everybody. No graph is private though only through ownership or an edit-link can an existing graph be edited.

Data is backuped daily though this site is _not_ intended for heavy production use. If your data is very sensitive host it yourself.

### Gist-hosted data
A third option is to host your data on a public [gist](https://gist.github.com). It has the benefit of _reliable data storage_ that is _version controlled_. Your graph is then accessible from ```https://treehouse.gartner.io/g/<GIST_ID>```.

The gist should have the following files:
- data.json *Required*
- stylesheet.css *Required*
- readme.md
- renderer.handlebars

See [this](https://treehouse.gartner.io/g/58e58be650453b6d49d7) example for more.

## dTree
[dTree](https://github.com/ErikGartner/dTree) is the open source graph library that powers this site. It is written by the Swedish computer engineering student [Erik Gärtner](https://gartner.io). It builds on top of D3 and works aims at being a simple yet extensive library for building family trees.

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
When using dTree on your own site you have the possibility to to fully customize how the library renders the text and the node. For security purposes Treehouse uses a custom text renderer that allows for handlebars template to format the node text.
