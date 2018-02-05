exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: {
        "js/app.js": /^(js)|(node_modules)/,
        "js/ex_admin_common.js": ["vendor/ex_admin_common.js"],
        "js/admin_lte2.js": ["vendor/admin_lte2.js"],
        "js/jquery.min.js": ["vendor/jquery.min.js"],
        "js/semantic.js": ["vendor/yarn/semantic-ui/dist/semantic.js"]
      },
      // To change the order of concatenation of files, explicitly mention here
      // https://github.com/brunch/brunch/tree/master/docs#concatenation
     order: {
        before: ["vendor/jquery.min.js"]
      }
    },
    stylesheets: {
      joinTo: {
        "css/app.css": /^(css|sass)/,
        "css/admin_lte2.css": ["vendor/admin_lte2.css"],
        "css/active_admin.css.css": ["vendor/active_admin.css.css"],
        "css/semantic.css": ["vendor/yarn/semantic-ui/dist/semantic.css"]
      },
      order: {
        after: ["css/app.css"] // concat app.css last
      }
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/assets/static". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ["static", "css", "js", "vendor", "sass"],
    // Where to compile files to
    public: "../priv/static"
  },

  // Configure your plugins
  plugins: {
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/vendor/]
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["js/app"]
    }
  },

  npm: {
    enabled: true
  }
};
