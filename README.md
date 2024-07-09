# About
UIKit iOS app showcasing best practices of using VIPER Architecture in Multi-Module projects.

## Walkthrow
https://github.com/NitishGadangi/MovieDetails-VIPER/assets/29014716/e653e746-6d17-421f-b269-52f0fe2a01b3

## Details
Few key details of the implementation
- Templatised UI. The arrangement of templates is fully Backend driven.
- All layers were implemented and properly integrated.
- Network layer with mock response, can be replaced with actual api and things work seamlessly.
- Network & Common Utils are added a separate modules
- Full VIPER implementation with RX subscriptions


## API Response Mock
```JSON
{
  "header": "Section Title",
  "items": [
    {
      "template_type": "asset_carousel_card",
      "assets": [
        {
          "url": "https://i.imgur.com/WGVSCWQ.jpg",
          "type": "IMAGE",
          "aspect_ratio": 1.8
        },
        {
          "url": "https://i.imgur.com/n9TGJsT.jpg",
          "type": "IMAGE",
          "aspect_ratio": 1.8
        }
      ]
    },
    {
      "template_type": "title_location_card",
      "title": "Title - Mad Max saga : Fury Road",
      "sub_title": "Body text - When the world is taken by darkness, A hero will rise.",
      "location": {
        "text": "Cinephile, Banglore",
        "asset": {
          "url": "https://i.imgur.com/BChvIFM.png",
          "type": "IMAGE",
          "aspect_ratio": 1.8
        }
      },
      "date_time": {
        "text": "8:30 PM, 28th July, Wednesday",
        "asset": {
          "url": "https://i.imgur.com/meekUTN.png",
          "type": "IMAGE",
          "aspect_ratio": 1.8
        }
      },
      "tag": "SPECIAL TAG - BLOCKBUSTER"
    },
    {
      "template_type": "countdown_timer_card",
      "end_time": 1723236441,
      "header": "Booking will close in :"
    },
    {
      "template_type": "social_proofing_card",
      "description": "Till now 10,000+ Users have already booked tickets.",
      "assets": [
        {
          "url": "https://i.imgur.com/FAcjxC9.jpg",
          "type": "IMAGE",
          "aspect_ratio": 1
        },
        {
          "url": "https://i.imgur.com/ApSECjn.png",
          "type": "IMAGE",
          "aspect_ratio": 1
        },
        {
          "url": "https://i.imgur.com/FAcjxC9.jpg",
          "type": "IMAGE",
          "aspect_ratio": 1
        },
        {
          "url": "https://i.imgur.com/ApSECjn.png",
          "type": "IMAGE",
          "aspect_ratio": 1
        },
        {
          "url": "https://i.imgur.com/FAcjxC9.jpg",
          "type": "IMAGE",
          "aspect_ratio": 1
        },
        {
          "url": "https://i.imgur.com/ApSECjn.png",
          "type": "IMAGE",
          "aspect_ratio": 1
        }
      ]
    },
    {
      "template_type": "additional_details_card",
      "details": [
        {
          "header": "About",
          "body": "A modern-day avatar of Vishnu, a Hindu god, who is believed to have descended to earth to protect the world from evil forces"
        },
        {
          "header": "Cast",
          "body": "A modern-day avatar of Vishnu, a Hindu god, who is believed to have descended to earth to protect the world from evil forces"
        },
        {
          "header": "Timings",
          "body": "A modern-day avatar of Vishnu, a Hindu god, who is believed to have descended to earth to protect the world from evil forces"
        },
        {
          "header": "Location",
          "body": "A modern-day avatar of Vishnu, a Hindu god, who is believed to have descended to earth to protect the world from evil forces"
        },
        {
          "header": "Process",
          "body": "A modern-day avatar of Vishnu, a Hindu god, who is believed to have descended to earth to protect the world from evil forces"
        }
      ]
    }
  ]
}
```

## Dependency Tree & Other Details will add soon
Will be updated
