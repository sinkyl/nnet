clear, clc
import ai.neuron.*
import linkedList.*

% test input neuron
in = EdgeNeuron;
in.setOutputValue(4)


% test train neuron
lf = 2; bias = 4;
tn = TrainNeuron(lf, bias, @myfun);
tn.initRandomWeights(3);

% test final neuron
fn = FinalNeuron(tn);

% test neuron update inputval function
% should be tested in layer object

function a = acf(x, type)
    switch type
        case 'e'
           a = x + 1;
        case 't'
           a = x + 0;
    end
end

function fun = myfun()
fun{1} = @(x) x + 1;
fun{2} = @(x) x + 2;
end