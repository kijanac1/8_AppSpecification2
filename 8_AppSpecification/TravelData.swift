//
//  Untitled.swift
//  8_AppSpecification
//
//  Created by user267360 on 11/28/24.
//

import SwiftUI

class TravelData: ObservableObject {
    
    /*@Published var completedTrips: [Int] = [3, 4, 5, 6, 7]
     @Published var favorites: Set<Int> = []
     @Published var bucketList: [Int] = [0, 8, 9, 10, 11]*/
    @Published var completedTrips: [Int] {
        didSet {
            UserDefaults.standard.set(completedTrips, forKey: "completedTrips")
        }
    }
    @Published var favorites: Set<Int> = []
    
    @Published var bucketList: [Int] {
        didSet {
            UserDefaults.standard.set(bucketList, forKey: "bucketList")
        }
    }
    
    @Published var locationImages: [[String]] = [
        ["Fiji_1", "Fiji_2", "Fiji_3", "Fiji_4"],
        ["kyoto_1", "kyoto_2", "kyoto_3"],
        ["Auckland_1", "Auckland_2", "Auckland_3", "Auckland_4"],
        ["Portland_1"],
        ["SanDiego_1"],
        ["Vegas_1"],
        ["Orleans_1"],
        ["Bigbend_1"],
        ["leavenworth1"],
        ["greece1"],
        ["montegobay1"],
        ["santodomingo1"],
        ["tokyo_1"],
        ["paris_1"],
        ["london_1"],
        ["rome_1"],
        ["barcelona_1"],
        ["nyc_1"],
        ["sydney_1"],
        ["capetown_1"],
        ["bangkok_1"],
        ["dubai_1"],
        ["rioDeJaneiro_1"],
        ["cairo_1"],
        ["istanbul_1"],
        ["machuPicchu_1"],
        ["honolulu_1"],
        ["Banff_1"],
        ["queenstown_1"],
        ["santorini_1"],
        ["seoul_1"],
        ["singapore_1"],
        ["reykjavik_1"],
        ["buenosAires_1"],
        ["prague_1"],
        ["amsterdam_1"],
        ["berlin_1"],
        ["marrakech_1"],
        ["vancouver_1"],
        ["edinburgh_1"],
        ["venice_1"],
        ["hanoi_1"],
        ["kruger_1"],
        ["tulum_1"],
        ["petra_1"],
        ["melbourne_1"],
        ["osaka_1"],
        ["dubrovnik_1"],
        ["grandCanyon_1"],
        ["bali_1"]
        
    ]
    
    @Published var locationNames: [String] = [
        "Fiji, South Pacific Islands",
        "Kyoto, Japan",
        "Auckland, New Zealand",
        "Portland, OR, USA",
        "San Diego, CA, USA",
        "Las Vegas, NV, USA",
        "New Orleans, LA, USA",
        "Big Bend National Park, USA",
        "Leavenworth, WA, USA",
        "Greece, Italy",
        "Montego Bay, Jamaica",
        "Santo Domingo, Dominican Republic",
        "Tokyo, Japan",
        "Paris, France",
        "London, United Kingdom",
        "Rome, Italy",
        "Barcelona, Spain",
        "New York City, NY, USA",
        "Sydney, Australia",
        "Cape Town, South Africa",
        "Bangkok, Thailand",
        "Dubai, United Arab Emirates",
        "Rio de Janeiro, Brazil",
        "Cairo, Egypt",
        "Istanbul, Turkey",
        "Machu Picchu, Peru",
        "Honolulu, Hawaii, USA",
        "Banff, Alberta, Canada",
        "Queenstown, New Zealand",
        "Santorini, Greece",
        "Seoul, South Korea",
        "Singapore, Singapore",
        "Reykjavik, Iceland",
        "Buenos Aires, Argentina",
        "Prague, Czech Republic",
        "Amsterdam, Netherlands",
        "Berlin, Germany",
        "Marrakech, Morocco",
        "Vancouver, British Columbia, Canada",
        "Edinburgh, Scotland",
        "Venice, Italy",
        "Hanoi, Vietnam",
        "Kruger National Park, South Africa",
        "Tulum, Mexico",
        "Petra, Jordan",
        "Melbourne, Australia",
        "Osaka, Japan",
        "Dubrovnik, Croatia",
        "Grand Canyon National Park, USA",
        "Bali, Indonesia"
        
    ]
    
