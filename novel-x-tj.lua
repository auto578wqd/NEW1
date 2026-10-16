--=====================================================================--
--  MELO HUB [BLOX FRUITS] | TJ EDITION v3.0  --  PC ONLY / NO KEY
--  (อดีตชื่อ NOVEL-X) -- made by TJ
--
--  [v3.0] 16 ต.ค. 2026 -- REBRAND "Melo Hub [Blox Fruits]" + โหมดใหม่ทั้งชุด
--  [*] FIX บินไปทำเควส: จำกัดความเร็ว 75 (กันวาร์ปกลับที่เดิม/rubber-band)
--  [*] FIX ระบบฟาร์มเวล "ยึกยัก" ตรงเควส (ตัด tween ที่ยิงซ้ำทุก 0.2 วิ)
--  [*] FIX Fixed Lag / FPS drop: ลดงานต่อเฟรม + ลดรอบสแกน + ตัดลูปเปล่า
--  [+] Double Quest Policy: 50% (Same Island) / 100% (Cross-Island)
--      50%  = เควสเฉพาะเกาะใกล้ตัว ต้องผ่าน reqLv/เลเวลคุณ > 0.5
--      100% = ไม่มีตัวกรองอัตราส่วน สลับข้ามเกาะไปมาได้ (แนะนำถ้ามี bypass tp)
--  [+] Sea Filter (Realtime): โชว์เฉพาะฟังก์ชันที่ใช้ได้ในโลกที่อยู่
--  [+] แท็บ PvP: Team / PvP State / Silent Aim + Mode + FOV + Aim Range
--  [+] ธีมอวกาศ: พื้นหลังดำ + ดวงดาว 60 ดวง + เนบิวลา (ไม่กิน FPS)
--  [+] Auto Rejoin กลับเซิร์ฟเดิม (JobId) + ลองใหม่เมื่อ tp ล้มเหลว
--  [+] ปุ่ม Self-Test ตรวจระบบทั้งหมดในเกมจริง (รายงาน PASS/FAIL)
--  [+] แท็บ Update Log: ประวัติพัฒนาทุกเวอร์ชัน (ให้ลูกค้าดู)
--  [v2.7] UI ใหม่ Pepsi v0.32 + เควสลับ = Island Secrets 40 อัน (wiki 15 ต.ค. 2026)
--  [v2.6] ทัวร์เควสหลัก (Island Tour) ทุกเกาะ 3 ทะเล + สถานะสด + กระโดดเริ่มเกาะไหนก็ได้
--  [v2.5.1] FIX TextXOverflow -> TextTruncate.AtEnd (แก้ error toast ตอนเปิดสคริปต์)
--  UPDATE 30 READY: MAX LEVEL 3000 (2800 ปกติ + Island Secrets 40 อัน x5 = 3000)
--
--  พัฒนาใหม่ทั้งระบบจาก Novel เดิม (ที่เป็นแค่ประตูขายคีย์ ไม่มีฟีเจอร์)
--  + Auto Farm / Auto Quest อัตโนมัติ สลับเควสตามเลเวล ถึง Lv 2725+
--  + ระบบเควส "ตรวจยืนยันกับเกมจริง" -- เกมอัปเดตเควสใหม่ ระบบหาอันใช้ได้เอง ไม่พังทั้งระบบ
--  + อัปเดตข้อมูลเควสได้โดยไม่ต้องแก้สคริปต์ (ดูหัวข้อ [DATA] ด้านล่าง)
--
--  CREDIT: made by TJ | UI: Pepsi's UI Library v0.32
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
    -- Travel + Double Quest Policy (v3.0)
    SafeTravel    = true,              -- บินไปทำเควสแบบปลอดภัย (กันวาร์ปกลับที่เดิม)
    TravelSpeed   = 75,                -- ความเร็วบินไปทำเควส (75 = ไม่โดนเซิร์ฟเวอร์ดึงกลับ)
    DQPolicy      = "50%",             -- "50%" = Same Island | "100%" = Cross-Island
    -- Sea Filter (v3.0): โชว์เฉพาะฟังก์ชันที่ใช้ได้ในโลกที่อยู่ (realtime)
    SeaFilter     = true,
    -- PvP / Silent Aim (v3.0)
    SilentAim     = false,
    AimMode       = "FOV",             -- "Cursor" | "FOV" | "Screen Center"
    AimRange      = 1500,
    AimPart       = "Head",            -- "Head" | "HumanoidRootPart"
    AimTeamCheck  = true,              -- ไม่ยิงเพื่อนร่วมทีม
    FaceTarget    = true,              -- หันตัวเข้าเป้าตอนกดยิง (สกิล/หมัด)
    FOVCircle     = true,
    FOVSize       = 200,
    FOVMode       = "Cursor",          -- "Cursor" | "Screen Center"
    -- Performance (v3.0)
    PerfMode      = true,              -- โหมดประหยัด (ลดงานพื้นหลัง ไม่กระทบฟีเจอร์)
    -- Island Secrets (Update 30)
    AwakenedAlert = true,              -- แจ้งเตือนเมื่อบอส Awakened เกิด (Island Secrets)
    AutoAwakened  = false,             -- ล่าบอส Awakened อัตโนมัติ (Island Secrets)
    -- Quest
    AutoSwap      = true,              -- สลับเควสอัตโนมัติเมื่อเลเวลพอ (เควสลับ)
    -- Island Tour (เควสลับ -- ไล่ทำเควสทุกเกาะ)
    TourMode      = false,             -- โหมดไล่ทำเควสทุกเกาะ (แท็บ เควสลับ)
    TourSea       = "All",             -- "All" | "Sea 1" | "Sea 2" | "Sea 3"
    TourSkipLocked = true,             -- true = ข้ามเควสที่เลเวลยังไม่ถึง / false = รอ+ฟาร์มเก็บเลเวลจนถึง
    -- เควสลับ -- Island Secrets Tour (Update 30: 40 secrets / 13 เกาะ Sea 1)
    SecretTour         = false,        -- โหมดไล่ทำ Island Secrets ทุกเกาะ (แท็บ เควสลับ)
    SecretTourAutoNext = true,         -- เลเวล +5 = เสร็จ 1 อัน -> ไปอันถัดไปเอง (หลังแคป 2800)
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
getgenv().NX = NX   -- เปิดให้เรียกจาก console / ทดสอบได้ (debug)

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
    warn("[Melo Hub] This script is for Blox Fruits only. (made by TJ)")
    return
end

-- รอโหลดเกม
if not game:IsLoaded() then game.Loaded:Wait() end
task.wait(0.3)

-- ตรวจว่าเป็น PC (มีคีย์บอร์ด) -- ตัวนี้รองรับ PC เท่านั้น
if not UserInput.KeyboardEnabled then
    warn("[Melo Hub] PC ONLY -- Melo Hub supports PC only. (made by TJ)")
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
    t.Text = "Melo Hub supports PC ONLY\n(made by TJ)"
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
local Travel = { dest = nil, tween = nil }   -- [v3.0] สถานะเดินทางไปทำเควส (กันยึกยัก)
local function topos(cf)
    local c, hrp = alive()
    if not hrp then return end
    if Travel.tween then pcall(function() Travel.tween:Cancel() end) Travel.tween, Travel.dest = nil, nil end
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

-- [v3.0] TRAVEL: บินไปทำเควสแบบ "ปลอดภัย" (จำกัดความเร็ว ~75)
-- แก้ 2 ปัญหาจริง: (1) บินเร็วเกิน -> เซิร์ฟดึงกลับที่เดิม (rubber-band)
--                 (2) ยิง tween ใหม่ทุก 0.2 วิ -> ตัวละอย "ยึกยัก" ตรงเควส
local function toposSafe(cf, speed)
    local c, hrp = alive()
    if not hrp then return end
    if not CFG.SafeTravel then topos(cf) return end
    speed = tonumber(speed) or CFG.TravelSpeed
    if speed < 16 then speed = 16 elseif speed > 150 then speed = 150 end
    local dest = cf.Position
    local dist = (hrp.Position - dest).Magnitude
    if dist <= 8 then
        -- ถึงแล้ว: ปักตำแหน่งเบาๆ (ถ้าหลุดเกิน 2 หล่น) แล้วเคลียร์สถานะเดินทาง
        if dist > 2 then pcall(function() hrp.CFrame = CFrame.new(dest) end) end
        if Travel.tween then pcall(function() Travel.tween:Cancel() end) end
        Travel.tween, Travel.dest = nil, nil
        return
    end
    -- ปลายทางเดิม + มี tween ยังไม่หมดอายุ = ไม่ยิงซ้ำ (แก้ยึกยัก)
    if Travel.tween and Travel.dest and (dest - Travel.dest).Magnitude < 4 then return end
    Travel.dest = dest
    pcall(function()
        if activeTween then activeTween:Cancel() end
        if Travel.tween then Travel.tween:Cancel() end
        local t = math.min(dist / speed, 20)
        Travel.tween = TweenService:Create(hrp, TweenInfo.new(t, Enum.EasingStyle.Linear), { CFrame = CFrame.new(dest) })
        Travel.tween:Play()
        local tw = Travel.tween
        -- หมดอายุแล้ว (หรือโดนวาร์ปกลับ) ให้รอบถัดไปยิงใหม่ได้
        task.delay(t + 0.15, function()
            if Travel.tween == tw then Travel.tween, Travel.dest = nil, nil end
        end)
    end)
end
NX.toposSafe = toposSafe

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
    print(string.format("[Melo Hub] %s: %s", tostring(title), tostring(text)))
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
    {190, "PrisonQuest", 1, "Prisoner", Vector3.new(4858.7, 7.5, -4361.7), Vector3.new(4930.0, 7.5, -4430.0), { "PrisonQuest1", "ImpelQuest", "PrisonerQuest" } },
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
        print("[Melo Hub] quest data: loaded " .. #g .. " entries from getgenv override")
    end
    -- 2) ไฟล์ json ในเครื่อง
    if isfile and isfile("NX-TJ-quests.json") then
        local arr = HttpService:JSONDecode(readfile("NX-TJ-quests.json"))
        for _, e in ipairs(arr) do addEntry(e) end
        print("[Melo Hub] quest data: loaded entries from NX-TJ-quests.json")
    end
    -- 3) URL
    local u = getgenv().NX_QUESTS_URL
    if type(u) == "string" then
        local ok, res = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(u, true))
        end)
        if ok and type(res) == "table" then
            for _, e in ipairs(res) do addEntry(e) end
            print("[Melo Hub] quest data: loaded entries from remote URL")
        end
    end
end)
-- เรียงเลเวล
table.sort(Quests, function(a, b) return a[1] < b[1] end)

-- ======================= [TOUR DATA] เควสลับ ========================
-- แผนที่ไล่เกาะ (Island Tour): ไล่ทำเควสทุกเกาะตามลำดับ Sea 1 > Sea 2 > Sea 3
-- รูปแบบ: { "ชื่อเกาะ", หมายเลขทะเล, { เลเวลเควสทั้งหมดบนเกาะนั้น (เรียงแล้ว) } }
local TOUR_ISLANDS = {
    { "Middle Town (เกาะเริ่มต้น)",  1, { 1 } },
    { "Jungle",                       1, { 10, 15 } },
    { "Pirate Village",               1, { 30, 40 } },
    { "Desert Island",                1, { 60, 75 } },
    { "Frozen Village",               1, { 90, 100 } },
    { "Marine Fortress",              1, { 120 } },
    { "Skylands",                     1, { 150, 175 } },
    { "Prison Island",                1, { 190 } },
    { "Colosseum",                    1, { 225, 275 } },
    { "Magma Village",                1, { 300 } },
    { "Underwater City",              1, { 375, 400 } },
    { "Upper Skylands",               1, { 450, 475, 525, 550 } },
    { "Fountain City",                1, { 625 } },
    { "Kingdom of Rose",              2, { 700, 725, 775 } },
    { "Green Zone",                   2, { 875, 900 } },
    { "Graveyard",                    2, { 950, 975 } },
    { "Snow Mountain",                2, { 1000, 1050 } },
    { "Ice Fire Island (ฝั่งน้ำแข็ง)", 2, { 1100, 1125 } },
    { "Ice Fire Island (ฝั่งไฟ)",     2, { 1175, 1200 } },
    { "Ice Haven",                    2, { 1350, 1375 } },
    { "Forgotten Island",             2, { 1425 } },
    { "Port City",                    2, { 1500, 1525 } },
    { "Hydra Island",                 3, { 1575, 1600 } },
    { "Amazon Island (Islander)",     3, { 1625, 1650 } },
    { "Great Tree",                   3, { 1700, 1725 } },
    { "Deep Forest (Fishman)",        3, { 1775, 1800 } },
    { "Deep Forest (Pirate)",         3, { 1825, 1850 } },
    { "Deep Forest (Jungle)",         3, { 1900, 1925 } },
    { "Haunted Castle",               3, { 1975, 2000, 2025, 2050 } },
    { "Sea of Treats -- Nuts",        3, { 2075, 2100 } },
    { "Sea of Treats -- Ice Cream",   3, { 2125, 2150 } },
    { "Cake Land",                    3, { 2200, 2225, 2250, 2275 } },
    { "Chocolate Land",               3, { 2300, 2325, 2350, 2375 } },
    { "Candy Cane Land",              3, { 2400, 2425 } },
    { "Tiki Outpost",                 3, { 2450, 2475, 2500, 2525, 2550, 2575 } },
    { "Submerged Island",             3, { 2600, 2625, 2650, 2675, 2700, 2725 } },
}
local Tour = {
    list = {}, idx = 1,
    doneLv = {}, skipLv = {}, failLv = {}, lastTry = {},
    hadQuest = false, finishedNotified = false,
}
local function buildTourList()
    local seaFilter = nil
    if CFG.TourSea == "Sea 1" then seaFilter = 1
    elseif CFG.TourSea == "Sea 2" then seaFilter = 2
    elseif CFG.TourSea == "Sea 3" then seaFilter = 3 end
    Tour.list = {}
    for _, isl in ipairs(TOUR_ISLANDS) do
        if not seaFilter or isl[2] == seaFilter then
            local qs = {}
            for _, qlv in ipairs(isl[3]) do
                for _, q in ipairs(Quests) do
                    if q[1] == qlv then table.insert(qs, q) end
                end
            end
            if #qs > 0 then
                table.insert(Tour.list, { name = isl[1], sea = isl[2], quests = qs })
            end
        end
    end
end
local function tourFlatten()
    local flat = {}
    for _, isl in ipairs(Tour.list) do
        for _, q in ipairs(isl.quests) do
            table.insert(flat, { island = isl, entry = q })
        end
    end
    return flat, #flat
end
buildTourList()

