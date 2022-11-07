function d = cosine(v1,v2)
if v1==v2
    d=0;
else
d = 1 - dot(v1,v2)/(norm(v1)*norm(v2));
end