function alreadyProcessed = processedORnot(currentSettings,previousSettings)

    % Round both vectors to 2 decimal places
    currentRounded = round(currentSettings, 2);
    previousRounded = round(previousSettings, 2);

    % Compare element-wise
    alreadyProcessed = all(currentRounded == previousRounded);

%     fprintf('alreadyProcessed: %d\n',alreadyProcessed)

end