-- ================= [SECRET DATA] เควสลับ -- Island Secrets (Update 30) =================
-- ข้อมูลจริงจาก Blox Fruits Wiki (island-secrets) อัปเดต 15 ต.ค. 2026
-- 40 อัน = Middle Town 4 (รวม The Finale) + อีก 12 เกาะ x 3 อัน | อันละ +5 = 2800 -> 3000
local ISLAND_POS = {
    ["Middle Town"]      = Vector3.new(1061.7, 16.5, 1544.5),
    ["Jungle"]           = Vector3.new(-1604.1, 36.9, 154.2),
    ["Pirate Village"]   = Vector3.new(-1139.6, 4.8, 3825.2),
    ["Desert Island"]    = Vector3.new(897.0, 6.4, 4389.0),
    ["Frozen Village"]   = Vector3.new(1384.1, 87.3, -1297.1),
    ["Marine Fortress"]  = Vector3.new(-5035.1, 28.7, 4325.3),
    ["Skylands"]         = Vector3.new(-4841.8, 717.7, -2624.0),
    ["Prison Island"]    = Vector3.new(4858.7, 7.5, -4361.7),
    ["Colosseum"]        = Vector3.new(-1576.1, 7.4, -2983.3),
    ["Magma Village"]    = Vector3.new(-5316.6, 12.2, 8517.3),
    ["Underwater City"]  = Vector3.new(61122.6, 18.5, 1568.2),
    ["Upper Skylands"]   = Vector3.new(-7902.7, 5636.0, -1411.7),
    ["Fountain City"]    = Vector3.new(5254.6, 38.5, 4049.7),
}
-- รูปแบบ: { id, เกาะ, ชื่อเควส(ในเกม), ประเภท, ต้องรออีเวนต์, บอส, ต้องเปิด Aura, สรุปวิธีทำ(ไทย) }
local SECRET_QUESTS = {
    { "mt1", "Middle Town", "Early Access", "interaction", false, nil, false,
      "เข้าทางหน้าต่างเหนือรถเข็นพัง > หากุญแจใกล้เครื่อง Aura Editor > ปลดล็อกตึกข้างๆ > หยิบ Sea Animation System กลับไปส่ง Janus" },
    { "mt2", "Middle Town", "Lookout Duty", "minigame", false, nil, false,
      "คุย Experienced Captain เลือก Keep Lookout > ดูเรือแล่นผ่าน 4 ลำ > ตอบคำถามให้ถูกทั้ง 4 ข้อ" },
    { "mt3", "Middle Town", "X Marks the Spot", "collection", false, nil, false,
      "ใช้หมัด M1 ตีต้นไม้/ถังไม้/เสาไฟ/กล่องทั่วเมือง หาชิ้นแผนที่ครบ > ประกอบแผนที่ > ขุดจุด X > สู้โครงกระดูก" },
    { "jg1", "Jungle", "Zipline Repair", "tool_interaction", false, nil, false,
      "เก็บ Grapple Hook ข้างแท่น > ปีนขึ้นแท่น > เล็งข้ามน้ำไปอีกฝั่ง > ใช้ hook ซ่อม Zipline" },
    { "jg2", "Jungle", "The Thieving Monkey", "timed_event", true, nil, false,
      "รอรอยเท้าโผล่ใกล้ต้นไม้ใหญ่ > ตีต้นไม้นั้นด้วย M1 > ฆ่าลิงขโมยที่โผล่มา > คืนหมวกให้ Adventurer" },
    { "jg3", "Jungle", "Awakened Gorilla King", "awakened_boss", true, "Gorilla King", false,
      "ตอนอีเวนต์ตื่น: ตีต้นกล้วย M1 ให้กล้วยร่วง = เรียกบอส > สังหาร Awakened Gorilla King" },
    { "pv1", "Pirate Village", "Free the Windmill", "environment_puzzle", false, nil, false,
      "ใช้ดาบ M1 ตัดเชือกที่มัดใบกังหันลมให้ขาดทุกเส้น > ไปรายงาน Pirate Adventurer" },
    { "pv2", "Pirate Village", "Tavern Brawl", "timed_event", true, nil, false,
      "ตอนอีเวนต์: เข้า Tavern > ฆ่า Tavern Pirate 3 ตัว > คุย Tavern Owner > รับรางวัลจาก Pirate Adventurer" },
    { "pv3", "Pirate Village", "Awakened Chef", "awakened_boss", true, "Chef", false,
      "ตอน Chef ตื่น: ทำสตูว์ตามสูตรที่สุ่มในห้อ Cauldron = เรียกบอส > สังหาร Awakened Chef" },
    { "ds1", "Desert Island", "Save Hasan", "rescue", false, nil, false,
      "เหยียบหีบเงินข้างพีระมิด เปิดทางลับ > ฆ่าโครงกระดูกที่รุม Hasan > คุย Hasan แล้วคุย Desert Merchant" },
    { "ds2", "Desert Island", "Rune Cleanup", "environment_puzzle", false, nil, false,
      "ใช้ M1 ทำความสะอาด monolith ทั้ง 8 ก้อนรอบวิหาร > คุย Desert Adventurer" },
    { "ds3", "Desert Island", "Prickly Harvest", "timed_event", true, nil, false,
      "ตอนอีเวนต์เปิด: ตีกระบองเพชรด้วย M1 เก็บ Cactus Petal 10 กลีบ > ส่ง Desert Merchant" },
    { "fv1", "Frozen Village", "Breaking the Ice", "interaction", false, nil, false,
      "เข้าถ้ำใหญ่ > ทำลายก้อนน้ำแข็งใหญ่ ปลดปล่อย Ability Teacher > คุย NPC" },
    { "fv2", "Frozen Village", "Build A Snowman", "timed_event", true, nil, false,
      "ตอนหิมะตกหนัก: เปลี่ยนกองหิมะเป็นบอลหิมะ > กลิ้งมา 3 ลูกประกอบเป็นตุ๊กตาหิมะ > รับรางวัลจาก Villager" },
    { "fv3", "Frozen Village", "Awakened Yeti", "awakened_boss", true, "Yeti", true,
      "เปิด Aura ก่อน! > ตอนอีเวนต์: ทำลายบล็อกน้ำแข็งสาปสีเขียว 3 ก้อง = เรียกบอส > สังหาร Awakened Yeti" },
    { "mf1", "Marine Fortress", "Raise the Flag", "movement_minigame", false, nil, false,
      "หาเชือก > หามไปเสาธงใกล้ Quest Giver > ยืนในวงที่กำหนด เลี่ยงกระสุนปืนใหญ่ จนธีชักขึ้นครบ" },
    { "mf2", "Marine Fortress", "Pirate Raid", "timed_event", true, nil, false,
      "หลังประกาศ + countdown: ขึ้นป้อมปืน turret > ยิงเรือโจรสลัดให้พังทุกลำ" },
    { "mf3", "Marine Fortress", "Awakened Vice Admiral", "awakened_boss", true, "Vice Admiral", false,
      "ตอนปืนใหญ่เริ่มทำงาน: ทำลายครึ่งบนของตึกกลาง = เรียกบอส > สังหาร Awakened Vice Admiral" },
    { "ls1", "Skylands", "Missing Lightning Bolt", "collection", false, nil, false,
      "หาก้อนเมฆเทาเข้มที่กะพริบบนเกาะ > โจมตีมันเพื่อได้ Lightning Bolt > คืนให้ Mad Scientist" },
    { "ls2", "Skylands", "Return the Treasure", "timed_event", true, nil, false,
      "ตอน invaders บุก: เปิดช่องหลังคาปราสาท > ฆ่าศัตรู > อ่านรหัสบนโต๊ะ > ใส่รหัสใน Angelic Vault" },
    { "ls3", "Skylands", "Unexpected Guest", "timed_event", true, nil, false,
      "ตอนเมฆเหลืองโผล่: ตีมัน 3 ครั้ง > เปิดหีบเพชรที่ตก > ฆ่า wave ที่เกิด > ใช้กุญแจเปิดหีบ" },
    { "pr1", "Prison Island", "Prison Break", "rescue", false, nil, false,
      "ตามหาและกำจัดนักโทษหลบหนี 3 คน > คุย Jail Keeper รับรางวัล" },
    { "pr2", "Prison Island", "Mysterious Key", "collection", false, nil, false,
      "เก็บกุญแจบนบอลคอนีหลังจุดเกิด Warden > เปิดห้องลูกกรงชั้นบนของเรือนจำ > ฆ่ายามเพื่อยึด Pink Coat" },
    { "pr3", "Prison Island", "Awakened Warden", "awakened_boss", true, "Warden", false,
      "ตอน Warden ตื่น: ตั้งคานในห้องเรียงซ้ายไปขวา 2 > 3 > 4 > 1 = เรียกบอส > สังหาร Warden" },
    { "co1", "Colosseum", "Gladiatorial Combat", "combat_waves", false, nil, false,
      "คุย Colosseum Emperor รับโจทย์ > ผ่านคลื่นศัตรูสนาม 3 รอบโดยไม่ตาย" },
    { "co2", "Colosseum", "Previous Champions", "environment_puzzle", false, nil, false,
      "เปิดรูปปั้น 4 อันรอบ Colosseum Quest Giver ด้วยชนิดอาวุธที่ตรงกับรูปปั้น (M1/สกิล)" },
    { "co3", "Colosseum", "Crowded Colosseum", "timed_event", true, nil, false,
      "ตอนอีเวนต์ฝูงชน: จุดเป้าที่กำหนด > ตีเป้า 18 อันรอบสนามให้ทันภายใน 90 วินาที" },
    { "mg1", "Magma Village", "Magma Nest", "combat_waves", false, nil, false,
      "ผ่านคลื่นมินิบอสธาตุรอบบ่อลาวา (geyser) > ทำลาย geyser > ฆ่าศัตรูที่เกิด" },
    { "mg2", "Magma Village", "Magma Ore Extraction", "timed_event", true, nil, false,
      "ตอนเจาะเริ่ม: นั่งลิฟต์ลงเหมือง > เลี่ยงไฟส่องของคนงาน > ไปทำลายสว่าน (drill)" },
    { "mg3", "Magma Village", "Awakened Magma General", "awakened_boss", true, "Magma General", false,
      "ตอนอีเวนต์: ทำลาย geyser จิ๋ว 5 จุดรอบภูเขาไฟด้วย M1 = เรียกบอส > สังหาร Awakened Magma General" },
    { "uc1", "Underwater City", "Ride the Bubble", "interaction", false, nil, false,
      "กระโดดเข้าฟองขาวใสที่ลอยจากปะการัง > เข้า Hidden Cove > กดหีบสีดำ > ฆ่าศัตรู 3 ตัวที่เกิด" },
    { "uc2", "Underwater City", "Scattered Light", "environment_puzzle", false, nil, false,
      "หมุนคริสตัลรอบปราสาท Fishman Lord ให้ลำแสงส่องโดนสัญลักษณ์บนกำแพงมืด = ปลดปล่อย Water Kung-fu Teacher" },
    { "uc3", "Underwater City", "Awakened Fishman Lord", "awakened_boss", true, "Fishman Lord", false,
      "ตอนอีเวนต์: ค้นหอย (clam) รอบๆ จนเจอ Black Pearl = เรียกบอส > สังหาร Awakened Fishman Lord" },
    { "us1", "Upper Skylands", "The Old Temple", "environment_puzzle", false, nil, false,
      "คุย Sky Quest Giver 2 รับเควส > บุกทำลายประตูวัด > หมุนหอพลังงานให้เรียงเป็นวงกลม > เก็บของกลับมาส่ง" },
    { "us2", "Upper Skylands", "Awakened Sky Warlord", "awakened_boss", true, "Sky Warlord", false,
      "ตอนพายุ: โจมตีเมฆสายฟ้าสีดำเหนือโครงสร้าง Sky Warlord = เรียกบอส > สังหารบอส" },
    { "us3", "Upper Skylands", "Awakened Lightning God", "awakened_boss", true, "Lightning God", false,
      "ตอนระฆังเรืองแสง: ตีระฆัง 6 ครั้งติดกันด้วยอาวุธตามไอคอนที่โผล่ > สังหาร Awakened Lightning God" },
    { "fc1", "Fountain City", "Pipe Repairs", "environment_puzzle", false, nil, false,
      "ใช้ M1 จัดท่อในบ่อน้ำพุกลางเกาะให้แนวเรียงต่อกัน > ความดันน้ำกลับมา + เรือดีดขึ้นบก = เสร็จ" },
    { "fc2", "Fountain City", "Sewer Gang", "timed_event", true, nil, false,
      "ตอนอีเวนต์: ยกแพลตฟอร์มข้าง Freezeburg Quest Giver เปิดฝาท่อ > ลงไล่ฆ่าศัตรูทุกห้องจนถึงบอสห้องสุดท้าย" },
    { "fc3", "Fountain City", "Awakened Cyborg", "awakened_boss", true, "Cyborg", false,
      "ตอนสายฟ้าแม่เหล็ก junkyard: ซ่อมสายไฟที่ขาดรอบ Cyborg ด้วยการโจมตี = เรียกบอส > สังหาร Cyborg" },
    { "mt4", "Middle Town", "The Finale", "sequence", true, nil, false,
      "ต้องทำอีก 39 อันเสร็จก่อน! > ไปเครื่อง Teleporter ตึกกลาง Middle Town > เลือกจุดหมายแต่ละเกาะตามลำดับที่ถูกต้อง โดยห้ามกดวาร์ปจริง" },
}
local SECRET_GUIDE = {
    ["Middle Town"] =
        "[1/4] Early Access: ขึ้นไปทางหน้าต่างเหนือรถเข็นพัง (ระวังตก) -- หากุญแจใกล้เครื่อง Aura Editor เอาไปปลดล็อกตึกข้างๆ แล้วหยิบ Sea Animation System กลับไปส่ง Janus\n\n" ..
        "[2/4] Lookout Duty: คุย Experienced Captain เลือก Keep Lookout -- ดูเรือแล่นผ่าน 4 ลำ แล้วตอบคำถามทั้ง 4 ข้อให้ถูกหมด\n\n" ..
        "[3/4] X Marks the Spot: ใช้หมัด M1 ตีต้นไม้/ถังไม้/เสาไฟ/กล่องทั่วเมืองจนได้ชิ้นแผนที่ครบ ประกอบแผนที่ ไปขุดจุด X แล้วสู้โครงกระดูกที่โผล่มา\n\n" ..
        "[4/4] The Finale: [ต้องทำอีก 39 อันเสร็จก่อน] ไปที่เครื่อง Teleporter ตึกกลาง Middle Town -- เลือกจุดหมายแต่ละเกาะตามลำดับที่ถูกต้อง โดยห้ามกดวาร์ปจริง",
    ["Jungle"] =
        "[1/3] Zipline: บริเวณจุดเกิด Gorilla King มีต้นไม้ใหญ่พร้อมแท่น Zipline -- เก็บ Grapple Hook ที่พื้นข้างต้นไม้ (ฝั่งขวา) ปีนขึ้นยืนบนแท่นแล้วโยน Grapple ไปที่ตึกฝั่งตรงข้าม จากนั้นกลับไปคุย Quest Giver กลางเกาะรับรางวัล\n\n" ..
        "[2/3] Awakened Gorilla King: มีโอกาสเกิดทุกชั่วโมง (ช่วงนาที 00:XX) -- เฝ้าประกาศบนจอแล้วไปสังหาร จากนั้นไปคุย Pirate Adventurer รับรางวัล\n\n" ..
        "[3/3] หมวกนักผจญภัย: คุย Pirate Adventurer กลางทะเลสาบ -- ลิงขโมยหมวกไปซ่อนในต้นไม้ ให้หาต้นไม้ที่โคนมีรอยเท้าเล็กๆ ตีต้นไม้นั้นด้วย M1 จนลิงร่วงลงมา ฆ่าลิงแล้วเอาหมวกคืนไปให้",
    ["Pirate Village"] =
        "[1/3] กังหันลม: ปีนไปกังหันลมใหญ่กลางเกาะ ใช้ดาบตัดเชือกที่มัดใบพัดให้ขาดทุกเส้น (ต้องถือดาบ) กังหันเริ่มหมุน = เสร็จ แล้วไปคุย NPC ที่ท่าเรือ\n\n" ..
        "[2/3] ครัว + Awakened Chef: ไปชั้นบนของ Tavern (จุดเกิด Chef) กดที่หม้อ Cauldron -- ทำสตูว์ตามสูตรที่เกมสุ่ม: Awakened Chef จะเกิด ฆ่าให้ได้\n\n" ..
        "[3/3] ความวุ่นวายใน Tavern: รออีเวนต์ -- เข้าประตู Saloon ที่สั่นอยู่ เลือก Breach Door แล้วฆ่า Tavern Pirate ทั้ง 3 ตัว คุย Tavern Owner รับรางวัลจาก Pirate Adventurer",
    ["Desert Island"] =
        "[1/3] ช่วย Hasan: หาหีบสมบัติบริเวณกระบองเพชร 2 ต้นข้างต้นมะพร้าว (มุมพีระมิดด้านหมู่บ้าน) -- พื้นจะเปิดเป็นทางลงใต้ดิน ตามทางเข้าไปในพีระมิด ฆ่าโครงกระดูก 4 ตัวรอบ Hasan แล้วกลับไปคุย Pirate Adventurer\n\n" ..
        "[2/3] ทำความสะอาดหิน: ด้านหลังจุดหาหีบสมบัติมีหิน 8 ก้อนจมอยู่ในทราย -- ตีด้วย M1 ให้สะอาดครบทุกก้อน พอร์ทัลบนพื้นเรืองแสง = เสร็จ\n\n" ..
        "[3/3] เก็บดอกกระบองเพชร: รออีเวนต์ -- ตีกระบองเพชรทั่วทั้งเกาะจนได้ Cactus Petal ครบ 10 กลีบ แล้วเอาไปส่ง Desert Merchant (dialog: Prickly Harvest)",
    ["Frozen Village"] =
        "[1/3] ครูพลังพิเศษ: เข้าถ้ำใหญ่หน้าเกาะ จะเจอ Ability Teacher ถูกแช่แข็ง -- ใช้หมัด/อาวุธตีน้ำแข็งให้แตก = ปลดปล่อยสำเร็จ\n\n" ..
        "[2/3] ตุ๊กตาหิมะ: รอช่วงหิมะตกหนัก (จุดเกิด Yeti) -- หาบอลหิมะแล้วกลิ้งมาวางซ้อนกัน ใช้บอลรวม 3 ลูกประกอบเป็นตุ๊กตาหิมะ รับรางวัลจาก Villager\n\n" ..
        "[3/3] Awakened Yeti: [ต้องเปิด Aura] ไปถาม Secret Masters ที่ Middle Town ว่าบอสตัวไหนกำลังตื่น -- ถ้าใช่ Yeti: ไปทำลายบล็อกน้ำแข็งสาปสีเขียว 3 ก้อนที่สุ่มเกิดรอบจุดเกิด Yeti บอสจะเกิด ฆ่าให้ได้",
    ["Marine Fortress"] =
        "[1/3] ธงของ Palrus: คุย Palrus บนหอสังเกตด้านขวาของเกาะ -- เขาต้องการเชือก: ไปเก็บที่ขอบเกาะฝั่งซ้าย (แถวจุดเกิด Chief Petty Officer) แล้วกลับมาที่เสาธงกลางเกาะ กด E ชูธง -- อยู่ในวงแดงจนเสร็จ ระวังกระสุนปืนใหญ่\n\n" ..
        "[2/3] Pirate Raid: รอประกาศ Enemy ships are closing in on the Marine Fortress -- คุย Palrus เลือก dialog ใหม่ แล้วขึ้นป้อมปืน (turret) ยิงเรือศัตรูให้พังทั้งหมด\n\n" ..
        "[3/3] Awakened Vice Admiral: รอประกาศ An alarm has sounded at Marine Fortress -- ป้อมปืนจะเริ่มยิงใส่เกาะ: ไปทำลายครึ่งบนตึกที่ Vice Admiral เกิดเพื่อหยุดปืน แล้วฆ่าบอส",
    ["Skylands"] =
        "[1/3] เมฆเหลือง + หีบเพชร: รอประกาศ A secret cloud has appeared over the Skylands -- มองหาเมฆสีเหลืองแล้วบิน/วาร์ปทะลุมัน 3 ครั้ง มันจะดรอปหีบ Diamond -- ไปเก็บที่เกาะ Angel Guard เปิดหีบ ฆ่าศัตรูที่เกิด คุย Angel Guard รับรางวัล\n\n" ..
        "[2/3] สายฟ้า: คุย Mad Scientist บนเกาะล่าง เขาต้องการ Lightning Bolt -- ขึ้นไปส่วนบนของเกาะหาก้อนเมฆสีเทาเข้มที่กะพริบ โจมตีมันจะได้สายฟ้า เอาไปคืน\n\n" ..
        "[3/3] คืนสมบัติ: คุย Angel Guard รับโจทย์ แล้วรอประกาศ Enemies have invaded the Skylands castle -- ไปปราสาทหลังคาสีน้ำเงิน (แถวจุดเกิด Sky Bandit) ทำลายแพตช์สีน้ำตาลข้างหลังคาแล้วเข้าไป ฆ่าศัตรู เก็บกระดาษรหัสใกล้ทางเข้า ใช้รหัสเปิดตู้เซฟ (Angelic Vault) กลางปราสาท",
    ["Prison Island"] =
        "[1/3] นักโทษหลบหนี: หานักโทษหลบหนี 3 คน -- (1) กำลังขุดหลุมหน้าห้อง Head Jailer (2) พิงกำแพงอยู่ฝั่งซ้าย (3) กำลังสร้างแพหนีทะเลข้าง Boat Dealer -- เข้าไปกด Confront ก่อนทุกครั้งแล้วค่อยโจมตี\n\n" ..
        "[2/3] กุญแจปริศนา: ขึ้นบอลคอนีที่อยู่เหนือจุดเกิด Warden เก็บ Cell Block Key -- เข้าตึกกลาง (ที่มี Dangerous Prisoner) ปีนขึ้นไปเปิด Office Gate ด้วยกุญแจ ขึ้นบันไดสีแดงไปหา Don Megalo กด E ที่เสื้อบนเก้าอี้ -- Megalo Guard จะเกิด ฆ่าแล้วยึดเสื้อ (Pink Coat) มา\n\n" ..
        "[3/3] Awakened Warden: รอประกาศ A cell creaks open -- เข้าตึกกลางไปห้องขวาสุด ดึงคานเรียงลำดับซ้ายไปขวา: 2 > 3 > 4 > 1 แล้วฆ่าบอส",
    ["Colosseum"] =
        "[1/3] คลื่นกลาดิเอเตอร์: คุย Emperor บนบอลคอนี เลือก Yes -- ฆ่าคลื่นกลาดิเอเตอร์ทั้ง 3 รอบ (รอบสุดท้ายมี Supreme Gladiator) แล้วคุย Emperor อีกครั้งรับรางวัล\n\n" ..
        "[2/3] รูปปั้น 4 อัน: คุย Colosseum Quest Giver หน้าสนาม เลือก dialog Rumor -- ตีรูปปั้นทั้ง 4 ด้วยชนิดอาวุธที่ตรงกับที่รูปปั้นถืออยู่ (หมัด/ดาบ/ปืน) จนทุกอันทำท่าทาง\n\n" ..
        "[3/3] ของขวัญของฝูงชน: รอประกาศ The Colosseum stands are filling up -- มองหาเป้าสีเทาบนเสาแล้วยิง จากนั้นเป้าแดง-ขาวจะเกิดทั่วสนาม ตีให้ครบ 18 อันภายใน 90 วินาที",
    ["Magma Village"] =
        "[1/3] บ่อลาวา: ไปบ่อลาวาใกล้ท่าเรือ ตีหม้อลาวากลางบ่อจนแตก -- มินิบอสธาตุจะเกิดทีละรอบ ฆ่าให้หมดทุกรอบ ทำลาย geyser แล้วฆ่าศัตรูที่เกิดต่อ แล้วไปคุย Mayor\n\n" ..
        "[2/3] Awakened Magma General: ถาม Secret Masters ที่ Middle Town ก่อน -- ถ้าเป็นตัวนี้: ไปที่ภูเขาไฟ ทำลาย geyser จิ๋ว 5 จุดรอบภูเขาด้วย M1 บอสจะเกิด ฆ่าให้ได้\n\n" ..
        "[3/3] ทำลายสว่าน: รออีเวนต์เจาะเหมือง -- เดินตามแนวชายทะเลฝั่งตรงข้ามบ่อลาวาจนเจอทางเข้า -- กดลิฟต์ลงไปในเหมือง เลี่ยงสายตาคนงาน (spotlight) เดินลับๆ ไปทำลาย Magma Drill",
    ["Underwater City"] =
        "[1/3] ฟองอากาศ: กระโดดเข้าฟองสีขาวใสบนเกาะ มันจะพาไป Hidden Cove -- เปิดหีบสีดำกลางถ้ำ ฆ่าศัตรู 3 ตัวที่เกิด แล้วลงวนน้ำ (whirlpool) ออกมา\n\n" ..
        "[2/3] ช่วยครูหมัดน้ำ: ไปด้านขวาของปราสาท Fishman Lord จะเห็นคริสตัล 4 อัน (แสงส่องอยู่ 2 อัน) และแผ่นทรายบนกำแพงขวา -- จัดมุมคริสตัลให้แสงส่องโดนแผ่นทราย กำแพงจะแตก เข้าไปคุย Water Kung-fu Teacher\n\n" ..
        "[3/3] Awakened Fishman Lord: รอประกาศ The water is stirring -- ค้นหอย (clam) รอบๆ จนเจอ Black Pearl เอาไปที่จุดเกิดบอสเพื่อเริ่มซีเควนซ์ แล้วฆ่าให้ได้",
    ["Upper Skylands"] =
        "[1/3] วัตถุโบราณ: คุย Sky Quest Giver 2 เลือก The old temple -- ทำลายก้อนหินที่ขวางประตูวัด เข้าไปทางซ้ายแล้วเลี้ยวขวา ตีเสาไฟฟ้าในวงให้ลำแสงเชื่อมถึงกันครบวง จะได้ของ (intel) แล้วหนีฟ้าผ่ากลับไปส่ง NPC\n\n" ..
        "[2/3] Awakened Sky Warlord: รอประกาศ A storm brews in the upper skylands -- ไปจุดเกิด Sky Warlord โจมตีก้อนเมฆสายฟ้าสีดำเหนือจุดเกิด แล้วฆ่าบอส\n\n" ..
        "[3/3] Awakened Lightning God: รอประกาศ The bell shimmers in upper skylands -- ไปที่ระฆัง จะมีไอคอนอาวุธผลัดกันโผล่ (ปืน/ดาบ/หมัด) ตีระฆังด้วยอาวุธที่ตรงกับไอคอน 6 ครั้งติดกันโดยไม่ผิด แล้วฆ่าบอส",
    ["Fountain City"] =
        "[1/3] ซ่อมท่อ: ขึ้นไปบนบ่อน้ำพุใหญ่กลางเกาะ ตีท่อที่แตกให้ซ่อมครบทุกท่อ -- แล้วขึ้นเรือที่อยู่ในบ่อ มันจะพาดีดขึ้นบก = เสร็จ\n\n" ..
        "[2/3] ใต้ฝาท่อระบายน้ำ: รออีเวนต์ -- ไปแถว Freezeburg Quest Giver จะเห็นเครน + แพลตฟอร์มมีจาน กด E ยกแพลตฟอร์มขึ้นเผยฝาท่อ (manhole) ลงไปในท่อระบายน้ำ ฆ่าศัตรูทุกห้อง ทุบกำแพงไปเรื่อยๆ จนเจอบอสห้องสุดท้าย ฆ่าให้ได้\n\n" ..
        "[3/3] Awakened Cyborg: รอประกาศ The junkyard has been magnetized by lightning -- ไปจุดเกิด Cyborg ซ่อมสายไฟที่ขาดบนพื้นให้ครบ แล้วฆ่าบอส",
    ["Mob Island"] =
        "[เสริม] ยังไม่มีเอกสารครบสามอัน -- เดินสำรวจ NPC แปลกใหม่ (ในตึก/บนหลังคา/กลางน้ำ) และวัตถุที่ตีแล้วมีปฏิกิริยา (แตก/สั่น/ขยับ) เช็คดาวของเกาะใน World Map เป็นตัวชี้วัด",
    ["Secrets Master"] =
        "[ส่วนเสริม] NPC Secret Masters อยู่ที่ Middle Town (ในตึกหลังจุดเกิด The Saw) -- เป็น NPC ใหม่ของ Update 30 ที่บอกได้ว่าบอส Awakened ตัวไหนกำลังจะตื่น (ถาม Which boss stirs next?) และตัวมันเองก็มีความลับของตัวเองซ่อนอยู่ -- ลองคุยทุก dialog และสำรวจรอบตึก",
}

