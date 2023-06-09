module "front_door_waf_policies" {
  source              = "./modules/networking/front_door_waf_policy"
  for_each            = local.networking.front_door_waf_policies
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags : {}
  global_settings     = local.global_settings
  settings            = each.value

}

output "front_door_waf_policies" {
  value = module.front_door_waf_policies

}