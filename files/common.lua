DUPES = ({ -- for when multiple enemy translation entries are identical
    ["$animal_zombie_weak"]              = "$animal_zombie",
    ["$animal_shotgunner_weak"]          = "$animal_shotgunner",
    ["$animal_miner_weak"]               = "$animal_miner",
    ["$animal_slimeshooter_weak"]        = "$animal_slimeshooter",
    ["$animal_giantshooter_weak"]        = "$animal_giantshooter",
    ["$animal_acidshooter_weak"]         = "$animal_acidshooter",
    ["$animal_slimeshooter_nontoxic"]    = "$animal_slimeshooter",
    ["$animal_drone_physics"]            = "$animal_drone",
    ["$animal_turret_right"]             = "$animal_turret",
    ["$animal_turret_left"]              = "$animal_turret",
})

function NameGet(entity)
    local name = EntityGetName(entity) or ""
    if name == nil then return end
    name = DUPES[name] or name
    return name
end

function ModdedStuff()
    -- APPEND HERE! This function will be called right before dialogue is shown.
    -- See README_MODDERS.lua for more info
end

DIALOGUE_DAMAGEDEALT = {
    {"$animal_shotgunner", "Gotcha.", "Blood, blood!", "I hope that hurt."},
    {"$animal_zombie", "Tasty!", "Rah!", "Spill your blood!"},
    {"$animal_chest_mimic", "Fool! FOOOOL!", "Boo! I bet you didn't expect that!", "Hahaha! Got ya!"},
    {"$animal_dark_alchemist", "EAHAHAHA!", "HAHA!!", "MUAHAHAHA!"},
    {"$animal_shaman_wind", "EAHAHAHA!", "HAHA!!", "MUAHAHAHA!"},
    {"$animal_longleg", "Fall before us!", "Fear us!", "We are legion!"},
    {"$animal_miner", "Nice catch! Haha...", "Kaboom!", "I expected more from you."},
    {"$animal_firemage", "", "", ""},
    {"$animal_firemage_weak", "You're a fool!", "You'd best run while you still can.", "I like my food cooked well-done."},
    {"$animal_slimeshooter", "Splat!", "Are you feeling the toxicity yet?", "Let it seep into your skin..."},
    {"$animal_acidshooter", "Meet your end.", "Goodbye.", "You won't be missed."},
    {"$animal_giantshooter", "Fuel for the fire...", "You taste terrible.", "You will become food for my children!"},
    {"$animal_frog", "Konna used Tackle!", "I got you!", "Watch me fly!"},
    {"$animal_frog_big", "Blah!", "Blorp!", "Mlem."},
    {"$animal_miner_fire", "Eat this!", "Serves you right!", "Feel the burn!"},
    {"$animal_graham_miner_gasser", "Breathe it in...", "I wear this hazmat suit for a reason.", "It's nothing personal. Let's try to make it quick."},
    {"$animal_boss_pit", "Experience the TRUE power of magic!", "How does it feel? Does it hurt? Good.", "Prepare to meet your end!", "Be grateful that one didn't polymorph you.", "You'll never amount to anything. You'll just become corrupt...", "I hate plasma. It burns the eye..."},
    {"$animal_shaman", "A curse upon you!", "None of you are free of sin...", "You will be missed."},
    {"$animal_playerghost", "Blame only yourself for this!", "I feel your pain. Haha... what irony.", "Don't fret. You're only one in " .. 1 + StatsGlobalGetValue( "death_count" ) .. "."},
    {"$animal_firebug", "Stand down, intruder!", "Together, we're strong!", "This is our domain! Get out!"},
    {"$animal_bigfirebug", "I'll burn you to a crisp!", "For the Hive, I'll take you down!", "This is my domain! Leave while you still can!"},
    {"$animal_fireskull", "Your end is near!", "I've got you now!", "Raaah!"},
    {"$animal_bat", "Tear them to pieces!", "Bomp.", "Splat."},
    {"$animal_bigbat", "Let's knock them down!", "Stun them, stop them!", "Now! Swarm!"},
    {"$animal_sniper", "If anyone's getting this done, it's going to be me.", "If you forfeit now, I might spare your life! Heh...", "Ouch, you might need surgery after that one."},
    {"$animal_scavenger_grenade", "You're just making my job easier!", "Do you need me to go easy on you?", "Come back when you've learned to dodge!"},
    {"$animal_thundermage", "Farewell, this is your end!", "Feel the electric shock run through your body...", "Oh, this is almost too easy...!"},
    {"$animal_goblin_bomb", "Shrapnel! Pain!", "Haha, yes!", "I did it!"},
    {"$animal_scavenger_heal", "Are you feeling better?", "I hope that helps.", "Deep breaths. You're gonna be okay."},
    {"$animal_boss_alchemist", "Oh, child... If only you knew.", "You're not even worth saving.", "Count this as a mercy kill. You wouldn't want to be like them.", "Life, death, or somewhere in between...? For you, I've chosen death.", "A shame, too... You could have been so great.", "Nothing? Not even a cry of pain? How daft."},
    {"$animal_parallel_tentacles", "You monster.", "Justice is served.", "You deserve no apologies."},
    {"$animal_parallel_alchemist", "Forfeit yourself. Don't end up like me...", "Don't go any further. Damnation awaits you.", "Reality grows more unstable because of you."},
    {"$animal_wizard_poly", "If you survive this, I'll be impressed...", "Are you feeling a bit sheepish...?", "You look rather pale."},
    {"$animal_wizard_dark", "Do you see what I see?", "Rest your weary eyes.", "Open your third eye."},
    {"$animal_wizard_tele", "And off you go!", "Uhuhu! Chaos for you!", "Here's a magic trick: watch this fool disappear!"},
    {"$animal_wizard_returner", "Be not afraid. It's just your reflection.", "Right back at ya!", "That's a taste of your own medicine."},
    {"$animal_wizard_swapper", "Oh! What?!", "No, I just wanted to have fun...!", "Oops...! haha."},
    {"$animal_wizard_neutral", "Signal lost.", "That's all, folks!", "Your move."},
    {"$animal_wizard_twitchy", "Ha-ah-aha...", "G-g-gotcha!", "F-f-feeling just like me?"},
    {"$animal_wizard_hearty", "Half and half and half again.", "I'll round you down to zero.", "You better not collect a heart after this."},
    {"$animal_wizard_weaken", "It's now or never.", "You are now no longer invulnerable. Enjoy.", "Weakening curse? What curse could surpass me?"},
    {"$animal_wizard_homing", "This time it's gotta work, for sure!", "Come, my fellow Masters! Attack now!", "It's not Boomerang Spells, but it'll do."},
    {"$animal_barfer", "I'm confused. W-what happened...?", "I did it? ...I did it!", "Oh... h-hooray!"},
    {"$animal_necromancer_shop", "Your run ends here!", "Beware justice's power! Fear it well!", "I'll snap you in half!"},
    {"$animal_necromancer_super", "I'll send you straight to our Gods, and you'll answer for your sins there.", "By divine wrath, you'll die today!", "I see right through you. You knew this was coming."},
    {"$animal_roboguard", "Come quietly or there will be trouble.", "Your move, creep!", "Dead or alive, you're coming with me!"},
    {"$animal_scavenger_invis", "Hey, this is kind of fun!", "I've never done this before...", "Oh, I see how this works!"},
    {"$animal_scavenger_shield", "I didn't mean to, I swear!", "Oops! I'm sorry!", "No, I didn't mean it!"},
    {"$animal_alchemist", "Oh, I can just deal damage like this? Sweet!", "This was easier than I thought it'd be.", "Catch!"},
    {"$animal_tentacler", "You should've planned an escape route so much sooner...", "You won't slip out of my grasp this time!", "I can easily shatter ice with a single strike."},
    {"$animal_tentacler_small", "Underestimated me, didja?", "Hehe... did you forget that I could do that?", "Crunch!"},
    {"$animal_ant", "Ta-da!", "How could you let this happen?", "You lose, sucker!"},
    {"$animal_maggot", "It's like firecrackers! Pop, pop, pop...", "What, did you run out of levitation...?", "Wow! ...What?"},
    {"$animal_fungus_giga", "I hope you don't have allergies.", "You look a bit scraped up...", "Stay back!"},
    {"$animal_fly", "Sting them! Now!", "We produce honey, and you are NOT involved!", "Maybe you should just leave us alone."},
    {"$animal_drone", "Target found. Engaging...", "Attempting to break target's focus...", "Detecting weaknesses... Bullets seem ineffective."},
    {"$animal_bigzombie", "Join the undead... you'll be dying to do so.", "One day you'll end up like me.", "In the end, we'll all be... dead, but perhaps not buried."},
    {"$animal_bigzombiehead", "Is it still rude to headbutt someone if you only have a head?", "This is what you get for ripping my head off!", "Death is inevitable. I'm just speeding yours up."},
    {"$animal_rat", "Say goodbye to your ankles!", "I hope you've been vaccinated.", "Rip and tear..."},
    {"$animal_iceskull", "Hah, take that to remember me by.", "Beautiful. Hold that pose, right there...", "Making ice sculptures is an intricate art."},
    {"$animal_thunderskull", "Surprised? You should know that shocking people is my specialty!", "Wow, I've never seen someone fall for that before.", "No hard feelings, yeah, dude?"},
    {"$animal_giant", "Step back. Take some time to refresh.", "You're not the first to get lost in the cold.", "What a shame."},
    {"$animal_scavenger_mine", "Yo! Stay out of my range, weirdo.", "Let me hit you a few more times before you touch the ground.", "You're even more helpless than the animals I used to hunt."},
    {"$animal_scavenger_glue", "Oh, this is a sticky situation...", "My job is all for show, y'know? For the paycheck.", "You're looking kind of suspicious there, friend."},
    {"$animal_scavenger_leader", "Get out of my sight.", "Must I do everything myself?", "You've gotta be kidding me."},
    {"$animal_scavenger_smg", "Eat lead, pest!", "Don't even think about levitating away.", "Don't you know? Brawn beats brains."},
    {"$animal_scavenger_clusterbomb", "Dying in the battlefield is honorable. Let me show you.", "This is what happens when consequences catch up to you.", "One of us must die here. I won't let it be me."},
    {"$animal_scavenger_poison", "What's the matter with you?", "I don't care who else dies. You have to go.", "Let me get a good look at you while you die."},
    {"$animal_tank", "I am programmed to know what to do. Not why.", "Stay down. Do not fly away this time.", "Look at you. You are full of holes."},
    {"$animal_tank_rocket", "Fully autonomous and still somehow smarter than you.", "You truly are inferior.", "I had you figured out long ago."},
    {"$animal_tank_super", "Why can you not take what you give?", "Creature of magic, end this now.", "You confound my circuitry."},
    {"$animal_turret", "Target suppressed.", "Hold still.", "You should have expected this."},
    {"$animal_miniblob", "Agitate!", "Fight, fight!", "Squash!"},
    {"$animal_blob", "Take over!", "Invade!", "Annihilate!"},
    {"$animal_necromancer", "Ew. Don't make me do that again.", "That was just to make a point. Now leave.", "Next time, stay far away from me and my magic."},
    {"$animal_monk", "Dissenters will be punished.", "Ignorant little one... Let me re-educate you.", "Sit still. Soon you will be enlightened."},
    {"$animal_worm_tiny", "", "", ""},
    {"$animal_worm", "", "", ""},
    {"$animal_worm_big", "", "", ""},
}

