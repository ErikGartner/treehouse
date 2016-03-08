# Treehouse
Treehouse is a playground / an open registry  for demoing and hosting of dTree graphs. Rather than having to build an entire app/site to try out a dTree graph feel free to use this site.

## Privacy and data safety
This site is free and open for everybody. No graph is private though only through ownership or an edit-link can an existing graph be edited.

Data is backuped daily though this site is _not_ intended for heavy production use. If your data is very sensitive host it yourself.

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
The stylesheet belong is simple and only intended to show an easy example of how what is possible.

### Custom renderer
When using dTree on your own site you have the possibility to to fully customize how the library renders the text and the node. For security purposes Treehouse allows for custom html templates using a handlebar template.