-- ================= [SEA] ตรวจโลกปัจจุบัน + กรองฟังก์ชันตามโลก (v3.0) =================
-- ใช้พิกัด NPC เควสจริงใน [DATA] เป็นจุดอ้างอิง หาว่าตอนนี้อยู่ Sea ไหน
-- แล้ว "โชว์เฉพาะฟังก์ชันที่ใช้ได้ในโลกนั้น" (เปิด-ปิดได้ที่แท็บ Teleport/Config)
local function questSea(lv)
    if lv <= 625 then return 1        -- Sea 1: Lv 1-625 (จบที่ Fountain City)
    elseif lv <= 1525 then return 2   -- Sea 2: Lv 700-1525 (จบที่ Port City)
    else return 3 end                 -- Sea 3: Lv 1575+ (Hydra -> Submerged)
end
NX.questSea = questSea
local SEA_ANCHORS = {}
for _, q in ipairs(Quests) do
    if typeof(q[5]) == "Vector3" then
        table.insert(SEA_ANCHORS, { pos = q[5], sea = questSea(q[1]), name = q[2] })
    end
end
for nm, p in pairs(ISLAND_POS) do
    table.insert(SEA_ANCHORS, { pos = p, sea = 1, name = nm })  -- 13 เกาะ secrets = Sea 1
end
NX.currentSea = 1
NX.currentSeaName = "?"
NX.seaListeners = {}
local function detectSea()
    local c, hrp = alive()
    if not hrp then return NX.currentSea, NX.currentSeaName end
    local best, bd = nil, math.huge
    for _, a in ipairs(SEA_ANCHORS) do
        local d = (hrp.Position - a.pos).Magnitude
        if d < bd then bd, best = d, a end
    end
    if not best then return NX.currentSea, NX.currentSeaName end
    return best.sea, best.name, bd
end
NX.detectSea = detectSea
local function fireSea(newSea, anchorName, dist)
    if newSea == NX.currentSea then return end
    local old = NX.currentSea
    NX.currentSea = newSea
    NX.currentSeaName = tostring(anchorName)
    Notify("โลกเปลี่ยน (Sea Filter)",
        "Sea " .. old .. " -> Sea " .. newSea .. " (ใกล้ " .. tostring(anchorName) .. ") -- กรองเมนูให้อัตโนมัติ", 6)
    for _, fn in ipairs(NX.seaListeners) do pcall(fn, newSea, old) end
