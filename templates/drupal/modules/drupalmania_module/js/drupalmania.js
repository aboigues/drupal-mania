/**
 * @file
 * JavaScript pour le module Drupal Mania
 */

(function ($, Drupal) {
  'use strict';

  /**
   * Behavior pour le module Drupal Mania
   */
  Drupal.behaviors.drupalmaniaModule = {
    attach: function (context, settings) {
      // Initialiser le module
      $('.drupalmania-stats .stat-box', context).once('drupalmania-stats').each(function() {
        console.log('Drupal Mania stat box initialized');
      });

      // Animer les nombres du dashboard
      $('.stat-number', context).once('animate-number').each(function() {
        var $this = $(this);
        var countTo = parseInt($this.text());

        $({ countNum: 0 }).animate({
          countNum: countTo
        }, {
          duration: 2000,
          easing: 'swing',
          step: function() {
            $this.text(Math.floor(this.countNum));
          },
          complete: function() {
            $this.text(this.countNum);
          }
        });
      });
    }
  };

  /**
   * Fonction utilitaire pour logger des messages
   */
  Drupal.drupalmania = Drupal.drupalmania || {};
  Drupal.drupalmania.log = function(message) {
    if (console && console.log) {
      console.log('[Drupal Mania] ' + message);
    }
  };

})(jQuery, Drupal);
