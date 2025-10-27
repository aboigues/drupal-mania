<?php

namespace Drupal\drupalmania_module\Controller;

use Drupal\Core\Controller\ControllerBase;

/**
 * Controller pour les pages personnalisées de Drupal Mania.
 */
class DrupalManiaController extends ControllerBase {

  /**
   * Page Hello.
   *
   * @return array
   *   Render array pour la page hello.
   */
  public function hello() {
    return [
      '#type' => 'markup',
      '#markup' => $this->t('<h2>Hello from Drupal Mania!</h2><p>Ceci est une page personnalisée créée par le module Drupal Mania.</p>'),
    ];
  }

  /**
   * Dashboard personnalisé.
   *
   * @return array
   *   Render array pour le dashboard.
   */
  public function dashboard() {
    // Récupérer des statistiques
    $node_storage = \Drupal::entityTypeManager()->getStorage('node');
    $query = $node_storage->getQuery()
      ->accessCheck(TRUE)
      ->count();
    $total_nodes = $query->execute();

    $user_storage = \Drupal::entityTypeManager()->getStorage('user');
    $query = $user_storage->getQuery()
      ->accessCheck(TRUE)
      ->count();
    $total_users = $query->execute();

    $build = [];

    $build['intro'] = [
      '#type' => 'markup',
      '#markup' => '<h2>' . $this->t('Drupal Mania Dashboard') . '</h2>',
    ];

    $build['stats'] = [
      '#type' => 'container',
      '#attributes' => ['class' => ['drupalmania-stats']],
    ];

    $build['stats']['nodes'] = [
      '#type' => 'markup',
      '#markup' => '<div class="stat-box"><h3>' . $this->t('Total Content') . '</h3><p class="stat-number">' . $total_nodes . '</p></div>',
    ];

    $build['stats']['users'] = [
      '#type' => 'markup',
      '#markup' => '<div class="stat-box"><h3>' . $this->t('Total Users') . '</h3><p class="stat-number">' . $total_users . '</p></div>',
    ];

    $build['#attached']['library'][] = 'drupalmania_module/drupalmania-library';

    return $build;
  }

}
