<?php

class User extends Model
{
  protected static $tableName = "users";
  protected static $columns = [
    "id",
    "name",
    "password",
    "email",
    "start_date",
    "end_date",
    "role",
  ];

  public function insert()
  {
    $this->validate();
    if (!$this->end_date)
      $this->end_date = null;
    $this->password = password_hash($this->password, PASSWORD_DEFAULT);
    return parent::insert();
  }

  public function update()
  {
    $this->validate();
    if (!$this->end_date)
      $this->end_date = null;
    $this->password = password_hash($this->password, PASSWORD_DEFAULT);
    return parent::update();
  }

  public static function getUsersByType()
  {
    $query = "SELECT id, name FROM " . static::$tableName . " WHERE role = 'imobiliaria'";

    $result = Database::getResultFromQuery($query);

    $registries = [];

    if ($result) {
      while ($row = $result->fetch_assoc()) {
        $registries[] = $row;
      }
    }

    return $registries;
  }

  private function validate()
  {
    $errors = [];

    if (!$this->name) {
      $errors['name'] = 'Nome é um campo abrigatório.';
    }

    if (!$this->email) {
      $errors['email'] = 'Email é um campo abrigatório.';
    } elseif (!filter_var($this->email, FILTER_VALIDATE_EMAIL)) {
      $errors['email'] = 'Email inválido.';
    }

    if (!$this->start_date) {
      $errors['start_date'] = 'Data de admissão é um campo abrigatório.';
    } elseif (!DateTime::createFromFormat('Y-m-d', $this->start_date)) {
      $errors['start_date'] = 'Data de admissão deve seguir o padrão dd/mm/aaaa.';
    }

    if ($this->end_date && !DateTime::createFromFormat('Y-m-d', $this->end_date)) {
      $errors['end_date'] = 'Data de desligamento deve seguir o padrão dd/mm/aaaa.';
    }

    if (!$this->password) {
      $errors['password'] = 'Senha é um campo abrigatório.';
    }

    if (!$this->confirm_password) {
      $errors['confirm_password'] = 'Confirmação de Senha é um campo abrigatório.';
    }

    if (
      $this->password && $this->confirm_password
      && $this->password !== $this->confirm_password
    ) {
      $errors['password'] = 'As senhas não são iguais.';
      $errors['confirm_password'] = 'As senhas não são iguais.';
    }

    if (!$this->role) {
      $errors['role'] = 'Permissão do usuário é um campo obrigatório.';
    } elseif (!in_array($this->role, ['admin', 'locatario', 'imobiliaria'])) {
      $errors['role'] = 'Permissão do usuário inválida.';
    }

    if (count($errors) > 0) {
      throw new ValidationException($errors);
    }
  }
}
