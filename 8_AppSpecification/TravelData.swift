//
//  Untitled.swift
//  8_AppSpecification
//
//  Created by user267360 on 11/28/24.
//

import SwiftUI

class TravelData: ObservableObject {
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
        ["tokyo_1"]
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
    
    @Published var completedTrips: [Int] = [3, 4, 5, 6, 7]
    @Published var favorites: Set<Int> = []
    @Published var bucketList: [Int] = [0, 8, 9, 10, 11]
    
    
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
        "Tokyo, Japan, is a bustling metropolis blending modern technology and ancient traditions. Famous for its vibrant neighborhoods like Shibuya and Harajuku, Tokyo also boasts serene temples, beautiful gardens, and world-class cuisine."
    ]}
