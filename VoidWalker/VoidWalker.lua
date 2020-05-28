--[[
Copyright © 2020, Garyfromwork of Asura
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of DistancePlus nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Sammeh BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

_addon.name = 'VoidWalker'
_addon.author = 'Garyfromwork'
_addon.version = '1.1.0.0'
_addon.command = 'vw'

require('tables')

res = require 'resources'
config = require('config')
texts = require('texts')

defaults = {}
defaults.main = {}
defaults.main.pos = {}
defaults.main.pos.x = -178
defaults.main.pos.y = 21
defaults.main.text = {}
defaults.main.text.font = 'Arial'
defaults.main.text.size = 14
defaults.main.flags = {}
defaults.main.flags.right = true

defaults.marktxt = {}
defaults.marktxt.pos = {}
defaults.marktxt.pos.x = -238
defaults.marktxt.pos.y = 21
defaults.marktxt.text = {}
defaults.marktxt.text.font = 'Arial'
defaults.marktxt.text.size = 14
defaults.marktxt.flags = {}
defaults.marktxt.flags.right = true

settings = config.load(defaults)
mark = texts.new('Marker Distance ${value||%.2f}', settings.marktxt)

voidwalker_mode = true

windower.register_event('status change', function(new, old)
    local s = windower.ffxi.get_mob_by_target('me')
    if new == 33 then --resting
        marker = s
    end
end)

windower.register_event('zone change', function()
    marker = nil
    mark.value = '0.00'
end)

windower.register_event('prerender', function()
    local s = windower.ffxi.get_mob_by_target('me')

    if s then
        if voidwalker_mode == true  then
            if (marker ~= nil) then 
                local x = math.abs(marker.x - s.x)
                local y = math.abs(marker.y - s.y)
                local z = math.abs(marker.z - s.z)
                x = (x*x)
                y = (y*y)
                z = (z*z)
                mark.value = math.sqrt(x + y + z)
            else
                mark.value = '0.00'
            end
        end      
    end
     if voidwalker_mode == true then
        mark:visible(s ~= nil)
     end
end)

windower.register_event('addon command', function(command)
    if command:lower() == 'help' then
        windower.add_to_chat(8,'VoidWalker: //VW <command>:')
        windower.add_to_chat(8,' On, Off (Not case sensitive')
    elseif command:lower() == 'on' then
        if voidwalker_mode == false then
            windower.add_to_chat(8, 'VoidWalker = On')
            voidwalker_mode = true
        end
    elseif command:lower() == 'off' then
        if voidwalker_mode == true then
            windower.add_to_chat(8, 'VoidWalker = Off')
            voidwalker_mode = false
        end
    end
end)

windower.register_event('incoming text', function(original, modified)
	-- 0 = east
	-- pi = west
	-- 3pi/2 = north
	-- pi/2 = south
	-- pi/4 = southeast
	-- 7pi/4 = northeast
	-- 5pi/4 = northwest
	-- 3pi/4 = southwest
	
	if (string.find(original:lower(), 'yalms northeast')) then
		windower.ffxi.turn(7*math.pi/4)
	elseif (string.find(original:lower(), 'yalms northwest')) then
		windower.ffxi.turn(5*math.pi/4)
	elseif (string.find(original:lower(), 'yalms southwest')) then
		windower.ffxi.turn(3*math.pi/4)
	elseif (string.find(original:lower(), 'yalms southeast')) then
		windower.ffxi.turn(math.pi/4)
	elseif (string.find(original:lower(), 'yalms east')) then
		windower.ffxi.turn(0)
	elseif (string.find(original:lower(), 'yalms west')) then
		windower.ffxi.turn(math.pi)
	elseif (string.find(original:lower(), 'yalms north')) then
		windower.ffxi.turn(3*math.pi/2)
	elseif (string.find(original:lower(), 'yalms south')) then
		windower.ffxi.turn(math.pi/2)
	end
end)

windower.register_event('load', function()
    if windower.ffxi.get_player() then 
        coroutine.sleep(2) -- sleeping because jobchange too fast doesn't show new abilities
        self = windower.ffxi.get_player()
    end
end)

windower.register_event('login', function()
    coroutine.sleep(2) -- sleeping because jobchange too fast doesn't show new abilities
    self = windower.ffxi.get_player()
end)
