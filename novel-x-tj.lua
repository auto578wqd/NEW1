--=====================================================================--
--  NOVEL-X | TJ EDITION v2.5  --  Blox Fruits Hub (PC ONLY / NO KEY)
--  UPDATE 30 READY: MAX LEVEL 3000 (2800 ปกติ + Island Secrets +200)
--
--  พัฒนาใหม่ทั้งระบบจาก Novel เดิม (ที่เป็นแค่ประตูขายคีย์ ไม่มีฟีเจอร์)
--  + UI ใหม่ สวย ลากได้ ค้นหาได้ ตั้งคีย์ลัดได้
--  + Auto Farm / Auto Quest อัตโนมัติ สลับเควสตามเลเวล ถึง Lv 2725+
--  + [v2.5] เควสใหม่ครบถึง Grand Devotee (Cake Land -> Submerged Island)
--  + [v2.5] แท็บ Secrets: ไกด์ทำ Island Secrets 40 อันทั้ง Sea 1
--    (อันละ +5 เลเวล = ปลดล็อกแคป 2800 -> 3000) + ล่าบอส Awakened อัตโนมัติ
--  + ระบบเควส "ตรวจยืนยันกับเกมจริง" -- ถ้า Blox Fruits อัปเดตเควสใหม่
--    ระบบจะหาอันที่ใช้ได้เอง + รายงานอันที่ใช้ไม่ได้ (ไม่พังทั้งระบบ)
--  + อัปเดตข้อมูลเควสได้โดยไม่ต้องแก้สคริปต์ (ดูหัวข้อ [DATA] ด้านล่าง)
--
--  CREDIT: made by TJ
--  ใช้กับ: Blox Fruits (PlaceId 2753915549) | เฉพาะ PC (คีย์บอร์ด)
--=====================================================================--

-- ============================== CONFIG ==============================
local CFG = {
    -- Farm
    AutoFarm      = false,
    FarmMode      = "Bring Enemies",   -- "Bring Enemies" | "Go To Enemies (Safe)"
    Weapon        = "Combat",
    AttackSpeed   = 3,                 -- จำนวนคลิกโจมตีต่อเฟรม (1-10)
    AutoSkills    = true,              -- กด Z X C V อัตโนมัติ
    FarmAll       = false,             -- ฟาร์มศัตรูทุกตัวแบบไม่สนเควส
    AutoSeaBeast  = false,
    -- Island Secrets (Update 30)
    AwakenedAlert = true,              -- แจ้งเตือนเมื่อบอส Awakened เกิด (Island Secrets)
    AutoAwakened  = false,             -- ล่าบอส Awakened อัตโนมัติ (Island Secrets)
    -- Quest
    AutoSwap      = true,              -- สลับเควสอัตโนมัติเมื่อเลเวลพอ (เควสลับ)
    -- Combat
    AutoBuso      = true,
    AutoKen       = false,
    AutoStats     = false,
    StatPriority  = "Melee",
    KeepPoints    = 0,
    -- Fruit
    FruitSniper   = false,
    FruitNotify   = true,
    -- ESP
    ESP           = false,
    ESPPlayers    = true,
    ESPEnemies    = true,
    ESPFruits     = true,
    ESPChests     = false,
    ESPTracers    = false,
    ESPDistance   = 3000,
    -- Player
    WalkSpeedOn   = false,  WalkSpeed = 60,
    JumpPowerOn   = false,  JumpPower = 60,
    InfJump       = false,
    Noclip        = false,
    Fly           = false,  FlySpeed  = 90,
    -- World
    AutoRejoin    = false,
    -- Teleport
    TweenTeleport = true,              -- true = เนียนกว่า / false = วาร์ปสุดทื่อ
    TweenSpeed    = 220,
    -- UI
    Accent        = "Red",
    -- Keybinds
    KeyUI         = Enum.KeyCode.RightControl,
    KeyFarm       = Enum.KeyCode.F,
    KeyFly        = Enum.KeyCode.G,
}
-- ====================================================================

local NX = { dead = false, cons = {}, notifyQueue = {}, stale = {} }

local Players        = game:GetService("Players")
local RunService     = game:GetService("RunService")
local UserInput      = game:GetService("UserInputService")
local TweenService   = game:GetService("TweenService")
local HttpService    = game:GetService("HttpService")
local Replicated     = game:GetService("ReplicatedStorage")
local TeleportService= game:GetService("TeleportService")
local Lighting       = game:GetService("Lighting")
local CoreGui        = game:GetService("CoreGui")
local VirtualUser    = game:GetService("VirtualUser")
local VirtualInput   = game:GetService("VirtualInputManager")

local LP = Players.LocalPlayer

-- ============================ [1] GATES =============================
-- กันรันซ้ำ
if getgenv().NX_LOADED then return end
getgenv().NX_LOADED = true

-- ตรวจเกม (Blox Fruits)
if game.PlaceId ~= 2753915549 and game.PlaceId ~= 4442272183 and game.PlaceId ~= 7449423635 then
    warn("[NOVEL-X] This script is for Blox Fruits only. (made by TJ)")
    return
end

-- รอโหลดเกม
if not game:IsLoaded() then game.Loaded:Wait() end
task.wait(0.3)

-- ตรวจว่าเป็น PC (มีคีย์บอร์ด) -- ตัวนี้รองรับ PC เท่านั้น
if not UserInput.KeyboardEnabled then
    warn("[NOVEL-X] PC ONLY -- NOVEL-X supports PC only. (made by TJ)")
    local g = Instance.new("ScreenGui")
    g.ResetOnSpawn = false
    pcall(function() g.Parent = CoreGui end)
    if not g.Parent then g.Parent = LP:WaitForChild("PlayerGui") end
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, 0, 1, 0)
    t.BackgroundTransparency = 0.45
    t.BackgroundColor3 = Color3.new(0, 0, 0)
    t.Font = Enum.Font.GothamBold
    t.TextSize = 26
    t.TextColor3 = Color3.fromRGB(255, 90, 90)
    t.Text = "NOVEL-X supports PC ONLY\n(made by TJ)"
    t.Parent = g
    task.delay(8, function() g:Destroy() end)
    return
end

-- Anti-AFK (กันโดนเตะเพราะไม่ขยับ)
pcall(function()
    for _, c in ipairs(getconnections(LP.Idled)) do
        pcall(function() c:Disable() end)
        pcall(function() c:Disconnect() end)
    end
end)

-- ============================ [2] UTILS =============================
local function tfind(t, v)
    for i = 1, #t do if t[i] == v then return i end end
    return nil
end
local function conn(c)
    table.insert(NX.cons, c)
    return c
end
local function scontains(s, p)
    return string.find(s, p, 1, true) ~= nil
end
local function stripLv(s)
    -- "Bandit [Lv. 5]" -> "Bandit"
    local i = string.find(s, " [Lv", 1, true)
    if i then return string.sub(s, 1, i - 1) end
    return s
end

local function getChar()
    local c = LP.Character
    if not c then return nil, nil, nil end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    local hum = c:FindFirstChildOfClass("Humanoid")
    return c, hrp, hum
end
local function alive()
    local c, hrp, hum = getChar()
    if c and hrp and hum and hum.Health > 0 then return c, hrp, hum end
    return nil
end

local function getVal(name)
    local ok, v = pcall(function() return LP.Data[name].Value end)
    if ok then return v end
    return 0
end
local function getLevel()   return getVal("Level") end
local function getBeli()    return getVal("Beli") end
local function getFrag()    return getVal("Fragments") end
local function getPoints()  return getVal("Points") end
local function getFruit()
    local ok, v = pcall(function() return LP.Data.DevilFruit.Value end)
    if ok then return v end
    return "None"
end

-- เดินทาง: tween (เนียน) หรือวาร์ป
local activeTween = nil
local function topos(cf)
    local c, hrp = alive()
    if not hrp then return end
    if not CFG.TweenTeleport then
        pcall(function() hrp.CFrame = cf end)
        return
    end
    pcall(function()
        if activeTween then activeTween:Cancel() end
        local d = (hrp.Position - cf.Position).Magnitude
        local t = math.min(d / math.max(CFG.TweenSpeed, 1), 6)
        activeTween = TweenService:Create(hrp, TweenInfo.new(t, Enum.EasingStyle.Linear), { CFrame = cf })
        activeTween:Play()
    end)
end

local function getComm()
    local ok, r = pcall(function()
        return Replicated:WaitForChild("Remotes"):WaitForChild("CommF_", 5)
    end)
    if ok then return r end
    return nil
end
local function invoke(...)
    local Comm = getComm()
    if not Comm then return nil end
    local args = { ... }
    local ok, r = pcall(function()
        return Comm:InvokeServer(unpack(args))
    end)
    if ok then return r end
    return nil
end

-- แจ้งเตือน (ก่อน UI พร้อม = เก็บคิว)
local Notify = function(title, text, dur)
    table.insert(NX.notifyQueue, { title = title, text = text, dur = dur or 4 })
    print(string.format("[NOVEL-X] %s: %s", tostring(title), tostring(text)))
end

-- ============================ [DATA] ================================
-- ตารางเควส Blox Fruits (ตรวจสอบข้อมูลจาก 2 แหล่ง hub จริง)
-- รูปแบบ: { เลเวลขั้นต่ำ, "NPC key", ลำดับเควส, "ชื่อศัตรู", พิกัด NPC, พิกัดศัตรู }
--
--  * อัปเดตเมื่อเกมเพิ่มเควสใหม่โดยไม่ต้องแก้สคริปต์นี้:
--    1) วิธีที่ 1: สร้างไฟล์ "NX-TJ-quests.json" ใน workspace folder ของ executor
--       รูปแบบ: [ [2250,"NutsIslandQuest",2,"Peanut Boss"], ... ]
--    2) วิธีที่ 2: getgenv().NX_QUESTS = { {2250,"NutsIslandQuest",2,"Peanut Boss"}, ... }
--       (ใส่ก่อนรันสคริปต์)
--    3) วิธีที่ 3: getgenv().NX_QUESTS_URL = "https://...json" (โหลดจากเน็ต)
--    ระบบจะเอา entry ใหม่ไป "ทดลองใช้จริง + ตรวจยืนยัน" ให้อัตโนมัติ
--
-- Update 30: เลเวลสูงสุดของเกม
local BASE_CAP  = 2800   -- แคปจากเควสปกติ
local MAX_LEVEL = 3000   -- 2800 + Island Secrets 40 อัน x อันละ 5 เลเวล