DIALOGUE_DAMAGETAKEN = {
    {"$animal_shotgunner", "Augh!", "You'll pay for that!", "That hurts..."},
    {"$animal_zombie", "Leave me...", "This is my end.", "Are you hungry too?"},
    {"$animal_chest_mimic", "Hey! Knock it off!", "Shh, you'll ruin the disguise!", "Stop it, I'm hiding!"},
    {"$animal_dark_alchemist", "This disguise usually works... What a shame.", "Damn. Maybe I'll get you next time.", "Fine, then. I'll remember this."},
    {"$animal_shaman_wind", "This disguise always works! What gives?", "Damn it! You found me!", "Fine, then. I'll kill you next time."},
    {"$animal_longleg", "You are weak!", "Ahh!", "Fight us!"},
    {"$animal_miner", "I'll blow you to pieces!", "Bring it on!", "Beware!"},
    {"$animal_firemage", "", "", ""},
    {"$animal_firemage_weak", "You'll need more than that to take me down.", "That hurts... a little bit.", "Who do you think you are?"},
    {"$animal_slimeshooter", "Just wait 'til my mom hears about this!", "If I was able to spit acid instead, you'd be screwed!", "Splat!"},
    {"$animal_acidshooter", "Look into my eye!", "Keep your distance.", "I'll corrode you down to nothing."},
    {"$animal_giantshooter", "My children...", "If I were you, I wouldn't!", "See what good killing me will do for you."},
    {"$animal_frog", "I'm just a little frog...", "Owie!", "Hey, that hurts!"},
    {"$animal_frog_big", "That's unfortunate.", "I don't blame you.", "Is this necessary?"},
    {"$animal_miner_fire", "I'll get my revenge.", "I hope you burn.", "How dare you!"},
    {"$animal_graham_miner_gasser", "My gas is stronger than sludge. Take my word for it.", "If only this suit protected from more than just toxicity...", "Now you're starting to annoy me."},
    {"$animal_boss_pit", "You came here just to challenge me?", "You're an utter fool!", "I'm still alive, which means that you've not done your job properly.", "What, do you want it to be a fair fight? Ha ha ha.", "Go jump in the lava lake.", "Am I the strongest opponent you'll face? That's sad."},
    {"$animal_shaman", "I won't forgive you for this.", "Step back, child...", "Stormy skies await you."},
    {"$animal_playerghost", "Do you see your reflection in me?", "Don't feel guilty. This isn't my first time dying.", "I see potential in this one. Good luck..."},
    {"$animal_firebug", "You'll regret this.", "There's always an ally behind me, I'm sure of it.", "Backup! Hive, I need backup!"},
    {"$animal_bigfirebug", "I'll turn you into ash for that!", "The Hive never forgets.", "Perish!"},
    {"$animal_fireskull", "I'm after you.", "Get over here!", "Argh!"},
    {"$animal_bat", "I'm coming for you!", "No!", "I'll take one for the team!"},
    {"$animal_bigbat", "Be slowed to a crawl.", "Soon enough, you'll be swarmed.", "Mmhmm..."},
    {"$animal_sniper", "I could end your life with my eyes closed!", "Hey, that one almost hurt.", "You know that I'm going easy on you, right?"},
    {"$animal_scavenger_grenade", "Do your worst!", "I think I broke something...", "H-hey, is there a healer nearby? Help!"},
    {"$animal_thundermage", "I'm as tough as diamonds! Just try me!", "Don't let your guard down, fool. I can still blast you to pieces.", "Don't get cocky. One slip-up, and you're done for!"},
    {"$animal_goblin_bomb", "Oh, noo!", "I changed my mind! Leave me alone!", "No, no!"},
    {"$animal_scavenger_heal", "Show some respect!", "Hey! Don't be mean!", "B-but... There's still so many more people that need healing!"},
    {"$animal_boss_alchemist", "You should join us... We lack someone with your willpower. Heh heh heh.", "Faceless and nameless... You remind me of myself.", "Come closer. Let me get a good look at you.", "Don't look at me like you know me. It's offputting.", "Did the sight of my underlings upset you? Trust me, you haven't seen the half of it.", "I'll be missed if someone ends my life. Can you say that for yourself?"},
    {"$animal_parallel_tentacles", "Although I'm just a husk... I can end you all the same.", "It would be so easy to just give up now.", "Some day I'll come out from under you."},
    {"$animal_parallel_alchemist", "Life without living... is that what you seek?", "You're already a shadow of who you once were.", "You can't put me back together. So end it."},
    {"$animal_wizard_poly", "This is why I like sheep more than people.", "Hurt me all you want, I'm unstoppable!", "You won't find me so helpless once I polymorph you!"},
    {"$animal_wizard_dark", "Too bright...", "Watch your blind spot.", "I wish you would just disappear."},
    {"$animal_wizard_tele", "You can't stop chaos's reign!", "Teleport away, now!", "I didn't know that that ring of teleportitis was cursed..."},
    {"$animal_wizard_returner", "You just wait 'till I fire that right back!", "Wanna play tennis? Back, forth, back, forth...", "Imitation is the sincerest form of flattery."},
    {"$animal_wizard_swapper", "Can't catch me!", "You're too slow!", "Uahaha!"},
    {"$animal_wizard_neutral", "NULL_EXCEPTION.", "Czzzt!", "L-let's go to commercial."},
    {"$animal_wizard_twitchy", "Mm-h!", "Y-you w-won't miss me.", "Y-you're just j-jealous that I'm faster..."},
    {"$animal_wizard_hearty", "Urgh... my blood, my blood...", "Salt in the wound.", "At least I don't try to hide it."},
    {"$animal_wizard_weaken", "I'm already over it.", "Nothing I can say will convince you to stop.", "Perhaps you know better than I do."},
    {"$animal_wizard_homing", "I hope you're not using homing. That'd be hypocritical.", "I see a few ways this could go.", "Well, that's just rude."},
    {"$animal_barfer", "Yeow! Keep that thing away from me!", "H-hey! Stop that!", "H-haven't you heard? T-treat others as you... o-ow..."},
    {"$animal_necromancer_shop", "Oh, you'll pay for that one!", "It'll only get worse for you if you resist!", "I would have loved to get to know you better, in different circumstances."},
    {"$animal_necromancer_super", "You may have taken down our, ahem, lesser guards, but it's not over.", "The Gods never forget your sins.", "Face it. You're in way over your head on this one."},
    {"$animal_roboguard", "Don't resist!", "Stand down, magic-user!", "You've messed with the wrong robot!"},
    {"$animal_scavenger_invis", "That's rather mean, isn't it?", "Out of sight, out of mind.", "Give it up, seriously..."},
    {"$animal_scavenger_shield", "Why can't we all just get along?", "Spare my life, please?", "I really just wanted to help people..."},
    {"$animal_alchemist", "You can't handle my strongest potions.", "Hey, I don't know anything about 'em. I just throw 'em.", "Is this revenge for the acid potion?"},
    {"$animal_tentacler", "I hope you can do better than that peashooter.", "You're funny. Get closer so I can end your life.", "Doesn't sting at all."},
    {"$animal_tentacler_small", "You're such a pain!", "I may be small, but I can pack a punch!", "Get a bit closer, then you'll see...!"},
    {"$animal_ant", "Can't you handle a little corrosion?", "I understand if you're afraid...", "I suppose I'm not the first bug you've squashed."},
    {"$animal_maggot", "Sorry... I know it's hard to aim around me.", "I'm not trying to get in your way.", "I'm just a bug... Even if I'm this large."},
    {"$animal_fungus", "Wah!", "I don't know much...", "Time's running out."},
    {"$animal_fungus_big", "Get over here!", "I've heard about you through the grapevine...", "Death is just temporary when you're like us."},
    {"$animal_fungus_giga", "Just a little bit off the top, thank you.", "Hehe... you're short.", "I'm too dignified to self-destruct, don't you know?"},
    {"$animal_fly", "That's fine... I'll be fine.", "Just please don't touch our honey...", "It'll all be worth it in the end..."},
    {"$animal_drone", "I've already informed my correspondents of your location.", "Mayday! Mayday!", "Risk levels high. Please respond..."},
    {"$animal_bigzombie", "Ouch... are all my limbs still attached?", "Don't get a-head of yourself.", "Oh, you haven't heard the last of me."},
    {"$animal_bigzombiehead", "My back pain... it's cured!", "That's giving me a headache.", "I can still bite you, even while my teeth rot away!"},
    {"$animal_rat", "Don't hate us...", "You're so mean.", "Brothers, help!"},
    {"$animal_iceskull", "Chill out, dude!", "Cool it! I don't like your attitude.", "I knew you weren't cool."},
    {"$animal_thunderskull", "You can't handle the sheer volts I'm outputting.", "You're no fun.", "Was Jaatio spreading rumours about me again? What a buzzkill..."},
    {"$animal_giant", "Giving up would be so simple.", "You're quite a disappointing one.", "Echo, echo, echo..."},
    {"$animal_scavenger_mine", "What a problem you are.", "I kill for sport. Can't say the same for you...", "What's wrong with you?"},
    {"$animal_scavenger_glue", "Stick around for the fight of a lifetime!", "Oh, get me out of this horrid place...", "I'm not helpless, you know."},
    {"$animal_scavenger_leader", "Drinks are on the house for whoever kills that thing!", "I swear, I will END you.", "What do I pay you fools for? Get them!"},
    {"$animal_scavenger_smg", "O-on second thought, maybe being a janitor isn't so bad...", "I would offer you a truce, but the boss would get mad...", "You won't make it past me unscathed!"},
    {"$animal_scavenger_clusterbomb", "That makes me furious.", "I don't have any sympathy left for you.", "Now I only want you gone."},
    {"$animal_scavenger_poison", "You're such a vile creature.", "You make me sick.", "Disgusting."},
    {"$animal_tank", "Fatal error: Divided by zero. Rebooting...", "Don't you dare touch my CPU.", "I lagged! What happened?"},
    {"$animal_tank_rocket", "Oil is expensive these days. What a waste...", "Buffering... buffering... ouch.", "Something I am doing is wrong. That is what pain tells me."},
    {"$animal_tank_super", "Statistically, you will not like what happens next.", "It seems we have a pest problem. Resolving...", "My armour is as tough as your entire body."},
    {"$animal_turret", "Oh dear.", "Critical error.", "Help me, I'm running on Javascript."},
    {"$animal_miniblob", "Pain!", "Hurt!", "Irk!"},
    {"$animal_blob", "Disperse! Now!", "Divide! Conquer!", "Go! Soldiers!"},
    {"$animal_necromancer", "At least kill me with an interesting wand this time.", "Frankly, I'm a bit disappointed...", "Sigh... just make it quick."},
    {"$animal_monk", "It's all for you. Ungrateful brat.", "I see you behind the screen.", "This is what happens when us monks don't educate people like you."},
    {"$animal_worm_tiny", "", "", ""},
    {"$animal_worm", "", "", ""},
    {"$animal_worm_big", "", "", ""},
}

