local modkey = require('config.init').mod

local M = modkey
local C = 'Control'
local S = 'Shift'
local A = 'Mod1'


local m    = {M}           -- Modkey
local c    = {C}           -- Control
local s    = {S}           -- Shift
local a    = {A}           -- Alt
local mc   = {M, C}        -- Modkey + Control
local ms   = {M, S}        -- Modkey + Shift
local ma   = {M, A}        -- Modkey + Alt
local cs   = {C, S}        -- Control + Shift
local ca   = {C, A}        -- Control + Alt
local sa   = {S, A}        -- Shift + Alt
local mcs  = {M, C, S}     -- Modkey + Control + Shift
local mca  = {M, C, A}     -- Modkey + Control + Alt
local msa  = {M, S, A}     -- Modkey + Shift + Alt
local csa  = {C, S, A}     -- Control + Shift + Alt
local mcsa = {M, C, S, A}  -- Modkey + Control + Shift + Alt


return {
    m = m,
    c = c,
    s = s,
    a = a,
    mc = mc,
    ms = ms,
    ma = ma,
    cs = cs,
    ca = ca,
    sa = sa,
    mcs = mcs,
    mca = mca,
    msa = msa,
    csa = csa,
    mcsa = mcsa,
}