end
task.spawn(function()
    while not NX.dead do
        task.wait(2)
        local s, nm, d = detectSea()
        if s then fireSea(s, nm, d) end
    end
end)
-- ============================ [3] UI LIB (Pepsi's UI Library) ============================
-- UI framework: Pepsi's UI Library v0.32 (โหลดจาก rbxassetid 7657867786 -- ช่องทางทางการ)
-- + adapter ชั้นบาง: engine เดิม (NOVEL-X/Melo Hub) เรียก UI.* แบบเดิม -> แปลงเป็น Pepsi API
-- + toast แจ้งเตือนแยก ScreenGui ของเราเอง (ไม่ตามตอนซ่อน/ปิดหน้าต่างหลัก)
local UI = {}
local PepsiLib
do
    -- ---- โหลด Pepsi UI ----
    local PEPSI_SRC = "rbxassetid://7657867786"
    local function tryLoadPepsi()
        local objs = game:GetObjects(PEPSI_SRC)
        if not objs or not objs[1] or not objs[1].Source then return nil end
        return loadstring(objs[1].Source)()
    end
    local ok = pcall(function() PepsiLib = tryLoadPepsi() end)
    if not ok or not PepsiLib then
        task.wait(1)
        ok = pcall(function() PepsiLib = tryLoadPepsi() end)
    end
    if not ok or not PepsiLib then
        print("[Melo Hub] ERROR: โหลด Pepsi UI Library ไม่สำเร็จ (GetObjects)")
        print("[Melo Hub] ลอง: (1) รันสคริปต์ใหม่ (2) เช็คเน็ต (3) executor ต้องรองรับ GetObjects")
        error("Melo Hub: Pepsi UI Library load failed (GetObjects) -- ลองรันใหม่อีกครั้ง")
    end

    local Window = PepsiLib:CreateWindow({
        Name = "Melo Hub [Blox Fruits] | TJ Edition",
        Themeable = {
            Credit = true,
            Info = "Melo Hub v3.0 | made by TJ | PC ONLY / NO KEY | Blox Fruits Update 30",
        },
    })
    pcall(function()
        Window:CreateDesigner({ Info = "Melo Hub v3.0 | made by TJ | (อดีตชื่อ NOVEL-X)" })
    end)
    UI.Library = PepsiLib
    UI.Window = Window

    -- ---- toast แจ้งเตือน (ของเราเอง -- แยกจากหน้าต่าง Pepsi) ----
    local toastGui = Instance.new("ScreenGui")
    toastGui.Name = "NX-Toast"
    toastGui.ResetOnSpawn = false
    toastGui.DisplayOrder = 9999
    pcall(function() if syn and syn.protect_gui then syn.protect_gui(toastGui) end end)
    local parented = pcall(function()
        toastGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")
    end)
    if not parented then
        pcall(function() toastGui.Parent = LP:FindFirstChild("PlayerGui") end)
    end
    local T_BG = Color3.fromRGB(21, 21, 30)
    local T_TEXT = Color3.fromRGB(235, 235, 240)
    local T_SUB = Color3.fromRGB(150, 150, 165)
    local T_ACC = Color3.fromRGB(235, 64, 74)
    local function tnew(class, props, parent)
        local o = Instance.new(class)
        for k, v in pairs(props) do
            if k ~= "Parent" then pcall(function() o[k] = v end) end
        end
        if parent then o.Parent = parent end
        return o
    end
    local notifRoot = tnew("Frame", {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -10, 0, 10),
        Size = UDim2.new(0, 290, 0, 400),
    }, toastGui)
    tnew("UIListLayout", {
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
    }, notifRoot)
    local notifOrder = 0
    UI.Notify = function(title, text, dur)
        notifOrder = notifOrder + 1
        local n = tnew("Frame", {
            BackgroundColor3 = T_BG,
            Size = UDim2.new(0, 280, 0, 52),
            LayoutOrder = notifOrder,
        }, notifRoot)
        tnew("UICorner", { CornerRadius = UDim.new(0, 8) }, n)
        tnew("UIStroke", { Color = Color3.fromRGB(55, 55, 80), Thickness = 1 }, n)
        tnew("Frame", {
            BackgroundColor3 = T_ACC,
            Position = UDim2.new(0, 0, 0, 6),
            Size = UDim2.new(0, 3, 1, -12),
        }, n)
        tnew("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 6),
            Size = UDim2.new(1, -18, 0, 16),
            Font = Enum.Font.GothamBold,
            Text = tostring(title),
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextColor3 = T_TEXT,
        }, n)
        tnew("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 24),
            Size = UDim2.new(1, -18, 0, 22),
            Font = Enum.Font.Gotham,
            Text = tostring(text),
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextColor3 = T_SUB,
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

    -- ---- adapter: engine เดิมเรียก UI.* -> Pepsi ----
    local function curSec(tab)
        if not tab.sec then
            tab.sec = tab.obj:CreateSection({ Name = " " })
        end
        return tab.sec
    end
    UI.Tab = function(name)
        local t = { sec = nil }
        t.obj = Window:CreateTab({ Name = tostring(name) })
        return t
    end
    UI.Section = function(tab, name, side)
        tab.sec = tab.obj:CreateSection({
            Name = tostring(name),
            Side = (side == "R") and "Right" or "Left",
        })
        return tab.sec
    end
    UI.Label = function(tab, text)
        local l = curSec(tab):AddLabel({ Text = tostring(text) })
        return { Set = function(v) pcall(function() l:Set(tostring(v)) end) end }
    end
    UI.Paragraph = function(tab, text)
        local l = curSec(tab):AddLabel({ Text = tostring(text) })
        return { Set = function(v) pcall(function() l:Set(tostring(v)) end) end }
    end
    UI.Button = function(tab, title, cb)
        return curSec(tab):AddButton({
            Name = tostring(title),
            Callback = function(...) pcall(cb, ...) end,
        })
    end
    UI.Toggle = function(tab, title, default, cb)
        local tg = curSec(tab):AddToggle({
            Name = tostring(title),
            Value = default and true or false,
            Callback = function(v) pcall(cb, v) end,
        })
        return {
            Set = function(v)
                v = v and true or false
                if tg.RawSet then
                    pcall(function() tg:RawSet(v) end)
                else
                    pcall(function() tg:Set(v) end)
                end
            end,
        }
    end
    UI.Slider = function(tab, title, min, max, default, cb)
        local s = curSec(tab):AddSlider({
            Name = tostring(title),
            Value = default or min or 0,
            Min = min or 0,
            Max = max or 100,
            Callback = function(v) pcall(cb, v) end,
        })
        return { Set = function(v) pcall(function() s:Set(v) end) end }
    end
    UI.Dropdown = function(tab, title, options, default, cb)
        local opts = options or {}
        local val = default
        if val ~= nil and table.find(opts, val) == nil then val = nil end
        local d = curSec(tab):AddDropdown({
            Name = tostring(title),
            List = opts,
            Value = val,
            Sort = false,
            BlankValue = "...",
            Callback = function(v) if v ~= nil then pcall(cb, v) end end,
        })
        return {
            Set = function(v) pcall(function() d:Set(v) end) end,
            Refresh = function(newOpts) pcall(function() d:UpdateList(newOpts or {}) end) end,
        }
    end
    UI.Search = function(tab, title, options, cb)
        local sb = curSec(tab):AddSearchBox({
            Name = tostring(title),
            List = options or {},
            Sort = false,
            BlankValue = "พิมพ์เพื่อค้นหา...",
            Callback = function(v) if v ~= nil then pcall(cb, v) end end,
        })
        return {
            Set = function(v) pcall(function() sb:Set(v) end) end,
            Refresh = function(newOpts) pcall(function() sb:UpdateList(newOpts or {}) end) end,
        }
    end
    UI.Keybind = function(tab, title, default, cb)
        return curSec(tab):AddKeybind({
            Name = tostring(title),
            Value = default,
            Callback = function(newKey)
                if typeof(newKey) == "EnumItem" then
                    NX.lastBind = os.clock()
                    pcall(cb, newKey)
                end
            end,
        })
    end
    UI.SetStatus = function() end      -- (แถบสถานะเดิม -> ดูที่ Home: Live Status)
    UI.SetAccent = function() end      -- (ธีม -> ใช้ Designer ของ Pepsi แทน)

    -- ---- ซ่อน/แสดงหน้าต่าง Pepsi (RightControl) ----
    local pepsiguis = {}
    pcall(function()
        for _, o in ipairs(PepsiLib.objects or {}) do
            if typeof(o) == "Instance" and o:IsA("ScreenGui") then
                table.insert(pepsiguis, o)
            end
        end
    end)
    if #pepsiguis == 0 then
        pcall(function()
            local roots = {}
            pcall(function() table.insert(roots, gethui()) end)
            table.insert(roots, game:GetService("CoreGui"))
            pcall(function() table.insert(roots, LP:FindFirstChild("PlayerGui")) end)
            for _, root in ipairs(roots) do
                for _, g in ipairs(root:GetChildren()) do
                    if g:IsA("ScreenGui") and (scontains(g.Name, "Pepsi") or scontains(g.Name, "Library")) then
                        table.insert(pepsiguis, g)
                    end
                end
            end
        end)
    end
    UI.pepsiguis = pepsiguis   -- [v3.0] ให้ธีมอวกาศ/ดวงดาวใช้รายการหน้าต่างนี้
    UI.toggleWindow = function()
        if #pepsiguis == 0 then
            Notify("Melo Hub", "หาหน้าต่าง UI หลักไม่เจอ -- ลองกด RightShift (ปุ่มซ่อนของ Pepsi) ดู", 5)
            return
        end
        for _, g in ipairs(pepsiguis) do
            pcall(function() g.Enabled = not g.Enabled end)
        end
    end
    UI.Destroy = function()
        pcall(function() toastGui:Destroy() end)
        pcall(function() PepsiLib.Unload() end)
    end
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
        print(string.format("[Melo Hub] %s: %s", tostring(title), tostring(text)))
    end
    flushQueue()
end

-- ================= [THEME] โหมดอวกาศ: ดำ + ดวงดาว (v3.0) =================
-- ทาพื้นหลังโทนเข้มของหน้าต่าง Pepsi ให้เป็นดำอวกาศ + วางดวงดาว 60 ดวง
-- สร้างครั้งเดียว ไม่มีลูปต่อเฟรม = ไม่กิน FPS (Fixed Lag แบบมีหลักฐาน)
local function applySpaceTheme()
    local n = 0
    local function paint(inst)
        pcall(function()
            if inst:IsA("GuiObject") and inst.BackgroundTransparency < 1 then
                local bg = inst.BackgroundColor3
                local lum = (bg.R + bg.G + bg.B) / 3
                if lum > 0 and lum <= 0.45 then
                    -- ขยี้ลงเป็นดำอวกาศ (คงโทนเดิม เช่น แดงเข้ม -> ดำอมแดง)
                    inst.BackgroundColor3 = Color3.new(bg.R * 0.40, bg.G * 0.40, bg.B * 0.48 + 0.015)
                    n = n + 1
                end
            end
        end)
    end
    for _, gui in ipairs(UI.pepsiguis or {}) do
        pcall(function()
            for _, d in ipairs(gui:GetDescendants()) do paint(d) end
        end)
    end
    return n
end

local starHolder = nil
local function injectStarfield()
    -- หา root Frame ของหน้าต่าง Pepsi = ลูกตรง (Frame) ที่ใหญ่สุดของ ScreenGui
    local win, winArea = nil, 0
    for _, gui in ipairs(UI.pepsiguis or {}) do
        pcall(function()
            for _, ch in ipairs(gui:GetChildren()) do
                if ch:IsA("Frame") then
                    local a = (ch.AbsoluteSize.X + 1) * (ch.AbsoluteSize.Y + 1)
                    if a > winArea then winArea, win = a, ch end
                end
            end
        end)
    end
    if not win then return false, "no-window" end
    if starHolder and starHolder.Parent then pcall(function() starHolder:Destroy() end) end
    local holder = Instance.new("Frame")
    holder.Name = "NX-Cosmos"
    holder.BackgroundTransparency = 1
    holder.Size = UDim2.new(1, 0, 1, 0)
    holder.ZIndex = 0
    holder.ClipsDescendants = true
    holder.Parent = win
    -- ดวงดาว 60 ดวง (สร้างครั้งเดียว -- ไม่มี animation loop)
    local rng = Random.new(20261016)
    for i = 1, 60 do
        local sz = math.floor(rng:NextNumber(2, 4.5))
        local star = Instance.new("Frame")
        star.Name = "Star" .. i
        star.BackgroundColor3 = (i % 7 == 0) and Color3.fromRGB(125, 211, 252) or Color3.fromRGB(238, 243, 255)
        star.BackgroundTransparency = rng:NextNumber(0.05, 0.55)
        star.Size = UDim2.new(0, sz, 0, sz)
        star.Position = UDim2.new(rng:NextNumber(), 0, rng:NextNumber(), 0)
        star.ZIndex = 0
        star.BorderSizePixel = 0
        local uc = Instance.new("UICorner")
        uc.CornerRadius = UDim.new(1, 0)
        uc.Parent = star
        star.Parent = holder
    end
    -- เนบิวลาจางๆ 2 ผืน (ฟ้า + ม่วง) เพิ่มบรรยากาศอวกาศ
    local nebulas = {
        { Color3.fromRGB(30, 58, 95), UDim2.new(0.04, 0, 0.10, 0), UDim2.new(0, 200, 0, 95) },
        { Color3.fromRGB(58, 30, 95), UDim2.new(0.60, 0, 0.62, 0), UDim2.new(0, 230, 0, 110) },
    }
    for i, nb in ipairs(nebulas) do
        local neb = Instance.new("Frame")
        neb.Name = "Nebula" .. tostring(i)
        neb.BackgroundColor3 = nb[1]
        neb.BackgroundTransparency = 0.88
        neb.Size = nb[3]
        neb.Position = nb[2]
        neb.ZIndex = 0
        neb.BorderSizePixel = 0
        local ng = Instance.new("UIGradient")
        ng.Transparency = NumberSequence.new(0.15, 1)
        ng.Parent = neb
        local nc = Instance.new("UICorner")
        nc.CornerRadius = UDim.new(1, 0)
        nc.Parent = neb
        neb.Parent = holder
    end
    -- ให้เนื้อหา (แท็บ/ปุ่ม) อยู่เหนือชั้นดาวเสมอ (nil = 0)
    for _, sib in ipairs(win:GetChildren()) do
        if sib ~= holder and sib:IsA("GuiObject") and (sib.ZIndex or 0) < 1 then
            pcall(function() sib.ZIndex = 1 end)
        end
    end
    starHolder = holder
    return true, "stars:60"
end
UI.applyCosmos = function()
    local n = applySpaceTheme()
    local ok, why = injectStarfield()
    return n, ok, why
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

-- เลือกเควส + [v3.0] Double Quest Policy (50% Same Island / 100% Cross-Island)
-- อัตราส่วน: reqLv / เลเวลคุณ > 0.5 (เท่ากับ 0.5 ไม่ผ่าน) + กันค่า 0/ว่าง
local function dqRatioOK(reqLevel, playerLevel)
    if type(reqLevel) ~= "number" or type(playerLevel) ~= "number" then
        return true, "ข้อมูลไม่ใช่ตัวเลข -- ข้ามตัวกรอง"
    end
    if playerLevel <= 0 then
        return true, "เลเวล 0/ไม่ทราบ -- ข้ามตัวกรอง (ป้องกันบล็อกลูป)"
    end
    if reqLevel <= 0 then
        return true, "เควสไม่มีขั้นต่ำ -- ผ่าน"
    end
    local ratio = reqLevel / playerLevel
    if ratio > 0.5 then
        return true, string.format("%.3f > 0.5 ผ่าน", ratio)
    end
    return false, string.format("%.3f <= 0.5 ตัดออก", ratio)
end
NX.dqRatioOK = dqRatioOK

local function pickQuest(lv, pos)
    local cands = {}
    for i = #Quests, 1, -1 do
        local q = Quests[i]
        if q[1] <= lv and not NX.stale[q[1] .. "-" .. q[2]] then
            table.insert(cands, q)   -- เรียงจากเควสล่าสุด -> ต่ำสุด
        end
    end
    if #cands == 0 then return nil, "ไม่มีเควสที่เลเวลถึง" end
    local is50 = (CFG.DQPolicy ~= "100%")
    if is50 then
        -- 50% (Same Island): กรองอัตราส่วน > 0.5 + เน้นเกาะใกล้ตัว (ไม่เดินทางไกลไม่จำเป็น)
        local passed, cutLog = {}, {}
        for _, q in ipairs(cands) do
            local ok, why = dqRatioOK(q[1], lv)
            if ok then table.insert(passed, q)
            else cutLog[#cutLog + 1] = "Lv" .. q[1] end end
        if #passed == 0 then
            NX.lastDQNote = "50%: ไม่มีเควสผ่านอัตราส่วน -- ใช้เควสดีสุดต่อ (ไม่บล็อกฟาร์ม)"
        elseif #cutLog > 0 then
            NX.lastDQNote = "50% ตัดทิ้ง (reqLv/เลเวล <= 0.5): " .. table.concat(cutLog, ", ")
        else
            NX.lastDQNote = nil
        end
        cands = (#passed > 0) and passed or cands
    else
        NX.lastDQNote = nil
    end
    if not is50 then
        return cands[1], "100%: เควสสูงสุด Lv " .. cands[1][1] .. " (ข้ามเกาะได้)"
    end
    if pos then
        local best, bd = nil, math.huge
        for _, q in ipairs(cands) do
            if typeof(q[5]) == "Vector3" then
                local d = (pos - q[5]).Magnitude
                if d < bd then bd, best = d, q end
            end
        end
        if best then
            return best, "50%: เกาะใกล้สุด Lv " .. best[1] .. " (" .. math.floor(bd) .. "m)"
        end
    end
    return cands[1], "50%: เควสสูงสุด Lv " .. cands[1][1]
end
NX.pickQuest = pickQuest
-- [v3.0] API: สลับ Double Quest Policy จากภายนอก (console/UI ภายนอก/ทดสอบ)
NX.setDQPolicy = function(v)
    local new = (v == "100%" or v == "100% -- Cross-Island") and "100%" or "50%"
    if new ~= CFG.DQPolicy then
        CFG.DQPolicy = new
        Notify("Double Quest", "โหมดใหม่: " .. new ..
            (new == "50%" and " (Same Island -- แนะนำ)" or " (Cross-Island -- ใช้ถ้ามี bypass tp)"), 5)
    end
    return CFG.DQPolicy
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

    -- วิธี 3: บินไปที่ NPC แบบปลอดภัย (75) แล้วลองใหม่ (กันเกมบังคับให้อยู่ใกล้)
    if typeof(entry[5]) == "Vector3" then
        toposSafe(CFrame.new(entry[5]))
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
        if not (CFG.AutoFarm or CFG.FarmAll or CFG.AutoAwakened or CFG.TourMode) then
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
                if CFG.TourMode and NX.tourEntry then
                    -- โหมดเควสลับ (Island Tour): ใช้เควสของทัวร์ที่กำลังไล่อยู่
                    entry = NX.tourEntry
                elseif not atCap then
                    entry, NX.pickWhy = pickQuest(lv, hrp and hrp.Position or nil)
                end
                NX.currentEntry = entry

                if atCap and not CFG.TourMode then
                    farmStatus = "CAP 2800 -- ทำ Island Secrets = 3000"
                    if not NX.capNotified then
                        NX.capNotified = true
                        Notify("MAX LEVEL 2800",
                            "ทำ Island Secrets 40 อัน (แท็บเควสลับ) = 3000", 10)
                    end
                end

                -- 0) Sea Beast มาก่อน (ถ้าเปิด)
                if CFG.AutoSeaBeast then
                    local beast, bpos = findSeaBeast()
                    if beast then
                        farmStatus = "Sea Beast!"
                        toposSafe(CFrame.new(bpos + Vector3.new(0, 20, 0)))
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
                --    โหมดเควสลับ: ลูปทัวร์จัดการรับ/สลับเควสเอง (ไม่ให้ชนกัน)
                if (CFG.AutoFarm or CFG.TourMode) and not CFG.FarmAll and not atCap
                    and not (CFG.TourMode and NX.tourEntry) then
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
                        toposSafe(trp.CFrame * CFrame.new(0, 0, 8))
                    end
                    attack(CFG.AttackSpeed)
                    skillTick = skillTick + 1
                    if skillTick >= 3 then useSkills() skillTick = 0 end
                elseif not CFG.FarmAll then
                    -- ไม่เจอศัตรู: ถ้าเควสยังไม่ยอมเกิด ไปรอที่จุดเกิดของมัน
                    if entry and typeof(entry[6]) == "Vector3" then
                        farmStatus = "Waiting mobs..."
                        toposSafe(CFrame.new(entry[6]))
                    elseif entry then
                        farmStatus = "Waiting mobs (ไม่มีพิกัด -- โหมด Bring จะดึงศัตรูมาเอง)"
                    end
                end
            end
        end
    end
end)

-- ---------------- เควสลับ: ฟังก์ชันควบคุมโหมดไล่ทุกเกาะ (Island Tour) ----------------
NX.setTour = function(v)
    v = v and true or false
    if v == CFG.TourMode then return end
    CFG.TourMode = v
    if v then
        -- เปิดทัวร์เควสหลัก = ปิด Auto Farm + เควสลับ (สลับกัน ไม่ให้ชน)
        if CFG.AutoFarm and NX.setFarm then NX.setFarm(false) end
        if CFG.SecretTour and NX.setSecretTour then NX.setSecretTour(false) end
        if NX.secretToggleRef then NX.secretToggleRef.Set(false) end
        Tour.finishedNotified = false
        Notify("ทัวร์เควสหลัก (Island Tour)",
            "เปิดโหมดไล่ทำเควสหลักทุกเกาะแล้ว -- ขอบเขต: " .. tostring(CFG.TourSea), 6)
    else
        if NX.tourToggleRef then NX.tourToggleRef.Set(false) end
        Notify("ทัวร์เควสหลัก (Island Tour)", "ปิดโหมดไล่เกาะแล้ว", 4)
    end
end
NX.tourReset = function()
    Tour.idx = 1
    Tour.doneLv, Tour.skipLv, Tour.failLv, Tour.lastTry = {}, {}, {}, {}
    Tour.hadQuest = false
    Tour.finishedNotified = false
    Notify("Island Tour", "รีเซ็ตความคืบหน้า -- เริ่มนับใหม่จากเกาะแรก", 5)
end
NX.tourRebuild = function()
    buildTourList()
    Tour.idx = 1
    Tour.doneLv, Tour.skipLv, Tour.failLv, Tour.lastTry = {}, {}, {}, {}
    Tour.hadQuest = false
    Tour.finishedNotified = false
end
NX.tourSkipCurrent = function()
    local flat = tourFlatten()
    local cur = flat[Tour.idx]
    if cur then
        Tour.skipLv[cur.entry[1]] = true
        if hasQuest() then invoke("AbandonQuest") end
        Tour.hadQuest = false
        Tour.idx = Tour.idx + 1
        Notify("Island Tour", "ข้าม: " .. cur.entry[4] .. " (Lv " .. cur.entry[1] .. ")", 4)
    else
        Notify("Island Tour", "ไม่มีเควสปัจจุบัน (ทัวร์จบแล้ว?)", 4)
    end
end
NX.tourJumpIsland = function(name)
    local flat = tourFlatten()
    for i, f in ipairs(flat) do
        if f.island.name == name then
            Tour.idx = i
            Tour.hadQuest = false
            Tour.finishedNotified = false
            if hasQuest() then invoke("AbandonQuest") end
            local q = f.entry
            if typeof(q[5]) == "Vector3" then toposSafe(CFrame.new(q[5])) end
            Notify("Island Tour", "เริ่มทัวร์ที่: " .. name .. " (เควสแรก Lv " .. q[1] .. ")", 5)
            return
        end
    end
    Notify("Island Tour", "ไม่พบเกาะ: " .. tostring(name), 4)
end

-- ---------------- ลูปเควสลับ: ไล่ทำเควสทุกเกาะ (Island Tour) ----------------
-- วิธีทำงาน: ไล่เควสตามลำดับเกาะ Sea 1 > 2 > 3 -- ถึงเกาะไหนรับเควสของเกาะนั้น
-- ครบทุกอันแล้วค่อยไปเกาะถัดไป / เกมส่งมอบเควสอัตโนมัติเมื่อตีครบ (UI เควสหายไป)
task.spawn(function()
    while not NX.dead do
        task.wait(0.3)
        if not CFG.TourMode then
            NX.tourEntry = nil
        else
            local flat, total = tourFlatten()
            local cur = flat[Tour.idx]
            if not cur then
                farmStatus = "TOUR: ครบทุกเกาะในขอบเขตแล้ว! (กดรีเซ็ตเพื่อเริ่มใหม่)"
                NX.tourEntry = nil
                if not Tour.finishedNotified then
                    Tour.finishedNotified = true
                    Notify("Island Tour", "ทำเควสครบทุกเกาะในขอบเขต " .. tostring(CFG.TourSea) .. " แล้ว! (made by TJ)", 10)
                end
            else
                local q = cur.entry
                local lv = getLevel()
                if q[1] > lv then
                    -- เลเวลยังไม่ถึงเควสนี้
                    if CFG.TourSkipLocked then
                        Tour.skipLv[q[1]] = true
                        Tour.idx = Tour.idx + 1
                    else
                        farmStatus = "TOUR: รอเลเวล " .. q[1] .. " (ฟาร์มเควสดีสุดเก็บเลเวลรอไปก่อน)"
                        NX.tourEntry = nil
                    end
                else
                    NX.tourEntry = q
                    NX.tourIslandName = cur.island.name
                    if not hasQuest() then
                        if Tour.hadQuest then
                            -- เควสเพิ่งเสร็จ (เกมส่งมอบอัตโนมัติ = UI เควสหาย)
                            Tour.doneLv[q[1]] = true
                            Tour.hadQuest = false
                            Tour.idx = Tour.idx + 1
                            Notify("Island Tour",
                                "เควสเสร็จ: " .. q[4] .. " (Lv " .. q[1] .. ") -- " ..
                                math.min(Tour.idx, total) .. "/" .. total .. " ไปเกาะ/เควสถัดไป", 5)
                        else
                            farmStatus = "TOUR: รับเควส @ " .. cur.island.name .. "..."
                            local now = os.clock()
                            if not Tour.lastTry[q[1]] or now - Tour.lastTry[q[1]] > 9 then
                                Tour.lastTry[q[1]] = now
                                local ok = acceptQuest(q)
                                if ok then
                                    Tour.hadQuest = true
                                    Tour.failLv[q[1]] = nil
                                    Notify("Island Tour", "รับเควสแล้ว: " .. q[4] .. " @ " .. cur.island.name, 5)
                                else
                                    Tour.failLv[q[1]] = (Tour.failLv[q[1]] or 0) + 1
                                    if Tour.failLv[q[1]] >= 3 then
                                        -- ลอง 3 รอบไม่ได้ (เกมอัปเดต?) = mark + ข้ามไปก่อน
                                        NX.stale[q[1] .. "-" .. q[2]] = true
                                        Tour.skipLv[q[1]] = true
                                        Tour.idx = Tour.idx + 1
                                        Notify("Island Tour",
                                            "Lv " .. q[1] .. " (" .. q[4] .. ") รับไม่ได้ 3 ครั้ง -- ข้ามไปก่อน", 6)
                                    end
                                end
                            end
                        end
                    else
                        local t = questTitle()
                        if t and not matchEnemy(t, q[4]) then
                            -- มีเควสเก่าค้างจากเกาะอื่น: ละทิ้งแล้วรับของทัวร์แทน
                            invoke("AbandonQuest")
                        else
                            Tour.hadQuest = true
                            farmStatus = "TOUR: " .. cur.island.name .. " > " .. q[4] ..
                                " (" .. Tour.idx .. "/" .. total .. ")"
                        end
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
        task.wait(3)
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
                toposSafe(CFrame.new(fpos))
            end
        else
            seenFruits = {}
        end
    end
end)

-- ================= [SECRET TOUR] เควสลับ -- Island Secrets (Update 30) =================
-- ไล่ทำ Island Secrets 40 อันทั้ง Sea 1: วาร์ปรายเกาะ > โชว์ไกด์รายอัน > ตรวจเสร็จ > ไปต่อ
-- หมายเหตุ: มินิเกม/อีเวนต์บางอันต้องทำเอง (ยิง turret / ตอบคำถาม / กลิ้งหิมะ)
--          ระบบช่วยเต็มที่: วาร์ป + ไกด์ละเอียด + ตรวจเสร็จอัตโนมัติ + ล่าบอส Awakened
local SecretTour = {
    idx = 1,          -- ลำดับ secret ปัจจุบัน (1-40)
    doneIds = {},     -- id ของอันที่เสร็จแล้ว
    skipIds = {},     -- id ของอันที่ข้าม
    lastLv = nil,     -- เลเวลล่าสุดที่เช็ค (ใช้ตรวจ +5)
    notified = {},    -- id ที่เคยวาร์ป+แจ้งไกด์แล้ว (กัน spam)
}
local function secretProgress()
    local dn, sk = 0, 0
    for _, s in ipairs(SECRET_QUESTS) do
        if SecretTour.doneIds[s[1]] then dn = dn + 1 end
        if SecretTour.skipIds[s[1]] then sk = sk + 1 end
    end
    return dn, sk, #SECRET_QUESTS
end
local function secretArrive(s)
    local p = ISLAND_POS[s[2]]
    if p then toposSafe(CFrame.new(p + Vector3.new(0, 25, 0))) end
    local tags = {}
    if s[5] then table.insert(tags, "รออีเวนต์") end
    if s[7] then table.insert(tags, "ต้องเปิด Aura") end
    if s[6] then table.insert(tags, "บอส: " .. s[6]) end
    local tag = (#tags > 0) and (" [" .. table.concat(tags, " | ") .. "]") or ""
    Notify("เควสลับ [" .. tostring(SecretTour.idx) .. "/40]: " .. s[3],
        s[2] .. tag .. " -- " .. s[8], 12)
end
NX.setSecretTour = function(v)
    v = v and true or false
    if v == CFG.SecretTour then return end
    CFG.SecretTour = v
    if v then
        -- เปิดเควสลับ = ปิด Auto Farm + ทัวร์เควสหลัก (สลับกัน ไม่ให้แย่งวาร์ป)
        if CFG.AutoFarm and NX.setFarm then NX.setFarm(false) end
        if CFG.TourMode and NX.setTour then NX.setTour(false) end
        if SecretTour.idx > #SECRET_QUESTS then
            Notify("เควสลับ", "ลิสต์ครบ 40 อันแล้ว -- กด [รีเซ็ตเควสลับ] ถ้าจะเริ่มใหม่", 6)
            CFG.SecretTour = false
            return
        end
        Notify("เควสลับ (Island Secrets)",
            "เริ่มไล่ทำ 40 อันทั้ง Sea 1 -- วาร์ปรายเกาะ + โชว์วิธีทำทีละอัน (เปิด-ปิดได้ตลอด)", 8)
        SecretTour.lastLv = getLevel()
        -- [v3.0] gen-token: กันลูปซ้ำเวลาปิด-เปิดถี่ๆ (บั๊กจริงที่ runtime test เคยเจอ)
        SecretTour.gen = (SecretTour.gen or 0) + 1
        local myGen = SecretTour.gen
        task.spawn(function()
            if SecretTour.gen ~= myGen then return end
            local cur = SECRET_QUESTS[SecretTour.idx]
            if cur and not SecretTour.notified[cur[1]] then
                SecretTour.notified[cur[1]] = true
                secretArrive(cur)
            end
            while not NX.dead and CFG.SecretTour do
                if SecretTour.gen ~= myGen then return end
                task.wait(1)
                local lv = getLevel()
                local c = SECRET_QUESTS[SecretTour.idx]
                -- ตรวจเสร็จอัตโนมัติ: หลังแคป 2800 เควสปกติไม่ให้เลเวล -> +5 = secret เสร็จ 1 อัน
                if CFG.SecretTourAutoNext and c and SecretTour.lastLv
                    and lv >= SecretTour.lastLv + 5 and lv > 2800 then
                    SecretTour.doneIds[c[1]] = true
                    Notify("เควสลับเสร็จอีก 1 อัน!", c[3] .. " (+5 เลเวล) -- ไปอันถัดไป", 6)
                    NX.secretNext(nil, true)
                    c = SECRET_QUESTS[SecretTour.idx]
                end
                SecretTour.lastLv = lv
                if c and not SecretTour.notified[c[1]] then
                    SecretTour.notified[c[1]] = true
                    secretArrive(c)
                elseif not c and CFG.SecretTour then
                    local dn, sk, total = secretProgress()
                    Notify("เควสลับจบแล้ว!",
                        string.format("ครบ %d อัน (เสร็จ %d + ข้าม %d) -- เป้าหมาย Lv 3000", total, dn, sk), 10)
                    CFG.SecretTour = false
                    if NX.secretToggleRef then NX.secretToggleRef.Set(false) end
                end
            end
        end)
    else
        if NX.secretToggleRef then NX.secretToggleRef.Set(false) end
        Notify("เควสลับ", "ปิดโหมดแล้ว (ความคืบหน้าถูกจำไว้ -- เปิดใหม่ทำต่อได้เลย)", 5)
    end
end
NX.secretNext = function(markDone, fromAuto)
    local cur = SECRET_QUESTS[SecretTour.idx]
    if not cur then
        Notify("เควสลับ", "ไม่มีอันปัจจุบัน (ลิสต์จบแล้ว -- กดรีเซ็ตถ้าจะเริ่มใหม่)", 4)
        return
    end
    if markDone ~= false then
        SecretTour.doneIds[cur[1]] = true
        if not fromAuto then Notify("เควสลับ", "จัดไป: " .. cur[3] .. " -- ไปอันถัดไป", 4) end
    else
        SecretTour.skipIds[cur[1]] = true
        Notify("เควสลับ", "ข้าม: " .. cur[3] .. " (กดรีเซ็ตถ้าจะกลับมาทำ)", 4)
    end
    SecretTour.idx = SecretTour.idx + 1
    local nxt = SECRET_QUESTS[SecretTour.idx]
    if nxt and CFG.SecretTour then
        if not SecretTour.notified[nxt[1]] then
            SecretTour.notified[nxt[1]] = true
            secretArrive(nxt)
        end
    elseif not nxt then
        local dn, sk, total = secretProgress()
        Notify("เควสลับจบแล้ว!", string.format("ครบ %d อัน (เสร็จ %d + ข้าม %d)", total, dn, sk), 10)
        if CFG.SecretTour then
            CFG.SecretTour = false
            if NX.secretToggleRef then NX.secretToggleRef.Set(false) end
        end
    end
end
NX.secretReset = function()
    SecretTour.idx = 1
    SecretTour.doneIds, SecretTour.skipIds, SecretTour.notified = {}, {}, {}
    SecretTour.lastLv = nil
    Notify("เควสลับ", "รีเซ็ตแล้ว -- เริ่มนับใหม่จากอันแรก (Middle Town)", 5)
end

-- ---------------- ลูปเสริม: เฝ้าบอส Awakened (Island Secrets -- Update 30) ----------------
-- บอส Awakened สุ่มเกิดราวๆ ทุกชั่วโมง (นาที 00:XX) พร้อมข้อความแจ้งบนจอ
-- เจอแล้ว: แจ้งเตือนทันที / ถ้าเปิดล่าอัตโนมัติ = วาร์ปไปตีให้เอง (ในลูปหลัก)
task.spawn(function()
    local seenAwakened = {}
    while not NX.dead do
        task.wait(3)
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
        -- [v3.0] ปิดสองอย่าง = ไม่ต้องแตะ Humanoid เลย (Fixed Lag)
        if not (CFG.WalkSpeedOn or CFG.JumpPowerOn) then
            -- ข้ามรอบนี้ไปเลย
        else
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
            local iv = CFG.PerfMode and 0.15 or 0.08   -- [v3.0] โหมดประหยัด = ESP ช้าลง
            if acc < iv then return end
            acc = 0
            if not CFG.ESP then
                if next(cache) then clearAll() end     -- [v3.0] ไม่วุ่นวายกับชุดว่างทุกเฟรม
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

-- ================= [PvP] Silent Aim + FOV + สถานะ PvP (v3.0) =================
-- Team / PvP State แสดงจากข้อมูลจริงที่เกมเปิดเผยได้ (หาไม่เจอ = แสดงตามจริง)
-- Silent Aim: เลือกเป้าตามโหมด + hook Mouse.Hit ตอนยิง (ปืน/สกิลที่อ่านตำแหน่งเมาส์)
local PvP = { lastHit = 0 }
NX.PvP = PvP
do
    -- ตรวจโดนดาเมจล่าสุด (ใช้ประมาณ InCombat แบบมีหลักฐาน)
    local function hookChar(c)
        if not c then return end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local lastHP = hum.Health
        conn(hum.HealthChanged:Connect(function(h)
            if h < lastHP - 0.5 then PvP.lastHit = os.clock() end
            lastHP = h
        end))
    end
    hookChar(LP.Character)
    conn(LP.CharacterAdded:Connect(function(c) task.wait(0.3) hookChar(c) end))
end

-- PvP State: InCombat / Disable PvP / Ready PvP (แสดงตามสัญญาณจริงที่หาเจอ)
local function pvpState()
    local sig = {}
    local dataVal
    pcall(function()
        for _, v in ipairs(LP.Data:GetChildren()) do
            if v:IsA("BoolValue") and (scontains(v.Name, "Pvp") or scontains(v.Name, "PVP")) then
                dataVal = v
                break
            end
        end
    end)
    if dataVal then table.insert(sig, "Data." .. dataVal.Name) end
    local combatUi
    pcall(function()
        local pg = LP:FindFirstChild("PlayerGui")
        if pg then
            for _, d in ipairs(pg:GetDescendants()) do
                if d:IsA("GuiObject") and d.Visible
                    and (scontains(d.Name, "InCombat") or scontains(d.Name, "Pvp")) then
                    combatUi = d
                    break
                end
            end
        end
    end)
    if combatUi then table.insert(sig, "UI:" .. combatUi.Name) end
    local recentHit = PvP.lastHit > 0 and (os.clock() - PvP.lastHit) < 6
    if recentHit then table.insert(sig, "โดนดาเมจล่าสุด") end
    local state, src
    if (NX.currentSea or 1) == 1 then
        state = "Disable PvP"
        src = "กติกาเกม: Sea 1 ปิด PvP"
    elseif dataVal then
        state = dataVal.Value and "Ready PvP" or "Disable PvP"
        src = "Data." .. dataVal.Name .. " (realtime)"
    elseif combatUi then
        state = "InCombat"
        src = "UI:" .. combatUi.Name
    elseif recentHit then
        state = "InCombat"
        src = "โดนดาเมจล่าสุด (ประมาณการ)"
    else
        state = "ไม่พบสัญญาณ PvP"
        src = "เกมไม่เปิดเผยค่านี้ -- ดูปุ่ม PvP ใน Settings ของเกม"
    end
    return state, src, sig
end
NX.pvpState = pvpState

-- เลือกเป้า Silent Aim ตามโหมด (Cursor / FOV / Screen Center) + Range + Team Check
local function screenPosOf(part)
    local cam = workspace.CurrentCamera
    if not cam then return nil end
    local sp, on = cam:WorldToViewportPoint(part.Position)
    if not on then return nil end
    return Vector2.new(sp.X, sp.Y)
end
local function aimTarget()
    local cam = workspace.CurrentCamera
    if not cam then return nil end
    local _, lphrp = alive()
    local vp = cam.ViewportSize
    local mousePos
    pcall(function() mousePos = UserInput:GetMouseLocation() end)
    if not mousePos then mousePos = Vector2.new(vp.X / 2, vp.Y / 2) end
    local ref, radius
    if CFG.AimMode == "Cursor" then
        ref, radius = mousePos, 120
    elseif CFG.AimMode == "Screen Center" then
        ref, radius = Vector2.new(vp.X / 2, vp.Y / 2), CFG.FOVSize
    else
        ref, radius = mousePos, CFG.FOVSize
    end
    local best, bestScore = nil, nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            local ch = p.Character
            if ch then
                local partName = (CFG.AimPart == "HumanoidRootPart") and "HumanoidRootPart" or "Head"
                local part = ch:FindFirstChild(partName)
                local hum = ch:FindFirstChildOfClass("Humanoid")
                if part and hum and hum.Health > 0 then
                    local dist = lphrp and (part.Position - lphrp.Position).Magnitude or math.huge
                    if dist <= CFG.AimRange then
                        if not (CFG.AimTeamCheck and p.Team and p.Team == LP.Team) then
                            local sp = screenPosOf(part)
                            if sp then
                                local sd = math.sqrt((sp.X - ref.X) ^ 2 + (sp.Y - ref.Y) ^ 2)
                                if sd <= radius then
                                    local score = sd + dist * 0.002
                                    if not bestScore or score < bestScore then
                                        bestScore = score
                                        best = { p = p, part = part, sp = sp, dist = dist }
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return best
end
NX.aimTarget = aimTarget

-- FOV Circle (Drawing API) -- อัพเดตเฉพาะช่วงเปิดใช้ (ไม่กิน FPS)
local fovCircle
local function ensureCircle()
    if not NX.canDraw then return false end
    if fovCircle then return true end
    pcall(function()
        fovCircle = Drawing.new("Circle")
        fovCircle.Thickness = 1
        fovCircle.NumSides = 64
        fovCircle.Radius = CFG.FOVSize
        fovCircle.Filled = false
        fovCircle.Color = Color3.fromRGB(125, 211, 252)
        fovCircle.Visible = false
    end)
    return fovCircle ~= nil
end
conn(RunService.RenderStepped:Connect(function()
    if not CFG.FOVCircle or not NX.canDraw then
        if fovCircle then pcall(function() fovCircle.Visible = false end) end
        return
    end
    if not ensureCircle() then return end
    local cam = workspace.CurrentCamera
    if not cam then return end
    local vp = cam.ViewportSize
    local pos
    if CFG.FOVMode == "Screen Center" then
        pos = Vector2.new(vp.X / 2, vp.Y / 2)
    else
        pcall(function() pos = UserInput:GetMouseLocation() end)
        if not pos then pos = Vector2.new(vp.X / 2, vp.Y / 2) end
    end
    fovCircle.Radius = CFG.FOVSize
    fovCircle.Position = pos
    fovCircle.Visible = true
end))

-- Silent Aim hook (lazy: ติดตั้งครั้งแรกที่เปิดใช้) -- executor ไม่มี hookmetamethod
-- = fallback เป็น Face Target อย่างเดียว + แจ้งตามจริง (ไม่โกหกว่าใช้ได้)
local aimHookState = "off"
local mouseObj
pcall(function() mouseObj = LP:GetMouse() end)
local function hookAim()
    if aimHookState == "hooked" then return true end
    if aimHookState == "fallback" then return false end
    if not mouseObj then aimHookState = "fallback" return false end
    local ok = pcall(function()
        local old
        old = hookmetamethod(game, "__index", function(self, k)
            local v = old(self, k)
            if k == "Hit" and self == mouseObj and CFG.SilentAim then
                local t = aimTarget()
                if t and t.part then
                    return CFrame.new(t.part.Position)
                end
            end
            return v
        end)
        aimHookState = "hooked"
    end)
    if not ok then aimHookState = "fallback" end
    return aimHookState == "hooked"
end
NX.hookAim = hookAim
NX.aimHookState = function() return aimHookState end

-- Face Target: กดยิง(ปืน/สกิล)แล้วหันตัวเข้าเป้าทันที (สกิล/หมัดที่ยิงตามทิศตัว)
local facedTools = {}
local function bindTool(tool)
    if facedTools[tool] then return end
    facedTools[tool] = true
    pcall(function()
        conn(tool.Activated:Connect(function()
            if CFG.SilentAim and CFG.FaceTarget then
                local t = aimTarget()
                if t and t.part then
                    local _, hrp = alive()
                    if hrp then
                        pcall(function() hrp.CFrame = CFrame.new(hrp.Position, t.part.Position) end)
                    end
                end
            end
        end))
    end)
end
local function scanTools(c)
    if not c then return end
    for _, ch in ipairs(c:GetChildren()) do
        if ch:IsA("Tool") then bindTool(ch) end
    end
end
do
    local c = LP.Character
    if c then
        scanTools(c)
        pcall(function()
            conn(c.ChildAdded:Connect(function(ch)
                if ch:IsA("Tool") then task.wait(0.2) bindTool(ch) end
            end))
        end)
    end
    conn(LP.CharacterAdded:Connect(function(nc)
        task.wait(0.5)
        scanTools(nc)
        pcall(function()
            conn(nc.ChildAdded:Connect(function(ch)
                if ch:IsA("Tool") then task.wait(0.2) bindTool(ch) end
            end))
        end)
    end))
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
    -- [v3.0] กลับ "เซิร์ฟเดิม" (JobId) -- ผิดพลาด = ไปเซิร์ฟใหม่แทน
    Notify("Rejoin", "กลับเซิร์ฟเดิม...")
    local ok = pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP)
    end)
    if not ok then
        pcall(function() TeleportService:Teleport(game.PlaceId, LP) end)
    end
end
-- [v3.0] tp ล้มเหลว = ลองใหม่อัตโนมัติ (อีเวนต์จริงของ TeleportService)
pcall(function()
    conn(TeleportService.TeleportInitFailed:Connect(function()
        if CFG.AutoRejoin then
            Notify("Auto Rejoin", "เทเลพอร์ตล้มเหลว -- ลองใหม่ใน 3 วิ")
            task.delay(3, function()
                pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP) end)
                pcall(function() TeleportService:Teleport(game.PlaceId, LP) end)
            end)
        end
    end))