local Quests = {
    {1, "BanditQuest1", 1, "Bandit", Vector3.new(1061.7, 16.5, 1544.5), Vector3.new(1199.3, 52.3, 1536.9)},
    {10, "JungleQuest", 1, "Monkey", Vector3.new(-1604.1, 36.9, 154.2), Vector3.new(-1772.4, 60.9, 54.9)},
    {15, "JungleQuest", 2, "Gorilla", Vector3.new(-1604.1, 36.9, 154.2), Vector3.new(-1223.5, 6.3, -502.3)},
    {30, "BuggyQuest1", 1, "Pirate", Vector3.new(-1139.6, 4.8, 3825.2), Vector3.new(-1219.3, 4.8, 3915.6)},
    {40, "BuggyQuest1", 2, "Brute", Vector3.new(-1139.6, 4.8, 3825.2), Vector3.new(-1146.5, 96.1, 4312.1)},
    {60, "DesertQuest", 1, "Desert Bandit", Vector3.new(897.0, 6.4, 4389.0), Vector3.new(932.8, 6.5, 4488.2)},
    {75, "DesertQuest", 2, "Desert Officer", Vector3.new(897.0, 6.4, 4389.0), Vector3.new(1580.0, 4.6, 4366.9)},
    {90, "SnowQuest", 1, "Snow Bandits", Vector3.new(1384.1, 87.3, -1297.1), Vector3.new(1370.2, 102.4, -1411.5)},
    {100, "SnowQuest", 2, "Snowman", Vector3.new(1384.1, 87.3, -1297.1), Vector3.new(1370.2, 102.4, -1411.5)},
    {120, "MarineQuest2", 1, "Chief Petty Officer", Vector3.new(-5035.1, 28.7, 4325.3), Vector3.new(-4882.9, 22.7, 4255.5)},
    {150, "SkyQuest", 1, "Sky Bandit", Vector3.new(-4841.8, 717.7, -2624.0), Vector3.new(-4970.7, 294.5, -2890.1)},
    {175, "SkyQuest", 2, "Dark Master", Vector3.new(-4841.8, 717.7, -2624.0), Vector3.new(-5220.6, 430.7, -2278.2)},
    {225, "ColosseumQuest", 1, "Toga Warrior", Vector3.new(-1576.1, 7.4, -2983.3), Vector3.new(-1780.0, 44.6, -2736.4)},
    {275, "ColosseumQuest", 2, "Gladiator", Vector3.new(-1576.1, 7.4, -2983.3), Vector3.new(-1274.8, 58.2, -3188.2)},
    {300, "MagmaQuest", 1, "Military Soldier", Vector3.new(-5316.6, 12.2, 8517.3), Vector3.new(-5363.0, 41.5, 8548.5)},
    {375, "FishmanQuest", 1, "Fishman Warrior", Vector3.new(61122.6, 18.5, 1568.2), Vector3.new(61163.9, 5.3, 1819.8)},
    {400, "FishmanQuest", 2, "Fishman Commando", Vector3.new(61122.6, 18.5, 1568.2), Vector3.new(61163.9, 5.3, 1819.8)},
    {450, "SkyExp1Quest", 1, "God's Guards", Vector3.new(-4721.7, 845.3, -1954.2), Vector3.new(-4717.0, 853.1, -1933.9)},
    {475, "SkyExp1Quest", 2, "Shandas", Vector3.new(-7863.6, 5545.5, -379.8), Vector3.new(-7685.1, 5601.1, -443.2)},
    {525, "SkyExp2Quest", 1, "Royal Squad", Vector3.new(-7902.7, 5636.0, -1411.7), Vector3.new(-7685.0, 5606.9, -1442.7)},
    {550, "SkyExp2Quest", 2, "Royal Soldier", Vector3.new(-7902.7, 5636.0, -1411.7), Vector3.new(-7864.4, 5661.9, -1708.2)},
    {625, "FountainQuest", 1, "Galley Pirate", Vector3.new(5254.6, 38.5, 4049.7), Vector3.new(5595.1, 41.5, 3961.5)},
    {700, "Area1Quest", 1, "Raider", Vector3.new(-424.1, 73.0, 1836.9), Vector3.new(-737.0, 39.2, 2392.6)},
    {725, "Area1Quest", 2, "Mercenary", Vector3.new(-424.1, 73.0, 1836.9), Vector3.new(-973.7, 95.9, 1836.5)},
    {775, "Area2Quest", 1, "Swan Pirate", Vector3.new(632.7, 73.1, 918.7), Vector3.new(970.4, 142.7, 1217.4)},
    {875, "MarineQuest3", 1, "Marine Lieutenant", Vector3.new(-2442.7, 73.1, -3219.1), Vector3.new(-2442.7, 73.1, -3219.1)},
    {900, "MarineQuest3", 2, "Marine Captain", Vector3.new(-2442.7, 73.1, -3219.1), Vector3.new(-1868.7, 73.0, -3321.7)},
    {950, "ZombieQuest", 1, "Zombie", Vector3.new(-5492.8, 48.5, -793.7), Vector3.new(-5634.8, 126.1, -697.7)},
    {975, "ZombieQuest", 2, "Vampire", Vector3.new(-5492.8, 48.5, -793.7), Vector3.new(-6030.3, 6.4, -1313.6)},
    {1000, "SnowMountainQuest", 1, "Snow Trooper", Vector3.new(605.0, 401.5, -5371.7), Vector3.new(535.9, 401.5, -5329.7)},
    {1050, "SnowMountainQuest", 2, "Winter Warrior", Vector3.new(605.0, 401.5, -5371.7), Vector3.new(1223.7, 454.6, -5170.0)},
    {1100, "IceSideQuest", 1, "Lab Subordinate", Vector3.new(-6060.1, 16.0, -4904.8), Vector3.new(-5769.2, 37.9, -4468.4)},
    {1125, "IceSideQuest", 2, "Horned Warrior", Vector3.new(-6060.1, 16.0, -4904.8), Vector3.new(-6400.9, 24.8, -5818.6)},
    {1175, "FireSideQuest", 1, "Magma Ninja", Vector3.new(-5431.1, 16.0, -5296.5), Vector3.new(-5496.7, 58.7, -5929.8)},
    {1200, "FireSideQuest", 2, "Lava Pirate", Vector3.new(-5431.1, 16.0, -5296.5), Vector3.new(-5169.7, 34.1, -4669.7)},
    {1350, "FrostQuest", 1, "Arctic Warrior", Vector3.new(5669.4, 28.2, -6482.6), Vector3.new(5995.1, 57.3, -6183.5)},
    {1375, "FrostQuest", 2, "Snow Lurker", Vector3.new(5669.4, 28.2, -6482.6), Vector3.new(5518.0, 60.6, -6828.8)},
    {1425, "ForgottenQuest", 1, "Sea Soldier", Vector3.new(-3053.0, 236.9, -10148.2), Vector3.new(-3030.4, 191.1, -9859.8)},
    {1500, "PiratePortQuest", 1, "Pirate Millionaire", Vector3.new(-290.1, 42.9, 5581.6), Vector3.new(81.2, 43.8, 5724.7)},
    {1525, "PiratePortQuest", 2, "Pistol Billionaire", Vector3.new(-290.1, 42.9, 5581.6), Vector3.new(81.2, 43.8, 5724.7)},
    {1575, "AmazonQuest", 1, "Dragon Crew Warrior", Vector3.new(5832.8, 51.7, -1101.5), Vector3.new(6242.0, 51.5, -1244.0)},
    {1600, "AmazonQuest", 2, "Dragon Crew Archer", Vector3.new(5832.8, 51.7, -1101.5), Vector3.new(6488.9, 383.4, -110.7)},
    {1625, "AmazonQuest2", 1, "Female Islander", Vector3.new(5448.9, 601.5, 751.1), Vector3.new(5825.2, 682.9, 704.6)},
    {1650, "AmazonQuest2", 2, "Giant Islander", Vector3.new(5448.9, 601.5, 751.1), Vector3.new(4530.4, 656.8, -131.6)},
    {1700, "MarineTreeIsland", 1, "Marine Commodore", Vector3.new(2180.5, 27.8, -6741.5), Vector3.new(2490.1, 190.4, -7160.1)},
    {1725, "MarineTreeIsland", 2, "Marine Rear Admiral", Vector3.new(2180.5, 27.8, -6741.5), Vector3.new(3951.4, 229.1, -6912.8)},
    {1775, "DeepForestIsland3", 1, "Fishman Raider", Vector3.new(-10581.7, 330.9, -8761.2), Vector3.new(-10322.4, 390.9, -8580.1)},
    {1800, "DeepForestIsland3", 2, "Fishman Captain", Vector3.new(-10581.7, 330.9, -8761.2), Vector3.new(-11194.5, 442.0, -8608.8)},
    {1825, "DeepForestIsland", 1, "Forest Pirate", Vector3.new(-13234.0, 331.5, -7625.4), Vector3.new(-13225.8, 428.2, -7753.1)},
    {1850, "DeepForestIsland", 2, "Mythological Pirate", Vector3.new(-13234.0, 331.5, -7625.4), Vector3.new(-13869.2, 565.0, -7084.4)},
    {1900, "DeepForestIsland2", 1, "Jungle Pirate", Vector3.new(-12680.4, 390.0, -9902.0), Vector3.new(-11982.2, 376.3, -10451.4)},
    {1925, "DeepForestIsland2", 2, "Musketeer Pirate", Vector3.new(-12680.4, 390.0, -9902.0), Vector3.new(-13282.3, 496.2, -9565.2)},
    {1975, "HauntedQuest1", 1, "Reborn Skeleton", Vector3.new(-9480.8, 142.1, 5566.1), Vector3.new(-8817.9, 191.2, 6298.7)},
    {2000, "HauntedQuest1", 2, "Living Zombie", Vector3.new(-9480.8, 142.1, 5566.1), Vector3.new(-10125.2, 183.9, 6242.0)},
    {2025, "HauntedQuest2", 1, "Demonic Soul", Vector3.new(-9517.0, 178.0, 6078.5), Vector3.new(-9712.0, 204.7, 6193.3)},
    {2050, "HauntedQuest2", 2, "Posessed Mummy", Vector3.new(-9517.0, 178.0, 6078.5), Vector3.new(-9545.8, 69.6, 6339.6)},
    {2075, "NutsIslandQuest", 1, "Peanut Scout", Vector3.new(-2104.4, 38.1, -10194.1), Vector3.new(-2126.4, 90.6, -10302.0)},
    {2100, "NutsIslandQuest", 2, "Peanut President", Vector3.new(-2104.4, 38.1, -10194.1), Vector3.new(-2118.8, 70.3, -10509.3)},
    {2125, "IceCreamIslandQuest", 1, "Ice Cream Chef", Vector3.new(-820.2, 65.8, -10966.2), Vector3.new(-685.3, 96.3, -10957.6)},
    {2150, "IceCreamIslandQuest", 2, "Ice Cream Commander", Vector3.new(-820.2, 65.8, -10966.2), Vector3.new(-635.7, 143.0, -11335.2)},
    -- [v2.5] Update 26-30: Cake Land -> Submerged Island (Lv 2200-2725)
    -- ชื่อ NPC ภายในยังไม่ยืนยัน 100% จึงใส่ aliases ไว้ (ช่อง 7) -- ระบบจะ
    -- ลองทีละชื่อให้เอง อันไหนรับเควสได้ = ใช้อันนั้น / ไม่ได้ = ข้ามไปก่อน
    {2200, "CakeIslandQuest", 1, "Cookie Crafter", nil, nil, {"CakeLandQuest", "CakeQuest"}},
    {2225, "CakeIslandQuest", 2, "Cake Guard", nil, nil, {"CakeLandQuest", "CakeQuest"}},
    {2250, "CakeIslandQuest", 3, "Baking Staff", nil, nil, {"CakeLandQuest", "CakeQuest"}},
    {2275, "CakeIslandQuest", 4, "Head Baker", nil, nil, {"CakeLandQuest", "CakeQuest"}},
    {2300, "ChocoIslandQuest", 1, "Cocoa Warrior", nil, nil, {"ChocolateIslandQuest", "ChocoQuest"}},
    {2325, "ChocoIslandQuest", 2, "Chocolate Bar Battler", nil, nil, {"ChocolateIslandQuest", "ChocoQuest"}},
    {2350, "ChocoIslandQuest", 3, "Sweet Thief", nil, nil, {"ChocolateIslandQuest", "ChocoQuest"}},
    {2375, "ChocoIslandQuest", 4, "Candy Rebel", nil, nil, {"ChocolateIslandQuest", "ChocoQuest"}},
    {2400, "CandyIslandQuest", 1, "Candy Pirate", nil, nil, {"CandyCaneIslandQuest", "CandyCaneQuest"}},
    {2425, "CandyIslandQuest", 2, "Snow Demon", nil, nil, {"CandyCaneIslandQuest", "CandyCaneQuest"}},
    {2450, "TikiIslandQuest", 1, "Isle Outlaw", nil, nil, {"TikiOutpostQuest", "TikiQuest"}},
    {2475, "TikiIslandQuest", 2, "Island Boy", nil, nil, {"TikiOutpostQuest", "TikiQuest"}},
    {2500, "TikiIslandQuest", 3, "Sun-kissed Warrior", nil, nil, {"TikiOutpostQuest", "TikiQuest"}},
    {2525, "TikiIslandQuest", 4, "Isle Champion", nil, nil, {"TikiOutpostQuest", "TikiQuest"}},
    {2550, "TikiIslandQuest", 5, "Serpent Hunter", nil, nil, {"TikiOutpostQuest", "TikiQuest"}},
    {2575, "TikiIslandQuest", 6, "Skull Slayer", nil, nil, {"TikiOutpostQuest", "TikiQuest"}},
    {2600, "SubmergedIslandQuest", 1, "Reef Bandit", nil, nil, {"SubmergedQuest", "SubIslandQuest"}},
    {2625, "SubmergedIslandQuest", 2, "Coral Pirate", nil, nil, {"SubmergedQuest", "SubIslandQuest"}},
    {2650, "SubmergedIslandQuest", 3, "Sea Chanter", nil, nil, {"SubmergedQuest", "SubIslandQuest"}},
    {2675, "SubmergedIslandQuest", 4, "Ocean Prophet", nil, nil, {"SubmergedQuest", "SubIslandQuest"}},
    {2700, "SubmergedIslandQuest", 5, "High Disciple", nil, nil, {"SubmergedQuest", "SubIslandQuest"}},
    {2725, "SubmergedIslandQuest", 6, "Grand Devotee", nil, nil, {"SubmergedQuest", "SubIslandQuest"}},
}

-- โหลดข้อมูลเควสเพิ่มเติม (override 3 ช่องทาง)
pcall(function()
    local function addEntry(e)
        if type(e) ~= "table" then return end
        local lv, npc, idx, enemy = e[1], e[2], e[3], e[4]
        if type(lv) == "number" and type(npc) == "string" and type(enemy) == "string" then
            table.insert(Quests, { lv, npc, tonumber(idx) or 1, enemy, e[5], e[6],
                type(e[7]) == "table" and e[7] or nil })
        end
    end
    -- 1) getgenv
    local g = getgenv().NX_QUESTS
    if type(g) == "table" then
        for _, e in ipairs(g) do addEntry(e) end
        print("[NOVEL-X] quest data: loaded " .. #g .. " entries from getgenv override")
    end
    -- 2) ไฟล์ json ในเครื่อง
    if isfile and isfile("NX-TJ-quests.json") then
        local arr = HttpService:JSONDecode(readfile("NX-TJ-quests.json"))
        for _, e in ipairs(arr) do addEntry(e) end
        print("[NOVEL-X] quest data: loaded entries from NX-TJ-quests.json")
    end
    -- 3) URL
    local u = getgenv().NX_QUESTS_URL
    if type(u) == "string" then
        local ok, res = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(u, true))
        end)
        if ok and type(res) == "table" then
            for _, e in ipairs(res) do addEntry(e) end
            print("[NOVEL-X] quest data: loaded entries from remote URL")
        end
    end