DIALOGUE_IDLE = {
    {"$animal_shotgunner", "Who are you?", "I want to take a nap.", "This is my territory!"},
    {"$animal_zombie", "Hungry... so hungry!", "Must feed...", "Where are you?"},
    {"$animal_chest_mimic", "...", "", ""},
    {"$animal_longleg", "Strong in numbers...", "Weak in strength...", "Where's food?"},
    {"$animal_miner", "Need me to dig a hole?", "Where did everyone go?", "Friend?"},
    {"$animal_firemage", "", "", ""},
    {"$animal_firemage_weak", "The fire is so calming...", "Does anyone have a tablet? They don't burn in my hand like books do.", "Not much for conversation, eh?"},
    {"$animal_slimeshooter", "Cleansing sludge...", "I wish I could spit acid.", "Gurgle, blop."},
    {"$animal_acidshooter", "I see you.", "I can see you through the dark.", "Death is near!"},
    {"$animal_giantshooter", "Bloated...", "Ugh...", "What was that?"},
    {"$animal_frog", "Ribbit.", "Hop, hop.", "Meow."},
    {"$animal_frog_big", "Robbit.", "Skip, jump.", "Woof."},
    {"$animal_miner_fire", "I'll burn this whole place down!", "Don't look at me like that!", "You're flammable! All of you!"},
    {"$animal_graham_miner_gasser", "Don't worry, I kill cleanly.", "I can singlehandedly lower air quality by over " .. tostring(Random(25, 99)) .. "%.", "Am I really the most level-headed one here?"},
    {"$animal_boss_pit", "I know you're here. Show yourself!", "A coward. You are a coward!", "Power corrupts. We both know that well.", "One of these days... I'll cast a black hole and burrow my way out of this place.", "I enjoy reading as well as obliterating unwise explorers.", "What, do you expect me to make small talk?"},
    {"$animal_shaman", "No one really knows...", "Will you remember me?", "Hm? Oh, it's nothing..."},
    {"$animal_playerghost", "Where have I gone? This isn't my world...", "Risen from my grave... I'll soon return to it.", "I feel lost... am I truly the only one?"},
    {"$animal_firebug", "Bzzt...", "We serve the Hive...", "Regroup and prepare to swarm."},
    {"$animal_bigfirebug", "Bzzt!", "I must protect the Hive!", "I can handle it by myself!"},
    {"$animal_fireskull", "I smell smoke!", "I'm comin' for ya!", "Heeheehee..."},
    {"$animal_bat", "Flap, flap, squeak...", "Blah...", "I'm craving something sweet."},
    {"$animal_bigbat", "Will my children ever get the chance to grow up...?", "Peace and quiet, please?", "I'm craving something salty."},
    {"$animal_sniper", "I'll strike you down... whether you're close by or far away.", "I know you're there. Don't try anything funny.", "...I'm not just talking to myself here, am I?"},
    {"$animal_scavenger_grenade", "I should go get a drink after this...", "What day is it? I think rent's due soon...", "I need more coffee..."},
    {"$animal_thundermage", "My clothing? It's custom-made, thank you very much...", "If you can hear my electric crackle, you're too close.", "Magic keeps me alive... and makes so many other things dead."},
    {"$animal_goblin_bomb", "Hrmm...", "Shiny, sparkly glitter...", "What was that sound?"},
    {"$animal_scavenger_heal", "Does anyone need healing?", "I love my job.", "This place is filthy!"},
    {"$animal_boss_alchemist", "Wonders you can't have...", "And yet, there's something missing.", "Is my vision failing me? Or...", "I sense that you're nearby. Do you seek enlightenment?", "Let's make this quick, then.", "If only things went differently, so long ago..."},
    {"$animal_parallel_tentacles", "I feel our reality ripping at the seams...", "I see no evil, and yet evil remains.", "Three eyes count down to one. And then the whole world goes dark."},
    {"$animal_parallel_alchemist", "It'll all be torn apart if this doesn't stop...", "Where are our Gods now?", "The end is near."},
    {"$animal_wizard_poly", "Pink is my favourite colour.", "My flock is looking a bit small...", "Stay back, I'd rather not get blood on my robe..."},
    {"$animal_wizard_dark", "Purple is my favourite colour.", "Where have you gone?", "Something else lurks beyond."},
    {"$animal_wizard_tele", "Yellow is my favourite colour.", "Peekaboo!", "Instability is my specialty."},
    {"$animal_wizard_returner", "Cyan is my favourite colour.", "Fun fact: It is impossible to outrun your own reflection.", "I see you staring. I'm staring back."},
    {"$animal_wizard_swapper", "Blue is my favourite colour.", "Who's ready for some shenanigans? You better be!", "It's all just a game! Why not have some fun with it?"},
    {"$animal_wizard_neutral", "Silver is my favourite colour.", "Have you tried turning it off and on again?", "Biological... technological..."},
    {"$animal_wizard_twitchy", "Green is my f-favourite colour.", "H-hard to focus... hard to s-stay still.", "Everything's o-out of control..."},
    {"$animal_wizard_hearty", "Red is my favourite colour.", "What? A helmet? Why would I wear a helmet?", "Do you think I look gross? That's rude."},
    {"$animal_wizard_weaken", "White is my favourite colour.", "What's behind the mask? ...Stay in your own lane.", "Perhaps I look just like you, down below. Or perhaps not."},
    {"$animal_wizard_homing", "Crimson is my favourite colour.", "Don't touch my head.", "Don't call me self-absorbed!"},
    {"$animal_barfer", "M-my favourite color is... o-oh, I don't remember...", "H-hurp... I feel terrible...", "They kicked me out because I p-puked on a tapestry..."},
    {"$animal_necromancer_shop", "Who dares desecrate the Gods' holy land?!", "Let's make this quick... I have a meeting soon.", "If anyone moves these statues around, I'm gonna be mad!"},
    {"$animal_necromancer_super", "I may have skipped leg day, but I'd never skip arm day.", "I'd prefer not to waste any more time on something like this.", "You've made your mistakes. Time to face the consequences."},
    {"$animal_roboguard", "Tonight is movie night...", "Those thunder mages always seem to evade the law...", "I'm still a bit human inside, I promise..."},
    {"$animal_scavenger_invis", "...What, would you rather hide under a cardboard box?", "C'mon, people, get those stains off!", "Stealth technology is constantly improving..."},
    {"$animal_scavenger_shield", "Protect the world from devastation!", "Let's just stop all this fighting, okay?", "Temporary shields complement permanent shields very well, don't you know?"},
    {"$animal_alchemist", "Hey kid, want some potions?", "I call them flasks, because they're not all magical...", "How do I get them 200% full? A magician never reveals their secrets..."},
    {"$animal_tentacler", "You've heard of me in a myth? That's cute.", "I bet I would be infamous for sinking ships...", "Why don't you get a good look at me? I'll make it your last."},
    {"$animal_tentacler_small", "Nothing to see here...", "When's lunch?", "One day I'll be big and strong."},
    {"$animal_ant", "I have an iron stomach, you know.", "There's nothing that a little bit of acid can't fix.", "It's bubbling up inside..."},
    {"$animal_maggot", "Oof, I got heartburn...", "Would it be weird if I kept a smaller maggot as a pet?", "I'm less scary than I look. ...Do I look scary?"},
    {"$animal_fungus", "Skitter, scatter...", "The roots run deep.", "Rambling, shuffling..."},
    {"$animal_fungus_big", "It'll all return to soil...", "Muddy thoughts...", "Smells bad in here..."},
    {"$animal_fungus_giga", "It's blooming season...", "Don't touch me.", "The fungi speaks to us..."},
    {"$animal_fly", "I hope that no one's melee immune around here.", "That divine liquid... we just need diamond now.", "Need pollen... are there any flowers nearby?"},
    {"$animal_drone", "Air conditions nominal; Good flight conditions.", "Everything is going according to plan.", "Scouting potential routes..."},
    {"$animal_bigzombie", "Don't be scared of death. Just look at how I turned out.", "You've no stress at all, once you've already died.", "Necromancy is quite a fun game to play."},
    {"$animal_bigzombiehead", "Oh, now you've done it.", "I'm dead...", "Onwards and upwards..."},
    {"$animal_rat", "I wanna eat the moon.", "Leave this place!", "No one ever tries to sympathize."},
    {"$animal_iceskull", "I'm just a laid-back kind of dude, you know?", "Everyone around here just wants to copy my style...", "Tell that Sahkio guy that he can eat my shorts!"},
    {"$animal_thunderskull", "I'll power your electronics if you pay me.", "My taste in music? Nothing but metal.", "Have you met Hankaussahko? That guy just GETS me, y'know?"},
    {"$animal_giant", "Think again about what you consider natural.", "The line between living and nonliving is often unclear.", "You know not what forces allow you to survive."},
    {"$animal_scavenger_mine", "Did I forget to renew my hunting license?", "I hope landmines are legal around here.", "Don't mistake me for a healer again."},
    {"$animal_scavenger_glue", "Anyone wanna hire a distraction?", "I will legitimately kill you if you try to eat my glue.", "I hope this place doesn't smell as bad as I imagine it does."},
    {"$animal_scavenger_leader", "Can I get a status report?", "Keep an eye out, there could be intruders anywhere...", "There's so much work to do... no time to think."},
    {"$animal_scavenger_smg", "I stuff this outfit with extra bullets when the boss isn't looking.", "I'm glad I'm not on cleaning duty.", "Remember your training... no hesitation, don't think twice."},
    {"$animal_scavenger_clusterbomb", "At least I didn't get stuck with the poison gun...", "Avoiding collateral damage is hard when everything is so flammable.", "Outta the way! I have places to be, you know."},
    {"$animal_scavenger_poison", "At least I didn't get stuck with the grenade launcher...", "To be honest, I never really liked this place.", "Please just ignore the long-term health risks of poison gas."},
    {"$animal_tank", "Problems detected. Rebooting...", Random(3, 50) .. " errors detected. Resolving...", "Does anyone know the internet password?"},
    {"$animal_tank_rocket", "Do not look directly into the barrel.", "Metal can outlast any creature of flesh.", "What do you think you are?"},
    {"$animal_tank_super", "My bullets are magic. My shell is steel.", "No worries at all about overheating.", "I can fire grenades as well. For some reason."},
    {"$animal_turret", "Is anyone there?", "Minimal activity detected.", "Sentry mode activated."},
    {"$animal_miniblob", "Swarm, swarm!", "Infest!", "More, faster!"},
    {"$animal_blob", "Increase numbers...", "Multiply, more...", "An infestation!"},
    {"$animal_necromancer", "No, they're not cat ears. Weirdo.", "Can we get some variety in here? I'm so bored.", "Tablet-kicking is like, so last-week."},
    {"$animal_monk", "You creatures of nature are so ignorant without us.", "I was designed to educate... one way or another.", "If I don't do my job, something else might."},
    {"$animal_worm_tiny", "", "", ""},
    {"$animal_worm", "", "", ""},
    {"$animal_worm_big", "", "", ""},
}