end)
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
                            Notify("Auto Rejoin", "โดนเตะ/เซิร์ฟปิด -- กลับเซิร์ฟเดิม!")
                            local ok2 = pcall(function()
                                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP)
                            end)
                            if not ok2 then
                                pcall(function() TeleportService:Teleport(game.PlaceId, LP) end)
                            end
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
    UI.Section(t, "Welcome", "L")
    UI.Label(t, "Melo Hub v3.0 | PC only | No key | Max Lv 3000")
    UI.Label(t, "made by TJ | UI: Pepsi v0.32 | free forever")
    UI.Section(t, "Quick Start", "L")
    UI.Button(t, "Start Auto Farm (ฟาร์มเควสหลัก)", function()
        NX.setFarm(true)
        Notify("Auto Farm", "Started -- good luck! (made by TJ)")
    end)
    UI.Button(t, "เควสลับ: ไล่ Island Secrets 40 อัน", function()
        NX.setSecretTour(true)
    end)
    UI.Button(t, "ทัวร์เควสหลัก: ไล่ทุกเกาะ 3 ทะเล", function()
        NX.setTour(true)
    end)
    UI.Button(t, "Stop All Loops (หยุดทุกอย่าง)", function()
        NX.setFarm(false)
        if NX.setTour then NX.setTour(false) end
        if NX.setSecretTour then NX.setSecretTour(false) end
        CFG.FarmAll = false
        NX.setFly(false)
        CFG.FruitSniper = false
        Notify("Stopped", "All farm loops stopped.")
    end)
    UI.Section(t, "Live Status (สด)", "R")
    local st1 = UI.Label(t, "...")
    local st2 = UI.Label(t, "...")
    local st3 = UI.Label(t, "...")
    local st4 = UI.Label(t, "...")
    local st5 = UI.Label(t, "...")
    local st6 = UI.Label(t, "...")
    task.spawn(function()
        while not NX.dead do
            task.wait(1)
            local e = NX.currentEntry
            st1.Set(string.format("Lv %d | Beli %s | %s",
                getLevel(), tostring(getBeli()), tostring(getFruit())))
            local qt = questTitle()
            if hasQuest() then
                st2.Set("Quest: " .. tostring(qt or "active"))
            else
                st2.Set("Quest: none")
            end
            if e then
                st3.Set(string.format("Target: Lv %d %s #%d", e[1], e[4], e[3]))
            elseif getLevel() >= 2800 then
                st3.Set("Target: ISLAND SECRETS (แท็บเควสลับ)")
            else
                st3.Set("Target: no data for this level")
            end
            local lvNow = getLevel()
            if lvNow > 2800 then
                local secretLv = lvNow - 2800
                local est = math.min(math.floor(secretLv / 5), 40)
                st4.Set(string.format("Secrets: +%d (ประมาณ %d/40)", secretLv, est))
            elseif lvNow == 2800 then
                st4.Set("ครบแคป 2800 -- เริ่มทำ Secrets ได้เลย")
            else
                st4.Set(string.format("ฟาร์มถึง 2800 ก่อน (เหลือ %d)", 2800 - lvNow))
            end
            st5.Set(NX.statusText or "FPS: ...")
            st6.Set("โลก: Sea " .. (NX.currentSea or 1) .. " (" .. tostring(NX.currentSeaName or "?") .. ")")
        end
    end)
