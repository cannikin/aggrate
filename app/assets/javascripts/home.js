$(document).ready(function() {

  var feedInputs = $('.menu input[type=checkbox]');

  // each time someone checks/unchecks a feed, update the location hash
  feedInputs.live('change', function() {
    // console.info('changed: ' + $(this).data('source-type') + ':' + this.id + ' ' + this.checked);
    createLocationHash();
  });


  // updates the URL
  var createLocationHash = function() {
    var enabledFeeds = {};
    feedInputs.each(function() {
      $this = $(this);
      var type = this.id.split('_')[0];
      var id = parseInt(this.id.split('_')[1]);

      if (this.checked) {
        if (enabledFeeds[type] === undefined) {
          enabledFeeds[type] = [];
        }
        enabledFeeds[type].push(id)
      };
    });

    // output enabledFeeds to URL hash
    var hash = []
    for(key in enabledFeeds) {
      hash.push(key + '=' + enabledFeeds[key].join(','));
    }
    location.hash = hash.join('&');

    // finally, update what's displayed in the feed
    updateFeed();
  }


  // update what shows in the feed based on values in the hash
  var updateFeed = function() {
    if (location.hash !== '') {
      var enabledFeeds = buildFeedFromHash();

      $('.entry').each(function() {
        var $this = $(this);
        var type = $this.data('source-type');
        var id = $this.data('source-id');
        if (enabledFeeds[type]) {
          if (enabledFeeds[type].indexOf(id) == -1) {
            $this.fadeOut();
          } else {
            $this.fadeIn();
          }
        } else {
          $this.fadeOut();
        }
      });
    }
  };


  // build a feed object from the location.hash
  var buildFeedFromHash = function() {
    var hash = location.hash.slice(1).split('&');
    var enabledFeeds = {};
    _.each(hash, function(item) {
      var key = item.split('=')[0];
      var value = item.split('=')[1];
      enabledFeeds[key] = [];
      _.each(value.split(','), function(item) {
        enabledFeeds[key].push(parseInt(item))
      });
    });
    return enabledFeeds;
  };


  var setCheckboxesFromEnabledFeeds = function() {
    if (location.hash !== '') {
      var enabledFeeds = buildFeedFromHash();
      feedInputs.each(function() {
        var $this = $(this);
        var type = this.id.split('_')[0];
        var id = parseInt(this.id.split('_')[1]);

        if (enabledFeeds[type]) {
          if (enabledFeeds[type].indexOf(id) == -1) {
            this.checked = false;
          } else {
          this.checked = true;
          }
        } else {
          this.checked = false;
        }
      });
    }
  }

  // update the feed list right away depending on what is in the hash when the page first loads
  updateFeed();
  setCheckboxesFromEnabledFeeds();

});