end)
-- เรียงเลเวล
table.sort(Quests, function(a, b) return a[1] < b[1] end)
-- ============================ [3] UI LIB ============================
-- UI สร้างเองทั้งหมด: ลากได้ / แท็บข้าง / ค้นหา / แจ้งเตือน / คีย์ลัด / ธีมสี
local UI = {}
do
    local ACCENTS = {
        Red    = Color3.fromRGB(235, 64, 74),
        Blue   = Color3.fromRGB(64, 132, 240),
        Purple = Color3.fromRGB(160, 92, 245),
        Green  = Color3.fromRGB(76, 200, 120),
        Yellow = Color3.fromRGB(245, 190, 70),
        Pink   = Color3.fromRGB(245, 105, 175),
    }
    local C_BG     = Color3.fromRGB(21, 21, 30)
    local C_SIDE   = Color3.fromRGB(16, 16, 24)
    local C_CARD   = Color3.fromRGB(28, 28, 40)
    local C_CARD2  = Color3.fromRGB(35, 35, 50)
    local C_TEXT   = Color3.fromRGB(235, 235, 240)
    local C_SUB    = Color3.fromRGB(150, 150, 165)
    local accentObjs = {}
    local function acc(obj, prop)
        table.insert(accentObjs, { o = obj, p = prop })
        obj[prop] = ACCENTS[CFG.Accent] or ACCENTS.Red
    end
    UI.SetAccent = function(name)
        if not ACCENTS[name] then return end
        CFG.Accent = name
        for _, a in ipairs(accentObjs) do
            pcall(function() a.o[a.p] = ACCENTS[name] end)
        end
    end
    UI.AccentColor = function() return ACCENTS[CFG.Accent] or ACCENTS.Red end
    UI.ACCENTS = ACCENTS

    local function new(class, props, parent)
        local o = Instance.new(class)
        for k, v in pairs(props) do o[k] = v end
        if parent then o.Parent = parent end
        return o
    end
    local function corner(o, r)
        new("UICorner", { CornerRadius = UDim.new(0, r or 6) }, o)
    end

    local gui = new("ScreenGui", {
        Name = "NOVEL-X-TJ",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })
    pcall(function() gui.Parent = (gethui and gethui()) or CoreGui end)
    if not gui.Parent then gui.Parent = LP:WaitForChild("PlayerGui") end
    UI.gui = gui

    -- หน้าต่างหลัก
    local window = new("Frame", {
        BackgroundColor3 = C_BG,
        Position = UDim2.new(0.5, -290, 0.5, -210),
        Size = UDim2.new(0, 580, 0, 420),
        Visible = true,
    }, gui)
    corner(window, 10)
    new("UIStroke", { Color = Color3.fromRGB(55, 55, 80), Thickness = 1 }, window)

    -- แถบหัว (ลากได้)
    local topbar = new("Frame", {
        BackgroundColor3 = C_SIDE,
        Size = UDim2.new(1, 0, 0, 44),
    }, window)
    corner(topbar, 10)
    new("Frame", { -- ปิดมุมล่างของ topbar
        BackgroundColor3 = C_SIDE,
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(1, 0, 0.5, 0),
        BorderSizePixel = 0,
    }, topbar)
    local titleTxt = new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 0),
        Size = UDim2.new(0, 200, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = "NOVEL-X",
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = C_TEXT,
    }, topbar)
    local subTxt = new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 92, 0, 0),
        Size = UDim2.new(0, 200, 1, 0),
        Font = Enum.Font.Gotham,
        Text = "| by TJ",
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = C_SUB,
    }, topbar)
    local miniDot = new("Frame", {
        BackgroundColor3 = ACCENTS[CFG.Accent] or ACCENTS.Red,
        Size = UDim2.new(0, 7, 0, 7),
    }, topbar)
    corner(miniDot, 4)
    acc(miniDot, "BackgroundColor3")
    miniDot.Position = UDim2.new(0, 78, 0.5, -3)

    local btnMin = new("TextButton", {
        BackgroundColor3 = C_CARD,
        Position = UDim2.new(1, -74, 0.5, -13),
        Size = UDim2.new(0, 26, 0, 26),
        Font = Enum.Font.GothamBold,
        Text = "-",
        TextSize = 14,
        TextColor3 = C_SUB,
    }, topbar)
    corner(btnMin, 6)
    local btnClose = new("TextButton", {
        BackgroundColor3 = Color3.fromRGB(90, 30, 36),
        Position = UDim2.new(1, -40, 0.5, -13),
        Size = UDim2.new(0, 26, 0, 26),
        Font = Enum.Font.GothamBold,
        Text = "X",
        TextSize = 12,
        TextColor3 = C_TEXT,
    }, topbar)
    corner(btnClose, 6)

    -- ปุ่มลอยตอนย่อหน้าต่าง
    local pill = new("TextButton", {
        BackgroundColor3 = C_BG,
        Position = UDim2.new(1, -130, 1, -60),
        Size = UDim2.new(0, 110, 0, 34),
        Font = Enum.Font.GothamBold,
        Text = "NX - by TJ",
        TextSize = 12,
        TextColor3 = C_TEXT,
        Visible = false,
    }, gui)
    corner(pill, 8)
    new("UIStroke", { Color = Color3.fromRGB(55, 55, 80), Thickness = 1 }, pill)
    local pillDot = new("Frame", {
        BackgroundColor3 = ACCENTS[CFG.Accent] or ACCENTS.Red,
        Position = UDim2.new(0, 10, 0.5, -3),
        Size = UDim2.new(0, 6, 0, 6),
    }, pill)
    corner(pillDot, 4)
    acc(pillDot, "BackgroundColor3")

    -- แถบข้าง (แท็บ)
    local sidebar = new("Frame", {
        BackgroundColor3 = C_SIDE,
        Position = UDim2.new(0, 0, 0, 44),
        Size = UDim2.new(0, 140, 1, -68),
    }, window)
    local sideList = new("UIListLayout", {
        Padding = UDim.new(0, 2),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, sidebar)
    new("UIPadding", {
        PaddingTop = UDim.new(0, 8), PaddingLeft = UDim.new(0, 6),
        PaddingRight = UDim.new(0, 6), PaddingBottom = UDim.new(0, 8),
    }, sidebar)

    -- เนื้อหา + ช่องค้นหา
    local content = new("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 140, 0, 44),
        Size = UDim2.new(1, -140, 1, -68),
    }, window)
    local searchBox = new("TextBox", {
        BackgroundColor3 = C_CARD,
        Position = UDim2.new(0, 8, 0, 6),
        Size = UDim2.new(1, -16, 0, 28),
        Font = Enum.Font.Gotham,
        PlaceholderText = "Search features... (พิมพ์เพื่อค้นหา)",
        Text = "",
        TextSize = 12,
        TextColor3 = C_TEXT,
        ClearTextOnFocus = false,
    }, content)
    corner(searchBox, 6)
    local scroll = new("ScrollingFrame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8, 0, 42),
        Size = UDim2.new(1, -16, 1, -50),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Color3.fromRGB(90, 90, 120),
        BorderSizePixel = 0,
    }, content)
    local scrollList = new("UIListLayout", {
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, scroll)
    new("UIPadding", {
        PaddingTop = UDim.new(0, 2), PaddingBottom = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2),
    }, scroll)

    -- แถบสถานะล่าง
    local statusTxt = new("TextLabel", {
        BackgroundColor3 = C_SIDE,
        Position = UDim2.new(0, 0, 1, -24),
        Size = UDim2.new(1, 0, 0, 24),
        Font = Enum.Font.Gotham,
        Text = "Lv ... | FPS ... | Beli ... | Fruit ...",
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = C_SUB,
    }, window)
    new("UIPadding", { PaddingLeft = UDim.new(0, 10) }, statusTxt)
    local creditTxt = new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -90, 1, -24),
        Size = UDim2.new(0, 80, 0, 24),
        Font = Enum.Font.GothamBold,
        Text = "made by TJ",
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Right,
        TextColor3 = C_SUB,
    }, window)

    -- ลากหน้าต่าง
    do
        local dragging, dragStart, startPos = false, nil, nil
        conn(topbar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = window.Position
            end
        end))
        conn(UserInput.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                window.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            end
        end))
        conn(UserInput.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end))
    end

    -- ย่อ/ขยาย + ปิด
    local minimized = false
    btnMin.MouseButton1Click:Connect(function()
        minimized = not minimized
        window.Visible = not minimized
        pill.Visible = minimized
    end)
    pill.MouseButton1Click:Connect(function()
        minimized = false
        window.Visible = true
        pill.Visible = false
    end)
    btnClose.MouseButton1Click:Connect(function()
        window.Visible = false
        pill.Visible = true
        minimized = true
    end)
    UI.toggleWindow = function()
        minimized = not minimized
        window.Visible = not minimized
        pill.Visible = minimized
    end

    -- คอมโพเนนต์ทั้งหมด (สำหรับค้นหา)
    local searchTargets = {}
    local function regSearch(title, inst)
        table.insert(searchTargets, { t = string.lower(title), i = inst })
    end
    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local q = string.lower(searchBox.Text)
        if q == "" then q = nil end
        for _, s in ipairs(searchTargets) do
            if q == nil or string.find(s.t, q, 1, true) then
                s.i.Visible = true
            else
                s.i.Visible = false
            end
        end
    end)

    -- ปิด dropdown ที่เปิดค้าง (list แขวนบน window เพราะ scroll ตัดขอบ)
    local openList = nil
    local function closeList()
        if openList then
            openList:Destroy()
            openList = nil
        end
    end

    -- สร้างแท็บ
    local tabs = {}
    local tabOrder = 0
    UI.Tab = function(name)
        tabOrder = tabOrder + 1
        local t = {}
        local btn = new("TextButton", {
            BackgroundColor3 = C_CARD,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 30),
            Font = Enum.Font.GothamMedium,
            Text = "  " .. name,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = C_SUB,
            LayoutOrder = tabOrder,
            AutoButtonColor = false,
        }, sidebar)
        corner(btn, 6)
        local dot = new("Frame", {
            BackgroundColor3 = ACCENTS[CFG.Accent] or ACCENTS.Red,
            Position = UDim2.new(0, 8, 0.5, -2),
            Size = UDim2.new(0, 4, 0, 4),
            Visible = false,
        }, btn)
        corner(dot, 2)
        acc(dot, "BackgroundColor3")
        local pad = new("UIPadding", { PaddingLeft = UDim.new(0, 16) }, btn)

        local page = new("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Visible = false,
        }, scroll)
        local pageList = new("UIListLayout", {
            Padding = UDim.new(0, 4),
            SortOrder = Enum.SortOrder.LayoutOrder,
        }, page)

        t.select = function()
            for _, other in ipairs(tabs) do
                other.page.Visible = false
                other.btn.BackgroundTransparency = 1
                other.btn.TextColor3 = C_SUB
                other.dot.Visible = false
            end
            page.Visible = true
            btn.BackgroundTransparency = 0
            btn.TextColor3 = C_TEXT
            dot.Visible = true
            closeList()
        end
        btn.MouseButton1Click:Connect(t.select)
        t.btn = btn
        t.dot = dot
        t.page = page
        table.insert(tabs, t)
        if #tabs == 1 then t.select() end
        return t
    end

    -- ------- คอมโพเนนต์ -------
    local compOrder = 0
    local function nextOrder() compOrder = compOrder + 1 return compOrder end

    UI.Section = function(tab, name)
        local holder = new("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 26),
            LayoutOrder = nextOrder(),
        }, tab.page)
        local bar = new("Frame", {
            BackgroundColor3 = ACCENTS[CFG.Accent] or ACCENTS.Red,
            Position = UDim2.new(0, 2, 0.5, -8),
            Size = UDim2.new(0, 3, 0, 16),
        }, holder)
        corner(bar, 2)
        acc(bar, "BackgroundColor3")
        new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 0),
            Size = UDim2.new(1, -12, 1, 0),
            Font = Enum.Font.GothamBold,
            Text = name,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = C_TEXT,
        }, holder)
        regSearch(name, holder)
        return holder
    end

    UI.Label = function(tab, text)
        local l = new("TextLabel", {
            BackgroundColor3 = C_CARD,
            BackgroundTransparency = 0.4,
            Size = UDim2.new(1, 0, 0, 24),
            Font = Enum.Font.Gotham,
            Text = text,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = C_SUB,
            LayoutOrder = nextOrder(),
        }, tab.page)
        corner(l, 6)
        new("UIPadding", { PaddingLeft = UDim.new(0, 8) }, l)
        regSearch(text, l)
        return {
            Set = function(v)
                l.Text = v
            end,
        }
    end

    -- [v2.5] ข้อความยาวหลายบรรทัด (ห่อบรรทัดอัตโนมัติ) -- ใช้กับไกด์ Island Secrets
    UI.Paragraph = function(tab, text)
        local l = new("TextLabel", {
            BackgroundColor3 = C_CARD,
            BackgroundTransparency = 0.4,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Font = Enum.Font.Gotham,
            Text = text,
            TextSize = 12,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextColor3 = C_SUB,
            LayoutOrder = nextOrder(),
        }, tab.page)
        corner(l, 6)
        new("UIPadding", {
            PaddingTop = UDim.new(0, 6),
            PaddingBottom = UDim.new(0, 6),
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
        }, l)
        regSearch(text, l)
        return {
            Set = function(v)
                l.Text = v
            end,
        }
    end

    UI.Button = function(tab, title, cb)
        local b = new("TextButton", {
            BackgroundColor3 = C_CARD,
            Size = UDim2.new(1, 0, 0, 30),
            Font = Enum.Font.GothamMedium,
            Text = title,
            TextSize = 12,
            TextColor3 = C_TEXT,
            LayoutOrder = nextOrder(),
        }, tab.page)
        corner(b, 6)
        b.MouseButton1Click:Connect(function() pcall(cb) end)
        regSearch(title, b)
        return b
    end

    UI.Toggle = function(tab, title, default, cb)
        local row = new("Frame", {
            BackgroundColor3 = C_CARD,
            Size = UDim2.new(1, 0, 0, 30),
            LayoutOrder = nextOrder(),
        }, tab.page)
        corner(row, 6)
        new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 8, 0, 0),
            Size = UDim2.new(1, -64, 1, 0),
            Font = Enum.Font.Gotham,
            Text = title,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = C_TEXT,
        }, row)
        local pill2 = new("TextButton", {
            BackgroundColor3 = C_CARD2,
            Position = UDim2.new(1, -44, 0.5, -9),
            Size = UDim2.new(0, 36, 0, 18),
            Text = "",
            AutoButtonColor = false,
        }, row)
        corner(pill2, 9)
        local knob = new("Frame", {
            BackgroundColor3 = C_SUB,
            Position = UDim2.new(0, 2, 0.5, -7),
            Size = UDim2.new(0, 14, 0, 14),
        }, pill2)
        corner(knob, 7)
        local state = default and true or false
        local ref = {}
        local function render(instant)
            if state then
                acc(pill2, "BackgroundColor3")
                if not instant then
                    TweenService:Create(knob, TweenInfo.new(0.15), { Position = UDim2.new(1, -16, 0.5, -7) }):Play()
                else
                    knob.Position = UDim2.new(1, -16, 0.5, -7)
                end
            else
                pill2.BackgroundColor3 = C_CARD2
                if not instant then
                    TweenService:Create(knob, TweenInfo.new(0.15), { Position = UDim2.new(0, 2, 0.5, -7) }):Play()
                else
                    knob.Position = UDim2.new(0, 2, 0.5, -7)
                end
            end
        end
        pill2.MouseButton1Click:Connect(function()
            state = not state
            render()
            pcall(cb, state)
        end)
        render(true)
        if default then pcall(cb, true) end
        regSearch(title, row)
        ref.Set = function(v)
            state = v and true or false
            render(true)
        end
        return ref
    end

    UI.Slider = function(tab, title, min, max, default, cb)
        local row = new("Frame", {
            BackgroundColor3 = C_CARD,
            Size = UDim2.new(1, 0, 0, 46),
            LayoutOrder = nextOrder(),
        }, tab.page)
        corner(row, 6)
        new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 8, 0, 4),
            Size = UDim2.new(1, -70, 0, 18),
            Font = Enum.Font.Gotham,
            Text = title,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = C_TEXT,
        }, row)
        local valTxt = new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -60, 0, 4),
            Size = UDim2.new(0, 52, 0, 18),
            Font = Enum.Font.GothamBold,
            Text = tostring(default),
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Right,
            TextColor3 = C_SUB,
        }, row)
        local track = new("TextButton", {
            BackgroundColor3 = C_CARD2,
            Position = UDim2.new(0, 8, 0, 28),
            Size = UDim2.new(1, -16, 0, 8),
            Text = "",
            AutoButtonColor = false,
        }, row)
        corner(track, 4)
        local fill = new("Frame", {
            BackgroundColor3 = ACCENTS[CFG.Accent] or ACCENTS.Red,
            Size = UDim2.new(0, 0, 1, 0),
        }, track)
        corner(fill, 4)
        acc(fill, "BackgroundColor3")
        local value = math.clamp(default, min, max)
        local ref = {}
        local function render()
            local alpha = (value - min) / math.max(max - min, 0.001)
            fill.Size = UDim2.new(alpha, 0, 1, 0)
            valTxt.Text = string.format("%.0f", value)
        end
        local function setFromX(x)
            local rel = (x - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1)
            value = math.floor(min + math.clamp(rel, 0, 1) * (max - min) + 0.5)
            render()
            pcall(cb, value)
        end
        track.MouseButton1Down:Connect(function()
            setFromX(UserInput:GetMouseLocation().X)
            local moveConn
            moveConn = UserInput.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    setFromX(input.Position.X)
                end
            end)
            local upConn
            upConn = UserInput.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if moveConn then moveConn:Disconnect() end
                    if upConn then upConn:Disconnect() end
                end
            end)
        end)
        render()
        pcall(cb, value)
        regSearch(title, row)
        ref.Set = function(v)
            value = math.clamp(v, min, max)
            render()
        end
        return ref
    end

    UI.Dropdown = function(tab, title, options, default, cb)
        local row = new("TextButton", {
            BackgroundColor3 = C_CARD,
            Size = UDim2.new(1, 0, 0, 30),
            Font = Enum.Font.Gotham,
            Text = "",
            TextSize = 12,
            AutoButtonColor = false,
            LayoutOrder = nextOrder(),
        }, tab.page)
        corner(row, 6)
        new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 8, 0, 0),
            Size = UDim2.new(0, 110, 1, 0),
            Font = Enum.Font.Gotham,
            Text = title,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = C_TEXT,
        }, row)
        local valTxt = new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 118, 0, 0),
            Size = UDim2.new(1, -140, 1, 0),
            Font = Enum.Font.GothamMedium,
            Text = tostring(default or "...") .. "  v",
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Right,
            TextColor3 = C_SUB,
        }, row)
        local current = default
        local opts = options or {}
        local ref = {}
        row.MouseButton1Click:Connect(function()
            closeList()
            local list = new("Frame", {
                BackgroundColor3 = C_CARD2,
                Position = UDim2.new(0, row.AbsolutePosition.X - window.AbsolutePosition.X,
                    0, row.AbsolutePosition.Y - window.AbsolutePosition.Y + 32),
                Size = UDim2.new(0, row.AbsoluteSize.X, 0, math.min(#opts, 8) * 26 + 4),
                Visible = false,
                ZIndex = 50,
            }, window)
            corner(list, 6)
            local ls = new("ScrollingFrame", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -4, 1, -4),
                Position = UDim2.new(0, 2, 0, 2),
                CanvasSize = UDim2.new(0, 0, 0, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollBarThickness = 2,
                BorderSizePixel = 0,
                ZIndex = 51,
            }, list)
            local ll = new("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder }, ls)
            for i, opt in ipairs(opts) do
                local ob = new("TextButton", {
                    BackgroundColor3 = C_CARD,
                    BackgroundTransparency = (opt == current) and 0 or 0.3,
                    Size = UDim2.new(1, 0, 0, 24),
                    Font = Enum.Font.Gotham,
                    Text = "  " .. tostring(opt),
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextColor3 = (opt == current) and C_TEXT or C_SUB,
                    ZIndex = 52,
                    LayoutOrder = i,
                }, ls)
                corner(ob, 4)
                ob.MouseButton1Click:Connect(function()
                    current = opt
                    valTxt.Text = tostring(opt) .. "  v"
                    closeList()
                    pcall(cb, opt)
                end)
            end
            openList = list
            list.Visible = true
        end)
        if default ~= nil then pcall(cb, default) end
        regSearch(title, row)
        ref.Set = function(v)
            current = v
            valTxt.Text = tostring(v) .. "  v"
        end
        ref.Refresh = function(newOpts)
            opts = newOpts or {}
        end
        return ref
    end

    UI.Keybind = function(tab, title, default, cb)
        local row = new("Frame", {
            BackgroundColor3 = C_CARD,
            Size = UDim2.new(1, 0, 0, 30),
            LayoutOrder = nextOrder(),
        }, tab.page)
        corner(row, 6)
        new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 8, 0, 0),
            Size = UDim2.new(1, -80, 1, 0),
            Font = Enum.Font.Gotham,
            Text = title,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = C_TEXT,
        }, row)
        local keyBtn = new("TextButton", {
            BackgroundColor3 = C_CARD2,
            Position = UDim2.new(1, -70, 0.5, -11),
            Size = UDim2.new(0, 62, 0, 22),
            Font = Enum.Font.GothamMedium,
            Text = default and default.Name or "None",
            TextSize = 11,
            TextColor3 = C_SUB,
        }, row)
        corner(keyBtn, 6)
        local listening = false
        keyBtn.MouseButton1Click:Connect(function()
            if listening then return end
            listening = true
            keyBtn.Text = "..."
        end)
        conn(UserInput.InputBegan:Connect(function(input, gp)
            if listening and not gp then
                listening = false
                local key = input.KeyCode
                keyBtn.Text = key.Name
                NX.lastBind = os.clock()
                pcall(cb, key)
            end
        end))
        regSearch(title, row)
        return keyBtn
    end

    -- ระบบแจ้งเตือน (มุมขวาบน)
    local notifRoot = new("Frame", {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -10, 0, 10),
        Size = UDim2.new(0, 270, 0, 400),
    }, gui)
    local notifList = new("UIListLayout", {
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
    }, notifRoot)
    local notifOrder = 0
    UI.Notify = function(title, text, dur)
        notifOrder = notifOrder + 1
        local n = new("Frame", {
            BackgroundColor3 = C_BG,
            Size = UDim2.new(0, 260, 0, 52),
            LayoutOrder = notifOrder,
        }, notifRoot)
        corner(n, 8)
        new("UIStroke", { Color = Color3.fromRGB(55, 55, 80), Thickness = 1 }, n)
        local bar2 = new("Frame", {
            BackgroundColor3 = ACCENTS[CFG.Accent] or ACCENTS.Red,
            Position = UDim2.new(0, 0, 0, 6),
            Size = UDim2.new(0, 3, 1, -12),
        }, n)
        corner(bar2, 2)
        acc(bar2, "BackgroundColor3")
        new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 6),
            Size = UDim2.new(1, -18, 0, 16),
            Font = Enum.Font.GothamBold,
            Text = tostring(title),
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = C_TEXT,
        }, n)
        new("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 24),
            Size = UDim2.new(1, -18, 0, 22),
            Font = Enum.Font.Gotham,
            Text = tostring(text),
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextXOverflow = Enum.TextXOverflow.Ellipsis,
            TextColor3 = C_SUB,
        }, n)
        task.delay(dur or 4, function()
            pcall(function()
                TweenService:Create(n, TweenInfo.new(0.3), {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.3, 0, 0, 0),
                }):Play()
            end)
            task.delay(0.35, function() pcall(function() n:Destroy() end) end)
        end)
    end

    UI.SetStatus = function(text)
        statusTxt.Text = text
    end
    UI.Title = titleTxt
