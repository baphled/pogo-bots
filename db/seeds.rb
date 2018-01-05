require_relative '../lib/team_colour_matrix/models/rgb_list'
require_relative '../lib/team_colour_matrix'

require 'active_model'

TeamColourMatrix::Models::RgbList.create(team: 'Instinct', r:90,  g:72,  b:0)
TeamColourMatrix::Models::RgbList.create(team: 'Instinct', r:91,  g:73,  b:0)
TeamColourMatrix::Models::RgbList.create(team: 'Instinct', r:153, g:122, b:0)
TeamColourMatrix::Models::RgbList.create(team: 'Instinct', r:246, g:202, b:69)
TeamColourMatrix::Models::RgbList.create(team: 'Instinct', r:255, g:200, b:5)
TeamColourMatrix::Models::RgbList.create(team: 'Instinct', r:250, g:200, b:5)

TeamColourMatrix::Models::RgbList.create({team: 'Valor', r: 89, g:0,  b:17})   
TeamColourMatrix::Models::RgbList.create({team: 'Valor', r: 90, g:0,  b:18})
TeamColourMatrix::Models::RgbList.create({team: 'Valor', r: 151,g:1,  b:30})  
TeamColourMatrix::Models::RgbList.create({team: 'Valor', r: 153,g:0,  b:30})  
TeamColourMatrix::Models::RgbList.create({team: 'Valor', r: 153,g:0,  b:31})  
TeamColourMatrix::Models::RgbList.create({team: 'Valor', r: 255,g:9,  b:49})  
TeamColourMatrix::Models::RgbList.create({team: 'Valor', r: 255,g:9,  b:50}) 
TeamColourMatrix::Models::RgbList.create({team: 'Valor', r: 234,g:53, b:60})

TeamColourMatrix::Models::RgbList.create(team: 'Mystic', r: 0,  g:42,  b:84)
TeamColourMatrix::Models::RgbList.create(team: 'Mystic', r: 0,  g:71,  b:142)
TeamColourMatrix::Models::RgbList.create(team: 'Mystic', r: 0,  g:71,  b:143)
TeamColourMatrix::Models::RgbList.create(team: 'Mystic', r: 1,  g:71,  b:143)
TeamColourMatrix::Models::RgbList.create(team: 'Mystic', r: 0,  g:119, b:237)
TeamColourMatrix::Models::RgbList.create(team: 'Mystic', r: 0,  g:119, b:238)
TeamColourMatrix::Models::RgbList.create(team: 'Mystic', r: 1,  g:120, b:238)
TeamColourMatrix::Models::RgbList.create(team: 'Mystic', r: 2,  g:116, b:241)
TeamColourMatrix::Models::RgbList.create(team: 'Mystic', r: 50, g:114, b:233)
TeamColourMatrix::Models::RgbList.create(team: 'Mystic', r: 2, g:116, b:241)