    let locationClimates: [String: String] = [
        "Fiji, South Pacific Islands": "Tropical",
        "Kyoto, Japan": "Temperate",
        "Auckland, New Zealand": "Temperate",
        "Portland, OR, USA": "Temperate",
        "San Diego, CA, USA": "Temperate",
        "Las Vegas, NV, USA": "Desert",
        "New Orleans, LA, USA": "Temperate",
        "Big Bend National Park, USA": "Desert",
        "Leavenworth, WA, USA": "Temperate",
        "Greece, Italy": "Temperate",
        "Montego Bay, Jamaica": "Tropical",
        "Santo Domingo, Dominican Republic": "Tropical",
        "Tokyo, Japan": "Temperate",
        "Paris, France": "Temperate",
        "London, United Kingdom": "Temperate",
        "Rome, Italy": "Temperate",
        "Barcelona, Spain": "Temperate",
        "New York City, NY, USA": "Temperate",
        "Sydney, Australia": "Temperate",
        "Cape Town, South Africa": "Temperate",
        "Bangkok, Thailand": "Tropical",
        "Dubai, United Arab Emirates": "Desert",
        "Rio de Janeiro, Brazil": "Tropical",
        "Cairo, Egypt": "Desert",
        "Istanbul, Turkey": "Temperate",
        "Machu Picchu, Peru": "Tropical",
        "Honolulu, Hawaii, USA": "Tropical",
        "Banff, Alberta, Canada": "Polar",
        "Queenstown, New Zealand": "Temperate",
        "Santorini, Greece": "Temperate",
        "Seoul, South Korea": "Temperate",
        "Singapore, Singapore": "Tropical",
        "Reykjavik, Iceland": "Polar",
        "Buenos Aires, Argentina": "Temperate",
        "Prague, Czech Republic": "Temperate",
        "Amsterdam, Netherlands": "Temperate",
        "Berlin, Germany": "Temperate",
        "Marrakech, Morocco": "Desert",
        "Vancouver, British Columbia, Canada": "Temperate",
        "Edinburgh, Scotland": "Temperate",
        "Venice, Italy": "Temperate",
        "Hanoi, Vietnam": "Tropical",
        "Kruger National Park, South Africa": "Desert",
        "Tulum, Mexico": "Tropical",
        "Petra, Jordan": "Desert",
        "Melbourne, Australia": "Temperate",
        "Osaka, Japan": "Temperate",
        "Dubrovnik, Croatia": "Temperate",
        "Grand Canyon National Park, USA": "Desert",
        "Bali, Indonesia": "Tropical"
    ]
    
    let locationLanguages: [String: [String]] = [
        "Fiji, South Pacific Islands": ["English", "Fijian", "Hindi"],
        "Kyoto, Japan": ["Japanese"],
        "Auckland, New Zealand": ["English", "Māori"],
        "Portland, OR, USA": ["English"],
        "San Diego, CA, USA": ["English"],
        "Las Vegas, NV, USA": ["English"],
        "New Orleans, LA, USA": ["English"],
        "Big Bend National Park, USA": ["English", "Spanish"],
        "Leavenworth, WA, USA": ["English"],
        "Greece, Italy": ["Greek"],
        "Montego Bay, Jamaica": ["English", "Patois"],
        "Santo Domingo, Dominican Republic": ["Spanish"],
        "Tokyo, Japan": ["Japanese"],
        "Paris, France": ["French"],
        "London, United Kingdom": ["English"],
        "Rome, Italy": ["Italian"],
        "Barcelona, Spain": ["Spanish", "Catalan"],
        "New York City, NY, USA": ["English"],
        "Sydney, Australia": ["English"],
        "Cape Town, South Africa": ["English", "Afrikaans", "Xhosa", "Zulu"],
        "Bangkok, Thailand": ["Thai"],
        "Dubai, United Arab Emirates": ["Arabic", "English"],
        "Rio de Janeiro, Brazil": ["Portuguese"],
        "Cairo, Egypt": ["Arabic"],
        "Istanbul, Turkey": ["Turkish"],
        "Machu Picchu, Peru": ["Spanish", "Quechua"],
        "Honolulu, Hawaii, USA": ["English", "Hawaiian"],
        "Banff, Alberta, Canada": ["English", "French"],
        "Queenstown, New Zealand": ["English", "Māori"],
        "Santorini, Greece": ["Greek"],
        "Seoul, South Korea": ["Korean"],
        "Singapore, Singapore": ["English", "Mandarin", "Malay", "Tamil"],
        "Reykjavik, Iceland": ["Icelandic", "English"],
        "Buenos Aires, Argentina": ["Spanish"],
        "Prague, Czech Republic": ["Czech"],
        "Amsterdam, Netherlands": ["Dutch", "English"],
        "Berlin, Germany": ["German"],
        "Marrakech, Morocco": ["Arabic", "Berber", "French"],
        "Vancouver, British Columbia, Canada": ["English", "French"],
        "Edinburgh, Scotland": ["English", "Scots Gaelic"],
        "Venice, Italy": ["Italian"],
        "Hanoi, Vietnam": ["Vietnamese"],
        "Kruger National Park, South Africa": ["English", "Afrikaans", "Zulu", "Tsonga"],
        "Tulum, Mexico": ["Spanish"],
        "Petra, Jordan": ["Arabic"],
        "Melbourne, Australia": ["English"],
        "Osaka, Japan": ["Japanese"],
        "Dubrovnik, Croatia": ["Croatian"],
        "Grand Canyon National Park, USA": ["English"],
        "Bali, Indonesia": ["Indonesian", "Balinese"]
    ]
    
