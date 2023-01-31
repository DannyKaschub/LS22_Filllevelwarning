--
-- FillLevel Warning for LS 22
--
-- # Author:  	LSM/Sachsenfarmer
-- # date: 		24.10.22
--
-- 1.0.0.0 Convert from LS19 to LS22
-- 1.0.0.1 new loading system for the Soundsamples



fillLevelWarning = {}
fillLevelWarning.MOD_NAME = g_currentModName


sounds = { 
	["AGCOBeepSound"] = "sounds/AGCO_beep.wav" ,
	["ClaasBeepSound"] = "sounds/Claas_beep.wav",
	["GrimmeBeepSound"] = "sounds/Grimme_beep.wav",
	["HolmerBeepSound"] = "sounds/Holmer_beep.wav",
	["JohnDeereSound"] = "sounds/JohnDeere_beep.wav",
	["NewHollandSound"] = "sounds/JohnDeere_beep.wav",
	["RopaSound"] = "sounds/Ropa_beep.wav"
}

mySamples = {}

for k, v in pairs(sounds) do
	mySamples[k] = createSample(k)
	loadSample(mySamples[k], g_currentModDirectory..v, false)
end



function fillLevelWarning.prerequisitesPresent(specializations)
  return true
end

function fillLevelWarning.registerEventListeners(vehicleType)
	SpecializationUtil.registerEventListener(vehicleType, "onPreLoad", fillLevelWarning)
	SpecializationUtil.registerEventListener(vehicleType, "onUpdate", fillLevelWarning)
  end

function fillLevelWarning:onPreLoad(vehicle)
	self.RULaktive = false
	self.BeepAktive1 = false
	self.brand = self.xmlFile:getValue ("vehicle.storeData.brand" , false)
	self.loud = 1
end

function fillLevelWarning:onUpdate(dt)
	if self:getIsActive() then
	local fillLevel = self:getFillUnitFillLevelPercentage(self:getCurrentDischargeNode().fillUnitIndex)  
		if fillLevel > 0 then
			if not	self.BeepAktive1 then
				if fillLevel >= 0.5 then
					if self:getIsEntered() then			
						if self.brand == "AGCO" or self.brand == "FENDT" or self.brand == "MASSEYFERGUSON" or self.brand == "CHALLENGER" then
							playSample(mySamples["AGCOBeepSound"] ,self.loud ,self.loud ,1 ,0 ,0)
						elseif self.brand == "CLAAS" then
							playSample(mySamples["ClaasBeepSound"]  ,self.loud ,self.loud ,1 ,0 ,0)
						elseif self.brand == "GRIMME" then
							playSample(mySamples["GrimmeBeepSound"]  ,self.loud ,self.loud ,1 ,0 ,0)
						elseif self.brand == "HOLMER" then
							playSample(mySamples["HolmerBeepSound"]  ,self.loud ,self.loud ,1 ,0 ,0)
						elseif self.brand == "JOHNDEERE" then
							playSample(mySamples["JohnDeereSound"]  ,self.loud ,self.loud ,1 ,0 ,0)	
						elseif self.brand == "NEWHOLLAND" or self.brand == "CASEIH" then
							playSample(mySamples["NewHollandSound"]  ,self.loud ,self.loud ,1 ,0 ,0)	
						elseif self.brand == "ROPA" then
							playSample(mySamples["RopaSound"]  ,self.loud ,self.loud ,1 ,0 ,0)
						end	
					end
					self.BeepAktive1 = true
				end
			else
				if fillLevel < 0.5 then
					self.BeepAktive1 = false
				end
			end
			if not self.RULaktive then
				if fillLevel >= 0.8 then
					self:setBeaconLightsVisibility(true)
					if self:getIsEntered() then				
						if self.brand == "AGCO" or self.brand == "FENDT" or self.brand == "MASSEYFERGUSON" or self.brand == "CHALLENGER" then
							playSample(mySamples["AGCOBeepSound"] ,self.loud ,self.loud ,1 ,0 ,0)
						elseif self.brand == "CLAAS" then
							playSample(mySamples["ClaasBeepSound"]  ,self.loud ,self.loud ,1 ,0 ,0)
						elseif self.brand == "GRIMME" then
							playSample(mySamples["GrimmeBeepSound"]  ,self.loud ,self.loud ,1 ,0 ,0)
						elseif self.brand == "HOLMER" then
							playSample(mySamples["HolmerBeepSound"]  ,self.loud ,self.loud ,1 ,0 ,0)
						elseif self.brand == "JOHNDEERE" then
							playSample(mySamples["JohnDeereSound"]  ,self.loud ,self.loud ,1 ,0 ,0)	
						elseif self.brand == "NEWHOLLAND" or self.brand == "CASEIH" then
							playSample(mySamples["NewHollandSound"]  ,self.loud ,self.loud ,1 ,0 ,0)	
						elseif self.brand == "ROPA" then
							playSample(mySamples["RopaSound"]  ,self.loud ,self.loud ,1 ,0 ,0)
						end	
					end
				self.RULaktive = true
				end
			else
				if fillLevel < 0.8 then
					self:setBeaconLightsVisibility(false)
					self.RULaktive = false
				end	
			end
		end
		g_inputBinding:setActionEventText(fillLevelWarning.actionEventId, Vehicle.togglesound)
	end
end