end
-- เปลี่ยน Notify ให้ใช้ UI จริง + ระบายคิวที่ค้างไว้
do
    local flushQueue
    flushQueue = function()
        while #NX.notifyQueue > 0 do
            local n = table.remove(NX.notifyQueue, 1)
            UI.Notify(n.title, n.text, n.dur)
        end
    end
    Notify = function(title, text, dur)
        UI.Notify(title, text, dur)
        print(string.format("[NOVEL-X] %s: %s", tostring(title), tostring(text)))
    end
    flushQueue()
end
-- ============================ [4] ENGINE ============================
-- ระบบเควส: ตรวจยืนยันกับเกมจริง + mark รายการที่ใช้ไม่ได้เมื่อเกมอัปเดต

-- มีเควสกำลังทำอยู่? (รองรับทั้ง UI เก่า Main.Quest และ UI ใหม่ Quest.QuestBoard)
local function hasQuest()
    local ok, r = pcall(function()
        local pg = LP:FindFirstChild("PlayerGui")
        if not pg then return false end
        local main = pg:FindFirstChild("Main")
        if main and main:FindFirstChild("Quest") then return true end
        local q = pg:FindFirstChild("Quest")
        if q then
            local qb = q:FindFirstChild("QuestBoard")
            if qb and qb:IsA("GuiObject") and qb.Visible then return true end
        end
        return false
    end)
    return ok and r or false
end

-- อ่านชื่อเควสปัจจุบันจากหน้าจอ เช่น "Bandit [Lv. 5]"
local function questTitle()
    local ok, r = pcall(function()
        local pg = LP:FindFirstChild("PlayerGui")
        if not pg then return nil end
        local roots = {}
        local main = pg:FindFirstChild("Main")
        if main then table.insert(roots, main:FindFirstChild("Quest")) end
        table.insert(roots, pg:FindFirstChild("Quest"))
        for _, root in ipairs(roots) do
            if root then
                local descs = root:GetDescendants()
                for _, d in ipairs(descs) do
                    if d:IsA("TextLabel") and scontains(d.Text, "[Lv") then
                        return d.Text
                    end
                end
            end
        end
        return nil
    end)
    if ok then return r end
    return nil
end

-- เลือกเควส: รายการสูงสุดที่เลเวลถึง (ข้ามอันที่ mark ว่าใช้ไม่ได้)
local function pickQuest(lv)
    for i = #Quests, 1, -1 do
        local q = Quests[i]
        if q[1] <= lv and not NX.stale[q[1] .. "-" .. q[2]] then
            return q
        end
    end
    return nil
end
-- เลือกอันถัดไปที่ต่ำกว่า (เมื่ออันล่าสุดใช้ไม่ได้)
local function pickQuestFallback(lv, brokenEntry)
    for i = #Quests, 1, -1 do
        local q = Quests[i]
        if q[1] <= lv and not NX.stale[q[1] .. "-" .. q[2]] and q ~= brokenEntry then
            return q
        end
    end
    return nil
end

local acceptCooldown = {}
-- ลองรับเควส 1 ชื่อ NPC (remote แบบเดิม + แบบใหม่)
local function tryStartQuest(name, idx)
    invoke("StartQuest", name, idx)
    task.wait(0.35)
    if hasQuest() then return true end
    invoke("StartQuest", name, idx, 1)
    task.wait(0.35)
    if hasQuest() then return true end
    return false
end
local function acceptQuest(entry)
    local key = entry[1] .. "-" .. entry[2]
    local now = os.clock()
    if acceptCooldown[key] and now - acceptCooldown[key] < 8 then return false end
    acceptCooldown[key] = now

    -- ชื่อ NPC ที่จะลอง: ชื่อหลัก + aliases (ช่องที่ 7)
    local names = { entry[2] }
    if type(entry[7]) == "table" then
        for _, a in ipairs(entry[7]) do
            table.insert(names, a)
        end
    end

    -- วิธี 1-2: remote ทุกชื่อที่มี
    for _, nm in ipairs(names) do
        if tryStartQuest(nm, entry[3]) then return true end
    end

    -- วิธี 3: วาร์ปไปที่ NPC แล้วลองใหม่ (กันเกมบังคับให้อยู่ใกล้)
    if typeof(entry[5]) == "Vector3" then
        topos(CFrame.new(entry[5]))
        task.wait(0.6)
        for _, nm in ipairs(names) do
            if tryStartQuest(nm, entry[3]) then return true end
        end
    end
    return false
end

-- หาศัตรูจากชื่อ (workspace.Enemies / ถ้าไม่มีลอง workspace.Monster)
local function enemyRoot()
    local f = workspace:FindFirstChild("Enemies")
    if f then return f end
    return workspace:FindFirstChild("Monster")
end
local function matchEnemy(name, enemy)
    if scontains(name, enemy) then return true end
    -- กันพลาดแบบพหูพจน์: "Snow Bandit" vs "Snow Bandits"
    local e2 = enemy
    if string.sub(enemy, -1) == "s" then e2 = string.sub(enemy, 1, -2) end
    if scontains(name, e2) then return true end
    -- กันพลาดแบบตัดค้าง: "Gladiato" vs "Gladiator"
    if #enemy >= 6 and scontains(name, string.sub(enemy, 1, -2)) then return true end
    return false
end
local function findEnemy(enemy)
    local f = enemyRoot()
    if not f then return nil end
    for _, e in ipairs(f:GetChildren()) do
        local hrp = e:FindFirstChild("HumanoidRootPart")
        local hum = e:FindFirstChildOfClass("Humanoid")
        if hrp and hum and hum.Health > 0 and matchEnemy(e.Name, enemy) then
            return e, hrp, hum
        end
    end
    return nil
end
local function anyEnemy()
    local f = enemyRoot()
    if not f then return nil end
    for _, e in ipairs(f:GetChildren()) do
        local hrp = e:FindFirstChild("HumanoidRootPart")
        local hum = e:FindFirstChildOfClass("Humanoid")
        if hrp and hum and hum.Health > 0 then
            return e, hrp, hum
        end
    end
    return nil
end

-- ดึงศัตรูเข้ามาตี (แบบที่ hub ทุกตัวใช้)
local function bringEnemy(e, hrp)
    pcall(function()
        local rp = e.HumanoidRootPart
        rp.CanCollide = false
        rp.Massless = true
        rp.Size = Vector3.new(50, 50, 50)
        rp.CFrame = hrp.CFrame * CFrame.new(0, 0, -4)
    end)
end

-- ถืออาวุธที่เลือก
local function equipWeapon()
    local c, _, hum = getChar()
    if not (c and hum) then return end
    local w = CFG.Weapon
    if w == "Combat" or w == "None" then w = "Combat" end
    local cur = c:FindFirstChild(w)
    if cur and cur:IsA("Tool") then return end
    local bp = LP:FindFirstChild("Backpack")
    if not bp then return end
    local t = bp:FindFirstChild(w)
    if t and t:IsA("Tool") then
        pcall(function() hum:EquipTool(t) end)
    end
end

-- โจมตีเร็ว: Activate หลายครั้ง/เฟรม + คลิกผ่าน VirtualUser
local function attack(n)
    local c = LP.Character
    if not c then return end
    local tool = c:FindFirstChildOfClass("Tool")
    if tool then
        for i = 1, n do
            pcall(function() tool:Activate() end)
        end
    end
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:Button1Down(Vector2.new(9999, 9999))
        VirtualUser:Button1Up(Vector2.new(9999, 9999))
    end)
end

-- Haki (ผ่าน remote ตามที่ hub จริงใช้: CommF_ "Buso"/"Ken")
local function autoHaki()
    local c = LP.Character
    if not c then return end
    if CFG.AutoBuso and not c:FindFirstChild("HasBuso") then
        invoke("Buso")
    end
    if CFG.AutoKen and not c:FindFirstChild("HasKen") then
        invoke("Ken")
    end
end

-- อัพสเตตัส (ผ่าน RemoteEvent ใน PlayerGui ตามที่ hub จริงใช้)
local statsWarned = false
local function allocateStats()
    local pts = getPoints() - CFG.KeepPoints
    if pts < 1 then return end
    local ok = pcall(function()
        local ev = LP.PlayerGui.Stats.Button.StatsFrame.RemoteEvent
        ev:FireServer(CFG.StatPriority, pts)
    end)
    if not ok and not statsWarned then
        statsWarned = true
        Notify("Auto Stats", "เข้าถึงปุ่มอัพสเตตัสไม่ได้ (UI เกมเปลี่ยน) -- ข้ามไปก่อน")
    end
end

-- สกิล Z X C V อัตโนมัติ (แบบ PC: ส่งคีย์จริง)
local skillKeys = { 122, 120, 99, 118 } -- Z X C V
local function useSkills()
    if not CFG.AutoSkills then return end
    local c = LP.Character
    if not c then return end
    for _, kc in ipairs(skillKeys) do
        pcall(function()
            VirtualInput:SendKeyEvent(true, kc, false, game)
            VirtualInput:SendKeyEvent(false, kc, false, game)
        end)
    end
end

-- ค้นหาผลไม้ในแผนที่ (โมเดลชื่อมีคำว่า Fruit)
local function findWorldFruit()
    local exclude = { "Dealer", "Seller", "Shop", "Buy", "Stand", "Npc", "Quest" }
    for _, ch in ipairs(workspace:GetChildren()) do
        local n = ch.Name
        if scontains(n, "Fruit") then
            local bad = false
            for _, ex in ipairs(exclude) do
                if scontains(n, ex) then bad = true end
            end
            if not bad then
                if ch:IsA("BasePart") then return n, ch.Position end
                if ch:IsA("Model") then
                    local pp = ch:FindFirstChildWhichIsA("BasePart", true)
                    if pp then return n, pp.Position end
                end
            end
        end
    end
    return nil, nil
end

-- Sea Beast (สแกนชื่อ)
local function findSeaBeast()
    for _, ch in ipairs(workspace:GetChildren()) do
        if scontains(ch.Name, "SeaBeast") or scontains(ch.Name, "Sea Beast") then
            local pp = ch:IsA("Model") and ch:FindFirstChildWhichIsA("BasePart", true) or ch
            if pp and pp:IsA("BasePart") then return ch, pp.Position end
        end
    end
    return nil, nil
end