    // Dictionary mapping city names to their regions
    @Published var locationRegions: [String: String] = [
        "Fiji, South Pacific Islands": "Oceania",
        "Kyoto, Japan": "Asia",
        "Auckland, New Zealand": "Oceania",
        "Portland, OR, USA": "North America",
        "San Diego, CA, USA": "North America",
        "Las Vegas, NV, USA": "North America",
        "New Orleans, LA, USA": "North America",
        "Big Bend National Park, USA": "North America",
        "Leavenworth, WA, USA": "North America",
        "Greece, Italy": "Europe",
        "Montego Bay, Jamaica": "North America",
        "Santo Domingo, Dominican Republic": "North America",
        "Tokyo, Japan": "Asia",
        "Paris, France": "Europe",
        "London, United Kingdom": "Europe",
        "Rome, Italy": "Europe",
        "Barcelona, Spain": "Europe",
        "New York City, NY, USA": "North America",
        "Sydney, Australia": "Oceania",
        "Cape Town, South Africa": "Africa",
        "Bangkok, Thailand": "Asia",
        "Dubai, United Arab Emirates": "Asia",
        "Rio de Janeiro, Brazil": "South America",
        "Cairo, Egypt": "Africa",
        "Istanbul, Turkey": "Asia",
        "Machu Picchu, Peru": "South America",
        "Honolulu, Hawaii, USA": "North America",
        "Banff, Alberta, Canada": "North America",
        "Queenstown, New Zealand": "Oceania",
        "Santorini, Greece": "Europe",
        "Seoul, South Korea": "Asia",
        "Singapore, Singapore": "Asia",
        "Reykjavik, Iceland": "Europe",
        "Buenos Aires, Argentina": "South America",
        "Prague, Czech Republic": "Europe",
        "Amsterdam, Netherlands": "Europe",
        "Berlin, Germany": "Europe",
        "Marrakech, Morocco": "Africa",
        "Vancouver, British Columbia, Canada": "North America",
        "Edinburgh, Scotland": "Europe",
        "Venice, Italy": "Europe",
        "Hanoi, Vietnam": "Asia",
        "Kruger National Park, South Africa": "Africa",
        "Tulum, Mexico": "North America",
        "Petra, Jordan": "Asia",
        "Melbourne, Australia": "Oceania",
        "Osaka, Japan": "Asia",
        "Dubrovnik, Croatia": "Europe",
        "Grand Canyon National Park, USA": "North America",
        "Bali, Indonesia": "Asia"
    ]
    
