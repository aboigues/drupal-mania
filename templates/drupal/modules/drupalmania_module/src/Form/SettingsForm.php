<?php

namespace Drupal\drupalmania_module\Form;

use Drupal\Core\Form\ConfigFormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Configuration form pour Drupal Mania.
 */
class SettingsForm extends ConfigFormBase {

  /**
   * {@inheritdoc}
   */
  public function getFormId() {
    return 'drupalmania_module_settings';
  }

  /**
   * {@inheritdoc}
   */
  protected function getEditableConfigNames() {
    return ['drupalmania_module.settings'];
  }

  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state) {
    $config = $this->config('drupalmania_module.settings');

    $form['site_message'] = [
      '#type' => 'textarea',
      '#title' => $this->t('Site Message'),
      '#description' => $this->t('Message à afficher sur le site.'),
      '#default_value' => $config->get('site_message'),
    ];

    $form['enable_features'] = [
      '#type' => 'checkbox',
      '#title' => $this->t('Enable custom features'),
      '#description' => $this->t('Activer les fonctionnalités personnalisées.'),
      '#default_value' => $config->get('enable_features'),
    ];

    $form['api_key'] = [
      '#type' => 'textfield',
      '#title' => $this->t('API Key'),
      '#description' => $this->t('Clé API pour les intégrations externes.'),
      '#default_value' => $config->get('api_key'),
    ];

    $form['items_per_page'] = [
      '#type' => 'number',
      '#title' => $this->t('Items per page'),
      '#description' => $this->t('Nombre d\'éléments à afficher par page.'),
      '#default_value' => $config->get('items_per_page') ?? 10,
      '#min' => 1,
      '#max' => 100,
    ];

    return parent::buildForm($form, $form_state);
  }

  /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state) {
    $this->config('drupalmania_module.settings')
      ->set('site_message', $form_state->getValue('site_message'))
      ->set('enable_features', $form_state->getValue('enable_features'))
      ->set('api_key', $form_state->getValue('api_key'))
      ->set('items_per_page', $form_state->getValue('items_per_page'))
      ->save();

    parent::submitForm($form, $form_state);
  }

}
