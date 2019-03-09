import handlebars from 'handlebars';
import registerHelpers from 'handlebars-helpers';
import sanitizeHtml from 'sanitize-html';
import _ from 'lodash';
window._ = _;

// Setup all helpers
registerHelpers();

var dTreeOptions, handlebarsRenderer;

handlebarsRenderer = function(name, extra, textClass) {
  var clean, context, html, renderFunction, view;
  context = {
    name: name,
    extra: extra,
    textClass: textClass
  };
  renderFunction = handlebars.compile(this.data.textTemplate);
  html = renderFunction(context);
  clean = sanitizeHtml(html, {
    allowedTags: [ 'h3', 'h4', 'h5', 'h6', 'blockquote', 'p', 'a', 'ul', 'ol',
      'nl', 'li', 'b', 'i', 'strong', 'em', 'strike', 'code', 'hr', 'br', 'div',
      'table', 'thead', 'caption', 'tbody', 'tr', 'th', 'td', 'pre', 'iframe',
      'img', 'span'],
    allowedAttributes: {
      a: ['href', 'name', 'target', 'class'],
      i: ['class'],
      div: ['align', 'class', 'style'],
      span: ['align', 'class', 'style'],
      img: ['src', 'class'],
      p: ['align', 'class', 'style']
    },
    selfClosing: [ 'img', 'br', 'hr', 'area', 'base', 'basefont', 'input', 'link', 'meta' ],
    allowedSchemes: [ 'http', 'https', 'ftp', 'mailto' ],
    allowedSchemesByTag: {},
    allowedSchemesAppliedToAttributes: [ 'href', 'src', 'cite' ],
    allowProtocolRelative: true
  });
  html = '<p align="center" class="' + textClass + '">' + clean + '</p>';
  return html;
};

dTreeOptions = {
  debug: false,
  margin: {
    top: 0,
    right: 0,
    bottom: 0,
    left: 0
  },
  nodeWidth: 125,
  styles: {
    node: 'node',
    linage: 'linage',
    marriage: 'marriage',
    text: 'nodeText'
  }
};

Template.viewer.onRendered(function() {
  return this.autorun((function(_this) {
    return function(comp) {
      var data, json;
      data = Template.currentData();
      document.title = data.owner + "/" + data.name + " - Treehouse";
      json = JSON.parse(data.data);
      dTreeOptions.width = $('#graph').width();
      dTreeOptions.height = window.screen.height * 0.7;
      dTreeOptions.target = '#graph';
      if ((data.textTemplate != null) && data.textTemplate !== '') {
        dTreeOptions.callbacks = {
          textRenderer: _.bind(handlebarsRenderer, _this)
        };
      }
      dTree.init(json, dTreeOptions);
      return $('svg').attr('width', '100%');
    };
  })(this));
});

Template.fullscreenViewer.onRendered(function() {
  return this.autorun((function(_this) {
    return function(comp) {
      var data, json;
      data = Template.currentData();
      document.title = data.owner + "/" + data.name + " - Treehouse";
      json = JSON.parse(data.data);
      dTreeOptions.width = window.screen.width;
      dTreeOptions.height = window.screen.height;
      dTreeOptions.target = '#fullscreen-graph';
      if ((data.textTemplate != null) && data.textTemplate !== '') {
        dTreeOptions.callbacks = {
          textRenderer: _.bind(handlebarsRenderer, _this)
        };
      }
      dTree.init(json, dTreeOptions);
      $('svg').attr('width', '100vw');
      return $('svg').attr('height', '100vh');
    };
  })(this));
});

Template.gistViewer.onRendered(function() {
  Session.set('gistData', void 0);
  return getGist(this.data.gist, function(err, res) {
    if (err != null) {
      console.log(err);
      return Session.set('gistErr', err);
    }
    return Session.set('gistData', res);
  });
});

Template.gistFullscreenViewer.onRendered(function() {
  Session.set('gistData', void 0);
  return getGist(this.data.gist, function(err, res) {
    if (err != null) {
      console.log(err);
      return Session.set('gistErr', err);
    }
    return Session.set('gistData', res);
  });
});

Template.viewer.helpers({
  compiledDescription: function() {
    return marked(this.description);
  },
  hlStyle: function() {
    return hljs.highlight('css', this.stylesheet).value;
  },
  hlTemplate: function() {
    return hljs.highlight('html', this.textTemplate).value;
  },
  hlData: function() {
    return hljs.highlight('json', this.data).value;
  },
  editKey: function() {
    if (this.writekey != null) {
      return this.writekey;
    } else {
      return Router.current().params.key;
    }
  },
  readLink: function() {
    if (this.gist != null) {
      return Router.routes['tree.view.gist'].url({
        gist: this.gist.id
      });
    } else {
      return Router.routes['tree.view.guest'].url({
        slug: this.slug
      });
    }
  },
  fullscreenLink: function() {
    if (this.gist != null) {
      return Router.routes['tree.view.fullscreenGist'].url({
        gist: this.gist.id
      });
    } else {
      return Router.routes['tree.view.fullscreenViewer'].url({
        slug: this.slug
      });
    }
  }
});

Template.gistViewer.helpers({
  gistData: function() {
    return Session.get('gistData');
  },
  gistErr: function() {
    return Session.get('gistErr');
  }
});

Template.gistFullscreenViewer.helpers({
  gistData: function() {
    return Session.get('gistData');
  },
  gistErr: function() {
    return Session.get('gistErr');
  }
});

Template.loading.helpers({
  gistSource: function() {
    return this.gist;
  }
});

Template.error.helpers({
  gistSource: function() {
    return this.gist;
  }
});

Template.viewer.events({
  'click #shareButton': function(event) {
    return $('#sharemodal').modal('show');
  }
});

// ---
// generated by coffee-script 1.9.2
