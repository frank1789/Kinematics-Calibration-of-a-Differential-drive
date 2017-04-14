function graphOdometricCam(data, parameters, n)
% OBJFUN calculates error for every configuration of parameters return
% error along the path

% Encoder resolution (multiplied by gear train ratio)
res_encoder = 16384 * 25;

fprintf('Progress analisys dataset: %i\n', n);
    
    % Initialize local variable
    [ diffleft, diffright ] = tick2differenceTick( data );
    
    % Initialize array and calc new position
    newpose.x(1)   = data.pose.x(1);
    newpose.y(1)   = data.pose.y(1);
    newpose.psi(1) = data.pose.psi(1);
    
    % Calculate ododometric recostruction
    for i=1:length(data.pose.psi)
        fprintf('\tProgress generation odometric recostruction: %3.2f%%\r', i/length(data.pose.psi)*100)
        newpose.x(i+1)   = newpose.x(i)   +   pi * (diffright(i) * parameters(2) + diffleft(i) * parameters(1)) * (cos(newpose.psi(i))/res_encoder);
        newpose.y(i+1)   = newpose.y(i)   +   pi * (diffright(i) * parameters(2) + diffleft(i) * parameters(1)) * (sin(newpose.psi(i))/res_encoder);
        newpose.psi(i+1) = newpose.psi(i) + 2*pi * (diffright(i) * parameters(2) - diffleft(i) * parameters(1)) / (res_encoder * parameters(3));
    end
    % clear duplicate rows
    newpose.x(1)   = [];
    newpose.y(1)   = [];
    newpose.psi(1) = [];

    % Offset performance
    % data.pose.psi = Camera's absolute orientation angle
    x_corr = data.pose.x - parameters(5) * cos(parameters(6) + data.pose.psi - parameters(4));
    y_corr = data.pose.y - parameters(5) * sin(parameters(6) + data.pose.psi - parameters(4));

    % Print plot and save
    figure();
    hold on
    axis equal
    grid on
    originalcampose = plot(data.pose.x,data.pose.y,'k');
    odometricpose   = plot(newpose.x,newpose.y,'r');
    correctcampose  = plot(x_corr,y_corr);
    xlabel('[cm]')
    ylabel('[cm]')
    legend([originalcampose odometricpose correctcampose],'original camera pose','odometric pose', 'camera offset pose');
    hold off
    fname = sprintf('recostropt_%d', n);
    print(fname,'-depsc','-tiff','-r0');
    
    % with covariance without saving
    
    % pre allocating 
    covariancematrix = double.empty;
    figure();
    hold on
    axis equal
    grid on
    originalcampose = plot(data.pose.x,data.pose.y,'k');
    odometricpose   = plot(newpose.x,newpose.y,'r');
    correctcampose  = plot(x_corr,y_corr);
    for n = 1:(length(data.cov_11))
        
        % assemble covariance
        covariancematrix(:,:,n) = [[data.cov_11(n), data.cov_12(n), data.cov_13(n)];
            [data.cov_21(n), data.cov_22(n), data.cov_23(n)];
            [data.cov_31(n), data.cov_32(n), data.cov_33(n)]];
        
        % plot
        [w1, w2, ell_angle] = Covariance2EllipseParameters(covariancematrix(:,:,n), 0.68);
        cov_orig  = myEllipse(w1, w2, ell_angle+pi/2, data.pose.x(n), data.pose.y(n), 'b', '-', 100);
        cov_rical =myEllipse(w1, w2, ell_angle+pi/2, newpose.x(n), newpose.y(n), 'm', '-', 100);  
    end
    xlabel('[cm]')
    ylabel('[cm]')
    legend([originalcampose odometricpose correctcampose],'original camera pose','odometric pose', 'camera offset pose');
    legend([cov_orig, cov_rical],'coavariance dataset', 'covariance calculate')
    hold off
    
    % free memory
    clearvars Cov
end
