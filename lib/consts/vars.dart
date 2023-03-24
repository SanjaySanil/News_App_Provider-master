import 'package:flutter/material.dart';

enum NewsType {
  topTrending,
  allNews,
}

enum SortByEnum {
  relevancy, // articles more closely related to q come first.
  popularity, // articles from popular sources and publishers come first.
  publishedAt, // newest articles come first.
}

const List<String> searchKeywords = [
  "Startups",
  "Flutter",
  "Python",
  "Weather",
  "Crypto",
  "Bitcoin",
  "Youtube",
  "Netflix",
  "Meta"
];

List blogContent = [
  {
    'image':
        'https://akm-img-a-in.tosshub.com/indiatoday/images/story/202302/rupee_rep-sixteen_nine.jpg?VersionId=PWzVot2cB09QBZ8ANHw2umCHmNMM5Ie3&size=690:388',
    'title':
        'Centre likely to hike dearness allowance for staffers, pensioners by 4% to 42%',
    'link':
        'https://www.indiatoday.in/business/story/centre-likely-to-hike-dearness-allowance-for-staffers-pensioners-by-4-to-42-2330697-2023-02-05',
  },
  {
    'image':
        'https://akm-img-a-in.tosshub.com/indiatoday/images/story/202302/bmccommissioneriqbal-sixteen_nine.jpeg?VersionId=WiH7IzjXH3d1C_IffaNBo3fcQx1uowIQ&size=690:388',
    'title':
        'Good news for Mumbaikars! No extra tax imposed, capital expenditure hiked to 52%',
    'link':
        'https://www.indiatoday.in/business/story/mumbai-civic-body-bmc-levied-no-new-tax-mumbaikars-will-tap-fixed-deposits-for-projects-2330534-2023-02-04',
  },
  {
    'image':
        'https://akm-img-a-in.tosshub.com/indiatoday/images/story/202302/sebi-_3.jpeg?VersionId=iLgZQoxwnZ9W1Y_E9YhLe_XrARQJaKdD&size=690:388',
    'title':
        'Committed to ensuring market integrity, measures in place to address volatility: Sebi',
    'link':
        'https://www.indiatoday.in/business/story/sebi-committed-ensure-market-integrity-adani-group-shares-plunge-2330465-2023-02-04',
  },
  {
    'image':
        'https://akm-img-a-in.tosshub.com/indiatoday/images/story/202302/niramala_sitharaman-sixteen_nine.jpg?VersionId=8C7KMgHQe8M15I9pvtgQfOeMQYAE28j6&size=690:388',
    'title':
        "India's fundamentals, economic image not affected: Sitharaman on Adani Group FPO pullout",
    'link':
        'https://www.indiatoday.in/business/story/fpos-come-and-go-regulators-doing-their-job-fm-sitharaman-adani-group-stock-rout-2330439-2023-02-04',
  },
  {
    'image':
        'https://akm-img-a-in.tosshub.com/indiatoday/images/story/202302/gates-musk-sixteen_nine.jpg?VersionId=8tLuauFkr_3MUuEVcbX799Szx.ukKNAH&size=690:388',
    'title':
        'Bill Gates takes a dig at Elon Musk, prefers making vaccines instead of going to Mars',
    'link':
        'https://www.indiatoday.in/technology/news/story/bill-gates-takes-a-dig-at-elon-musk-prefers-making-vaccines-instead-of-going-to-mars-2330605-2023-02-05',
  }
];

List<DropdownMenuItem<String>> get dropDownItems {
  List<DropdownMenuItem<String>> menuItem = [
    DropdownMenuItem(
      value: SortByEnum.popularity.name,
      child: Text(SortByEnum.popularity.name),
    ),
    DropdownMenuItem(
      value: SortByEnum.relevancy.name,
      child: Text(SortByEnum.relevancy.name),
    ),
    DropdownMenuItem(
      value: SortByEnum.publishedAt.name,
      child: Text(SortByEnum.publishedAt.name),
    ),
  ];
  return menuItem;
}
