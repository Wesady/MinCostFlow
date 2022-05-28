function w = searchG(G,st,en)%查找边的w
w = nan;
for i = 1:height(G.Edges)
    if strcmp(G.Edges.EndNodes{i,1},st) && strcmp(G.Edges.EndNodes{i,2},en)%如果起点终点符合
        w = G.Edges.Weight(i);
        break
    end
end