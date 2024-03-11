abstract interface class EntityMapper<Entity, Model> {
  Model fromEntity(Entity entity);

  Entity toEntity(Model model);
}
