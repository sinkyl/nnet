clear, clc
import ai.layer.*
import linkedList.*

% input layer
il = InputLayer(3);
il.init;

% train hidden layer
bl = linkedList.LinkedList;
lf = linkedList.LinkedList;
al = linkedList.LinkedList;
bl.add(2); bl.add(4);
lf.add(0.4); lf.add(0.5);
al.add(@yoo); al.add(@yoo);
thl = TrainHiddenLayer(3,bl,lf,al);
thl.init(3);

% test final hidden layer
fhl = ai.layer.HiddenLayer(thl);


% activation functions
function r = yoo(x)
    r = x + 1000;
end


