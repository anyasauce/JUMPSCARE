--[[
       _           _       _     
      | |         (_)     | |    
      | | ___  ___ _  __ _| |__  
  _   | |/ _ \/ __| |/ _` | '_ \ 
 | |__| | (_) \__ \ | (_| | | | |
  \____/ \___/|___/_|\__,_|_| |_|

📜 Developed by: Josiah Danielle Gallenero
🚫 Do NOT copy, steal, or redistribute this code without permission.
🎮 Made for fun, creative jumpscare and welcome animation system.
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local ContentProvider = game:GetService("ContentProvider")

local JUMPSCARE_IMAGE_ID = "rbxassetid://112366012470321"
local JUMPSCARE_SOUND_ID = "rbxassetid://125597394353188"
local BLINK_COUNT = 4
local BLINK_SPEED = 0.1
local IMAGE_DISPLAY_DURATION = 1.5
local FADE_OUT_DURATION = 1
local WELCOME_MESSAGE = "Welcome to Josiah's Script!"
local WELCOME_DURATION = 3
local CLOSING_DURATION = 5

-- 🟢 Welcome Message
local function showWelcomeMessage(playerGui)
	local welcomeGui = Instance.new("ScreenGui")
	welcomeGui.Name = "WelcomeGui"
	welcomeGui.ResetOnSpawn = false
	welcomeGui.IgnoreGuiInset = true
	welcomeGui.Parent = playerGui

	local bg = Instance.new("Frame")
	bg.Size = UDim2.new(1, 0, 1, 0)
	bg.BackgroundColor3 = Color3.new(0, 0, 0)
	bg.BackgroundTransparency = 1
	bg.Parent = welcomeGui

	local container = Instance.new("Frame")
	container.Size = UDim2.new(0.8, 0, 0.2, 0)
	container.Position = UDim2.new(0.1, 0, 0.4, 0)
	container.BackgroundTransparency = 1
	container.Parent = bg

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = WELCOME_MESSAGE
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextTransparency = 1
	label.TextScaled = true
	label.Font = Enum.Font.GothamBlack
	label.Parent = container

	local glow = Instance.new("UIStroke", label)
	glow.Color = Color3.fromRGB(255, 255, 255)
	glow.Thickness = 2
	glow.Transparency = 0.4

	label.TextScaled = false
	label.TextSize = 32
	label.Position = UDim2.new(0.5, 0, 0.5, 0)
	label.AnchorPoint = Vector2.new(0.5, 0.5)

	TweenService:Create(bg, TweenInfo.new(0.8), {BackgroundTransparency = 0}):Play()
	TweenService:Create(label, TweenInfo.new(0.8), {
		TextTransparency = 0,
		TextSize = 60
	}):Play()

	wait(WELCOME_DURATION + 0.8)

	TweenService:Create(bg, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
	TweenService:Create(label, TweenInfo.new(0.8), {
		TextTransparency = 1,
		TextSize = 30
	}):Play()

	wait(0.8)
	welcomeGui:Destroy()
end

-- 🔥 Jumpscare with fullscreen image and blinking
local function triggerJumpscare()
	local player = Players.LocalPlayer
	if player:FindFirstChild("JumpscareActive") then return end
	local tag = Instance.new("BoolValue", player)
	tag.Name = "JumpscareActive"

	local scream = Instance.new("Sound", SoundService)
	scream.SoundId = JUMPSCARE_SOUND_ID
	scream.Volume = 10 -- Max volume
	ContentProvider:PreloadAsync({scream})

	local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
	gui.Name = "JumpscareGui"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true

	-- White flash screen
	local flash = Instance.new("Frame", gui)
	flash.Size = UDim2.new(1, 0, 1, 0)
	flash.Position = UDim2.new(0, 0, 0, 0)
	flash.BackgroundColor3 = Color3.new(1, 1, 1)
	flash.BackgroundTransparency = 1
	flash.ZIndex = 5

	-- FULLSCREEN Image
	local img = Instance.new("ImageLabel", gui)
	img.Size = UDim2.new(1, 0, 1, 0)
	img.Position = UDim2.new(0, 0, 0, 0)
	img.BackgroundTransparency = 1
	img.Image = JUMPSCARE_IMAGE_ID
	img.ImageTransparency = 1
	img.ZIndex = 10
	img.ScaleType = Enum.ScaleType.Stretch

	-- Play scream
	scream:Play()
	img.ImageTransparency = 0

	-- Blink effect
	for i = 1, BLINK_COUNT do
		TweenService:Create(flash, TweenInfo.new(BLINK_SPEED), {BackgroundTransparency = 0}):Play()
		TweenService:Create(img, TweenInfo.new(BLINK_SPEED), {ImageTransparency = 0.4}):Play()
		wait(BLINK_SPEED)

		TweenService:Create(flash, TweenInfo.new(BLINK_SPEED), {BackgroundTransparency = 1}):Play()
		TweenService:Create(img, TweenInfo.new(BLINK_SPEED), {ImageTransparency = 0}):Play()
		wait(BLINK_SPEED)
	end

	wait(IMAGE_DISPLAY_DURATION)

	-- Fade out image
	TweenService:Create(img, TweenInfo.new(FADE_OUT_DURATION), {ImageTransparency = 1}):Play()
	wait(FADE_OUT_DURATION)

	gui:Destroy()
	scream:Destroy()
	tag:Destroy()
end

-- ⚫ Closing screen with prank message
local function showClosingAnimation(playerGui)
	local closingGui = Instance.new("ScreenGui", playerGui)
	closingGui.Name = "ClosingGui"
	closingGui.ResetOnSpawn = false
	closingGui.IgnoreGuiInset = true

	local black = Instance.new("Frame", closingGui)
	black.Size = UDim2.new(1, 0, 1, 0)
	black.BackgroundColor3 = Color3.new(0, 0, 0)
	black.BackgroundTransparency = 1
	black.ZIndex = 20

	local text = Instance.new("TextLabel", black)
	text.Size = UDim2.new(0.8, 0, 0.2, 0)
	text.Position = UDim2.new(0.1, 0, 0.4, 0)
	text.Text = "You scared??? It's a prank!!! 😂"
	text.TextColor3 = Color3.new(1, 1, 1)
	text.BackgroundTransparency = 1
	text.TextTransparency = 1
	text.TextScaled = true
	text.Font = Enum.Font.GothamBlack
	text.ZIndex = 21

	local glow = Instance.new("UIStroke", text)
	glow.Color = Color3.fromRGB(255, 255, 255)
	glow.Thickness = 2
	glow.Transparency = 0.5

	TweenService:Create(black, TweenInfo.new(1), {BackgroundTransparency = 0}):Play()
	wait(1)

	TweenService:Create(text, TweenInfo.new(1), {TextTransparency = 0}):Play()
	wait(CLOSING_DURATION)

	TweenService:Create(text, TweenInfo.new(1), {TextTransparency = 1}):Play()
	TweenService:Create(black, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
	wait(1)

	closingGui:Destroy()
end


-- 🔁 Run all
local player = Players.LocalPlayer
if player then
	local gui = player:WaitForChild("PlayerGui")
	wait(1)
	showWelcomeMessage(gui)
	wait(1)
	triggerJumpscare()
	wait(0.1)
	showClosingAnimation(gui)
else
	warn("LocalPlayer not found")
end
