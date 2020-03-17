//
//  ViewController.swift
//  experimentvideoslider
//
//  Created by Est Rouge on 1/8/20.
//  Copyright © 2020 ThaoPN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var videosSliderView: VideosSliderView!
    
    lazy var medias: [MediaObject] = {
        return makeFakeData()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        videosSliderView.datasource = self
    }

    private func makeFakeData() -> [MediaObject] {
        let urlStrings = [
            "https://image.isu.pub/131111123920-1754baee39f623867cc9a5c52d01d7fd/jpg/page_1.jpg"
            ,"https://i.ytimg.com/vi/KF7-b7EhJvE/maxresdefault.jpg"
            ,"https://shop.r10s.jp/e-monhiroba/cabinet/eemon_h/190703asuraku.jpg"
            ,"https://static.yukoyuko.net/images/new-hotel/201812.jpg"
            ,"https://www.homemate-research.com/pubuser1/pubuser_facility_img/0/6/0/14092747060/0000001723/14092747060_0000001723_4.jpg"
            ,"https://static.retrip.jp/spot/ad318f2e-bc73-43be-8fa3-07589f5f8a14/images/380c8ff5-2027-4843-831f-06b4fc2343fa_l.jpg"
            ,"https://static.retrip.jp/spot/010e7509-184c-4911-b14d-688cd330050d/images/648128d6-5d7d-4b03-8435-14b22750c912_l.jpg"
            ,"https://media-cdn.tripadvisor.com/media/photo-m/1280/16/09/5d/e6/hazeleyes125.jpg"
            ,"https://scontent-hkg3-1.cdninstagram.com/v/t51.2885-15/e35/s1080x1080/70630462_1147018988829063_9033937118559166068_n.jpg?_nc_ht=scontent-hkg3-1.cdninstagram.com&_nc_cat=103&oh=ad5fbc218e322e0574702d6f5384ce60&oe=5E7266F5"
            ,"https://scontent-hkg3-1.cdninstagram.com/v/t51.2885-15/e35/12132834_1496588877305471_553450391_n.jpg?_nc_ht=scontent-hkg3-1.cdninstagram.com&_nc_cat=111&oh=4866e1448b047ea006dd1db2cd7efb6f&oe=5E675965"
            ,"https://scontent-hkg3-1.cdninstagram.com/v/t51.2885-15/e35/75324274_424976855077119_8418210592810160320_n.jpg?_nc_ht=scontent-hkg3-1.cdninstagram.com&_nc_cat=103&oh=72fb7e98dd8fa0572f30b4c19a22a52d&oe=5E673478"
            ,"https://static.retrip.jp/spot/fc6d816a-acb1-44cf-a777-2a4d9786936a/images/8e3bbdf1-49aa-4c32-90c3-97dafb53400f_l.jpg"
            ,"https://www.depot-island.co.jp/depotisland/wp-content/uploads/2017/11/5dc624cbda88bd3ed22cd3afe5a7d636-1200x1101.jpg"
            ,"http://okinawa-realguide.com/wp-content/uploads/2018/10/pork-egg-rice-ball-head-office_shrimp2-e1539765378252.jpg"
            ,"https://4.bp.blogspot.com/-HUTyB8-zLWQ/WetfaVlEfHI/AAAAAAAFCMg/Kb2WqHSjyZ4nH95iP6gdJkVlXRcK2EmXACLcBGAs/s1600/DSC05941.jpg"
            ,"https://1.bp.blogspot.com/-Oe9l1sOZ3K0/WetfYGLIVKI/AAAAAAAFCMM/HPlj9wijocoI_9w57d9xjtEmLAzkWCc1gCLcBGAs/s1600/DSC05928.jpg"
            ,"https://ximg.retty.me/resize/s880x880/-/retty/img_repo/l/01/2632868.jpg"
            ,"https://scontent-hkg3-1.cdninstagram.com/v/t51.2885-15/e35/s1080x1080/70630462_1147018988829063_9033937118559166068_n.jpg?_nc_ht=scontent-hkg3-1.cdninstagram.com&_nc_cat=103&oh=ad5fbc218e322e0574702d6f5384ce60&oe=5E7266F5"
            ,"https://tristatepregnancycenter.org/templates/g5_brighton/custom/images/logo-stock-2.png"
            ,"https://lucida.cc/wp-content/uploads/2018/03/DSC00328.jpg"
            ,"https://cdn.jalan.jp/jalan/images/pict3L/Y2/Y354832/Y354832583.jpg"
            ,"https://yukotabi.static.yukoyuko.net/wp-content/uploads/2019/04/17212855/cc953fe85c4bf0e16ada096c90638ab7.jpg"
            ,"https://www.jalan.net/jalan/img/6/kuchikomi/5126/KXL/be143_0005126991_1.jpg"
            ,"https://static.retrip.jp/spot/ad318f2e-bc73-43be-8fa3-07589f5f8a14/images/380c8ff5-2027-4843-831f-06b4fc2343fa_l.jpg"
            ,"https://static.retrip.jp/spot/010e7509-184c-4911-b14d-688cd330050d/images/648128d6-5d7d-4b03-8435-14b22750c912_l.jpg"
            ,"https://tidakankan.jp/wp-content/uploads/2018/12/7CAB6311-6E43-4647-B4FA-BC66678111AA-1024x768.jpeg"
            ,"https://pbs.twimg.com/media/DkokxF7U4AEYNFs.jpg"
            ,"https://tidakankan.jp/wp-content/uploads/2018/12/0E2429DE-8F38-4420-8047-502BB48625E0-1024x768.jpeg"
            ,"https://ryukyu.link/wp/wp-content/uploads/2019/11/ryukyu_okinawa-nago-higashisyokudou_0-1534x864.jpg"
            ,"https://pbs.twimg.com/media/DjF3HC1V4AEJfxx.jpg"
            ,"https://tagoo.jp/docs/wp-content/uploads/2017/09/1505976069788.jpg"
            ,"https://scontent-hkg3-1.cdninstagram.com/v/t51.2885-15/e35/s1080x1080/70630462_1147018988829063_9033937118559166068_n.jpg?_nc_ht=scontent-hkg3-1.cdninstagram.com&_nc_cat=103&oh=ad5fbc218e322e0574702d6f5384ce60&oe=5E7266F5"
            ,"https://scontent-hkg3-1.cdninstagram.com/v/t51.2885-15/e35/12132834_1496588877305471_553450391_n.jpg?_nc_ht=scontent-hkg3-1.cdninstagram.com&_nc_cat=111&oh=4866e1448b047ea006dd1db2cd7efb6f&oe=5E675965"
            ,"https://scontent-hkg3-1.cdninstagram.com/v/t51.2885-15/e35/75324274_424976855077119_8418210592810160320_n.jpg?_nc_ht=scontent-hkg3-1.cdninstagram.com&_nc_cat=103&oh=72fb7e98dd8fa0572f30b4c19a22a52d&oe=5E673478"
            ,"https://tidakankan.jp/wp-content/uploads/2018/12/7CAB6311-6E43-4647-B4FA-BC66678111AA-1024x768.jpeg"
            ,"https://pbs.twimg.com/media/DkokxF7U4AEYNFs.jpg"
            ,"https://m.niwaka.com/s/img/store/shinjyuku-satellite/main.jpg"
            ,"https://www.sunroute.jp/common2/img/map/hotel_koshinetsu_hokuriku.png"
            ,"https://static.retrip.jp/spot/643155b4-8de4-4746-952b-4228a6ddb955/images/f948a24c-dc86-4f2e-a82e-73dce77e2bc0_l.jpg"
            ,"https://www.jalan.net/jalan/img/0/spot/0300/KXL/foomoojH000300110_1.jpg"
            ,"https://cdn.jalan.jp/jalan/img/3/kuchikomi/5123/KXL/3f941_0005123536_2.jpeg"
            ,"https://static.retrip.jp/spot/ad318f2e-bc73-43be-8fa3-07589f5f8a14/images/380c8ff5-2027-4843-831f-06b4fc2343fa_l.jpg"
            ,"https://static.retrip.jp/spot/010e7509-184c-4911-b14d-688cd330050d/images/648128d6-5d7d-4b03-8435-14b22750c912_l.jpg"
            ,"https://m.niwaka.com/s/img/store/shinjyuku-satellite/main.jpg"
            ,"https://cdn.4travel.jp/img/tcs/t/pict/src/30/25/57/src_30255739.jpg?1379674940"
            ,"https://www.sunroute.jp/common2/img/map/hotel_koshinetsu_hokuriku.png"
            ,"https://static.retrip.jp/spot/643155b4-8de4-4746-952b-4228a6ddb955/images/f948a24c-dc86-4f2e-a82e-73dce77e2bc0_l.jpg"
            ,"https://www.jalan.net/jalan/img/0/spot/0300/KXL/foomoojH000300110_1.jpg"
            ,"https://cdn.jalan.jp/jalan/img/3/kuchikomi/5123/KXL/3f941_0005123536_2.jpeg"
            ,"https://static.retrip.jp/spot/a64ecde8-65db-46a9-8073-f9ec95a39a29/images/fb4f01b6-5598-4320-9807-b2cae0cb34e4_l.jpg"
            ,"https://media-cdn.tripadvisor.com/media/photo-s/04/4b/2d/fb/jakkisutekihausu.jpg"
            ,"https://media-cdn.tripadvisor.com/media/photo-s/04/4b/c3/36/jakkisutekihausu.jpg"
            ,"https://static.retrip.jp/spot/28f0f11c-c825-4484-82a5-52c3a729f583/images/2ee26219-ad89-4ff1-8e14-33650a4f444b_l.jpg"
            ,"http://img-cdn.guide.travel.co.jp/article/29/20160918215419/5A9A70F1436943E68F30ED9C68E473B9_LL.jpg"
            ,"https://pix10.agoda.net/hotelImages/241/241099/241099_15020908430025198433.jpg?s=1024x768"
            ,"https://scontent-hkg3-1.cdninstagram.com/v/t51.2885-15/e35/s1080x1080/70630462_1147018988829063_9033937118559166068_n.jpg?_nc_ht=scontent-hkg3-1.cdninstagram.com&_nc_cat=103&oh=ad5fbc218e322e0574702d6f5384ce60&oe=5E7266F5"
            ,"https://scontent-hkg3-1.cdninstagram.com/v/t51.2885-15/e35/12132834_1496588877305471_553450391_n.jpg?_nc_ht=scontent-hkg3-1.cdninstagram.com&_nc_cat=111&oh=4866e1448b047ea006dd1db2cd7efb6f&oe=5E675965"
        ]
        
        let urls = urlStrings.map { return URL(string: $0) }.compactMap { $0 }
        
        var medias = [MediaObject]()
        for url in urls {
            let media = MediaObject(url, type: .image)
            medias.append(media)
        }
        
        return medias
    }
}

extension ViewController: VideosSliderViewDataSource {
    func numberOfItems() -> Int {
        return 1
    }
    
    func videosSliderView(_ videosSliderView: VideosSliderView, index: Int) -> [MediaObject] {
        return medias
    }
    
    func getMedias() -> [MediaObject] {
        return makeFakeData()
    }
}