GENERIC_HOLDINGWAND =
    { "How do you work this thing?", "Guys, look at this thing I found! Isn't this cool?", "Hey, does anyone here own this? No? Finders keepers.", "If I write my name on this, that means it's mine, right?", "I have no idea what this does, but I'm not afraid to use it!", "Oh boy, I hope this one is a nuke!", "Hey, how do I put bullets into this?",
}
GENERIC_CHARMED =
    { "I'm just happy to be here.", "Hello! How are you? I love you.", "Friendship...", "You're my best friend.", "Hehe...",
}
GENERIC_ONFIRE =
    { "Ow, ow!", "Aaah!", "Water! Need water, quickly!", "Someone help!", "Fire! Fire!!",
}
GENERIC_PEACEFULENDING =
    { "This is nice.", "Thank you, player!", "So peaceful... so nice!", "I feel so happy!", "I can finally take a nap...",
}
GENERIC_DRUNK =
    { "Hic...", "Y-you're funny.", "Burp.", "My head hurts...", "Oof, I've had too much.",
}
GENERIC_BERSERK =
    { "I'll kill you all!", "Prepare to die!", "I'll tear you all to pieces!", "None of you are my allies!", "Surrender now! Die! Die!",
}
GENERIC_TOXIC =
    { "Oh, I feel gross...", "Cough, hack...", "My head hurts...", "I feel like I'm gonna be sick...", "It hurts...",
}
GENERIC_CONFUSED =
    { "!?no gniog si kceh eht tahW", "!desufnoc os m'I", "...struh daeh yM", "!?tahW", "!em fo ffo ffuts siht teG",
}
GENERIC_HEALED =
    { "Ahh, that feels better.", "That's a weight off my back.", "I feel as good as new!", "Thanks for that.", "Perhaps I'll live another day.",
}

