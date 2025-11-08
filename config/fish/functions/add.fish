function add
    awk '{s+=$1} END{print s}'
end
