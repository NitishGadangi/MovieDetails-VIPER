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

## Project Folder Structure
```
.
├── LICENSE
├── MovieDetails
│   ├── AppDelegate.swift
│   ├── Constants
│   │   ├── CommonColors.swift
│   │   ├── CommonFonts.swift
│   │   └── CommonInsets.swift
│   ├── Details
│   │   ├── Components
│   │   │   ├── AdditionalDetailsCard
│   │   │   │   ├── AdditionalDetailsCardView.swift
│   │   │   │   ├── AdditionalDetailsCardViewModel.swift
│   │   │   │   └── Components
│   │   │   │       ├── AdditionalDetailsItemView.swift
│   │   │   │       └── TextIndicatorPageControl
│   │   │   │           ├── TextIndicatorItemView.swift
│   │   │   │           └── TextIndicatorPageControl.swift
│   │   │   ├── AssetCarouselCard
│   │   │   │   ├── AssetCarouselCardView.swift
│   │   │   │   ├── AssetCarouselCardViewModel.swift
│   │   │   │   └── Components
│   │   │   │       ├── CircularCornersAssetView.swift
│   │   │   │       └── CircularPageControl
│   │   │   │           ├── CircularPageControl.swift
│   │   │   │           └── CircularPageControlItemView.swift
│   │   │   ├── BasicErrorView.swift
│   │   │   ├── BasicLoaderView.swift
│   │   │   ├── CountDownTimerCard
│   │   │   │   ├── Components
│   │   │   │   │   └── TimerTextView.swift
│   │   │   │   ├── CountDownTimerCardView.swift
│   │   │   │   └── CountDownTimerCardViewModel.swift
│   │   │   ├── EmptyCollectionViewCell.swift
│   │   │   ├── SectionHeaderView.swift
│   │   │   ├── SocialProofingCard
│   │   │   │   ├── Components
│   │   │   │   │   ├── CircularImageView.swift
│   │   │   │   │   └── StackedAssetsView.swift
│   │   │   │   ├── SocialProofingCardView.swift
│   │   │   │   └── SocialProofingCardViewModel.swift
│   │   │   └── TitleLocationCard
│   │   │       ├── Components
│   │   │       │   ├── ImageTextView.swift
│   │   │       │   └── SpecialTagView.swift
│   │   │       ├── TimeLocationCardView.swift
│   │   │       └── TimeLocationCardViewModel.swift
│   │   ├── DetailsBuilder.swift
│   │   ├── Entity
│   │   │   ├── CommonModels.swift
│   │   │   ├── DetailsModels.swift
│   │   │   ├── MoviesAPIEndPoint.swift
│   │   │   └── UIModels.swift
│   │   ├── Interactor
│   │   │   ├── DetailsInteractor.swift
│   │   │   ├── DetailsInteractorIO.swift
│   │   │   └── Repository
│   │   │       ├── DetailsRepository.swift
│   │   │       └── DetailsRepositoryProtocol.swift
│   │   ├── Presenter
│   │   │   ├── DetailsPresenter.swift
│   │   │   └── DetailsPresenterIO.swift
│   │   ├── Router
│   │   │   ├── DetailsRouter.swift
│   │   │   └── DetailsRouterProtocol.swift
│   │   └── ViewController
│   │       ├── DetailsViewController.swift
│   │       └── DetailsViewControllerProtocol.swift
│   ├── Info.plist
│   └── SceneDelegate.swift
├── MovieDetails.xcodeproj
├── Packages
│   ├── CommonUtils
│   │   ├── Package.swift
│   │   ├── Sources
│   │   │   └── CommonUtils
│   │   │       ├── AnyCollectionViewCell.swift
│   │   │       ├── BaseViperUtils.swift
│   │   │       ├── Collection+Extensions.swift
│   │   │       ├── DateTimeUtils.swift
│   │   │       ├── ReusableView.swift
│   │   │       ├── RxSwift+Extensions.swift
│   │   │       ├── String+Extensions.swift
│   │   │       ├── UICollectionView+Extensions.swift
│   │   │       ├── UIColor+Extensions.swift
│   │   │       ├── UIImageView+Extensions.swift
│   │   │       ├── UIStackView+Extensions.swift
│   │   │       └── UIView+Extensions.swift
│   └── NetworkCore
│       ├── Package.swift
│       ├── Sources
│       │   └── NetworkCore
│       │       ├── Core
│       │       │   ├── EndpointType.swift
│       │       │   ├── HTTPHeaders.swift
│       │       │   ├── HTTPMethod.swift
│       │       │   ├── HTTPTask.swift
│       │       │   ├── NetworkError.swift
│       │       │   └── NetworkLogger.swift
│       │       ├── MockResponses
│       │       │   └── movie_detail_response.json
│       │       ├── NetworkManager.swift
│       │       └── Service
│       │           ├── NetworkService.swift
│       │           ├── NetworkServiceMock.swift
│       │           └── NetworkServiceable.swift
└── README.md

52 directories, 86 files
```

## Other Details will be added soon