    let locationActivities: [String: [String]] = [
        "Fiji, South Pacific Islands": ["Hiking", "Swimming", "Camping"],
        "Kyoto, Japan": ["Hiking", "Shopping", "Dining"],
        "Auckland, New Zealand": ["Hiking", "Swimming", "Dining"],
        "Portland, OR, USA": ["Hiking", "Shopping", "Dining"],
        "San Diego, CA, USA": ["Swimming", "Shopping", "Dining"],
        "Las Vegas, NV, USA": ["Shopping", "Dining"],
        "New Orleans, LA, USA": ["Shopping", "Dining"],
        "Big Bend National Park, USA": ["Hiking", "Camping"],
        "Leavenworth, WA, USA": ["Skiing", "Dining"],
        "Greece, Italy": ["Swimming", "Dining"],
        "Montego Bay, Jamaica": ["Swimming", "Dining"],
        "Santo Domingo, Dominican Republic": ["Swimming", "Shopping"],
        "Tokyo, Japan": ["Shopping", "Dining"],
        "Paris, France": ["Shopping", "Dining"],
        "London, United Kingdom": ["Shopping", "Dining"],
        "Rome, Italy": ["Shopping", "Dining"],
        "Barcelona, Spain": ["Swimming", "Shopping", "Dining"],
        "New York City, NY, USA": ["Shopping", "Dining"],
        "Sydney, Australia": ["Hiking", "Swimming", "Dining"],
        "Cape Town, South Africa": ["Hiking", "Swimming", "Camping"],
        "Bangkok, Thailand": ["Shopping", "Dining"],
        "Dubai, United Arab Emirates": ["Shopping", "Swimming"],
        "Rio de Janeiro, Brazil": ["Swimming", "Hiking"],
        "Cairo, Egypt": ["Hiking", "Shopping"],
        "Istanbul, Turkey": ["Shopping", "Dining"],
        "Machu Picchu, Peru": ["Hiking", "Camping"],
        "Honolulu, Hawaii, USA": ["Swimming", "Hiking", "Dining"],
        "Banff, Alberta, Canada": ["Hiking", "Camping", "Skiing"],
        "Queenstown, New Zealand": ["Hiking", "Skiing"],
        "Santorini, Greece": ["Swimming", "Dining"],
        "Seoul, South Korea": ["Shopping", "Dining"],
        "Singapore, Singapore": ["Shopping", "Dining"],
        "Reykjavik, Iceland": ["Hiking", "Camping"],
        "Buenos Aires, Argentina": ["Shopping", "Dining"],
        "Prague, Czech Republic": ["Shopping", "Dining"],
        "Amsterdam, Netherlands": ["Hiking", "Shopping", "Dining"],
        "Berlin, Germany": ["Shopping", "Dining"],
        "Marrakech, Morocco": ["Shopping", "Dining"],
        "Vancouver, British Columbia, Canada": ["Hiking", "Camping", "Dining"],
        "Edinburgh, Scotland": ["Hiking", "Dining"],
        "Venice, Italy": ["Shopping", "Dining"],
        "Hanoi, Vietnam": ["Shopping", "Dining"],
        "Kruger National Park, South Africa": ["Hiking", "Camping"],
        "Tulum, Mexico": ["Swimming", "Camping"],
        "Petra, Jordan": ["Hiking", "Camping"],
        "Melbourne, Australia": ["Shopping", "Dining"],
        "Osaka, Japan": ["Shopping", "Dining"],
        "Dubrovnik, Croatia": ["Swimming", "Dining"],
        "Grand Canyon National Park, USA": ["Hiking", "Camping"],
        "Bali, Indonesia": ["Swimming", "Hiking", "Dining"]
    ]
    
    
    