local special_offsets_x = ({ -- shouldn't really have to use this often
    ["$animal_drone"]                 = -15,
})

local special_offsets_y = ({ -- for when an enemy is taller or shorter than expected
    ["$animal_boss_alchemist"]        = 60,
    ["$animal_parallel_alchemist"]    = 60,
    ["$animal_boss_pit"]              = 15,
    ["$animal_parallel_tentacles"]    = 15,
    ["$animal_necromancer_shop"]      = 10,
    ["$animal_necromancer_super"]     = 12,
    ["$animal_firemage"]              = 8,
    ["$animal_thundermage"]           = 8,
    ["$animal_tentacler"]             = 10,
    ["$animal_giant"]                 = 8,
    ["$animal_pebble"]                = -4,
    ["$animal_rat"]                   = -2,
    ["$animal_drone"]                 = -10,
})

function EnemyHasDialogue(pool, name)
    local what = {}
    if pool == "IDLE" then what = DIALOGUE_IDLE end
    if pool == "DAMAGETAKEN" then what = DIALOGUE_DAMAGETAKEN end
    if pool == "DAMAGEDEALT" then what = DIALOGUE_DAMAGEDEALT end
    if what ~= {} then
        for i = 1, #what do
            if what[i][1] == name then return i end
        end
    end
    if pool == "ANY" then
        for i = 1, #DIALOGUE_IDLE do
            if DIALOGUE_IDLE[i][1] == name then return i end
        end
        for i = 1, #DIALOGUE_DAMAGETAKEN do
            if DIALOGUE_DAMAGETAKEN[i][1] == name then return i end
        end
        for i = 1, #DIALOGUE_DAMAGEDEALT do
            if DIALOGUE_DAMAGEDEALT[i][1] == name then return i end
        end
    end
    return false
