//Experiment No.8
//Hybrid topology using bus, star and ring
clear;
clc;

// Network details
NameOfNetwork = 'Hybrid Topology (Bus + Star + Ring)';
NumberOfNodes = 26;

// Bus section (nodes 1–10)
BusStart = [1 2 3 4 5 6 7 8 9];
BusEnd   = [2 3 4 5 6 7 8 9 10];

// Star section (nodes 11–18)
// Node 11 acts as the center
StarStart = [11 11 11 11 11 11 11];
StarEnd   = [12 13 14 15 16 17 18];

// Ring section (nodes 19–26)
RingStart = [19 20 21 22 23 24 25 26];
RingEnd   = [20 21 22 23 24 25 26 19];

// Connections between different topologies
HybridStart = [5 8];
HybridEnd   = [11 19];

// Combine all edges
StartingNodes = [BusStart StarStart RingStart HybridStart];
EndingNodes   = [BusEnd   StarEnd   RingEnd   HybridEnd];

// Node positions (used only for display)
XCoordinates = [
100 150 200 250 300 350 400 450 500 550, ...
350 300 300 350 400 400 350 300, ...
650 700 750 800 800 750 700 650
];

YCoordinates = [
500 500 500 500 500 500 500 500 500 500, ...
400 450 350 300 350 450 500 450, ...
400 450 500 550 600 650 600 450
];

// Create the hybrid topology
[TopologyGraph] = NL_G_MakeGraph(NameOfNetwork, NumberOfNodes, StartingNodes, EndingNodes, XCoordinates, YCoordinates);

// Show the topology
WindowIndex = 1;
NL_G_ShowGraph(TopologyGraph, WindowIndex);
xtitle("Hybrid Topology", "X-Nodes", "Y-Nodes");

// Show node and edge numbers
WindowIndex = 2;
NL_G_ShowGraphNE(TopologyGraph, WindowIndex);

// Highlight selected nodes
NodeColor = 30;
BorderThickness = 10;
NodeDiameter = 25;
WindowIndex = 3;

HighlightNodes = [1 5 10 11 15 19 23];
[TopologyGraph, f] = NL_G_HighlightNodes(TopologyGraph, HighlightNodes, NodeColor, BorderThickness, NodeDiameter, WindowIndex);

// Highlight selected edges
EdgeColor = 5;
EdgeWidth = 5;
WindowIndex = 4;

HighlightEdges = [1 5 10 15 20];
[TopologyGraph, f] = NL_G_HighlightEdges(TopologyGraph, HighlightEdges, EdgeColor, EdgeWidth, WindowIndex);

// Find degree of each node
disp("Node Degree Information:");

MaxDegree = 0;
MaxNode = 0;

for i = 1:NumberOfNodes
    EdgeSet = NL_G_EdgesOfNode(TopologyGraph, i);
    Degree = length(EdgeSet);
    disp("Node " + string(i) + " has edges: " + string(Degree));

    // Track the node with most connections
    if Degree > MaxDegree then
        MaxDegree = Degree;
        MaxNode = i;
    end
end

disp("Node with Maximum Edges:");
disp("Node " + string(MaxNode) + " with Degree " + string(MaxDegree));

// Print total size of the network
[TotalNodes, TotalEdges] = NL_G_GraphSize(TopologyGraph);
disp("Total Number of Nodes:", TotalNodes);
disp("Total Number of Edges:", TotalEdges);