-- ---------------- ลูปหลัก: AUTO FARM + QUEST ----------------
local farmStatus = "Idle"
local lastQuestCheck = 0
task.spawn(function()
    local skillTick = 0
    while not NX.dead do
        task.wait(0.2)
        if not (CFG.AutoFarm or CFG.FarmAll or CFG.AutoAwakened) then
            farmStatus = "Idle"
        else
            local c, hrp, hum = alive()
            if not c then
                farmStatus = "Waiting respawn..."
            else
                local lv = getLevel()
                -- Update 30: ถึงแคป 2800 แล้ว เควสจะไม่ให้เลเวลอีก -- ต้องทำ Island Secrets
                local atCap = lv >= BASE_CAP
                local entry = nil
                if not atCap then
                    entry = pickQuest(lv)
                end
                NX.currentEntry = entry

                if atCap then
                    farmStatus = "CAP 2800 -- ทำ Island Secrets (แท็บ Secrets) ให้ครบ = 3000"
                    if not NX.capNotified then
                        NX.capNotified = true
                        Notify("MAX LEVEL 2800",
                            "เควสปกติเก็บได้ถึงแคป 2800 แล้ว -- ทำ Island Secrets 40 อันที่ Sea 1 " ..
                            "(ดูแท็บ Secrets) อันละ +5 เลเวล รวมไปถึง 3000", 12)
                    end
                end

                -- 0) Sea Beast มาก่อน (ถ้าเปิด)
                if CFG.AutoSeaBeast then
                    local beast, bpos = findSeaBeast()
                    if beast then
                        farmStatus = "Sea Beast!"
                        topos(CFrame.new(bpos + Vector3.new(0, 20, 0)))
                        equipWeapon()
                        attack(CFG.AttackSpeed)
                        skillTick = skillTick + 1
                        if skillTick >= 3 then useSkills() skillTick = 0 end
                        -- วนต่อไปเรื่อยๆ จนไม่เจอ beast
                    end
                end

                -- 1) เปิด Haki
                autoHaki()

                -- 2) อัพสเตตัส
                if CFG.AutoStats then allocateStats() end

                -- 3) ถืออาวุธ
                equipWeapon()

                -- 4) เควส: ต้องมีเควสก่อนตี (โหมดฟาร์มปกติ) -- ข้ามถึงแคปแล้ว
                if CFG.AutoFarm and not CFG.FarmAll and not atCap then
                    if not hasQuest() then
                        if entry then
                            farmStatus = "Accepting quest..."
                            local ok = acceptQuest(entry)
                            if not ok then
                                -- เกมอัปเดตเควสนี้? -> mark แล้วใช้เควสก่อนหน้าแทน
                                local fallback = pickQuestFallback(lv, entry)
                                if fallback and fallback ~= entry then
                                    NX.stale[entry[1] .. "-" .. entry[2]] = true
                                    Notify("Quest Data",
                                        "Lv " .. entry[1] .. " (" .. entry[4] .. ") ใช้ไม่ได้แล้ว -- สลับไป Lv " ..
                                        fallback[1] .. " ชั่วคราว (รออัปเดตข้อมูล)", 7)
                                else
                                    NX.stale[entry[1] .. "-" .. entry[2]] = true
                                    Notify("Quest Data",
                                        "ไม่มีเควสที่ใช้ได้สำหรับ Lv " .. lv .. " -- ตรวจแท็บ Quest", 7)
                                end
                            end
                        else
                            farmStatus = "No quest data for your level"
                        end
                    else
                        -- มีเควสอยู่แล้ว: เช็คว่าตรงเลเวลไหม (สลับเควสอัตโนมัติ)
                        if CFG.AutoSwap and entry then
                            local t = questTitle()
                            if t and not matchEnemy(t, entry[4]) and os.clock() - lastQuestCheck > 3 then
                                lastQuestCheck = os.clock()
                                invoke("AbandonQuest")
                            end
                        end
                    end
                end

                -- 5) หาเป้าหมาย + โจมตี (บอส Awakened = Island Secrets มีความสำคัญสูงสุด)
                local target, trp, thum
                if CFG.AutoAwakened then
                    target, trp, thum = findEnemy("Awakened")
                    if target then
                        farmStatus = "AWAKENED: " .. stripLv(target.Name)
                    end
                end
                if not target and CFG.FarmAll then
                    target, trp, thum = anyEnemy()
                    if target then
                        farmStatus = "Farming all: " .. stripLv(target.Name)
                    end
                elseif (not target) and entry then
                    target, trp, thum = findEnemy(entry[4])
                    if target then
                        farmStatus = "Lv " .. lv .. " > " .. entry[4]
                    end
                end

                if target and trp then
                    if CFG.FarmMode == "Bring Enemies" then
                        bringEnemy(target, hrp)
                    else
                        topos(trp.CFrame * CFrame.new(0, 0, 8))
                    end
                    attack(CFG.AttackSpeed)
                    skillTick = skillTick + 1
                    if skillTick >= 3 then useSkills() skillTick = 0 end
                elseif not CFG.FarmAll then
                    -- ไม่เจอศัตรู: ถ้าเควสยังไม่ยอมเกิด ไปรอที่จุดเกิดของมัน
                    if entry and typeof(entry[6]) == "Vector3" then
                        farmStatus = "Waiting mobs..."
                        topos(CFrame.new(entry[6]))
                    elseif entry then
                        farmStatus = "Waiting mobs (ไม่มีพิกัด -- โหมด Bring จะดึงศัตรูมาเอง)"
                    end
                end
            end
        end
    end
end)

-- ---------------- ลูปเสริม: สแกนผลไม้ / แจ้งเตือน ----------------
task.spawn(function()
    local seenFruits = {}
    while not NX.dead do
        task.wait(2)
        -- Fruit sniper
        local fname, fpos = findWorldFruit()
        if fname and fpos then
            if not seenFruits[fname] then
                seenFruits[fname] = true
                if CFG.FruitNotify then
                    Notify("Fruit Found", fname .. " spawned! (made by TJ)", 6)
                end
            end
            if CFG.FruitSniper then
                topos(CFrame.new(fpos))
            end
        else
            seenFruits = {}
        end
    end
end)

-- ---------------- ลูปเสริม: เฝ้าบอส Awakened (Island Secrets -- Update 30) ----------------
-- บอส Awakened สุ่มเกิดราวๆ ทุกชั่วโมง (นาที 00:XX) พร้อมข้อความแจ้งบนจอ
-- เจอแล้ว: แจ้งเตือนทันที / ถ้าเปิดล่าอัตโนมัติ = วาร์ปไปตีให้เอง (ในลูปหลัก)
task.spawn(function()
    local seenAwakened = {}
    while not NX.dead do
        task.wait(2)
        local f = enemyRoot()
        if f then
            local aliveNow = {}
            for _, e in ipairs(f:GetChildren()) do
                if scontains(e.Name, "Awakened") then
                    local hm = e:FindFirstChildOfClass("Humanoid")
                    if hm and hm.Health > 0 then
                        aliveNow[e.Name] = true
                        if not seenAwakened[e.Name] then
                            Notify("AWAKENED BOSS",
                                stripLv(e.Name) .. " เกิดแล้ว! (Island Secrets -- Sea 1)", 8)
                        end
                    end
                end
            end
            seenAwakened = aliveNow
        end
    end
end)

-- ---------------- ลูปเสริม: WalkSpeed / JumpPower ----------------
task.spawn(function()
    while not NX.dead do
        task.wait(0.5)
        pcall(function()
            local c, hrp, hum = getChar()
            if not hum then return end
            if CFG.WalkSpeedOn then hum.WalkSpeed = CFG.WalkSpeed end
            if CFG.JumpPowerOn then
                pcall(function() hum.UseJumpPower = true end)
                hum.JumpPower = CFG.JumpPower
            end
        end)
    end
end)