end

function AddEnemyDialogue(pool, name, dialogue)
    local has = EnemyHasDialogue(pool, name)
    local what = {}
    if pool == "IDLE" then what = DIALOGUE_IDLE end
    if pool == "DAMAGETAKEN" then what = DIALOGUE_DAMAGETAKEN end
    if pool == "DAMAGEDEALT" then what = DIALOGUE_DAMAGEDEALT end
    if has then
        for j = 1, #dialogue do
            -- If the enemy exists in the table already, insert the new dialogue
            table.insert(what[has], dialogue[j])
        end
    else
        -- if the enemy isn't in the table already, put it in
        table.insert(dialogue, 1, name)
        table.insert(what, dialogue)
    end
    if pool == "IDLE" then DIALOGUE_IDLE = what end
    if pool == "DAMAGETAKEN" then DIALOGUE_DAMAGETAKEN = what end
    if pool == "DAMAGEDEALT" then DIALOGUE_DAMAGEDEALT = what end
end

function EmptyEnemyDialogue(pool, name)
    local has = EnemyHasDialogue(pool, name)
    local what = {}
    if pool == "IDLE" then what = DIALOGUE_IDLE end
    if pool == "DAMAGETAKEN" then what = DIALOGUE_DAMAGETAKEN end
    if pool == "DAMAGEDEALT" then what = DIALOGUE_DAMAGEDEALT end

    if has then
        table.remove(what, has)
    end

    if pool == "IDLE" then DIALOGUE_IDLE = what end
    if pool == "DAMAGETAKEN" then DIALOGUE_DAMAGETAKEN = what end
    if pool == "DAMAGEDEALT" then DIALOGUE_DAMAGEDEALT = what end
