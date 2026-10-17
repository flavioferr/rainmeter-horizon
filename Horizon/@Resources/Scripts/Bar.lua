-- Monta o bloco da direita da barra so com os itens ativos.
-- Simbolos unicode vem das variaveis (Deg, NetIcon), entao o arquivo fica ASCII.

function Initialize()
end

local function on(key)
	return tonumber(SKIN:GetVariable(key)) == 1
end

local function value(name)
	local m = SKIN:GetMeasure(name)
	return m and m:GetValue() or 0
end

local function bytes(v)
	local units = { 'B', 'kB', 'MB', 'GB' }
	local i = 1
	while v >= 1000 and i < #units do
		v = v / 1024
		i = i + 1
	end
	return string.format(i == 1 and '%.0f %s' or '%.1f %s', v, units[i])
end

function Items()
	local parts = {}
	local deg = SKIN:GetVariable('Deg')
	if on('ShowWeather') then
		local cond = SKIN:GetMeasure('MeasureCondition'):GetStringValue()
		table.insert(parts, string.format('%d%s %s', math.floor(value('MeasureTemp') + 0.5), deg, cond))
	end
	if on('ShowCPU') then
		table.insert(parts, string.format('CPU %d%%', math.floor(value('MeasureCPU') + 0.5)))
	end
	if on('ShowRAM') then
		table.insert(parts, string.format('RAM %d%%', math.floor(value('MeasureRamPct') + 0.5)))
	end
	if on('ShowDisk') then
		table.insert(parts, string.format('SSD %d%%', math.floor(value('MeasureDiskPct') + 0.5)))
	end
	if on('ShowNet') then
		table.insert(parts, 'NET ' .. bytes(value('MeasureNetIn')) .. '  ' .. bytes(value('MeasureNetOut')))
	end
	return table.concat(parts, '      ')
end
