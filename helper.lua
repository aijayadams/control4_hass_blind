function PrintTable(tValue, sIndent)
        local function isTable(t) return type(t) == 'table' end
        sIndent = sIndent or "   "
        if tValue == nil then print("Cannot print empty table")  return -1 end
        if not isTable(tValue) then print("Tried to print string as table: " .. tValue) return -1 end
        for k,v in pairs(tValue) do
                print(sIndent .. tostring(k) .. ":  " .. tostring(v))
                if (type(v) == "table") then
                        PrintTable(v, sIndent .. "   ")
                end
        end
end