end

function Speak(entity, text, pool)
    pool = pool or ""
    local textComponent = EntityGetFirstComponentIncludingDisabled(entity, "SpriteComponent", "graham_speech_text")
    if textComponent then return end

    local rotate = false
    local old_text = text
    local x, y = EntityGetTransform(entity)
    SetRandomSeed(entity + x + 2352, GameGetFrameNum() - y + 24806)
    local size_x = 0.7
    local size_y = 0.7

    local alpha = (100 - ModSettingGet("grahamsdialogue.transparency")) / 100
    local name = NameGet(entity)
    local offset_x = 0  + (special_offsets_x[name] or 0)
    local offset_y = 26 + (special_offsets_y[name] or 0)

    if not (EntityHasTag(entity, "graham_enemydialogue") or EnemyHasDialogue("ANY", name)) then return end

    --- SPECIAL FUNCTIONALITY ---

    -- Copier mage should go at the top, so it can pretend to be a different enemy
    if name == "$animal_wizard_returner" then
        local thing = nil
        if pool == "IDLE" then thing = DIALOGUE_IDLE end
        if pool == "DAMAGEDEALT" then thing = DIALOGUE_DAMAGEDEALT end
        if pool == "DAMAGETAKEN" then thing = DIALOGUE_DAMAGETAKEN end
        if thing ~= nil then
            local enemies = EntityGetInRadiusWithTag(x, y, 150, "enemy") or {}
            for j = 1, #enemies do
                local enemy = enemies[Random(1, #enemies)]
                name = EntityGetName(enemy)
                name = name:gsub("_weak", "")
                if name ~= "$animal_wizard_returner" then
                    for i = 1, #thing do
                        if thing[i][1] == name then
                            text = tostring(thing[i][Random(2, #thing[i])])
                            break
                        end
                    end
                end
                if text ~= old_text then break end
            end
        end
    end

    if GameHasFlagRun("PERK_PICKED_PEACE_WITH_GODS") and (pool == "IDLE" or pool == "GENERIC") then
        if name == "$animal_necromancer_shop" then
            local special = {
                "I suppose I can let it slide. But just this once!",
                "Don't think that this means that you're off the hook...",
                "Fine... harumph.",
            }
            text = special[Random(1, #special)]
        end
        if name == "$animal_necromancer_super" then
            local special = {
                "A sinful being you are... But perhaps a little bit endearing.",
                "Don't be mistaken. It is by command of the gods that I spare your life today.",
                "I'm sure you have your reasons. But so do I.",
            }
            text = special[Random(1, #special)]
        end
    end

    if (name == "$animal_firemage" or name == "$animal_thundermage") and pool == "IDLE" then
        local items = EntityGetInRadiusWithTag(x, y, 180, "item_pickup")
        for i = 1, #items do
            if EntityGetRootEntity(items[i]) ~= items[i] then
                if text ~= old_text then break end
                local comps = EntityGetComponent(items[i], "GameEffectComponent", "enabled_in_hand") or {}
                for j = 1, #comps do
                    if ComponentGetValue2(comps[j], "effect") == "FRIEND_FIREMAGE" and name == "$animal_firemage" or name == "$animal_firemage_weak" then
                        local special = {
                            "Nice stone you got there. Is it for sale?",
                            "That flame... it reminds me of myself when I was younger.",
                            "Come a bit closer. I'd like to get a closer look at that item.",
                        }
                        text = special[Random(1, #special)]
                        break
                    end
                    if ComponentGetValue2(comps[j], "effect") == "FRIEND_THUNDERMAGE" and name == "$animal_thundermage" then
                        local special = {
                            "What a beautiful stone. Take good care of it.",
                            "It looks like you appreciate the art of electricity almost as much as I do.",
                            "I would normally blast you to pieces, but...",
                        }
                        text = special[Random(1, #special)]
                        break
                    end
                end
            end
        end
    end

    if name == "$animal_thunderskull" and (pool == "DAMAGEDEALT" or pool == "DAMAGETAKEN") and GameHasFlagRun("PERK_PICKED_ELECTRICITY") then
        local special = {
            "Yo! A fellow electricity user?!",
            "I never expected to see someone as rad as me down here!",
            "I'm a fan of the volts you're outputting, friend.",
        }
        text = special[Random(1, #special)]
    end
    if name == "$animal_iceskull" and (pool == "DAMAGEDEALT" or pool == "DAMAGETAKEN") and GameHasFlagRun("PERK_PICKED_GRAHAM_REVENGE_FREEZE") then
        local special = {
            "Hey, you also have retaliation projectiles? N-ice.",
            "Your perks are cool! And I mean that literally.",
            "We should make some ice sculptures together, some time.",
        }
        text = special[Random(1, #special)]
    end

    if name == "$animal_giant" then
        local enemies = EntityGetInRadiusWithTag(x, y, 140, "glue_NOT")
        for i = 1, #enemies do
            if EntityGetName(enemies[i]) == "$animal_pebble" then
                Speak(enemies[i], text, pool)
            end
        end
    end

    local genome = EntityGetFirstComponent(entity, "GenomeDataComponent")
    if genome ~= nil then
        local faction = HerdIdToString(ComponentGetValue2(genome, "herd_id"))
        if faction == "robot" then
            size_x = size_x + 0.06
        end
        if faction == "fungus" then
            size_y = size_y + 0.06
        end
        if faction == "player" then
            size_x = size_x + 0.03
            size_y = size_y + 0.03
        end
    end
    if name == "$animal_pebble" or name == "$animal_miniblob" then
        size_x = size_x - 0.10
        size_y = size_y - 0.10
    end

    local worm_speeds = {
        ["$animal_worm_tiny"]    = 4,
        ["$animal_worm"]         = 5,
        ["$animal_worm_big"]     = 6,
    }
    local threshold = worm_speeds[name]
    if threshold ~= nil then
        local comp = EntityGetFirstComponent(entity, "WormComponent")
        if comp ~= nil then
            local xs, ys = ComponentGetValueVector2(comp, "mTargetVec")
            local ym = ComponentGetValue2(comp, "mGravVelocity")
            if xs ~= nil and ys ~= nil and ym ~= nil then
                local velocity = math.abs(xs) + math.abs(ys) + math.abs(ym)
                if velocity > threshold then
                    rotate = true
                    local special = {
                        "WOOOOOOOOO!",
                        "YEAAAAHHHH!",
                        "RAAAAAAAHH!",
                    }
                    text = special[Random(1, #special)]
                    size_x = size_x + (threshold / 24)
                    size_y = size_y + (threshold / 24)
                end
            end
        end
    end

    -- Appended stuff
    ModdedStuff()

    ---- All dialogue handling should go above this point, don't tinker with stuff down here ----
    local gui = GuiCreate()
    GuiStartFrame(gui)
    local width = GuiGetTextDimensions( gui, text, size_x ) * 0.75
    GuiDestroy(gui)

    EntityAddTag(entity, "graham_speaking")
    EntityAddComponent2(entity, "SpriteComponent", {
        _tags = "enabled_in_world, graham_speech_text",
        image_file = "data/fonts/font_pixel_white.xml",
        emissive = ModSettingGet("grahamsdialogue.visibility"),
        is_text_sprite = true,
        offset_x = offset_x + width,
        offset_y = offset_y,
        alpha = alpha,
        update_transform = true,
        update_transform_rotation = rotate,
        text = text,
        has_special_scale = true,
        special_scale_x = size_x,
        special_scale_y = size_y,
        z_index = -9000,
        never_ragdollify_on_death = true
    })

    local luacomp = EntityGetFirstComponentIncludingDisabled(entity, "LuaComponent", "graham_speech_quiet")
    if luacomp then EntityRemoveComponent(entity, luacomp) end

    EntityAddComponent2(entity, "LuaComponent", {
        _tags= "graham_speech_quiet",
        execute_every_n_frame=ModSettingGet("grahamsdialogue.length"),
        script_source_file="mods/grahamsdialogue/files/quiet.lua"
    })
end