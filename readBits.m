function result = readBits(bits)
  ascii = zeros(183);
  i = 1;
  for b = 1:8:1464
    bin = bits(b:(b+7));
    binstr = int2str(bin);
    ascii(i) = bin2dec(binstr);
    i = i + 1;
  end
  result = strcat(char(ascii(1:find(ascii==0, 1, 'first'))));
end

