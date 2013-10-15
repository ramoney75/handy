name "developer_workstation"
description "Standard developer workstation"
run_list(
  "recipe[basic]",
  "recipe[gnome]",
  "recipe[cp-developer]"
)
