exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: {
        "js/app.js": /^(assets\/js)|(assets\/node_modules)/,
        "js/ex_admin_common.js": ["assets/vendor/ex_admin_common.js"],
        "js/admin_lte2.js": ["assets/vendor/admin_lte2.js"],
        "js/jquery.min.js": ["assets/vendor/jquery.min.js"]
      }
      // To use a separate vendor.js bundle, specify two files path
      // http://brunch.io/docs/config#-files-
      // joinTo: {
      //  "js/app.js": /^(assets\/js)/,
      //  "js/vendor.js": /^(assets\/vendor)|(deps)/
      // }
      //
      // To change the order of concatenation of files, explicitly mention here
      // order: {
      //   before: [
      //     "assets/vendor/js/jquery-2.1.1.js",
      //     "assets/vendor/js/bootstrap.min.js"
      //   ]
      // }
    },
    stylesheets: {
      joinTo: {
        "css/app.css": /^(assets\/css)/,
        "css/admin_lte2.css": ["assets/vendor/admin_lte2.css"],
        "css/active_admin.css.css": ["assets/vendor/active_admin.css.css"],
      },
      order: {
        after: ["assets/css/app.css"] // concat app.css last
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
     watched: ["static", "css", "js", "vendor"],

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
      "js/app.js": ["/js/app"]
    }
  },

  npm: {
    enabled: true
  }
};
