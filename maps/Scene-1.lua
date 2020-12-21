return {
  version = "1.4",
  luaversion = "5.1",
  tiledversion = "2020.10.30",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 10,
  height = 10,
  tilewidth = 64,
  tileheight = 64,
  nextlayerid = 3,
  nextobjectid = 7,
  properties = {},
  tilesets = {
    {
      name = "tilesets",
      firstgid = 1,
      filename = "tilesets.tsx",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      columns = 14,
      image = "../res/platformPack_tilesheet.png",
      imagewidth = 896,
      imageheight = 448,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 64,
        height = 64
      },
      properties = {},
      terrains = {},
      wangsets = {},
      tilecount = 98,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      id = 1,
      name = "suelo",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 59, 59, 59, 0, 0, 0,
        73, 0, 0, 0, 73, 73, 0, 0, 0, 0,
        4, 4, 1, 1, 4, 4, 1, 1, 1, 1,
        18, 4, 4, 18, 4, 4, 4, 4, 18, 18,
        4, 18, 18, 18, 18, 18, 18, 18, 18, 19
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "solid",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["collidable"] = true
      },
      objects = {
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1.43337,
          y = 454.379,
          width = 634.983,
          height = 55.9014,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 265.174,
          y = 329.675,
          width = 170.571,
          height = 11.467,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
