local circuitconnectors = require "prototypes.entity.circuitconnectors"
local pictures = require "prototypes.entity.pictures"

data:extend {
  -- buildable entity, immediately replaced by scripting
  {
    type = "pump",
    name = "railloader-placement-proxy",
    icon = "__base__/graphics/icons/rail.png",
    icon_size = 32,
    minable = { mining_time = 0.1, result = "railloader" },
    flags = { "player-creation", "placeable-neutral" },
    max_health = 800,
    collision_box = { { -1.8, -1.8 }, { 1.8, 1.8 } },
    selection_box = { { -1.8, -1.8 }, { 1.8, 1.8 } },
    fluid_box = {
      pipe_connections = {},
    },
    energy_usage = "0kW",
    energy_source = {
      type = "void",
    },
    pumping_speed = 0,
    animations = pictures.railloader_proxy_animations,
    circuit_wire_connection_points = circuitconnectors["railloader-placement-proxy"].points,
    circuit_connector_sprites = circuitconnectors["railloader-placement-proxy"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance + 1.5,
  },

  -- decorative entities to show structure above train
  {
    type = "simple-entity",
    name = "railloader-structure-horizontal",
    icon = "__base__/graphics/icons/steel-chest.png",
    icon_size = 32,
    flags = {},
    collision_mask = {},
    render_layer = "higher-object-under",
    picture = pictures.railloader_structure_horizontal,
  },
  {
    type = "simple-entity",
    name = "railloader-structure-vertical",
    icon = "__base__/graphics/icons/steel-chest.png",
    icon_size = 32,
    flags = {},
    collision_mask = {},
    render_layer = "higher-object-under",
    picture = pictures.railloader_structure_vertical,
  },

  {
    type = "inserter",
    name = "railloader-inserter",
    icon = "__railloader-MXO__/graphics/icons/railloader.png",
    icon_size = 32,
    flags = { "hide-alt-info" },
    collision_box = { { -1, -1 }, { 1, 1 } },
    collision_mask = {},
    stack = true,
    max_health = 800,
    filter_count = 5,
    energy_per_movement = "4kJ",
    energy_per_rotation = "4kJ",
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      drain = "5kW",
    },
    extension_speed = 1,
    rotation_speed = 1,
    pickup_position = { 1.5, 1.5 },
    insert_position = { 0.5, 2.3 },
    draw_held_item = false,
    platform_picture = { sheet = pictures.empty_sheet },
    hand_base_picture = pictures.empty_sheet,
    hand_open_picture = pictures.empty_sheet,
    hand_closed_picture = pictures.empty_sheet,
    -- circuit_wire_connection_points = circuitconnectors["railloader-inserter"].points,
    -- circuit_connector_sprites = circuitconnectors["railloader-inserter"].sprites,
    circuit_wire_max_distance = 0.5,
    draw_circuit_wires = false,
    allow_custom_vectors = true
  },

  -- interactable inventory
  {
    type = "container",
    name = "railloader-chest",
    icon = "__railloader-MXO__/graphics/icons/railloader.png",
    icon_size = 32,
    flags = { "player-creation" },
    minable = { mining_time = 0.5, result = "railloader" },
    placeable_by = { item = "railloader", count = 1 },
    max_health = 800,
    corpse = "big-remnants",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume = 0.65 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7 },
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    collision_box = { { -2, -2 }, { 2, 2 } },
    selection_box = { { -2, -2 }, { 2, 2 } },
    collision_mask = { "item-layer", "object-layer", "water-tile" },
    selection_priority = 255,
    fast_replaceable_group = "railloader",
    inventory_size = settings.startup["railloader-capacity"].value,
    vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    picture = pictures.empty_sheet,
    -- circuit_wire_connection_point = circuit_connector_definitions["chest"].points,
    -- circuit_connector_sprites = circuit_connector_definitions["chest"].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance
  },
}

local univ = util.table.deepcopy(data.raw["inserter"]["railloader-inserter"])
univ.name = "railloader-universal-inserter"
univ.localised_name = { "entity-name.railloader-inserter" }
univ.filter_count = nil
data:extend { univ }

local interface_inserter = util.table.deepcopy(univ)
interface_inserter.name = "railloader-interface-inserter"
interface_inserter.allow_custom_vectors = true
data:extend { interface_inserter }
