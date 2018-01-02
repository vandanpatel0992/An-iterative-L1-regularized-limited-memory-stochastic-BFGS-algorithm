function expo= Exponential(w,input,output)

if (output*transpose(input)*w)>709
    expo=output*transpose(input)*w;
else
    expo=exp(output*transpose(input)*w);
end
end