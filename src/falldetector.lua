local LEG_BUTTON, BACK_BUTTON, BUTTON_PRESSED = 7, 6, 1

gpio.mode(LEG_BUTTON, gpio.INPUT)
gpio.mode(BACK_BUTTON, gpio.INPUT)

local function interp(s, tab)
    return (s:gsub('($%b{})', function(w) return tab[w:sub(3, -2)] or w end))
end

local function fallDetected()
    print("ALARM!")

    http.post(
        interp('https://api.twilio.com/2010-04-01/Accounts/${twilioAccount}/Messages.json?', params),
        interp('Content-Type: application/x-www-form-urlencoded\r\nAuthorization: Basic ${twilioAuth}\r\n', params),
        interp("To=%2B${smsTo}&From=%2B${smsFrom}&Body=${smsMessage}", params),
        function(code, data)
            print(code, data)
        end)
end

local fallCount = 0
local mainLoop = tmr.create()
mainLoop:alarm(3000, tmr.ALARM_AUTO, function()
    local legButtonValue = gpio.read(LEG_BUTTON)
    local backButtonValue = gpio.read(BACK_BUTTON)
    print('leg   back', legButtonValue, backButtonValue)

    if (legButtonValue == BUTTON_PRESSED and backButtonValue ~= BUTTON_PRESSED) 
    then
        if (fallCount >= 10) then
            -- You have to reset the device to begin detecting falls again
            mainLoop:unregister()
            fallDetected()
        else
            fallCount = fallCount + 1
            print('fall detected ', fallCount)
        end
    else
        fallCount = 0
    end
end)