-- ---------------- Noclip / Fly (RenderStepped) ----------------
conn(RunService.Stepped:Connect(function()
    if CFG.Noclip then
        pcall(function()
            local c = LP.Character
            if c then
                for _, p in ipairs(c:GetChildren()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end)
    end
end))
conn(RunService.Heartbeat:Connect(function()
    if not CFG.Fly then return end
    pcall(function()
        local c, hrp, hum = alive()
        if not hrp then return end
        local cam = workspace.CurrentCamera
        local v = Vector3.new()
        if UserInput:IsKeyDown(Enum.KeyCode.W) then v = v + cam.CFrame.LookVector end
        if UserInput:IsKeyDown(Enum.KeyCode.S) then v = v - cam.CFrame.LookVector end
        if UserInput:IsKeyDown(Enum.KeyCode.A) then v = v - cam.CFrame.RightVector end
        if UserInput:IsKeyDown(Enum.KeyCode.D) then v = v + cam.CFrame.RightVector end
        if UserInput:IsKeyDown(Enum.KeyCode.Space) then v = v + Vector3.new(0, 1, 0) end
        if UserInput:IsKeyDown(Enum.KeyCode.LeftShift) then v = v - Vector3.new(0, 1, 0) end
        if v.Magnitude > 0 then
            hrp.Velocity = v.Unit * CFG.FlySpeed
        else
            hrp.Velocity = Vector3.new(0, 0, 0)
        end
    end)
end))

-- Infinite Jump
conn(UserInput.JumpRequest:Connect(function()
    if CFG.InfJump then
        pcall(function()
            local c, hrp, hum = getChar()
            if hum then hum.Jump = true end
        end)
    end
end))

-- ---------------- ESP (Drawing API -- PC เท่านั้น) ----------------
do
    local canDraw = false
    pcall(function() canDraw = (typeof(Drawing) == "table" or typeof(Drawing) == "userdata") and Drawing.new ~= nil end)
    if not canDraw then
        pcall(function()
            local test = Drawing.new("Text")
            test:Remove()
            canDraw = true
        end)
    end
    NX.canDraw = canDraw
    if canDraw then
        local cache = {}
        local function mkText(color)
            local t = Drawing.new("Text")
            t.Size = 13
            t.Center = true
            t.Outline = true
            t.Color = color
            t.Font = 2
            t.Visible = false
            return t
        end
        local function mkLine(color)
            local l = Drawing.new("Line")
            l.Thickness = 1
            l.Color = color
            l.Visible = false
            return l
        end
        local function clearAll()
            for _, e in pairs(cache) do
                pcall(function() e.t:Remove() end)
                pcall(function() e.l:Remove() end)
            end
            cache = {}
        end
        local function addEntry(key, color, text, pos, tracer)
            local e = cache[key]
            if not e then
                e = { t = mkText(color), l = mkLine(color) }
                cache[key] = e
            end
            e.t.Text = text
            e.t.Position = Vector2.new(pos.X, pos.Y)
            e.t.Visible = true
            if tracer then
                local cam = workspace.CurrentCamera
                local vp = cam.ViewportSize
                e.l.From = Vector2.new(vp.X / 2, vp.Y)
                e.l.To = Vector2.new(pos.X, pos.Y)
                e.l.Visible = true
            else
                e.l.Visible = false
            end
            e.dead = false
        end
        local acc = 0
        conn(RunService.RenderStepped:Connect(function(dt)
            acc = acc + dt
            if acc < 0.08 then return end
            acc = 0
            if not CFG.ESP then
                clearAll()
                return
            end
            for _, e in pairs(cache) do e.dead = true end
            local cam = workspace.CurrentCamera
            if not cam then return end
            local camPos = cam.CFrame.Position
            local function proj(worldPos)
                local sp, onScreen = cam:WorldToViewportPoint(worldPos)
                if not onScreen then return nil end
                return sp, (worldPos - camPos).Magnitude
            end
            -- Players
            if CFG.ESPPlayers then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LP and p.Character then
                        local hrp2 = p.Character:FindFirstChild("HumanoidRootPart")
                        if hrp2 then
                            local sp, dist = proj(hrp2.Position)
                            if sp and dist <= CFG.ESPDistance then
                                local nm = p.Name
                                pcall(function()
                                    local plv = p.Data.Level.Value
                                    nm = p.Name .. " [Lv " .. plv .. "]"
                                end)
                                addEntry("P:" .. p.Name, Color3.fromRGB(255, 90, 90),
                                    nm .. " (" .. string.format("%.0f", dist) .. "m)", sp, CFG.ESPTracers)
                            end
                        end
                    end
                end
            end
            -- Enemies (เฉพาะเป้าเควส + ทุกตัวถ้าเปิด)
            if CFG.ESPEnemies then
                local f = enemyRoot()
                if f then
                    for _, e2 in ipairs(f:GetChildren()) do
                        local rp = e2:FindFirstChild("HumanoidRootPart")
                        local hm = e2:FindFirstChildOfClass("Humanoid")
                        if rp and hm and hm.Health > 0 then
                            local sp, dist = proj(rp.Position)
                            if sp and dist <= CFG.ESPDistance then
                                local nm = stripLv(e2.Name)
                                local hp = string.format("%.0f", hm.Health / math.max(hm.MaxHealth, 1) * 100)
                                addEntry("E:" .. e2.Name, Color3.fromRGB(255, 200, 90),
                                    nm .. " " .. hp .. "% (" .. string.format("%.0f", dist) .. "m)", sp, CFG.ESPTracers)
                            end
                        end
                    end
                end
            end
            -- Fruits
            if CFG.ESPFruits then
                local exclude = { "Dealer", "Seller", "Shop", "Buy", "Stand", "Npc", "Quest" }
                for _, ch in ipairs(workspace:GetChildren()) do
                    local n = ch.Name
                    if scontains(n, "Fruit") then
                        local bad = false
                        for _, ex in ipairs(exclude) do
                            if scontains(n, ex) then bad = true end
                        end
                        if not bad then
                            local pos = nil
                            if ch:IsA("BasePart") then pos = ch.Position end
                            if ch:IsA("Model") then
                                local pp = ch:FindFirstChildWhichIsA("BasePart", true)
                                if pp then pos = pp.Position end
                            end
                            if pos then
                                local sp, dist = proj(pos)
                                if sp then
                                    addEntry("F:" .. n, Color3.fromRGB(110, 255, 130),
                                        n .. " (" .. string.format("%.0f", dist) .. "m)", sp, CFG.ESPTracers)
                                end
                            end
                        end
                    end
                end
            end
            -- Chests
            if CFG.ESPChests then
                for _, ch in ipairs(workspace:GetChildren()) do
                    if scontains(ch.Name, "Chest") then
                        local pos = nil
                        if ch:IsA("BasePart") then pos = ch.Position end
                        if ch:IsA("Model") then
                            local pp = ch:FindFirstChildWhichIsA("BasePart", true)
                            if pp then pos = pp.Position end
                        end
                        if pos then
                            local sp, dist = proj(pos)
                            if sp then
                                addEntry("C:" .. ch.Name, Color3.fromRGB(255, 220, 90),
                                    ch.Name .. " (" .. string.format("%.0f", dist) .. "m)", sp, CFG.ESPTracers)
                            end
                        end
                    end
                end
            end
            -- เอารายการที่หายไปออก
            for k, e in pairs(cache) do
                if e.dead then
                    pcall(function() e.t:Remove() end)
                    pcall(function() e.l:Remove() end)
                    cache[k] = nil
                end
            end
        end))
    end
end

-- ---------------- Server Hop / Rejoin / Auto Rejoin ----------------
local function serverHop()
    Notify("Server Hop", "Looking for a new server...")
    local ok, err = pcall(function()
        local url = "https://games.roblox.com/v1/games/" ..
            tostring(game.PlaceId) .. "/servers/Public?sortOrder=Asc&limit=100"
        local res = HttpService:JSONDecode(game:HttpGet(url))
        local candidates = {}
        for _, s in ipairs(res.data or {}) do
            if s.id ~= game.JobId and (s.playing or 0) < (s.maxPlayers or 1) then
                table.insert(candidates, s)
            end
        end
        if #candidates == 0 then
            Notify("Server Hop", "No free server found. Try again.")
            return
        end
        local pick = candidates[math.random(#candidates)]
        TeleportService:TeleportToPlaceInstance(game.PlaceId, pick.id, LP)
    end)
    if not ok then
        Notify("Server Hop", "Failed: " .. tostring(err))
    end
end
local function rejoin()
    Notify("Rejoin", "Rejoining...")
    pcall(function() TeleportService:Teleport(game.PlaceId, LP) end)
end
task.spawn(function()
    local lastTry = 0
    while not NX.dead do
        task.wait(2)
        if CFG.AutoRejoin then
            pcall(function()
                local po = CoreGui:FindFirstChild("RobloxPromptGui")
                if po then
                    local overlay = po:FindFirstChild("promptOverlay")
                    if overlay and #overlay:GetChildren() > 0 then
                        if os.clock() - lastTry > 5 then
                            lastTry = os.clock()
                            Notify("Auto Rejoin", "Kick detected -- rejoining!")
                            TeleportService:Teleport(game.PlaceId, LP)
                        end
                    end
                end
            end)
        end
    end
end)
-- ============================ [5] TABS ==============================
-- ------- อัพเดตตัวเลือกอาวุธ/ศัตรู/ผู้เล่น แบบสด -------
local function getWeaponOptions()
    local opts = { "Combat" }
    local bp = LP:FindFirstChild("Backpack")
    if bp then
        for _, t in ipairs(bp:GetChildren()) do
            if t:IsA("Tool") and t.Name ~= "Combat" then
                table.insert(opts, t.Name)
            end
        end
    end
    return opts
end
local function getEnemyOptions()
    local opts = {}
    local f = enemyRoot()
    if f then
        local seen = {}
        for _, e in ipairs(f:GetChildren()) do
            local nm = stripLv(e.Name)
            if not seen[nm] then
                seen[nm] = true
                table.insert(opts, nm)
            end
        end
        table.sort(opts)
    end
    return opts
end
local function getPlayerOptions()
    local opts = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then table.insert(opts, p.Name) end
    end
    return opts
end

-- ================= HOME =================
do
    local t = UI.Tab("Home")
    UI.Section(t, "Welcome")
    UI.Label(t, "NOVEL-X v2.5 -- TJ EDITION | PC ONLY | NO KEY | MAX LV 3000").Set = "NOVEL-X v2.5 -- TJ EDITION | PC ONLY | NO KEY | MAX LV 3000"
    UI.Label(t, "made by TJ -- free forever")
    UI.Section(t, "Quick Start")
    UI.Button(t, "Start Auto Farm (เริ่มฟาร์มอัตโนมัติ)", function()
        NX.setFarm(true)
        Notify("Auto Farm", "Started -- good luck! (made by TJ)")
    end)
    UI.Button(t, "Stop All Loops (หยุดทุกอย่าง)", function()
        NX.setFarm(false)
        CFG.FarmAll = false
        NX.setFly(false)
        CFG.FruitSniper = false
        Notify("Stopped", "All farm loops stopped.")
    end)
    UI.Section(t, "Live Status")
    local st1 = UI.Label(t, "Lv ...")
    local st2 = UI.Label(t, "Quest: ...")
    local st3 = UI.Label(t, "Farm: ...")
    local st4 = UI.Label(t, "Secrets: ...")
    task.spawn(function()
        while not NX.dead do
            task.wait(1)
            local e = NX.currentEntry
            st1.Set(string.format("Lv %d | Beli %s | Fragments %s | Fruit: %s",
                getLevel(), tostring(getBeli()), tostring(getFrag()), tostring(getFruit())))
            local qt = questTitle()
            if hasQuest() then
                st2.Set("Quest: " .. tostring(qt or "active"))
            else
                st2.Set("Quest: none")
            end
            if e then
                st3.Set(string.format("Target quest: Lv %d %s (NPC %s #%d)",
                    e[1], e[4], e[2], e[3]))
            elseif getLevel() >= 2800 then
                st3.Set("Target: ISLAND SECRETS -- แคป 2800 แล้ว (ดูแท็บ Secrets)")
            else
                st3.Set("Target quest: no data for this level")
            end
            -- สถานะ Island Secrets (Update 30): เลเวลที่เกิน 2800 = มาจาก secrets
            local lvNow = getLevel()
            if lvNow > 2800 then
                local secretLv = lvNow - 2800
                local est = math.min(math.floor(secretLv / 5), 40)
                st4.Set(string.format("Secret Levels: +%d (ประมาณ %d/40 secrets) | แคปตอนนี้: %d",
                    secretLv, est, 2800 + est * 5))
            elseif lvNow == 2800 then
                st4.Set("ครบแคป 2800 -- เริ่มทำ Island Secrets ได้เลย (แท็บ Secrets)")
            else
                st4.Set(string.format("ปกติ -- ฟาร์มเควสถึง 2800 ก่อน (เหลืออีก %d เลเวล)", 2800 - lvNow))
            end
        end
    end)
end

-- ================= FARM =================
do
    local t = UI.Tab("Farm")
    UI.Section(t, "Auto Farm Level")
    local farmToggle
    farmToggle = UI.Toggle(t, "Auto Farm (Quest Mode)", false, function(v)
        CFG.AutoFarm = v
        if v then Notify("Auto Farm", "Quest mode ON -- leveling with quests") end
    end)
    NX.setFarm = function(v)
        CFG.AutoFarm = v and true or false
        if farmToggle then farmToggle.Set(v) end
    end
    UI.Toggle(t, "Auto Swap Quest (สลับเควสตามเลเวล)", CFG.AutoSwap, function(v)
        CFG.AutoSwap = v
    end)
    UI.Dropdown(t, "Farm Mode", { "Bring Enemies", "Go To Enemies (Safe)" }, CFG.FarmMode, function(v)
        CFG.FarmMode = v
    end)
    local wepDrop
    wepDrop = UI.Dropdown(t, "Weapon", getWeaponOptions(), CFG.Weapon, function(v)
        CFG.Weapon = v
    end)
    UI.Button(t, "Refresh weapon list", function()
        wepDrop.Refresh(getWeaponOptions())
        wepDrop.Set(CFG.Weapon)
    end)
    UI.Slider(t, "Attack Speed (clicks/frame)", 1, 10, CFG.AttackSpeed, function(v)
        CFG.AttackSpeed = v
    end)
    UI.Toggle(t, "Auto Skills Z X C V", CFG.AutoSkills, function(v)
        CFG.AutoSkills = v
    end)
    UI.Section(t, "Modes")
    UI.Toggle(t, "Farm All Enemies (no quest)", false, function(v)
        CFG.FarmAll = v
        if v then Notify("Farm All", "Attacking every enemy nearby") end
    end)
    UI.Toggle(t, "Auto Sea Beast (โจมตี Sea Beast)", false, function(v)
        CFG.AutoSeaBeast = v
    end)
    UI.Section(t, "Combat Extras")
    UI.Toggle(t, "Auto Buso Haki", CFG.AutoBuso, function(v)
        CFG.AutoBuso = v
    end)
    UI.Toggle(t, "Auto Ken Haki (Observation)", CFG.AutoKen, function(v)
        CFG.AutoKen = v
    end)
    UI.Toggle(t, "Auto Stats (อัพค่าสเตตัส)", CFG.AutoStats, function(v)
        CFG.AutoStats = v
    end)
    UI.Dropdown(t, "Stat Priority", { "Melee", "Defense", "Sword", "Gun", "Demon Fruit" }, CFG.StatPriority, function(v)
        CFG.StatPriority = v
    end)
    UI.Slider(t, "Keep Points (เก็บไว้กี่แต้ม)", 0, 100, CFG.KeepPoints, function(v)
        CFG.KeepPoints = v
    end)
    -- อัพเดตรายชื่ออาวุธเรื่อยๆ
    task.spawn(function()
        while not NX.dead do
            task.wait(5)
            pcall(function() wepDrop.Refresh(getWeaponOptions()) end)
        end
    end)
end

-- ================= QUEST =================
do
    local t = UI.Tab("Quest")
    UI.Section(t, "Quest System")
    UI.Label(t, "ระบบเควสอัตโนมัติ: รับเควส ตี สลับเควสเองตามเลเวล").Set = "ระบบเควสอัตโนมัติ: รับเควส ตี สลับเควสเองตามเลเวล"
    UI.Button(t, "Abandon Current Quest (ละทิ้งเควสปัจจุบัน)", function()
        invoke("AbandonQuest")
        Notify("Quest", "Abandoned.")
    end)
    UI.Button(t, "Accept Best Quest Now (รับเควสที่ดีที่สุดเดี๋ยวนี้)", function()
        local lv = getLevel()
        local e = pickQuest(lv)
        if e then
            Notify("Quest", "Trying: Lv " .. e[1] .. " " .. e[4])
            task.spawn(function()
                local ok = acceptQuest(e)
                Notify("Quest", ok and "Accepted!" or "Failed (server refused)")
            end)
        else
            Notify("Quest", "No quest data for Lv " .. lv)
        end
    end)
    UI.Section(t, "Quest Data Status (สถานะฐานข้อมูลเควส)")
    local dq1 = UI.Label(t, "...")
    local dq2 = UI.Label(t, "...")
    UI.Button(t, "Re-Verify Quests (ล้าง mark แล้วลองใหม่)", function()
        NX.stale = {}
        Notify("Quest Data", "Cleared stale marks -- engine will re-verify each quest")
    end)
    task.spawn(function()
        while not NX.dead do
            task.wait(3)
            local lv = getLevel()
            local total = #Quests
            local maxLv = Quests[#Quests][1]
            local staleCount = 0
            for _ in pairs(NX.stale) do staleCount = staleCount + 1 end
            dq1.Set(string.format("รวม %d เควส | ครอบคลุมถึง Lv %d | เลเวลคุณ: %d", total, maxLv, lv))
            if lv > maxLv then
                dq2.Set("เลเวลคุณเกินฐานข้อมูล -- ใส่ข้อมูลใหม่ได้ที่หัวข้อ [DATA] บนสคริปต์ (getgenv/file/url)")
            elseif staleCount > 0 then
                dq2.Set("รายการที่ใช้ไม่ได้ (รออัปเดต): " .. staleCount .. " รายการ")
            else
                dq2.Set("ทุกเควสในฐานข้อมูล: ใช้งานได้ปกติ")
            end
        end
    end)
    UI.Section(t, "อัปเดตฐานข้อมูลเมื่อเกมอัปเดต")
    UI.Label(t, "เกมเพิ่มเควสใหม่? ใส่ getgenv().NX_QUESTS = { {เลเวล, \"NPCชื่อ\", ลำดับ, \"ชื่อศัตรู\"} } ก่อนรันสคริปต์ หรือสร้างไฟล์ NX-TJ-quests.json ใน workspace folder ของ executor").Set = "เกมเพิ่มเควสใหม่? ใส่ getgenv().NX_QUESTS = { {เลเวล, \"NPCชื่อ\", ลำดับ, \"ชื่อศัตรู\"} } ก่อนรันสคริปต์ หรือสร้างไฟล์ NX-TJ-quests.json ใน workspace folder ของ executor"
    UI.Label(t, "ระบบจะทดลองใช้ + ตรวจยืนยันกับเกมจริงให้อัตโนมัติ อันไหนใช้ไม่ได้จะข้ามให้เอง").Set = "ระบบจะทดลองใช้ + ตรวจยืนยันกับเกมจริงให้อัตโนมัติ อันไหนใช้ไม่ได้จะข้ามให้เอง"
end

-- ================= SECRETS (Island Secrets -- Update 30) =================
-- เกมเพิ่มระบบ Island Secrets: เควสลับ + ปริศนา + บอสตื่น (Awakened) 40 อันทั่ว Sea 1
-- ทำอันแรกเสร็จ = เปิด World Map | ครบ 3 ดาว/เกาะ = เปิด Teleporter (ตึกกลาง Middle Town)
-- อันละ +5 Secret Levels = ปลดล็อกแคปจาก 2800 ไปสู่ 3000
local ISLAND_POS = {
    ["Middle Town"]      = Vector3.new(1061.7, 16.5, 1544.5),
    ["Jungle"]           = Vector3.new(-1604.1, 36.9, 154.2),
    ["Pirate Village"]   = Vector3.new(-1139.6, 4.8, 3825.2),
    ["Desert Island"]    = Vector3.new(897.0, 6.4, 4389.0),
    ["Frozen Village"]   = Vector3.new(1384.1, 87.3, -1297.1),
    ["Marine Fortress"]  = Vector3.new(-5035.1, 28.7, 4325.3),
    ["Skylands"]         = Vector3.new(-4841.8, 717.7, -2624.0),
    ["Upper Skylands"]   = Vector3.new(-7902.7, 5636.0, -1411.7),
    ["Colosseum"]        = Vector3.new(-1576.1, 7.4, -2983.3),
    ["Magma Village"]    = Vector3.new(-5316.6, 12.2, 8517.3),
    ["Underwater City"]  = Vector3.new(61122.6, 18.5, 1568.2),
    ["Fountain City"]    = Vector3.new(5254.6, 38.5, 4049.7),
}
local SECRET_GUIDE = {
    ["Jungle"] =
        "[1/3] Zipline: บริเวณจุดเกิด Gorilla King มีต้นไม้ใหญ่พร้อมแท่น Zipline -- เก็บ Grapple Hook ที่พื้นข้างต้นไม้ (ฝั่งขวา) ปีนขึ้นยืนบนแท่นแล้วโยน Grapple ไปที่ตึกฝั่งตรงข้าม จากนั้นกลับไปคุย Quest Giver กลางเกาะรับรางวัล\n\n" ..
        "[2/3] Awakened Gorilla King: มีโอกาสเกิดทุกชั่วโมง (ช่วงนาที 00:XX) -- เฝ้าประกาศบนจอแล้วไปสังหาร จากนั้นไปคุย Pirate Adventurer รับรางวัล\n\n" ..
        "[3/3] หมวกนักผจญภัย: คุย Pirate Adventurer กลางทะเลสาบ -- ลิงขโมยหมวกไปซ่อนในต้นไม้ ให้หาต้นไม้ที่โคนมีรอยเท้าเล็กๆ ตีต้นไม้นั้นด้วย M1 จนลิงร่วงลงมา ฆ่าลิงแล้วเอาหมวกคืนไปให้",
    ["Pirate Village"] =
        "[1/3] กังหันลม: ปีนไปกังหันลมใหญ่กลางเกาะ ใช้ดาบตัดเชือกที่มัดใบพัดให้ขาดทุกเส้น (ต้องถือดาบ) กังหันเริ่มหมุน = เสร็จ แล้วไปคุย NPC ที่ท่าเรือ\n\n" ..
        "[2/3] ครัว + Awakened Chef: ไปชั้นบนของ Tavern (จุดเกิด Chef) กดที่หม้อ Cauldron -- ใส่ปลา + Yeti Fur แล้วกด Cook: Awakened Chef จะเกิด ฆ่าให้ได้\n\n" ..
        "[3/3] ความวุ่นวายใน Tavern: คุย NPC ท่าเรือเรื่อง Tavern -- เข้าประตู Saloon ที่สั่นอยู่ เลือก Breach Door แล้วฆ่า Tavern Pirate ทั้ง 3 ตัว",
    ["Desert Island"] =
        "[1/3] ช่วย Hasan: หาหีบสมบัติบริเวณกระบองเพชร 2 ต้นข้างต้นมะพร้าว (มุมพีระมิดด้านหมู่บ้าน) -- พื้นจะเปิดเป็นทางลงใต้ดิน ตามทางเข้าไปในพีระมิด ฆ่าศัตรู 4 ตัวรอบ Hasan แล้วกลับไปคุย Pirate Adventurer\n\n" ..
        "[2/3] ทำความสะอาดหิน: ด้านหลังจุดหาหีบสมบัติมีหิน 8 ก้อนจมอยู่ในทราย -- ตีด้วย M1 ให้สะอาดครบทุกก้อล พอร์ทัลบนพื้นเรืองแสง = เสร็จ\n\n" ..
        "[3/3] เก็บดอกกระบองเพชร: ตีกระบองเพชรทั่วทั้งเกาะจนได้ Cactus Petal ครบ 10 กลีบ แล้วเอาไปส่ง Pirate Adventurer (dialog: Prickly Harvest) -- รับเลเวล + Lava Potion",
    ["Frozen Village"] =
        "[1/3] ครูพลังพิเศษ: เข้าถ้ำใหญ่หน้าเกาะ จะเจอ Ability Teacher ถูกแช่แข็ง -- ใช้หมัด/อาวุธตีน้ำแข็งให้แตก = ปลดปล่อยสำเร็จ (เรียนอะไรซักอย่างฟรีได้)\n\n" ..
        "[2/3] ตุ๊กตาหิมะ: บริเวณจุดเกิด Yeti (ควรเป็นช่วงหน้าหนาว/หิมะตก) -- หาบอลหิมะแล้วกลิ้งมาวางซ้อนกัน ใช้บอลรวม 3 ลูกประกอบเป็นตุ๊กตาหิมะ\n\n" ..
        "[3/3] Awakened Yeti: ไปถาม Secret Masters ที่ Middle Town (ตึกหลังจุดเกิด The Saw) ว่าบอสตัวไหนกำลังตื่น -- ถ้าใช่ Yeti: ไปทำลายบอลหิมะสีเขียว 3 ลูกที่สุ่มเกิดรอบจุดเกิด Yeti คบไฟติดครบ 3 อันแล้วบอสจะเกิด ฆ่าให้ได้",
    ["Marine Fortress"] =
        "[1/3] ธงของ Palrus: คุย Palrus บนหอสังเกตด้านขวาของเกาะ -- เขาต้องการเชือก: ไปเก็บที่ขอบเกาะฝั่งซ้าย (แถวจุดเกิด Chief Petty Officer) แล้วกลับมาที่เสาธงกลางเกาะ กด E ชูธง -- อยู่ในวงแดงจนเสร็จ ระวังกระสุนปืนใหญ่\n\n" ..
        "[2/3] Pirate Raid: รอประกาศ Enemy ships are closing in on the Marine Fortress -- คุย Palrus เลือก dialog ใหม่ แล้วขึ้นป้อมปืน (turret) ยิงเรือศัตรูให้พังทั้งหมด\n\n" ..
        "[3/3] Awakened Vice Admiral: รอประกาศ An alarm has sounded at Marine Fortress -- ป้อมปืนจะเริ่มยิงใส่เกาะ: ไปทำลายตึกที่ Vice Admiral เกิดเพื่อหยุดปืน แล้วฆ่าบอส",
    ["Prison Island"] =
        "[1/3] นักโทษหลบหนี: หานักโทษหลบหนี 3 คน -- (1) กำลังขุดหลุมหน้าห้อง Head Jailer (2) พิงกำแพงอยู่ฝั่งซ้าย (3) กำลังสร้างแพหนีทะเลข้าง Boat Dealer -- เข้าไปกด Confront ก่อนทุกครั้งแล้วค่อยโจมตี\n\n" ..
        "[2/3] กุญแจปริศนา: ขึ้นบอลคอนีที่อยู่เหนือจุดเกิด Warden เก็บ Cell Block Key -- เข้าตึกกลาง (ที่มี Dangerous Prisoner) ปีนขึ้นไปเปิด Office Gate ด้วยกุญแจ ขึ้นบันไดสีแดงไปหา Don Megalo กด E ที่เสื้อบนเก้าอี้ -- Megalo Guard จะเกิด ฆ่าแล้วยึดเสื้อมา\n\n" ..
        "[3/3] Awakened Warden: รอประกาศ A cell creaks open -- เข้าตึกกลางไปห้องขวาสุด ดึงคานเรียงลำดับ: ส้ม > น้ำเงิน (อันที่ 3) > เขียว > น้ำเงิน (อันที่ 1) แล้วฆ่าบอส",
    ["Colosseum"] =
        "[1/3] คลื่นกลาดิเอเตอร์: คุย Emperor บนบอลคอนี เลือก Yes -- ฆ่าคลื่นกลาดิเอเตอร์ทั้งหมด (รอบสุดท้ายมี Supreme Gladiator) แล้วคุย Emperor อีกครั้งรับ EXP\n\n" ..
        "[2/3] รูปปั้น 4 อัน: คุย Colosseum Quest Giver หน้าสนาม เลือก dialog Rumor -- ตีรูปปั้นทั้ง 4 ด้วยชนิดอาวุธที่ตรงกับที่รูปปั้นถืออยู่ (หมัด/ดาบ/ปืน) จนทุกอันทำท่าทาง\n\n" ..
        "[3/3] ของขวัญของฝูงชน: รอประกาศ The Colosseum stands are filling up -- มองหาเป้าสีเทาบนเสาแล้วยิง จากนั้นเป้าแดง-ขาวจะเกิดทั่วสนาม ยิงให้ครบภายใน 90 วินาที",
    ["Magma Village"] =
        "[1/3] บ่อลาวา: ไปบ่อลาวาใกล้ท่าเรือ ตีหม้อลาวากลางบ่อจนแตก -- Lava Elemental ใหญ่ + Mini จะเกิด ฆ่าให้หมดแล้วไปคุย Mayor\n\n" ..
        "[2/3] Awakened Magma Admiral: ถาม Secret Masters ที่ Middle Town ก่อน -- ถ้าเป็นตัวนี้: ไปที่ภูเขาไฟ ทำลายถุงลาวา (lava pocket) ที่เกาะอยู่รอบภูเขาให้หมด บอสจะเกิด ฆ่าให้ได้\n\n" ..
        "[3/3] ทำลายสว่าน: เดินตามแนวชายทะเลฝั่งตรงข้ามบ่อลาวาจนเจอทางเข้าถ้ำลับ -- กดลิฟต์ลงไปใน Volcano Cave เลี่ยงสายตาคนงาน เดินลับๆ ไปทำลาย Magma Drill",
    ["Skylands"] =
        "[1/3] เมฆเหลือง + หีบเพชร: รอประกาศ A secret cloud has appeared over the Skylands -- มองหาเมฆสีเหลืองแล้วบิน/วาร์ปทะลุมัน 3 ครั้ง มันจะดรอปหีบ Diamond -- ไปเก็บที่เกาะ Angel Guard เปิดหีบ ฆ่าศัตรูที่เกิด คุย Angel Guard รับรางวัล\n\n" ..
        "[2/3] สายฟ้า: คุย Mad Scientist บนเกาะล่าง เขาต้องการ Lightning Bolt -- ขึ้นไปส่วนบนของเกาะหาก้อนเมฆสีเทาเข้มที่กะพริบ โจมตีมันจะได้สายฟ้า เอาไปคืน\n\n" ..
        "[3/3] คืนสมบัติ: คุย Angel Guard รับโจทย์ แล้วรอประกาศ Enemies have invaded the Skylands castle -- ไปปราสาทหลังคาสีน้ำเงิน (แถวจุดเกิด Sky Bandit) ทำลายแพตช์สีน้ำตาลข้างหลังคาแล้วเข้าไป ฆ่าศัตรู เก็บกระดาษรหัสใกล้ทางเข้า ใช้รหัสเปิดตู้เซฟกลางปราสาท",
    ["Upper Skylands"] =
        "[1/3] วัตถุโบราณ: คุย Sky Quest Giver 2 เลือก The old temple -- ทำลายก้อนหินที่ขวางประตูวัด (ต้องมีท่าระเบิด) เข้าไปทางซ้ายแล้วเลี้ยวขวา ตีเสาไฟฟ้าในวงให้ลำแสงเชื่อมถึงกันครบวง จะได้ Relic แล้วหนีฟ้าผ่ากลับไปส่ง NPC\n\n" ..
        "[2/3] Awakened Sky Warlord: รอประกาศ A storm brews in the upper skylands -- ไปจุดเกิด Sky Warlord โจมตีก้อนเมฆสายฟ้าสีดำเหนือจุดเกิด แล้วฆ่าบอส\n\n" ..
        "[3/3] Awakened Lightning God: รอประกาศ The bell shimmers in upper skylands -- ไปที่ระฆัง จะมีไอคอนอาวุธผลัดกันโผล่ (ปืน/ดาบ/หมัด) ตีระฆังด้วยอาวุธที่ตรงกับไอคอน 6 ครั้งติดกันโดยไม่ผิด แล้วฆ่าบอส",
    ["Underwater City"] =
        "[1/3] ฟองอากาศ: กระโดดเข้าฟองสีขาวใสบนเกาะ มันจะพาไปถ้ำปะการัง -- เปิดหีบกลางถ้ำ ฆ่าศัตรู 3 ตัวที่เกิด แล้วลงวนน้ำ (whirlpool) ออกมา\n\n" ..
        "[2/3] ช่วยครูหมัดน้ำ: ไปด้านขวาของปราสาท Fishman Lord จะเห็นคริสตัล 4 อัน (แสงส่องอยู่ 2 อัน) และแผ่นทรายบนกำแพงขวา -- จัดมุมคริสตัลให้แสงส่องโดนแผ่นทราย กำแพงจะแตก เข้าไปคุย Water Kung-fu Teacher\n\n" ..
        "[3/3] Awakened Fishman Lord: รอประกาศ The water is stirring -- ค้นหอย (clam) รอบๆ จนเจอ Black Pearl เอาไปที่จุดเกิดบอสเพื่อเริ่มซีเควนซ์ แล้วฆ่าให้ได้",
    ["Fountain City"] =
        "[1/3] ซ่อมท่อ: ขึ้นไปบนบ่อน้ำพุใหญ่กลางเกาะ ตีท่อที่แตกให้ซ่อมครบทุกท่อ -- แล้วขึ้นเรือที่อยู่ในบ่อ มันจะพาดีดขึ้นบก = เสร็จ\n\n" ..
        "[2/3] ใต้ฝาท่อระบายน้ำ: ไปแถว Freezebug Quest Giver จะเห็นเครน + แพลตฟอร์มมีจาน -- กด E ยกแพลตฟอร์มขึ้นเผยฝาท่อ ลงไปในท่อระบายน้ำ ฆ่า NPC ทุกห้อง ทุบกำแพงไปเรื่อยๆ จนเจอ Megalo Brute ฆ่าให้ได้\n\n" ..
        "[3/3] Awakened Cyborg: รอประกาศ The junkyard has been magnetized by lightning -- ไปจุดเกิด Cyborg ซ่อมสายไฟที่ขาดบนพื้นให้ครบ แล้วฆ่าบอส",
    ["Mob Island"] =
        "[1-3] ยังไม่มีเอกสารครบสามอัน -- เดินสำรวจ NPC แปลกใหม่ (ในตึก/บนหลังคา/กลางน้ำ) และวัตถุที่ตีแล้วมีปฏิกิริยา (แตก/สั่น/ขยับ) เช็คดาวของเกาะใน World Map เป็นตัวชี้วัด -- ถ้าเจออะไรเพิ่มจะได้อัปเดตไกด์ต่อ",
    ["Secrets Master"] =
        "[ส่วนเสริม] NPC Secret Masters อยู่ที่ Middle Town (ในตึกหลังจุดเกิด The Saw) -- เป็น NPC ใหม่ของ Update 30 ที่บอกได้ว่าบอส Awakened ตัวไหนกำลังจะตื่น (ถาม Which boss stirs next?) และตัวมันเองก็มีความลับของตัวเองซ่อนอยู่ -- ลองคุยทุก dialog และสำรวจรอบตึก",
}
do
    local t = UI.Tab("Secrets")
    UI.Section(t, "Island Secrets -- ทางสู่ Lv 3000 (Update 30)")
    UI.Paragraph(t,
        "เควสปกติเก็บได้ถึง Lv 2800 -- อีก 200 เลเวล (ไปถึง 3000) ต้องทำ Island Secrets ใน Sea 1: " ..
        "เควสลับ + ปริศนา + บอสตื่น (Awakened) รวม 40 อัน อันละ +5 เลเวล " ..
        "ทำอันแรกเสร็จ = เปิด World Map | ครบ 3 ดาวต่อเกาะ = เปิด Teleporter (ตึกกลาง Middle Town)")
    UI.Section(t, "สถานะของคุณ (อัพเดตสด)")
    local sc1 = UI.Label(t, "...")
    local sc2 = UI.Label(t, "...")
    task.spawn(function()
        while not NX.dead do
            task.wait(1)
            local lv = getLevel()
            if lv > 2800 then
                local secretLv = lv - 2800
                local est = math.min(math.floor(secretLv / 5), 40)
                sc1.Set(string.format("Lv %d / 3000 (Secret Levels: +%d)", lv, secretLv))
                sc2.Set(string.format("ประมาณ %d/40 secrets เสร็จ -- แคปปัจจุบัน: %d", est, 2800 + est * 5))
            else
                sc1.Set(string.format("Lv %d / 3000 (เหลืออีก %d เลเวลถึงแคป 2800)", lv, 2800 - lv))
                sc2.Set("ยังไม่ถึงแคป -- ฟาร์มเควสต่อก่อน (เลเวลที่เกิน 2800 จะมาจาก secrets เท่านั้น)")
            end
        end
    end)
    UI.Section(t, "Awakened Boss (บอสตื่น)")
    UI.Toggle(t, "แจ้งเตือนเมื่อบอส Awakened เกิด", CFG.AwakenedAlert, function(v)
        CFG.AwakenedAlert = v
    end)
    UI.Toggle(t, "ล่าบอส Awakened อัตโนมัติ (วาร์ปไปตี)", CFG.AutoAwakened, function(v)
        CFG.AutoAwakened = v
        if v then
            Notify("Awakened Hunter", "เปิดแล้ว -- เจอบอส Awakened สคริปต์จะวาร์ปไปตีให้เอง")
        end
    end)
    UI.Paragraph(t,
        "เคล็ดลับ: บอส Awakened สุ่มเกิดราวๆ ทุกชั่วโมง (ช่วงนาที 00:XX) พร้อมข้อความประกาศบนจอ " ..
        "เช็คตัวถัดไปได้ที่ NPC Secret Masters (Middle Town) -- เปิดล่าอัตโนมัติไว้แล้วรอจับได้เลย")
    UI.Section(t, "ไกด์ทำ Secret รายเกาะ (กดดูแล้วทำตาม)")
    local islandNames = {}
    for k in pairs(SECRET_GUIDE) do
        table.insert(islandNames, k)
    end
    table.sort(islandNames)
    local curIsland = islandNames[1]
    UI.Dropdown(t, "เลือกเกาะ", islandNames, curIsland, function(v)
        curIsland = v
    end)
    UI.Button(t, "วาร์ปไปเกาะที่เลือก", function()
        local p = ISLAND_POS[curIsland]
        if p then
            topos(CFrame.new(p + Vector3.new(0, 25, 0)))
            Notify("Teleport", curIsland .. " -- หาจุดทำ secret ตามไกด์ด้านล่าง")
        else
            Notify("Teleport", curIsland .. ": ยังไม่มีพิกัด -- บิน/เดินเรือไปเอง")
        end
    end)
    local guide = UI.Paragraph(t, "เลือกเกาะด้านบน แล้วกดปุ่ม [แสดงวิธีทำ] เพื่อดูขั้นตอนครบทั้ง 3 secrets")
    UI.Button(t, "แสดงวิธีทำ Secrets ของเกาะนี้", function()
        guide.Set(SECRET_GUIDE[curIsland] or "ไม่มีข้อมูลเกาะนี้")
    end)
    UI.Section(t, "หมายเหตุ")
    UI.Paragraph(t,
        "Update 30 ปรับโฉมเกาะ Sea 1 ใหม่ทั้ง 16 เกาะ -- พิกัดวาร์ปอาจคลาดเคลื่อนได้ ถ้าไม่ตรงจุดให้บินสำรวจรอบๆ " ..
        "เกาะ Starter ทั้งสองฝ่ายไม่มี secrets | Middle Town = ที่ตั้ง Teleporter + Secret Masters " ..
        "ดาวครบ 3 ของเกาะไหน = เกาะนั้นจบแล้ว (เช็คใน World Map)")
end

-- ================= FRUIT =================
do
    local t = UI.Tab("Fruit")
    UI.Section(t, "Fruit Sniper (ผลไม้ในแผนที่)")
    UI.Toggle(t, "Auto Teleport To Fruit (วาร์ปเก็บผลไม้)", CFG.FruitSniper, function(v)
        CFG.FruitSniper = v
    end)
    UI.Toggle(t, "Notify When Fruit Spawns", CFG.FruitNotify, function(v)
        CFG.FruitNotify = v
    end)
    UI.Button(t, "Scan Fruits Now (ค้นหาผลไม้ตอนนี้)", function()
        local n, p = findWorldFruit()
        if n then
            Notify("Fruit Scan", n .. " found! Teleporting...")
            topos(CFrame.new(p))
            pcall(function() setclipboard(n) end)
        else
            Notify("Fruit Scan", "No fruit in map right now.")
        end
    end)
    UI.Section(t, "Your Fruit")
    local fl = UI.Label(t, "...")
    task.spawn(function()
        while not NX.dead do
            task.wait(2)
            fl.Set("Devil Fruit: " .. tostring(getFruit()))
        end
    end)
    UI.Section(t, "Buy Fighting Style (ซื้อสไตล์ต่อสู้)")
    local styles = { "BuySuperhuman", "BuyDeathStep", "BuyElectricClaw", "BuyDragonTalon", "BuySharkmanKarate", "BuyFishmanKarate", "BuyElectro", "BuyBlackLeg" }
    UI.Button(t, "Buy Superhuman", function()
        invoke("BuySuperhuman")
        Notify("Shop", "BuySuperhuman sent")
    end)
    UI.Button(t, "Buy Death Step", function()
        invoke("BuyDeathStep")
        Notify("Shop", "BuyDeathStep sent")
    end)
    UI.Button(t, "Buy Electric Claw", function()
        invoke("BuyElectricClaw")
        Notify("Shop", "BuyElectricClaw sent")
    end)
    UI.Button(t, "Buy Dragon Talon", function()
        invoke("BuyDragonTalon")
        Notify("Shop", "BuyDragonTalon sent")
    end)
end

-- ================= ESP =================
do
    local t = UI.Tab("ESP")
    UI.Section(t, "ESP (PC Drawing API)")
    UI.Toggle(t, "Enable ESP", CFG.ESP, function(v)
        CFG.ESP = v
        if v and not NX.canDraw then
            Notify("ESP", "This executor does not support Drawing API")
        end
    end)
    UI.Toggle(t, "Players", CFG.ESPPlayers, function(v) CFG.ESPPlayers = v end)
    UI.Toggle(t, "Enemies", CFG.ESPEnemies, function(v) CFG.ESPEnemies = v end)
    UI.Toggle(t, "Fruits", CFG.ESPFruits, function(v) CFG.ESPFruits = v end)
    UI.Toggle(t, "Chests", CFG.ESPChests, function(v) CFG.ESPChests = v end)
    UI.Toggle(t, "Tracers (เส้นชี้)", CFG.ESPTracers, function(v) CFG.ESPTracers = v end)
    UI.Slider(t, "Max Distance (m)", 200, 10000, CFG.ESPDistance, function(v)
        CFG.ESPDistance = v
    end)
end

-- ================= TELEPORT =================
do
    local t = UI.Tab("Teleport")
    UI.Section(t, "Teleport")
    UI.Toggle(t, "Tween Mode (เนียน) ปิด = วาร์ปทันที", CFG.TweenTeleport, function(v)
        CFG.TweenTeleport = v
    end)
    UI.Slider(t, "Tween Speed", 50, 400, CFG.TweenSpeed, function(v)
        CFG.TweenSpeed = v
    end)
    UI.Section(t, "Quick Teleports")
    UI.Button(t, "To Quest NPC (ไปหา NPC เควสของเลเวลนี้)", function()
        local e = pickQuest(getLevel())
        if e and typeof(e[5]) == "Vector3" then
            topos(CFrame.new(e[5]))
            Notify("Teleport", "Quest NPC: " .. e[2])
        else
            Notify("Teleport", "No quest NPC data")
        end
    end)
    UI.Button(t, "To Quest Mobs (ไปจุดเกิดศัตรูเควส)", function()
        local e = pickQuest(getLevel())
        if e and typeof(e[6]) == "Vector3" then
            topos(CFrame.new(e[6]))
            Notify("Teleport", "Mobs: " .. e[4])
        else
            Notify("Teleport", "No mob data")
        end
    end)
    UI.Section(t, "Teleport To Enemy")
    local edrop
    edrop = UI.Dropdown(t, "Enemy", getEnemyOptions(), nil, function(v)
        -- เก็บไว้ใช้ตอนกดปุ่ม
        getgenv().NX_TP_ENEMY = v
    end)
    UI.Button(t, "Teleport To Selected Enemy", function()
        local name = getgenv().NX_TP_ENEMY
        if not name then
            Notify("Teleport", "Pick an enemy first")
            return
        end
        local e, rp = findEnemy(name)
        if rp then
            topos(rp.CFrame * CFrame.new(0, 0, 6))
            Notify("Teleport", "Teleported to " .. name)
        else
            Notify("Teleport", name .. " is not spawned right now")
        end
    end)
    UI.Button(t, "Refresh enemy list", function()
        edrop.Refresh(getEnemyOptions())
    end)
    UI.Section(t, "Teleport To Player")
    local pdrop
    pdrop = UI.Dropdown(t, "Player", getPlayerOptions(), nil, function(v)
        getgenv().NX_TP_PLAYER = v
    end)
    UI.Button(t, "Teleport To Selected Player", function()
        local name = getgenv().NX_TP_PLAYER
        if not name then
            Notify("Teleport", "Pick a player first")
            return
        end
        local pl = Players:FindFirstChild(name)
        if pl and pl.Character then
            local rp = pl.Character:FindFirstChild("HumanoidRootPart")
            if rp then
                topos(rp.CFrame * CFrame.new(0, 0, 6))
                Notify("Teleport", "Teleported to " .. name)
                return
            end
        end
        Notify("Teleport", "Cannot find " .. name)
    end)
    UI.Button(t, "Refresh player list", function()
        pdrop.Refresh(getPlayerOptions())
    end)
    task.spawn(function()
        while not NX.dead do
            task.wait(6)
            pcall(function()
                edrop.Refresh(getEnemyOptions())
                pdrop.Refresh(getPlayerOptions())
            end)
        end
    end)
end

-- ================= PLAYER =================
do
    local t = UI.Tab("Player")
    UI.Section(t, "Movement")
    UI.Toggle(t, "WalkSpeed Enable", CFG.WalkSpeedOn, function(v)
        CFG.WalkSpeedOn = v
        if not v then
            pcall(function()
                local c, _, hum = getChar()
                if hum then hum.WalkSpeed = 16 end
            end)
        end
    end)
    UI.Slider(t, "WalkSpeed", 16, 300, CFG.WalkSpeed, function(v) CFG.WalkSpeed = v end)
    UI.Toggle(t, "JumpPower Enable", CFG.JumpPowerOn, function(v)
        CFG.JumpPowerOn = v
        if not v then
            pcall(function()
                local c, _, hum = getChar()
                if hum then hum.JumpPower = 50 end
            end)
        end
    end)
    UI.Slider(t, "JumpPower", 20, 300, CFG.JumpPower, function(v) CFG.JumpPower = v end)
    UI.Toggle(t, "Infinite Jump", CFG.InfJump, function(v) CFG.InfJump = v end)
    UI.Toggle(t, "Noclip", CFG.Noclip, function(v) CFG.Noclip = v end)
    UI.Section(t, "Fly (WASD + Space/Shift)")
    local flyToggle
    flyToggle = UI.Toggle(t, "Fly", CFG.Fly, function(v)
        CFG.Fly = v
        if v then Notify("Fly", "WASD to move | Space up | Shift down") end
    end)
    NX.setFly = function(v)
        CFG.Fly = v and true or false
        if flyToggle then flyToggle.Set(v) end
    end
    UI.Slider(t, "Fly Speed", 20, 400, CFG.FlySpeed, function(v) CFG.FlySpeed = v end)
    UI.Section(t, "Misc")
    UI.Button(t, "Reset Character (รีเซ็ตตัวละคร)", function()
        pcall(function()
            local c, _, hum = getChar()
            if hum then hum.Health = 0 end
        end)
    end)
    UI.Button(t, "Rejoin Server", function() rejoin() end)
    UI.Button(t, "Server Hop (หาเซิร์ฟใหม่)", function() serverHop() end)
    UI.Toggle(t, "Auto Rejoin On Kick", CFG.AutoRejoin, function(v)
        CFG.AutoRejoin = v
    end)
end

-- ================= CONFIG =================
do
    local t = UI.Tab("Config")
    UI.Section(t, "Theme")
    UI.Dropdown(t, "Accent Color", { "Red", "Blue", "Purple", "Green", "Yellow", "Pink" }, CFG.Accent, function(v)
        UI.SetAccent(v)
    end)
    UI.Section(t, "Keybinds (คีย์ลัด)")
    UI.Keybind(t, "Toggle UI", CFG.KeyUI, function(k)
        CFG.KeyUI = k
    end)
    UI.Keybind(t, "Toggle Auto Farm", CFG.KeyFarm, function(k)
        CFG.KeyFarm = k
    end)
    UI.Keybind(t, "Toggle Fly", CFG.KeyFly, function(k)
        CFG.KeyFly = k
    end)
    UI.Section(t, "Save / Load (บันทึกการตั้งค่า)")
    UI.Button(t, "Save Config", function() NX.saveConfig() end)
    UI.Button(t, "Load Config", function() NX.loadConfig() end)
    UI.Section(t, "Unload")
    UI.Button(t, "Unload NOVEL-X (ปิดสคริปต์ทั้งหมด)", function()
        NX.unload()
    end)
    UI.Section(t, "Credits")
    UI.Label(t, "NOVEL-X v2.5 | TJ EDITION -- made by TJ").Set = "NOVEL-X v2.5 | TJ EDITION -- made by TJ"
    UI.Label(t, "Free | No key | PC only | Blox Fruits Update 30 | Max Lv 3000")
end
-- ============================ [6] MAIN ==============================
-- บันทึก/โหลดค่า
NX.saveConfig = function()
    local ok = pcall(function()
        local data = {}
        for k, v in pairs(CFG) do
            if typeof(v) == "EnumItem" then
                data[k] = { __enum = v.Name }
            elseif type(v) ~= "table" then
                data[k] = v
            end
        end
        writefile("NX-TJ-Config.json", HttpService:JSONEncode(data))
    end)
    if ok then
        Notify("Config", "Saved to NX-TJ-Config.json")
    else
        Notify("Config", "Save failed -- executor ไม่รองรับ writefile?")
    end
end
NX.loadConfig = function()
    local ok = pcall(function()
        if not isfile("NX-TJ-Config.json") then error("no config file") end
        local data = HttpService:JSONDecode(readfile("NX-TJ-Config.json"))
        for k, v in pairs(data) do
            if type(v) == "table" and v.__enum then
                local e = Enum.KeyCode[v.__enum]
                if e then CFG[k] = e end
            elseif type(v) ~= "table" and CFG[k] ~= nil and k ~= "AutoFarm" and k ~= "Fly" then
                CFG[k] = v
            end
        end
    end)
    if ok then
        Notify("Config", "Loaded! (ค่าที่เป็น toggle กดเปิดใหม่ในแท็บต่างๆ)")
    else
        Notify("Config", "Load failed -- ยังไม่มีไฟล์ config")
    end
end

-- ปิดสคริปต์ทั้งหมดอย่างสะอาด
NX.unload = function()
    NX.dead = true
    for _, c in ipairs(NX.cons) do
        pcall(function() c:Disconnect() end)
    end
    pcall(function() UI.gui:Destroy() end)
    getgenv().NX_LOADED = nil
    print("[NOVEL-X] Unloaded. Thank you -- made by TJ")
end

-- คีย์ลัดทั่วไป
conn(UserInput.InputBegan:Connect(function(input, gp)
    if gp then return end
    if os.clock() - (NX.lastBind or 0) < 0.25 then return end -- เพิ่งผูกคีย์ใหม่ ข้ามก่อน
    if input.KeyCode == CFG.KeyUI then
        UI.toggleWindow()
    elseif input.KeyCode == CFG.KeyFarm then
        local nv = not CFG.AutoFarm
        if NX.setFarm then NX.setFarm(nv) else CFG.AutoFarm = nv end
        Notify("Auto Farm", nv and "ON (quest mode)" or "OFF")
    elseif input.KeyCode == CFG.KeyFly then
        local nv = not CFG.Fly
        if NX.setFly then NX.setFly(nv) else CFG.Fly = nv end
        Notify("Fly", nv and "ON -- WASD + Space/Shift" or "OFF")
    end
end))

-- มิเตอร์ FPS + แถบสถานะล่าง
do
    local frames = 0
    conn(RunService.RenderStepped:Connect(function()
        frames = frames + 1
    end))
    task.spawn(function()
        local last = os.clock()
        while not NX.dead do
            task.wait(1)
            local fps = frames
            frames = 0
            last = os.clock()
            pcall(function()
                UI.SetStatus(string.format("Lv %d  |  FPS %d  |  Beli %d  |  %s",
                    getLevel(), fps, getBeli(), farmStatus or "Idle"))
            end)
        end
    end)
end

-- ยินดีต้อนรับ
print("=================================================")
print("   NOVEL-X v2.5 | TJ EDITION -- loaded successfully")
print("   Blox Fruits UPDATE 30 | MAX LV 3000 | No Key | made by TJ")
print("   Toggle UI: RightControl | Farm: F | Fly: G")
print("   Lv 2800+ : ทำ Island Secrets (แท็บ Secrets) เพื่อไปถึง 3000")
print("=================================================")
Notify("NOVEL-X v2.5", "Welcome! made by TJ -- Press RightControl to toggle UI", 6)
Notify("Quick Start", "Farm tab > Auto Farm ON (หรือกด F) -- เควสครบถึง Lv 2725+ | พอถึง 2800 ให้ทำ Island Secrets ที่แท็บ Secrets เพื่อไปถึง 3000", 10)

