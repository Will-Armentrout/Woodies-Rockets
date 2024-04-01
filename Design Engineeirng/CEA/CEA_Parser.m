clear
clc

out_path = "Output_Test_4.html";

output = fileread(out_path);

out_split = strsplit(output, '\n');

conditions = 0;
Pin = [];
OFRatio = [];
PRatioThroat = [];
PRatio = {};
press = {};
temp = {};
rho = {};
gamma = {};
SOS = {};
machNum = {};
areaRatio = {};
Isp = {};
for i = 1:length(out_split)
    line = out_split{i};
    curr = split(line);
    
    %Each Condition
    if(contains(line, 'THEORETICAL'))
        conditions = conditions + 1;
    
    %Chamber Pressure
    elseif(contains(line, 'Pin '))
        Pin_curr = str2double(curr{end - 1});
        Pin = [Pin Pin_curr];
    
    %Oxidizer to Fuel Ratio
    elseif(contains(line, 'O/F'))
        OFRatio_curr = str2double(curr{3});
        OFRatio = [OFRatio OFRatio_curr];
    
    %Pressure Ratio
    elseif(contains(line,'Pinf/P'))
        PRatio_curr = curr(3:end);
        data = [];
        for j = 1:length(PRatio_curr)
            data = [data; str2double(PRatio_curr{j})];
        end
        PRatio{end + 1} = data;

    %Pressure
    elseif(contains(line,'P, BAR'))
        press_curr = curr(4:end);
        data = [];
        for j = 1:length(press_curr)
            data = [data; str2double(press_curr{j})];
        end
        press{end + 1} = data;
    
    %Temperature
    elseif(contains(line,'T, K'))
        temp_curr = curr(4:end);
        data = [];
        for j = 1:length(temp_curr)
            data = [data; str2double(temp_curr{j})];
        end
        temp{end + 1} = data;

    %Density
    elseif(contains(line,'RHO'))
        rho_curr = curr(5:end);
        data = [];
        for j = 1:length(rho_curr)
            data = [data; {rho_curr{j}}];
        end
        rho{end + 1} = data;

    %Gamma
    elseif(contains(line,'GAMMAs'))
        gamma_curr = curr(3:end);
        data = [];
        for j = 1:length(gamma_curr)
            data = [data; str2double(gamma_curr{j})];
        end
        gamma{end + 1} = data;

    %Speed of Sound
    elseif(contains(line,'SON VEL'))
        SOS_curr = curr(4:end);
        data = [];
        for j = 1:length(SOS_curr)
            data = [data; str2double(SOS_curr{j})];
        end
        SOS{end + 1} = data;

    %Mach Number
    elseif(contains(line,'MACH NUMBER'))
        machNum_curr = curr(4:end);
        data = [];
        for j = 1:length(machNum_curr)
            data = [data; str2double(machNum_curr{j})];
        end
        machNum{end + 1} = data;

    %Area Ratio
    elseif(contains(line,'Ae/At'))
        areaRatio_curr = curr(4:end);
        data = [];
        for j = 1:length(areaRatio_curr)
            data = [data; str2double(areaRatio_curr{j})];
        end
        areaRatio{end + 1} = data;

    %Specific Impulse
    elseif(contains(line,'Isp'))
        Isp_curr = curr(4:end);
        data = [];
        for j = 1:length(Isp_curr)
            data = [data; str2double(Isp_curr{j})];
        end
        Isp{end + 1} = data;

    end
end

%Converting density to a number because the display is fucked
rho_conv = {};
for i = 1:length(rho)
    vect_Rho = rho{i};
    rho_double = [];
    for j = 1:length(vect_Rho)
        num = vect_Rho{j};
        if(~strcmp(num, '0'))
            num = split(num, '-');
            val = str2double(num{1});
            ex = 0;
            if(length(num) == 2)
                ex = str2double(num{2});
            end

            rho_double = [rho_double (val*10^(-ex))];
        end
    end
    rho_conv{end + 1} = rho_double;
end



%Converting to Bar
Pin = round(Pin/14.5038);

%Output Variables
PRatio_throat = [];
PRatio_exit = [];
press_chamber = [];
press_throat = [];
press_exit = [];
OF = [];
temp_chamber = [];
temp_throat = [];
temp_exit = [];
rho_chamber = [];
rho_throat = [];
rho_exit = [];
gamma_chamber = [];
gamma_throat = [];
gamma_exit = [];
SOS_chamber = [];
SOS_throat = [];
SOS_exit = [];
machNum_exit = [];
areaRatio_exit = [];
Isp_exit = [];

%Parsing data to the correct exit pressure
for i = 1:length(Pin)
    vect_PRatio = PRatio{i};
    vect_Press = press{i};
    vect_Temp = temp{i};
    vect_Gamma = gamma{i};
    vect_SOS = SOS{i};
    vect_MachNum = machNum{i};
    vect_AreaRatio = areaRatio{i};
    vect_Isp = Isp{i};
    vect_Rho = rho_conv{i};
    
    P = Pin(i);
    if(ismember(P, vect_PRatio))
        idx = find(vect_PRatio == P);

        PRatio_throat = [PRatio_throat vect_PRatio(2)];
        PRatio_exit = [PRatio_exit vect_PRatio(idx)];

        press_chamber = [press_chamber vect_Press(1)];
        press_throat = [press_throat vect_Press(2)];
        press_exit = [press_exit vect_Press(idx)];

        OF = [OF OFRatio(i)];

        temp_chamber = [temp_chamber vect_Temp(1)];
        temp_throat = [temp_throat vect_Temp(2)];
        temp_exit = [temp_exit vect_Temp(idx)];

        rho_chamber = [rho_chamber vect_Rho(1)];
        rho_throat = [rho_throat vect_Rho(2)];
        rho_exit = [rho_exit vect_Rho(idx)];

        gamma_chamber = [gamma_chamber vect_Gamma(1)];
        gamma_throat = [gamma_throat vect_Gamma(2)];
        gamma_exit = [gamma_exit vect_Gamma(idx)];

        SOS_chamber = [SOS_chamber vect_SOS(1)];
        SOS_throat = [SOS_throat vect_SOS(2)];
        SOS_exit = [SOS_exit vect_SOS(idx)];

        machNum_exit = [machNum_exit vect_MachNum(idx)];

        areaRatio_exit = [areaRatio_exit vect_AreaRatio(idx-2)];

        Isp_exit = [Isp_exit vect_Isp(idx-1)];
    end
end

figure(1)
mdl = scatteredInterpolant(press_chamber', OF', areaRatio_exit');
[xg, yg] = meshgrid(unique(press_chamber), unique(OF));
zg = mdl(xg, yg);
surf(xg,yg,zg)
xlabel('Chamber Pressure (bar)')
ylabel('O/F Ratio')
zlabel('Gamma')
    








