clear;clc;
[~,~,nodes] = xlsread('.\OriginalData\nodes.xlsx');
[~,~,edges] = xlsread('.\OriginalData\edges.xlsx');
%��edges�����node����ID�ţ�,ע��Ҫ�ų���ͷ
[rowNodes,~] = size(nodes);
[rowEdges,~] = size(edges);
for iE = 2:1:rowEdges %ȥ����ͷ
    for iN = 2:1:rowNodes
        if strcmp(edges{iE,2},nodes{iN,2})
            edges(iE,1) = nodes(iN,1);
        end
        if strcmp(edges{iE,4},nodes{iN,2})
            edges(iE,3) = nodes(iN,1);
        end
    end
end
xlswrite('.\edges',edges);
%���txt
fid = fopen('.\relation.txt','w');
for iN = 2:1:rowNodes
    if iN == 2
        fprintf(fid,'var nodes = [ {name:"%s"},\n',num2str(nodes{iN,2}));
    elseif iN == rowNodes
        fprintf(fid,'              {name:"%s"}];\n',num2str(nodes{iN,2}));
    else
        fprintf(fid,'              {name:"%s"},\n',num2str(nodes{iN,2}));
    end
end
for iE = 2:1:rowEdges
    if iE == 2
        fprintf(fid,'var edges = [ {source: %d , target: %d },\n',edges{iE,1},edges{iE,3});
    elseif iE == rowEdges
        fprintf(fid,'              {source: %d , target: %d }];\n',edges{iE,1},edges{iE,3});
    else
        fprintf(fid,'              {source: %d , target: %d },\n',edges{iE,1},edges{iE,3});
    end
end
fclose(fid);
