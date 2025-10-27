/**
 * @file
 * Scripts JavaScript pour le thème Drupal Mania
 */

(function ($, Drupal) {
  'use strict';

  /**
   * Comportement pour initialiser le thème
   */
  Drupal.behaviors.drupalmaniaTheme = {
    attach: function (context, settings) {
      // Ajouter une classe au body une fois le DOM chargé
      $('body', context).once('drupalmania-init').addClass('theme-loaded');

      // Menu mobile toggle
      $('.menu-toggle', context).once('menu-toggle').click(function(e) {
        e.preventDefault();
        $(this).toggleClass('is-active');
        $('.primary-menu').toggleClass('is-open');
      });

      // Smooth scroll pour les ancres
      $('a[href*="#"]', context).once('smooth-scroll').click(function(e) {
        if (this.pathname === location.pathname && this.hash !== '') {
          e.preventDefault();
          var target = $(this.hash);
          if (target.length) {
            $('html, body').animate({
              scrollTop: target.offset().top - 80
            }, 500);
          }
        }
      });

      // Ajouter une classe aux éléments au scroll
      $(window).once('scroll-animations').scroll(function() {
        $('.fade-in-on-scroll').each(function() {
          var elementTop = $(this).offset().top;
          var viewportBottom = $(window).scrollTop() + $(window).height();

          if (viewportBottom > elementTop + 100) {
            $(this).addClass('is-visible');
          }
        });
      });

      // Console log pour le debug (à retirer en production)
      console.log('Drupal Mania Theme initialized');
    }
  };

  /**
   * Comportement pour les formulaires
   */
  Drupal.behaviors.drupalmaniaForms = {
    attach: function (context, settings) {
      // Ajouter des classes aux champs de formulaire en focus
      $('input, textarea', context).once('form-focus')
        .focus(function() {
          $(this).parent().addClass('is-focused');
        })
        .blur(function() {
          $(this).parent().removeClass('is-focused');
        });
    }
  };

})(jQuery, Drupal);