end

-- ================= FARM =================
do
    local t = UI.Tab("Farm")
    UI.Section(t, "Auto Farm Level")
    local farmToggle
    farmToggle = UI.Toggle(t, "Auto Farm (Quest Mode)", false, function(v)
        NX.setFarm(v)
    end)
    NX.farmToggleRef = farmToggle
    NX.setFarm = function(v)
        v = v and true or false
        if v == CFG.AutoFarm then return end
        CFG.AutoFarm = v
        if farmToggle then farmToggle.Set(v) end
        if v then
            -- เปิดฟาร์ม = ปิดโหมดทัวร์ + เควสลับ (สลับกัน ไม่ให้แย่งเป้าหมาย)
            if CFG.TourMode and NX.setTour then NX.setTour(false) end
            if CFG.SecretTour and NX.setSecretTour then NX.setSecretTour(false) end
            if NX.tourToggleRef then NX.tourToggleRef.Set(false) end
            if NX.secretToggleRef then NX.secretToggleRef.Set(false) end
            Notify("Auto Farm", "Quest mode ON -- leveling with quests")
        end
    end
    UI.Toggle(t, "Auto Swap Quest (สลับเควสตามเลเวล)", CFG.AutoSwap, function(v)
        CFG.AutoSwap = v
    end)
    UI.Dropdown(t, "Farm Mode", { "Bring Enemies", "Go To Enemies (Safe)" }, CFG.FarmMode, function(v)
        CFG.FarmMode = v
    end)
    -- [v3.0] การเดินทาง + Double Quest Policy
    UI.Toggle(t, "บินไปทำเควสแบบปลอดภัย (กันวาร์ปกลับ)", CFG.SafeTravel, function(v)
        CFG.SafeTravel = v
        if v then Notify("Travel", "เปิด -- จำกัดความเร็ว " .. CFG.TravelSpeed) end
    end)
    UI.Slider(t, "ความเร็วบินไปทำเควส (75 = กันวาร์ป)", 16, 150, CFG.TravelSpeed, function(v)
        CFG.TravelSpeed = v
    end)
    local dqDrop
    dqDrop = UI.Dropdown(t, "Double Quest Policy", { "50% -- Same Island (แนะนำ)", "100% -- Cross-Island" },
        (CFG.DQPolicy == "100%") and "100% -- Cross-Island" or "50% -- Same Island (แนะนำ)", function(v)
            local new = (v == "100% -- Cross-Island") and "100%" or "50%"
            if new ~= CFG.DQPolicy then
                CFG.DQPolicy = new
                Notify("Double Quest", "โหมดใหม่: " .. v, 5)
            end
        end)
    UI.Button(t, "คืนค่าเริ่มต้น Policy (50%)", function()
        CFG.DQPolicy = "50%"
        pcall(function() dqDrop.Set("50% -- Same Island (แนะนำ)") end)
        Notify("Double Quest", "คืนค่าเริ่มต้นแล้ว: 50% -- Same Island", 5)
    end)
    local dqLbl = UI.Label(t, "...")
    task.spawn(function()
        while not NX.dead do
            task.wait(2)
            local note = NX.lastDQNote or NX.pickWhy or "-"
            if #note > 60 then note = string.sub(note, 1, 60) .. ".." end
            dqLbl.Set("Policy " .. CFG.DQPolicy .. ": " .. note)
        end
    end)
    local wepDrop
    local wepList = getWeaponOptions()
    wepDrop = UI.Dropdown(t, "Weapon", wepList, (table.find(wepList, CFG.Weapon) and CFG.Weapon) or nil, function(v)
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
    UI.Section(t, "Modes", "R")
    UI.Toggle(t, "Farm All Enemies (no quest)", false, function(v)
        CFG.FarmAll = v
        if v then Notify("Farm All", "Attacking every enemy nearby") end
    end)
    UI.Toggle(t, "Auto Sea Beast (โจมตี Sea Beast)", false, function(v)
        CFG.AutoSeaBeast = v
    end)
    UI.Section(t, "Combat Extras", "R")
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
    -- อัพเดตรายชื่ออาวุธเรื่อยๆ (v3.0: 10 วิ/ครั้ง -- Fixed Lag)
    task.spawn(function()
        while not NX.dead do
            task.wait(10)
            pcall(function() wepDrop.Refresh(getWeaponOptions()) end)
        end
    end)
end

-- ================= QUEST (+ ทัวร์เควสหลัก) =================
do
    local t = UI.Tab("Quest")
    UI.Section(t, "Quest System (เควสหลัก)", "L")
    UI.Label(t, "ระบบเควสอัตโนมัติ: รับเควส ตี สลับเควสเองตามเลเวล")
    UI.Button(t, "Abandon Current Quest (ละทิ้งเควสปัจจุบัน)", function()
        invoke("AbandonQuest")
        Notify("Quest", "Abandoned.")
    end)
    UI.Button(t, "Accept Best Quest Now (รับเควสดีสุด)", function()
        local lv = getLevel()
        local _, hrp = alive()
        local e, why = pickQuest(lv, hrp and hrp.Position or nil)
        if e then
            Notify("Quest", "Trying: Lv " .. e[1] .. " " .. e[4] .. " (" .. tostring(why) .. ")")
            task.spawn(function()
                local ok = acceptQuest(e)
                Notify("Quest", ok and "Accepted!" or "Failed (server refused)")
            end)
        else
            Notify("Quest", "No quest data for Lv " .. lv)
        end
    end)
    UI.Section(t, "Quest Data Status (สถานะฐานข้อมูล)", "L")
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
    UI.Section(t, "อัปเดตฐานข้อมูลเมื่อเกมอัปเดต", "L")
    UI.Label(t, "เกมเพิ่มเควสใหม่? ใส่ getgenv().NX_QUESTS = { {เลเวล, \"NPCชื่อ\", ลำดับ, \"ชื่อศัตรู\"} } ก่อนรันสคริปต์ หรือสร้างไฟล์ NX-TJ-quests.json ใน workspace folder ของ executor")
    UI.Label(t, "ระบบจะทดลองใช้ + ตรวจยืนยันกับเกมจริงให้อัตโนมัติ อันไหนใช้ไม่ได้จะข้ามให้เอง")

    -- ---------- ทัวร์เควสหลัก (36 เกาะ / 83 เควส) ----------
    UI.Section(t, "ทัวร์เควสหลัก (36 เกาะ / 83 เควส)", "R")
    UI.Label(t, "ไล่ทำเควสหลักทุกเกาะตามลำดับ Sea 1 > 2 > 3")
    UI.Label(t, "ถึงเกาะไหนรับเควสของเกาะนั้นให้ครบทุกอัน")
    UI.Label(t, "เปิด-ปิดได้ตลอด ความคืบหน้าจำตลอดเซสชัน")
    local tourTgl
    tourTgl = UI.Toggle(t, "เปิดโหมดทัวร์เควสหลัก (ไล่ทุกเกาะ)", false, function(v)
        NX.setTour(v)
    end)
    NX.tourToggleRef = tourTgl
    local scopeDrop
    scopeDrop = UI.Dropdown(t, "ขอบเขต (Scope)", { "All", "Sea 1", "Sea 2", "Sea 3" }, CFG.TourSea, function(v)
        if v == CFG.TourSea then return end
        CFG.TourSea = v
        NX.tourScopeManual = true   -- [v3.0] เลือกเอง = ไม่ตาม Sea Filter อัตโนมัติ
        NX.tourRebuild()
        Notify("Island Tour", "ขอบเขตใหม่: " .. v, 5)
    end)
    -- [v3.0] Sea Filter: เปลี่ยนโลก = สลับขอบเขตทัวร์ตาม (ถ้ายังไม่เลือกเอง)
    table.insert(NX.seaListeners, function(newSea)
        if CFG.SeaFilter and not NX.tourScopeManual then
            local want = "Sea " .. newSea
            if want ~= CFG.TourSea then
                CFG.TourSea = want
                NX.tourRebuild()
                pcall(function() scopeDrop.Set(want) end)
                Notify("Sea Filter", "ทัวร์: ขอบเขตตามโลก -> " .. want, 5)
            end
        end
    end)
    UI.Toggle(t, "ข้ามเควสที่เลเวลไม่ถึง (ปิด=รอ+ฟาร์ม)", CFG.TourSkipLocked, function(v)
        CFG.TourSkipLocked = v
    end)
    UI.Button(t, "ข้ามเควสปัจจุบัน (Skip Current Quest)", function()
        NX.tourSkipCurrent()
    end)
    UI.Button(t, "รีเซ็ตทัวร์ (เริ่มใหม่จากเกาะแรก)", function()
        NX.tourReset()
    end)
    local ts1 = UI.Label(t, "...")
    local ts2 = UI.Label(t, "...")
    local ts3 = UI.Label(t, "...")
    local tourIslandNames = {}
    for _, isl in ipairs(TOUR_ISLANDS) do
        table.insert(tourIslandNames, isl[1])
    end
    local curTourIsland = tourIslandNames[1]
    UI.Search(t, "เริ่มทัวร์ที่เกาะ... (พิมพ์ค้นหาได้)", tourIslandNames, function(v)
        curTourIsland = v
    end)
    UI.Button(t, "กระโดดไปเริ่มที่เกาะที่เลือก", function()
        if curTourIsland then NX.tourJumpIsland(curTourIsland) end
    end)
    task.spawn(function()
        while not NX.dead do
            task.wait(2)
            local flat, total = tourFlatten()
            local cur = flat[Tour.idx]
            local doneN, skipN = 0, 0
            for _, f in ipairs(flat) do
                if Tour.doneLv[f.entry[1]] then doneN = doneN + 1 end
                if Tour.skipLv[f.entry[1]] then skipN = skipN + 1 end
            end
            ts1.Set(string.format("ความคืบหน้ารวม: %d/%d เควส (เสร็จ %d | ข้าม %d | เหลือ %d)",
                doneN + skipN, total, doneN, skipN, total - doneN - skipN))
            if CFG.TourMode and cur then
                ts2.Set("กำลังทำ: " .. cur.island.name .. " (Sea " .. cur.island.sea ..
                    ") > Lv " .. cur.entry[1] .. " " .. cur.entry[4])
            elseif CFG.TourMode then
                ts2.Set("สถานะ: ทำครบทุกเกาะในขอบเขตแล้ว!")
            else
                ts2.Set("สถานะ: ปิดอยู่ (เปิดได้จาก toggle ด้านบน)")
            end
            ts3.Set("ขอบเขต: " .. tostring(CFG.TourSea) .. " | เกาะ: " .. #Tour.list ..
                " | โหมดเลเวลไม่ถึง: " .. (CFG.TourSkipLocked and "ข้าม" or "รอ+ฟาร์มจนถึง"))
        end
    end)
end

-- ================= เควสลับ (Island Secrets -- Update 30) =================
-- เควสลับของ Sea 1 ทั้งหมด = Island Secrets 40 อัน (Middle Town 4 + อีก 12 เกาะ x3)
-- อันละ +5 Secret Levels: ปลดล็อกแคป 2800 -> 3000 | ข้อมูล: Blox Fruits Wiki (2026-10-15)
do
    local t = UI.Tab("เควสลับ")
    UI.Section(t, "เควสลับ -- Island Secrets (40 อัน)", "L")
    UI.Label(t, "เควสปกติเก็บถึง 2800 -- อีก 200 ต้องทำ Secrets")
    UI.Label(t, "40 อัน อันละ +5 (Middle Town 4 + 12 เกาะ x3)")
    UI.Label(t, "โหมดนี้ไล่วาร์ปทุกเกาะ + โชว์วิธีทำรายอัน")
    UI.Label(t, "เสร็จแล้วไปต่อเอง (+5 = เสร็จ 1 อัน) หรือกดเองก็ได้")
    local secretTgl
    secretTgl = UI.Toggle(t, "เปิดเควสลับ (Island Secrets 40 อัน)", false, function(v)
        NX.setSecretTour(v)
    end)
    NX.secretToggleRef = secretTgl
    UI.Toggle(t, "อัตโนมัติเมื่อ +5 เลเวล (= เสร็จ 1 อัน)", CFG.SecretTourAutoNext, function(v)
        CFG.SecretTourAutoNext = v
    end)
    UI.Button(t, "ทำอันนี้เสร็จแล้ว -- ไปต่อ (Next)", function()
        NX.secretNext(true)
    end)
    UI.Button(t, "ข้ามอันนี้ไปก่อน (Skip)", function()
        NX.secretNext(false)
    end)
    UI.Button(t, "รีเซ็ตเควสลับ (เริ่มนับใหม่ทั้งหมด)", function()
        NX.secretReset()
    end)

    UI.Section(t, "สถานะเควสลับ (สด -- ทุก 1 วิ)", "R")
    local sc1 = UI.Label(t, "...")
    local sc2 = UI.Label(t, "...")
    local sc3 = UI.Label(t, "...")
    local sc4 = UI.Label(t, "...")
    local sc5 = UI.Label(t, "...")
    task.spawn(function()
        while not NX.dead do
            task.wait(1)
            local lv = getLevel()
            if lv > 2800 then
                local est = math.min(math.floor((lv - 2800) / 5), 40)
                sc1.Set(string.format("Lv %d / 3000 (Secret Levels: +%d)", lv, lv - 2800))
                sc2.Set(string.format("ประมาณเสร็จแล้ว: %d/40 อัน (คำนวณจากเลเวล)", est))
            else
                sc1.Set(string.format("Lv %d / 3000 (เหลืออีก %d เลเวลถึงแคป 2800)", lv, 2800 - lv))
                sc2.Set("ยังไม่ถึงแคป -- ฟาร์มเควสไปพร้อมกันได้ (auto-next ใช้หลัง 2800)")
            end
            local dn, sk, total = secretProgress()
            local cur = SECRET_QUESTS[SecretTour.idx]
            sc3.Set(string.format("ทัวร์: เสร็จ %d | ข้าม %d | เหลือ %d (อันที่ %d/40)",
                dn, sk, total - dn - sk, math.min(SecretTour.idx, total)))
            if CFG.SecretTour and cur then
                local tags = {}
                if cur[5] then table.insert(tags, "รออีเวนต์") end
                if cur[7] then table.insert(tags, "ต้องเปิด Aura") end
                if cur[6] then table.insert(tags, "บอส " .. cur[6]) end
                local tag = (#tags > 0) and (" [" .. table.concat(tags, ", ") .. "]") or ""
                sc4.Set("กำลังทำ: " .. cur[3] .. tag .. " @ " .. cur[2])
            elseif CFG.SecretTour then
                sc4.Set("สถานะ: ครบทุกอันในลิสต์แล้ว! (เป้าหมาย Lv 3000)")
            else
                sc4.Set("สถานะ: ปิดอยู่ (กด toggle ด้านบนซ้ายเพื่อเริ่ม)")
            end
            sc5.Set("โลก: Sea " .. (NX.currentSea or 1) .. " | Secrets ใช้ได้ Sea 1")
        end
    end)

    UI.Section(t, "Awakened Boss (บอสตื่น -- 10 ตัว ใน 40 อัน)", "R")
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
        "บอส Awakened 10 ตัว: Gorilla King / Chef / Yeti / Vice Admiral / Warden / " ..
        "Magma General / Fishman Lord / Sky Warlord / Lightning God / Cyborg -- " ..
        "เกิดราวๆ ทุกชั่วโมง (นาที 00:XX) พร้อมประกาศบนจอ ตัวถัดไปเช็คได้ที่ NPC Secret Masters (Middle Town)")

    UI.Section(t, "การตรวจสอบข้อมูล (Data Policy)", "R")
    UI.Label(t, "ชื่อเควส/เป้าหมาย: Verified (wiki 15 ต.ค. 2026)")
    UI.Label(t, "วิธีทำรายอัน: NeedsInGameTest (ทดสอบในเกม)")
    UI.Label(t, "อ้างอิง: bloxfruitswiki.org/wiki/island-secrets")
    UI.Label(t, "รางวัล +5/อัน (Verified) | 40 อัน = +200")

    UI.Section(t, "ไกด์รายเกาะ (ค้นหา + วาร์ป + วิธีทำ)", "L")
    local guideNames = {}
    for k in pairs(SECRET_GUIDE) do
        table.insert(guideNames, k)
    end
    table.sort(guideNames)
    local curIsland = guideNames[1]
    UI.Search(t, "เลือกเกาะ (พิมพ์ค้นหาได้)", guideNames, function(v)
        curIsland = v
    end)
    UI.Button(t, "วาร์ปไปเกาะที่เลือก", function()
        local p = ISLAND_POS[curIsland]
        if p then
            topos(CFrame.new(p + Vector3.new(0, 25, 0)))
            Notify("Teleport", curIsland .. " -- หาจุดทำ secret ตามไกด์ด้านล่าง")
        else
            Notify("Teleport", tostring(curIsland) .. ": ยังไม่มีพิกัด -- บิน/เดินเรือไปเอง")
        end
    end)
    local guideLbl = UI.Paragraph(t, "เลือกเกาะด้านบน แล้วกด [แสดงวิธีทำ Secrets ของเกาะนี้] เพื่อดูขั้นตอนครบทุกอัน")
    UI.Button(t, "แสดงวิธีทำ Secrets ของเกาะนี้", function()
        guideLbl.Set(SECRET_GUIDE[curIsland] or "ไม่มีข้อมูลเกาะนี้")
    end)
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
    UI.Section(t, "Your Fruit", "R")
    local fl = UI.Label(t, "...")
    task.spawn(function()
        while not NX.dead do
            task.wait(2)
            fl.Set("Devil Fruit: " .. tostring(getFruit()))
        end
    end)
    UI.Section(t, "Buy Fighting Style (ซื้อสไตล์ต่อสู้)", "R")
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
    UI.Section(t, "Quick Teleports (บินปลอดภัย 75)")
    -- [v3.0] Sea Filter + Quick Warp รายเกาะ
    local refreshWarpList   -- forward-declare: ถูกเรียกก่อนประกาศจริง (กันจับ global nil)
    UI.Toggle(t, "Sea Filter (โชว์เฉพาะของโลกที่อยู่)", CFG.SeaFilter, function(v)
        CFG.SeaFilter = v
        if refreshWarpList then refreshWarpList() end
        Notify("Sea Filter", v and "เปิด -- แสดงเฉพาะของโลกปัจจุบัน (realtime)" or "ปิด -- แสดงทุกโลก", 5)
    end)
    local seaLbl = UI.Label(t, "...")
    local warpTargets = {}
    local selWarp = nil
    local warpDrop
    function refreshWarpList()
        warpTargets = {}
        local list = {}
        local cur = NX.currentSea or 1
        for _, q in ipairs(Quests) do
            if typeof(q[5]) == "Vector3" then
                local ok = (not CFG.SeaFilter) or questSea(q[1]) == cur
                if ok then
                    local disp = q[2] .. " Lv" .. q[1] .. " (Sea" .. questSea(q[1]) .. ")"
                    warpTargets[disp] = q[5]
                    table.insert(list, disp)
                end
            end
        end
        for nm2 in pairs(ISLAND_POS) do
            if (not CFG.SeaFilter) or cur == 1 then
                local disp = nm2 .. " (Secrets, Sea1)"
                warpTargets[disp] = ISLAND_POS[nm2]
                table.insert(list, disp)
            end
        end
        table.sort(list)
        pcall(function() warpDrop.Refresh(list) end)
        seaLbl.Set("โลกปัจจุบัน: Sea " .. cur .. " (" .. tostring(NX.currentSeaName or "?") .. ")")
    end
    warpDrop = UI.Search(t, "วาร์ปไปเกาะ/เควส (พิมพ์ค้นหา)", {}, function(v)
        selWarp = v
    end)
    refreshWarpList()
    -- [v3.0] เปลี่ยนโลก = รีเฟรชลิสต์วาร์ปตาม (หลังประกาศเสร็จแล้ว)
    table.insert(NX.seaListeners, function()
        if refreshWarpList then refreshWarpList() end
    end)
    UI.Button(t, "วาร์ปไปที่เลือก (บิน 75 กันวาร์ปกลับ)", function()
        local p = warpTargets[selWarp or ""]
        if p then
            toposSafe(CFrame.new(p + Vector3.new(0, 20, 0)))
            Notify("Teleport", tostring(selWarp) .. " -- บินปลอดภัย " .. CFG.TravelSpeed, 5)
        else
            Notify("Teleport", "เลือกเกาะก่อน (ค้นหาด้านบน)", 4)
        end
    end)
    UI.Button(t, "To Quest NPC (ของเลเวลนี้)", function()
        local lv = getLevel()
        local _, hrp = alive()
        local e = pickQuest(lv, hrp and hrp.Position or nil)
        if e and typeof(e[5]) == "Vector3" then
            toposSafe(CFrame.new(e[5]))
            Notify("Teleport", "Quest NPC: " .. e[2], 4)
        else
            Notify("Teleport", "No quest NPC data", 4)
        end
    end)
    UI.Button(t, "To Quest Mobs (จุดเกิดศัตรูเควส)", function()
        local lv = getLevel()
        local _, hrp = alive()
        local e = pickQuest(lv, hrp and hrp.Position or nil)
        if e and typeof(e[6]) == "Vector3" then
            toposSafe(CFrame.new(e[6]))
            Notify("Teleport", "Mobs: " .. e[4], 4)
        else
            Notify("Teleport", "No mob data", 4)
        end
    end)
    UI.Section(t, "Teleport To Enemy", "R")
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
    UI.Section(t, "Teleport To Player", "R")
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
            task.wait(12)
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
    UI.Section(t, "Fly (WASD + Space/Shift)", "R")
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
    UI.Section(t, "Misc", "R")
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

-- ================= PvP (v3.0) =================
do
    local t = UI.Tab("PvP")
    UI.Section(t, "สถานะ (Realtime)", "L")
    local pv1 = UI.Label(t, "...")
    local pv2 = UI.Label(t, "...")
    local pv3 = UI.Label(t, "...")
    UI.Label(t, "Sea 1 ปิด PvP (กติกาเกม) / Sea 2-3 เปิดได้ใน Settings")
    task.spawn(function()
        while not NX.dead do
            task.wait(1)
            local tm = LP.Team
            pv1.Set("Team: " .. (tm and tostring(tm) or "ไม่มีทีม"))
            local state, src = pvpState()
            pv2.Set("PvP State: " .. state)
            pv3.Set("ที่มา: " .. src)
        end
    end)
    UI.Section(t, "Silent Aim (ปืน/สกิล)", "R")
    UI.Toggle(t, "Silent Aim (เปิด/ปิด)", CFG.SilentAim, function(v)
        CFG.SilentAim = v
        if v then
            local ok = hookAim()
            if ok then
                Notify("Silent Aim", "เปิด -- hook Mouse.Hit ติดตั้งแล้ว (ปืนคมจัด)", 6)
            else
                Notify("Silent Aim", "executor ไม่รองรับ hookmetamethod -- ใช้ Face Target แทน", 7)
            end
        else
            Notify("Silent Aim", "ปิดแล้ว")
        end
    end)
    UI.Dropdown(t, "Silent Aim Mode", { "Cursor", "FOV", "Screen Center" }, CFG.AimMode, function(v)
        CFG.AimMode = v
    end)
    UI.Slider(t, "Aim Range (ระยะหาเป้า)", 100, 3000, CFG.AimRange, function(v)
        CFG.AimRange = v
    end)
    UI.Dropdown(t, "Target Part", { "Head", "HumanoidRootPart" }, CFG.AimPart, function(v)
        CFG.AimPart = v
    end)
    UI.Toggle(t, "Team Check (ไม่ยิงเพื่อนทีมเดียวกัน)", CFG.AimTeamCheck, function(v)
        CFG.AimTeamCheck = v
    end)
    UI.Toggle(t, "Face Target ตอนยิง (หันตัวเข้าเป้า)", CFG.FaceTarget, function(v)
        CFG.FaceTarget = v
    end)
    UI.Section(t, "FOV (วงกลมเล็ง)", "L")
    UI.Toggle(t, "FOV Circle (โชว์วงกลมบนจอ)", CFG.FOVCircle, function(v)
        CFG.FOVCircle = v
        if v and not NX.canDraw then
            Notify("FOV Circle", "executor นี้ไม่รองรับ Drawing API (แจ้งตามจริง)", 6)
        end
    end)
    UI.Slider(t, "FOV Size (ขนาดวงกลม)", 50, 800, CFG.FOVSize, function(v)
        CFG.FOVSize = v
    end)
    UI.Dropdown(t, "FOV Mode (จุดอ้างอิง)", { "Cursor", "Screen Center" }, CFG.FOVMode, function(v)
        CFG.FOVMode = v
    end)
    UI.Label(t, "Cursor = วงกลมตามเมาส์ | Center = กึ่งกลางจอ")
end

-- ================= CONFIG =================
do
    local t = UI.Tab("Config")
    UI.Section(t, "Theme (ธีม)", "L")
    UI.Label(t, "แต่งสี/ฟอนต์/พื้นหลังได้เอง: กดไอคอนธีมมุมหน้าต่าง (Designer)")
    UI.Label(t, "เปลี่ยนธีมแล้วเห็นผลทั้งหน้าต่างทันที (บันทึกอัตโนมัติของ Pepsi)")
    UI.Button(t, "ทาธีมอวกาศใหม่ (ดำ + ดวงดาว)", function()
        local n, okS, why = UI.applyCosmos()
        Notify("ธีมอวกาศ", string.format("ทาเข้ม %d จุด | ดาว: %s",
            tonumber(n) or 0, okS and "วางแล้ว 60 ดวง" or tostring(why)), 6)
    end)
    UI.Toggle(t, "Performance Mode (ลดงานพื้นหลัง)", CFG.PerfMode, function(v)
        CFG.PerfMode = v
        Notify("Perf Mode", v and "เปิด -- ESP/ลูปสแกนเบาลง" or "ปิด -- ตอบสนองไวขึ้น", 5)
    end)
    UI.Section(t, "Keybinds (คีย์ลัด)", "L")
    UI.Keybind(t, "Toggle UI", CFG.KeyUI, function(k)
        CFG.KeyUI = k
    end)
    UI.Keybind(t, "Toggle Auto Farm", CFG.KeyFarm, function(k)
        CFG.KeyFarm = k
    end)
    UI.Keybind(t, "Toggle Fly", CFG.KeyFly, function(k)
        CFG.KeyFly = k
    end)
    UI.Label(t, "ตั้งคีย์ในช่องนี้ -- ใช้งานทันทีทั้งระบบ (ค่าเริ่มต้น: RightControl / F / G)")
    UI.Section(t, "Save / Load (บันทึกการตั้งค่า)", "R")
    UI.Button(t, "Save Config", function() NX.saveConfig() end)
    UI.Button(t, "Load Config", function() NX.loadConfig() end)
    UI.Section(t, "Unload", "R")
    UI.Button(t, "Unload Melo Hub (ปิดสคริปต์ทั้งหมด)", function()
        NX.unload()
    end)
    UI.Section(t, "Self-Test (v3.0)", "R")
    UI.Button(t, "Run Self-Test (ทดสอบทั้งหมด)", function()
        if NX.selfTest then
            local rep, p, f = NX.selfTest()
            Notify("Self-Test", string.format("PASS %d / FAIL %d -- ดู console (F9)", p, f), 8)
        else
            Notify("Self-Test", "ยังไม่พร้อม (โหลดไม่ครบ)", 5)
        end
    end)
    UI.Section(t, "Credits", "L")
    UI.Label(t, "Melo Hub v3.0 | TJ EDITION -- made by TJ")
    UI.Label(t, "UI: Pepsi v0.32 | Free | No key | PC only")
    UI.Label(t, "Update 30 | Max Lv 3000 | เควสลับ 40 อันครบ Sea 1")
end

-- ================= UPDATE LOG (v3.0 -- ให้ลูกค้าดู) =================
do
    local t = UI.Tab("Update Log")
    UI.Section(t, "v3.0 -- 16 ต.ค. 2026 (Melo Hub)", "L")
    UI.Label(t, "[*] Fix บินไปทำเควส = 75 กันวาร์ปกลับที่เดิม")
    UI.Label(t, "[*] Fix ฟาร์มเวลยึกยักตรงเควส (ตัด tween ซ้ำ)")
    UI.Label(t, "[*] Fix Fixed Lag / FPS drop (ลดงานพื้นหลัง)")
    UI.Label(t, "[+] New Method Farm: เดินทางปลอดภัย + เควสนุ่ม")
    UI.Label(t, "[+] Double Quest Policy: เลือก 50% หรือ 100%")
    UI.Label(t, "    50% = Same Island | 100% = Cross-Island")
    UI.Label(t, "    50%: เวล 15 กลับไปทำ Lv10 ได้ (0.67 > 0.5)")
    UI.Label(t, "    แต่เวล 10 ไม่กลับไปทำ Lv5 (0.5 ไม่ผ่าน)")
    UI.Label(t, "    100%: เวล 10 กลับไปทำ Lv5 ได้ + สลับเกาะ")
    UI.Label(t, "    ตอนนี้แนะนำ 50% (ถ้ามี bypass tp ค่อยใช้ 100%)")
    UI.Label(t, "[+] Sea Filter: โชว์เฉพาะฟังก์ชันของโลกที่อยู่")
    UI.Label(t, "[+] แท็บ PvP: Team / Pvp State / Silent Aim")
    UI.Label(t, "[+] Silent Aim Mode + FOV + Aim Range (ปืนคมจัด)")
    UI.Label(t, "[+] ธีมอวกาศ: ดำ + ดวงดาว 60 ดวง (ไม่กิน FPS)")
    UI.Label(t, "[+] Auto Rejoin กลับเซิร์ฟเดิม (JobId)")
    UI.Label(t, "[+] ปุ่ม Self-Test + แท็บ Update Log นี้")
    UI.Label(t, "[*] Fix Double Quest โลก 3 ให้เนี้ยบขึ้น (การ์ดโหมดชนกัน)")
    UI.Label(t, "[*] เปลี่ยนชื่อ NOVA/NOVEL-X -> Melo Hub [Blox Fruits]")
    UI.Section(t, "v2.7 -- 15 ต.ค. 2026", "R")
    UI.Label(t, "[+] UI ใหม่: Pepsi's UI Library v0.32 + Designer")
    UI.Label(t, "[+] เควสลับ = Island Secrets 40 อันจริง (wiki)")
    UI.Label(t, "[+] เควส Lv 190 Prison ที่หายไป (36 เกาะ/83 เควส)")
    UI.Label(t, "[*] Fix บั๊ก 3 ตัวจาก runtime test 47 ข้อ")
    UI.Section(t, "v2.6 -- 15 ต.ค. 2026", "L")
    UI.Label(t, "[+] ทัวร์เควสหลัก (Island Tour) ทุกเกาะ 3 ทะเล")
    UI.Label(t, "[+] สถานะสดรายเกาะ + กระโดดเริ่มเกาะไหนก็ได้")
    UI.Section(t, "v2.5 / v2.5.1 -- 10 ต.ค. 2026", "R")
    UI.Label(t, "[+] Update 30: max Lv 3000 (2800 + secrets 200)")
    UI.Label(t, "[+] เควส 2200-2725 + ไกด์ Secrets 13 เกาะ")
    UI.Label(t, "[*] Fix TextXOverflow -> TextTruncate (error toast)")
    UI.Section(t, "v1.0 -- ต.ค. 2026 (กำเนิด)", "L")
    UI.Label(t, "เกิดจาก Novel เดิม (ประตูขายคีย์ ไม่มีฟีเจอร์)")
    UI.Label(t, "พัฒนาใหม่ทั้งระบบ: 60 เควสจาก hub จริง 2 แหล่ง")
    UI.Label(t, "ไม่มีคีย์ | PC only | made by TJ ทุกจุด")
    UI.Label(t, "-- ขอบคุณทุกคนที่อยู่กับเรามาตลอด -- made by TJ")
end

-- [v3.0] ธีมอวกาศ: ทาดำ + วางดาว (เรียกหลังสร้างทุกแท็บเสร็จ)
do
    local n, okS, why = UI.applyCosmos()
    print(string.format("[Melo Hub] ธีมอวกาศ: ทาพื้นเข้ม %d จุด | ดวงดาว: %s",
        tonumber(n) or 0, okS and "วางแล้ว (60 ดวง)" or ("ยังไม่วาง: " .. tostring(why))))
    task.delay(2, function()
        pcall(function() applySpaceTheme() end)
    end)
end

-- [v3.0] Self-Test: ทดสอบระบบทั้งหมดในเกมจริง -- รายงาน PASS/FAIL ตามจริง
NX.selfTest = function()
    local rep, pass, fail = {}, 0, 0
    local function T(name, ok, ev)
        ok = ok and true or false
        if ok then pass = pass + 1 else fail = fail + 1 end
        table.insert(rep, string.format("[%s] %s (%s)", ok and "PASS" or "FAIL", name, tostring(ev or "-")))
    end
    -- 1) Double Quest ratio (unit test 0.49 / 0.50 / 0.51 + ตัวอย่างจริง + guard)
    local r49 = dqRatioOK(49, 100)
    T("ratio 0.49 ไม่ผ่าน (>0.5)", r49 == false, tostring(r49))
    local r50 = dqRatioOK(50, 100)
    T("ratio 0.50 ไม่ผ่าน (= 0.5)", r50 == false, tostring(r50))
    local r51 = dqRatioOK(51, 100)
    T("ratio 0.51 ผ่าน", r51 == true, tostring(r51))
    local ex1 = dqRatioOK(10, 15)
    T("เวล 15 ทำเควส 10 (0.667) ผ่าน", ex1 == true, tostring(ex1))
    local ex2 = dqRatioOK(5, 10)
    T("เวล 10 ทำเควส 5 (0.5) ไม่ผ่าน", ex2 == false, tostring(ex2))
    local gz = dqRatioOK(10, 0)
    T("เลเวล 0: ข้ามกรอง (กันบล็อกลูป)", gz == true, tostring(gz))
    -- 2) ฐานข้อมูล
    T("Island Secrets = 40 อัน", #SECRET_QUESTS == 40, tostring(#SECRET_QUESTS))
    local mtCount = 0
    local missingIsland = {}
    for _, s in ipairs(SECRET_QUESTS) do
        if s[2] == "Middle Town" then mtCount = mtCount + 1 end
        if not ISLAND_POS[s[2]] then missingIsland[#missingIsland + 1] = s[2] end
    end
    T("Middle Town = 4 อัน (รวม The Finale)", mtCount == 4, tostring(mtCount))
    T("ทุก secret มีพิกัดเกาะ", #missingIsland == 0,
        #missingIsland == 0 and "ครบ" or table.concat(missingIsland, ","))
    T("ทัวร์เควสหลัก = 36 เกาะ", #TOUR_ISLANDS == 36, tostring(#TOUR_ISLANDS))
    local tourQ = 0
    for _, isl in ipairs(TOUR_ISLANDS) do tourQ = tourQ + #isl[3] end
    T("เควสทัวร์รวม = 83", tourQ == 83, tostring(tourQ))
    T("ตาราง Quests >= 83", #Quests >= 83, tostring(#Quests))
    local missing = 0
    for _, isl in ipairs(TOUR_ISLANDS) do
        for _, qlv in ipairs(isl[3]) do
            local found = false
            for _, q in ipairs(Quests) do
                if q[1] == qlv then found = true break end
            end
            if not found then missing = missing + 1 end
        end
    end
    T("เควสทัวร์แมพ Quests ครบ", missing == 0, "หล่น " .. tostring(missing))
    -- 3) Sea
    T("questSea: 625=1 / 700=2 / 1575=3",
        questSea(625) == 1 and questSea(700) == 2 and questSea(1575) == 3, "ok")
    local ds = detectSea()
    T("detectSea ตอบ 1-3", ds == 1 or ds == 2 or ds == 3, "Sea " .. tostring(ds))
    -- 4) ความสามารถ (แจ้งตามจริง -- ไม่มีอะไรปลอม)
    T("Drawing API (ESP/FOV Circle)", NX.canDraw == true, tostring(NX.canDraw))
    T("hookmetamethod พร้อม (Silent Aim เต็มรูป)",
        type(hookmetamethod) == "function", type(hookmetamethod))
    local ps = pvpState()
    T("PvP State ตอบข้อความได้", type(ps) == "string", tostring(ps))
    -- สรุป + พิมพ์รายงานเต็มที่ console
    print("===== MELO HUB SELF-TEST: " .. (pass + fail) .. " รายการ =====")
    print(table.concat(rep, "\n"))
    print(string.format("สรุป: PASS %d / FAIL %d", pass, fail))
    Notify("Self-Test", string.format("PASS %d / FAIL %d -- รายละเอียดที่ console (F9)", pass, fail), 8)
    NX.lastSelfTest = { pass = pass, fail = fail, at = os.time() }
    return rep, pass, fail
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
            elseif type(v) ~= "table" and CFG[k] ~= nil and k ~= "AutoFarm" and k ~= "Fly" and k ~= "TourMode" and k ~= "SecretTour" and k ~= "SilentAim" then
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
    pcall(function() UI.Destroy() end)
    getgenv().NX_LOADED = nil
    print("[Melo Hub] Unloaded. Thank you -- made by TJ")
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
        if not nv then Notify("Auto Farm", "OFF") end
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
                NX.statusText = string.format("Lv %d | FPS %d | %s",
                    getLevel(), fps, farmStatus or "Idle")
            end)
        end
    end)
end

-- ยินดีต้อนรับ
print("=================================================")
print("   Melo Hub [Blox Fruits] v3.0 -- loaded successfully")
print("   Blox Fruits UPDATE 30 | MAX LV 3000 | No Key | made by TJ")
print("   UI: Pepsi's UI Library | RightControl = ซ่อน/แสดง | Farm: F | Fly: G")
print("   เควสลับ (Island Secrets 40) = แท็บเควสลับ | ทัวร์เควสหลัก = แท็บ Quest")
print("   PvP / Silent Aim = แท็บ PvP | ประวัติพัฒนา = แท็บ Update Log")
print("=================================================")
Notify("Melo Hub v3.0", "Welcome! made by TJ -- (อดีตชื่อ NOVEL-X) | RightControl = ซ่อน/แสดง", 7)
Notify("เควสลับพร้อมแล้ว", "แท็บเควสลับ = Island Secrets 40 อัน (2800 -> 3000)", 10)
Notify("Quick Start", "F = ฟาร์ม | เควสลับ = 40 secrets | PvP = แท็บ PvP | ธีมอวกาศ ON", 10)

