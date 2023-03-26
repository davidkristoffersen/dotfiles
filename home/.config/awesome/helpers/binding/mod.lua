local modkey = require('config.vars').mod

local M = modkey
local C = 'Control'
local S = 'Shift'
local A = 'Mod1'


local m    = {M}
local c    = {C}
local s    = {S}
local a    = {A}
local mc   = {M, C}
local ms   = {M, S}
local ma   = {M, A}
local cs   = {C, S}
local ca   = {C, A}
local sa   = {S, A}
local mcs  = {M, C, S}
local mca  = {M, C, A}
local msa  = {M, S, A}
local csa  = {C, S, A}
local mcsa = {M, C, S, A}


return {
    m    = m,    -- Modkey
    c    = c,    -- Control
    s    = s,    -- Shift
    a    = a,    -- Alt
    mc   = mc,   -- Modkey + Control
    ms   = ms,   -- Modkey + Shift
    ma   = ma,   -- Modkey + Alt
    cs   = cs,   -- Control + Shift
    ca   = ca,   -- Control + Alt
    sa   = sa,   -- Shift + Alt
    mcs  = mcs,  -- Modkey + Control + Shift
    mca  = mca,  -- Modkey + Control + Alt
    msa  = msa,  -- Modkey + Shift + Alt
    csa  = csa,  -- Control + Shift + Alt
    mcsa = mcsa, -- Modkey + Control + Shift + Alt
}
