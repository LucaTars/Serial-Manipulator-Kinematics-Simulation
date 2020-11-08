function qnew = normalize(q)
    qtype = evalin('base','qtype');
    qnew = q;
    for i = 1 : max(size(qtype))
        if (qtype(i) == 0) % if rot joint
            qnew(i) = wrapToPi(q(i));
        end
    end
end