    @Published var descriptions: [String] = [
        "Fiji is a tropical paradise located in the South Pacific Ocean, consisting of over 330 islands, with about 110 inhabited. Known for its pristine beaches, turquoise waters, and vibrant coral reefs, Fiji is a popular destination for snorkeling, diving, and beach vacations. The islands boast a rich cultural heritage, blending indigenous Fijian traditions with Indian, European, and Chinese influences. Visitors can experience warm hospitality, partake in traditional kava ceremonies, and explore local villages to gain insight into the islanders' way of life. Fiji's lush rainforests, dramatic landscapes, and cascading waterfalls provide endless opportunities for adventure, from hiking to zip-lining. The capital city, Suva, offers a mix of modern amenities and cultural landmarks, such as the Fiji Museum and Thurston Gardens.",
        "Kyoto, Japan, is a city steeped in history and tradition, serving as the cultural heart of Japan for over a thousand years. Once the imperial capital, Kyoto is renowned for its beautifully preserved temples, shrines, and traditional wooden houses. The city is home to over 1,600 Buddhist temples and 400 Shinto shrines, including iconic landmarks like Kinkaku-ji (the Golden Pavilion), Fushimi Inari-taisha, and Kiyomizu-dera. Visitors can explore serene Zen gardens, tea houses, and ancient palaces that offer a glimpse into Japan's rich spiritual and cultural heritage. Kyoto is also famous for its seasonal beauty, with cherry blossoms in the spring and vibrant autumn leaves attracting travelers from around the world.",
        "A vibrant, diverse city located on the North Island, known as the 'City of Sails' due to its numerous harbors and love for boating. Surrounded by stunning natural landscapes, Auckland boasts both urban sophistication and breathtaking outdoor beauty. The city is built on a volcanic field, featuring picturesque hills and ancient cones, such as Mount Eden and Rangitoto Island, offering spectacular views of the skyline and surrounding waters. Renowned for its multicultural atmosphere, with influences from Māori, Pacific Islander, Asian, and European cultures, creating a rich tapestry of traditions, art, and cuisine.",
        "Portland, OR, USA, is a vibrant city known for its eco-friendliness, thriving art scene, and coffee culture. Surrounded by stunning natural beauty, including the Columbia River Gorge and Mount Hood, Portland offers an urban experience with a love for the outdoors. Famous for its food trucks, microbreweries, and Powell's City of Books, the city attracts those looking for a unique cultural experience.",
        "San Diego, CA, USA, is a coastal city known for its sunny weather, beautiful beaches, and rich military history. Home to attractions like Balboa Park, the San Diego Zoo, and the USS Midway Museum, it’s a destination for both relaxation and adventure. The city's diverse neighborhoods, including La Jolla and Gaslamp Quarter, offer a mix of culture, dining, and entertainment.",
        "Las Vegas, NV, USA, is the entertainment capital of the world, renowned for its casinos, luxury resorts, and dazzling nightlife. Beyond the famous Las Vegas Strip, visitors can explore the Red Rock Canyon, world-class restaurants, and extravagant shows, making it a destination for fun and excitement.",
        "New Orleans, LA, USA, is a city with a unique blend of French, African, and American cultures, famous for its music, cuisine, and festivals like Mardi Gras. The French Quarter, with its vibrant nightlife and historic architecture, offers an unforgettable experience for visitors. From jazz to gumbo, New Orleans captivates with its rich heritage.",
        "Big Bend National Park, USA, is a vast and rugged park located in southwest Texas, featuring breathtaking desert landscapes, towering mountains, and the Rio Grande River. Known for its hiking trails, dark night skies, and diverse wildlife, it’s a paradise for outdoor enthusiasts and nature lovers.",
        "Leavenworth, WA, USA, is a charming Bavarian-style village nestled in the Cascade Mountains. Known for its alpine charm, Leavenworth offers a range of outdoor activities and cultural festivals, attracting visitors year-round for skiing, hiking, and its famous Oktoberfest.",
        "Greece, Italy, boasts a breathtaking coastline, vibrant culture, and rich history. From ancient ruins to picturesque beaches, Greece is a destination that combines relaxation and exploration, with delicious Mediterranean cuisine to match.",
        "Montego Bay, Jamaica, is a tropical paradise known for its stunning beaches, vibrant reggae music, and welcoming culture. Visitors can explore coral reefs, lush rainforests, and enjoy the lively nightlife of this Caribbean gem.",
        "Santo Domingo, Dominican Republic, is the oldest European settlement in the Americas, offering a rich blend of history, culture, and vibrant city life. From the historic Zona Colonial to its bustling modern neighborhoods, Santo Domingo is a unique Caribbean destination.",
        "Tokyo, Japan, is a bustling metropolis blending modern technology and ancient traditions. Famous for its vibrant neighborhoods like Shibuya and Harajuku, Tokyo also boasts serene temples, beautiful gardens, and world-class cuisine.",
        "Paris, France, is known as the City of Light and a global hub for art, culture, and fashion. With iconic landmarks like the Eiffel Tower, Louvre Museum, and Notre Dame Cathedral, Paris offers a rich history, exquisite cuisine, and romantic charm. Stroll along the Seine River or explore the charming neighborhoods of Montmartre and Le Marais.",
        "London, United Kingdom, is a vibrant city with a rich history spanning over 2,000 years. From the historic Tower of London and Buckingham Palace to the cultural hotspots of Soho and Camden, the city offers a mix of tradition and modernity. Visitors can enjoy world-class museums, theaters, and diverse cuisine.",
        "Rome, Italy, is a city where history comes alive. Known as the Eternal City, Rome is home to iconic landmarks like the Colosseum, Roman Forum, and Vatican City. With its cobblestone streets, vibrant piazzas, and world-famous cuisine, it’s a destination that offers both culture and romance.",
        "Barcelona, Spain, is a Mediterranean gem known for its unique architecture by Antoni Gaudí, such as the Sagrada Familia and Park Güell. Visitors can enjoy its vibrant art scene, delicious Catalan cuisine, and stunning beaches. The bustling La Rambla and Gothic Quarter are must-see areas.",
        "New York City, NY, USA, is a global metropolis known for its iconic skyline, diverse neighborhoods, and world-class attractions. From Times Square and Central Park to the Statue of Liberty and Broadway shows, NYC offers something for everyone, blending culture, entertainment, and innovation.",
        "Sydney, Australia, is a city known for its stunning harbor, iconic Sydney Opera House, and beautiful beaches like Bondi and Manly. Visitors can explore the Royal Botanic Gardens, climb the Sydney Harbour Bridge, and enjoy the vibrant dining and cultural scene.",
        "Cape Town, South Africa, is a city of breathtaking beauty, nestled between Table Mountain and the Atlantic Ocean. Known for its diverse culture, historic Robben Island, and stunning Cape Winelands, Cape Town offers a mix of adventure and relaxation.",
        "Bangkok, Thailand, is a bustling city known for its ornate temples, vibrant street markets, and delicious Thai cuisine. Highlights include the Grand Palace, Wat Arun, and the lively Khao San Road. The city offers a blend of tradition and modernity.",
        "Dubai, United Arab Emirates, is a city of luxury and innovation, known for its towering skyscrapers like the Burj Khalifa, stunning artificial islands, and world-class shopping malls. Visitors can enjoy desert safaris, luxurious resorts, and cultural landmarks like the Al Fahidi Historical District.",
        "Rio de Janeiro, Brazil, is famous for its stunning beaches, lively Carnival festival, and iconic landmarks like Christ the Redeemer and Sugarloaf Mountain. The city’s vibrant samba culture and breathtaking landscapes make it a must-visit destination.",
        "Cairo, Egypt, is a historic city known as the gateway to the ancient world. Visitors can explore the Pyramids of Giza, the Sphinx, and the Egyptian Museum. The bustling markets of Khan El Khalili and the Nile River add to its charm.",
        "Istanbul, Turkey, is a city where East meets West. Known for its historic landmarks like Hagia Sophia, the Blue Mosque, and Topkapi Palace, Istanbul offers a unique blend of cultures, vibrant bazaars, and delicious Turkish cuisine.",
        "Machu Picchu, Peru, is a mystical Incan citadel nestled in the Andes Mountains. A UNESCO World Heritage Site, it offers breathtaking views, ancient ruins, and a sense of wonder for visitors trekking the iconic Inca Trail.",
        "Honolulu, Hawaii, USA, is a tropical paradise on the island of Oahu. Known for its stunning beaches like Waikiki, rich Polynesian culture, and historic landmarks like Pearl Harbor, Honolulu is a destination for relaxation and adventure.",
        "Banff, Alberta, Canada, is a breathtaking mountain town in the Canadian Rockies. Known for its turquoise lakes, such as Lake Louise, and stunning landscapes, Banff offers outdoor adventures like hiking, skiing, and wildlife spotting.",
        "Queenstown, New Zealand, is an adventure capital surrounded by the Southern Alps and Lake Wakatipu. Visitors can enjoy activities like bungee jumping, skiing, and wine tours in this picturesque town.",
        "Santorini, Greece, is a romantic island known for its whitewashed buildings, blue-domed churches, and stunning sunsets. Perched on volcanic cliffs, Santorini offers breathtaking views, delicious Mediterranean cuisine, and historic ruins.",
        "Seoul, South Korea, is a dynamic city blending traditional culture with modern innovation. Visitors can explore ancient palaces like Gyeongbokgung, vibrant markets, and trendy districts like Gangnam and Hongdae.",
        "Singapore, Singapore, is a modern city-state known for its stunning skyline, Marina Bay Sands, and lush Gardens by the Bay. Visitors can enjoy diverse cuisine, cultural districts, and world-class attractions like Sentosa Island.",
        "Reykjavik, Iceland, is the world’s northernmost capital, known for its colorful houses, vibrant arts scene, and proximity to natural wonders. Visitors can explore geothermal hot springs, glaciers, and the iconic Blue Lagoon.",
        "Buenos Aires, Argentina, is a city of tango, culture, and vibrant neighborhoods like La Boca and Palermo. Known for its European charm, world-class steak, and rich history, it’s often called the Paris of South America.",
        "Prague, Czech Republic, is a fairy-tale city known for its historic Old Town, Charles Bridge, and stunning Prague Castle. With its cobblestone streets and Gothic architecture, Prague offers a magical experience.",
        "Amsterdam, Netherlands, is a picturesque city of canals, historic buildings, and vibrant culture. Visitors can explore the Anne Frank House, Van Gogh Museum, and bustling neighborhoods like Jordaan and De Pijp.",
        "Berlin, Germany, is a city of history, art, and innovation. Known for landmarks like the Berlin Wall, Brandenburg Gate, and Museum Island, Berlin offers a mix of cultural depth and contemporary energy.",
        "Marrakech, Morocco, is a vibrant city known for its bustling souks, stunning palaces like Bahia Palace, and vibrant Jemaa el-Fnaa square. Visitors can explore the historic Medina and lush Majorelle Garden.",
        "Vancouver, British Columbia, Canada, is a coastal city surrounded by stunning natural beauty. Known for its outdoor activities, diverse cuisine, and attractions like Stanley Park and Granville Island, Vancouver is a favorite for travelers.",
        "Edinburgh, Scotland, is a historic city known for its medieval Old Town, elegant Georgian New Town, and iconic Edinburgh Castle. Visitors can enjoy the Royal Mile, lively festivals, and stunning landscapes.",
        "Venice, Italy, is a romantic city built on canals, known for its iconic gondolas, St. Mark’s Basilica, and Doge’s Palace. Visitors can explore its unique architecture, vibrant squares, and charming waterways.",
        "Hanoi, Vietnam, is a city of rich history and vibrant culture. Known for its bustling Old Quarter, serene Hoan Kiem Lake, and historic landmarks like the Temple of Literature, Hanoi offers a unique blend of tradition and modernity.",
        "Kruger National Park, South Africa, is one of Africa’s largest game reserves, offering incredible wildlife experiences. Visitors can enjoy safaris to see the Big Five and immerse themselves in breathtaking landscapes.",
        "Tulum, Mexico, is a beach paradise known for its Mayan ruins, turquoise waters, and eco-friendly resorts. Visitors can explore cenotes, relax on pristine beaches, and enjoy the vibrant local culture.",
        "Petra, Jordan, is an ancient city carved into rose-red cliffs, known as the Lost City. A UNESCO World Heritage Site, Petra’s stunning architecture, such as the Treasury and Monastery, is a marvel of human history.",
        "Melbourne, Australia, is a cultural capital known for its vibrant arts scene, coffee culture, and iconic landmarks like Federation Square. Visitors can explore its laneways, beaches, and nearby Great Ocean Road.",
        "Osaka, Japan, is a bustling city known for its vibrant food scene, historic Osaka Castle, and lively districts like Dotonbori. Visitors can enjoy delicious street food and explore Universal Studios Japan.",
        "Dubrovnik, Croatia, is a stunning coastal city known as the Pearl of the Adriatic. Visitors can explore its medieval Old Town, walk along ancient city walls, and enjoy breathtaking views of the Adriatic Sea.",
        "Grand Canyon National Park, USA, is one of the world’s natural wonders, known for its awe-inspiring views and geological history. Visitors can hike, raft, and explore the vast landscapes of this iconic destination.",
        "Bali, Indonesia, is a tropical paradise known for its lush rice terraces, vibrant temples, and stunning beaches. Visitors can experience Balinese culture, wellness retreats, and breathtaking landscapes."
        
        
    ]
    init() {
            // Load saved data from UserDefaults or use default values
            self.bucketList = UserDefaults.standard.array(forKey: "bucketList") as? [Int] ?? []
            self.completedTrips = UserDefaults.standard.array(forKey: "completedTrips") as? [Int] ?? []
        }
}
