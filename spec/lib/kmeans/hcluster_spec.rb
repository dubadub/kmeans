# -*- coding: utf-8 -*-

require File.dirname(__FILE__) + '/../../spec_helper'

describe Kmeans::HCluster do
  before :all do
    @blognames = ["The Superficial - Because You're Ugly", "Wonkette", "Publishing 2.0"]
    @data =
[[0, 1, 0, 0, 3, 3, 0, 0, 3, 0, 6, 0, 1, 0, 4, 3, 0, 0, 0, 0, 0, 4, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 2, 0, 1, 1, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 4, 0, 0, 0, 2, 0, 2, 0, 0, 0, 1, 3, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 5, 1, 0, 0, 3, 0, 0, 0, 0, 1, 5, 0, 0, 2, 1, 0, 1, 2, 1, 0, 0, 0, 5, 0, 3, 0, 0, 0, 1, 0, 2, 2, 0, 3, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 3, 1, 0, 0, 4, 0, 1, 0, 1, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 3, 0, 2, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 2, 1, 2, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 21, 2, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 5, 0, 1, 0, 0, 2, 0, 0, 0, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 3, 0, 0, 0, 2, 2, 0, 0, 0, 0, 1, 0, 1, 0, 2, 3, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 24, 1, 0, 1, 0, 0, 0, 1, 9, 0, 1, 1, 3, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 0, 0, 0, 0, 3, 3, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 4, 0, 1, 1, 0, 1, 2, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 2, 0, 0, 3, 0, 0, 1, 1, 0, 0, 3, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 5, 1, 0, 0, 0, 1, 0, 0, 0, 2, 2, 0, 0, 1, 2, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 2, 4, 1, 1, 0, 0, 2, 0, 2, 1, 1, 0, 0, 1, 5, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 4, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 3, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 5, 1, 4, 0, 0, 2, 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 1, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 2, 1, 3, 0, 0, 0, 0, 2, 0, 0, 2, 0, 9, 2, 0], [0, 2, 1, 0, 6, 2, 1, 0, 4, 5, 25, 0, 0, 0, 6, 12, 4, 2, 1, 4, 0, 3, 0, 1, 1, 3, 4, 0, 2, 0, 4, 3, 2, 1, 4, 0, 3, 3, 2, 12, 0, 1, 6, 4, 0, 0, 0, 0, 2, 1, 0, 0, 7, 2, 7, 2, 3, 5, 0, 0, 12, 0, 2, 10, 2, 2, 2, 0, 1, 9, 1, 0, 3, 1, 3, 5, 0, 6, 2, 2, 2, 1, 1, 0, 0, 2, 0, 0, 0, 2, 3, 2, 3, 5, 3, 6, 1, 2, 1, 4, 11, 0, 0, 4, 3, 1, 0, 3, 7, 2, 1, 1, 0, 8, 1, 6, 7, 0, 0, 0, 8, 5, 1, 0, 2, 2, 4, 0, 9, 0, 4, 2, 2, 2, 1, 0, 1, 0, 3, 1, 20, 6, 9, 1, 0, 2, 0, 9, 2, 5, 0, 1, 0, 0, 0, 1, 4, 13, 0, 2, 2, 0, 2, 1, 0, 0, 0, 6, 2, 1, 10, 1, 2, 3, 2, 7, 1, 2, 5, 1, 1, 1, 4, 0, 0, 6, 3, 7, 0, 2, 0, 3, 2, 2, 0, 4, 1, 1, 0, 16, 1, 2, 1, 3, 2, 7, 0, 0, 0, 3, 0, 5, 0, 1, 2, 4, 5, 3, 0, 4, 1, 16, 1, 2, 2, 1, 2, 5, 0, 3, 2, 0, 2, 0, 2, 1, 0, 3, 0, 2, 1, 4, 0, 6, 0, 3, 9, 2, 1, 2, 3, 4, 6, 1, 4, 1, 4, 2, 7, 0, 1, 0, 2, 4, 16, 2, 0, 5, 0, 1, 3, 0, 8, 1, 3, 7, 3, 2, 1, 2, 0, 4, 3, 0, 1, 2, 15, 10, 2, 2, 1, 6, 5, 1, 1, 1, 3, 0, 0, 8, 3, 1, 0, 0, 3, 6, 6, 1, 0, 1, 3, 2, 10, 0, 0, 0, 1, 1, 0, 5, 1, 2, 16, 2, 0, 2, 7, 2, 0, 6, 0, 4, 1, 0, 3, 1, 0, 2, 0, 0, 0, 3, 1, 1, 8, 0, 0, 2, 7, 1, 1, 5, 0, 1, 0, 0, 0, 7, 5, 1, 0, 2, 3, 5, 28, 0, 1, 1, 2, 5, 23, 2, 3, 0, 2, 0, 1, 2, 14, 0, 5, 0, 7, 3, 5, 0, 1, 3, 2, 5, 4, 0, 5, 0, 0, 3, 3, 1, 1, 1, 1, 0, 8, 0, 3, 3, 1, 9, 1, 3, 0, 1, 8, 0, 2, 1, 2, 4, 18, 9, 0, 2, 5, 4, 2, 0, 3, 0, 6, 0, 1, 0, 3, 1, 1, 3, 1, 0, 0, 8, 4, 12, 2, 2, 9, 3, 1, 2, 0, 0, 3, 0, 0, 1, 0, 3, 3, 2, 5, 0, 8, 6, 9, 10, 1, 5, 3, 2, 0, 1, 2, 3, 1, 2, 0, 0, 0, 4, 8, 3, 0, 0, 2, 0, 5, 3, 1, 2, 0, 2, 0, 1, 0, 2, 4, 11, 6, 1, 0, 6, 3, 0, 2, 0, 0, 4, 5, 0, 2, 0, 0, 5, 0, 0, 1, 0, 3, 0, 0, 1, 9, 6, 0, 9, 0, 3, 0, 1, 1, 3, 7, 1, 0, 3, 1, 7, 2, 9, 0, 0, 2, 1, 0, 3, 0, 8, 10, 6, 1, 2, 6, 5, 2, 3, 6, 0, 2, 0, 11, 7, 1, 3, 2, 3, 0, 1, 3, 0, 0, 0, 0, 5, 0, 6, 3, 4, 0, 1, 2, 0, 1, 1, 5, 5, 0, 3, 8, 6, 0, 1, 4, 0, 1, 0, 0, 4, 0, 0, 0, 0, 0, 0, 2, 3, 0, 0, 6, 4, 0, 0, 1, 2, 3, 0, 2, 2, 3, 1, 2, 4, 0, 1, 2, 2, 0, 1, 2, 6, 2, 4, 2, 3, 4, 2, 2, 0, 3, 2, 7, 3, 0, 1, 0, 1, 0, 4, 0, 0, 3, 0, 8, 0, 0, 7, 3, 1, 3, 2, 12, 0, 1, 2, 0, 1, 0, 2, 1, 3, 4, 3, 0, 5, 2, 0, 0, 2, 12, 1, 2, 4, 1, 2, 1, 0, 0, 2, 9, 1, 2, 1, 5, 3, 1, 5, 0, 2, 4, 0, 2, 0, 0, 4, 3, 19, 8, 7], [0, 0, 7, 4, 0, 1, 3, 6, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 4, 0, 0, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 5, 0, 1, 1, 1, 3, 0, 0, 13, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 1, 0, 0, 1, 0, 0, 1, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 3, 2, 0, 0, 0, 0, 2, 1, 0, 2, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 2, 0, 0, 1, 0, 6, 0, 0, 3, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 3, 2, 0, 0, 3, 1, 0, 0, 0, 0, 1, 0, 1, 0, 2, 0, 0, 0, 0, 2, 1, 0, 0, 0, 1, 0, 1, 1, 1, 3, 0, 1, 0, 0, 2, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 21, 0, 2, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 1, 0, 0, 2, 1, 0, 0, 1, 9, 0, 0, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 0, 1, 0, 7, 1, 1, 1, 0, 1, 3, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 2, 2, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 1, 0, 0, 2, 0, 1, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 2, 0, 0, 1, 0, 0, 0, 0, 2, 1, 0, 0, 0, 1, 0, 1, 2, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 1, 0, 1, 1, 0, 0, 4, 0, 0, 0, 1, 1, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 2, 0, 0, 1, 0, 2, 0, 2, 4, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 2, 1, 1, 0, 0, 0, 3, 0, 0, 1, 1, 0, 1, 3, 0, 0, 0, 0, 0, 0, 1, 0, 4, 0, 0, 0, 0, 0, 0, 2, 1, 0, 0, 1, 3, 0, 6, 1, 0, 0, 1, 6, 0, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0, 1, 0, 4, 0, 4, 2, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 6, 0, 0, 1, 2, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 11, 0, 0, 0, 0, 1, 1, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 3, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 4, 0, 0, 0, 0, 0, 0]]
  end

  context 'の HCluster クラスにおいて' do
    describe '二次元配列を渡すと' do
      it "Kmeans::Bicluster クラスが返却される" do
        cs = Kmeans::HCluster.new
        clust = cs.hcluster(@data)
        clust.class.should == Kmeans::Bicluster
      end
    end
  end

  context 'の HCluster クラスにおいて' do
    describe 'printclust メソッドを呼ぶと' do
      it "クラスタの中身が返却される" do
        cs = Kmeans::HCluster.new
        clust = cs.hcluster(@data)
        out = cs.printclust(clust, @blognames)
        out.should ==
"-
 Publishing 2.0
 -
  The Superficial - Because You're Ugly
  Wonkette
"
      end
    end
  end
  context 'の HCluster クラスにおいて' do
    describe 'printclust メソッドを呼ぶと' do
      it "クラスタの中身が返却される" do
        cs = Kmeans::HCluster.new
        blognames,words,data = readline(File.join(File.dirname(__FILE__),
          '..', '..', 'fixtures', 'blogdata.txt'))

        clust = cs.hcluster(data)
        out = cs.printclust(clust, blognames)
        out.should ==
"-\n -\n  Topix.net Weblog\n  The Blotter\n -\n  gapingvoid: \"cartoons drawn on the back of business cards\"\n  -\n   -\n    Schneier on Security\n    Instapundit.com\n   -\n    43 Folders\n    -\n     TechEBlog\n     -\n      -\n       Bloglines | News\n       -\n        Oilman\n        -\n         Online Marketing Report\n         -\n          Treehugger\n          -\n           SimpleBits\n           -\n            Cool Hunting\n            -\n             Steve Pavlina's Personal Development Blog\n             -\n              -\n               ScienceBlogs : Combined Feed\n               Pharyngula\n              -\n               BuzzMachine\n               -\n                Copyblogger\n                -\n                 -\n                  The Viral Garden\n                  Seth's Blog\n                 -\n                  -\n                   Bloggers Blog: Blogging the Blogsphere\n                   -\n                    Sifry's Alerts\n                    ProBlogger Blog Tips\n                  -\n                   -\n                    Valleywag\n                    Scobleizer - Tech Geek Blogger\n                   -\n                    -\n                     O'Reilly Radar\n                     456 Berea Street\n                    -\n                     Lifehacker\n                     -\n                      Quick Online Tips\n                      -\n                       Publishing 2.0\n                       -\n                        Micro Persuasion\n                        -\n                         A Consuming Experience (full feed)\n                         -\n                          John Battelle's Searchblog\n                          -\n                           Search Engine Watch Blog\n                           -\n                            Read/WriteWeb\n                            -\n                             Official Google Blog\n                             -\n                              Search Engine Roundtable\n                              -\n                               Google Operating System\n                               Google Blogoscoped\n      -\n       -\n        Slashdot\n        -\n         MAKE Magazine\n         Boing Boing\n       -\n        -\n         Mashable!\n         Signum sine tinnitu--by Guy Kawasaki\n        -\n         Wired News: Top Stories\n         -\n          -\n           flagrantdisregard\n           -\n            WWdN: In Exile\n            -\n             Derek Powazek\n             -\n              lifehack.org\n              Dave Shea's mezzoblue\n          -\n           -\n            -\n             -\n              Blog Maverick\n              -\n               Download Squad\n               -\n                CoolerHeads Prevail\n                -\n                 Joystiq\n                 The Unofficial Apple Weblog (TUAW)\n             -\n              Autoblog\n              -\n               Engadget\n               TMZ.com\n            -\n             -\n              PaulStamatiou.com\n              -\n               -\n                GigaOM\n                TechCrunch\n               -\n                -\n                 Techdirt\n                 Creating Passionate Users\n                -\n                 Joho the Blog\n                 -\n                  -\n                   PerezHilton.com\n                   Jeremy Zawodny's blog\n                  -\n                   Joi Ito's Web\n                   -\n                    ongoing\n                    -\n                     Joel on Software\n                     -\n                      -\n                       we make money not art\n                       -\n                        plasticbag.org\n                        -\n                         Signal vs. Noise\n                         -\n                          kottke.org\n                          -\n                           Neil Gaiman's Journal\n                           -\n                            -\n                             The Huffington Post | Raw Feed\n                             -\n                              Wonkette\n                              -\n                               Gawker\n                               -\n                                The Superficial - Because You're Ugly\n                                Go Fug Yourself\n                            -\n                             Deadspin\n                             Gothamist\n                      -\n                       Kotaku\n                       Gizmodo\n             -\n              Shoemoney - Skills to pay the bills\n              Matt Cutts: Gadgets, Google, and SEO\n           -\n            MetaFilter\n            -\n             SpikedHumor\n             -\n              Captain's Quarters\n              -\n               Michelle Malkin\n               -\n                -\n                 NewsBusters.org - Exposing Liberal Media Bias\n                 -\n                  -\n                   Hot Air\n                   Crooks and Liars\n                  -\n                   Power Line\n                   Think Progress\n                -\n                 Andrew Sullivan | The Daily Dish\n                 -\n                  Little Green Footballs\n                  -\n                   Eschaton\n                   -\n                    Talking Points Memo: by Joshua Micah Marshall\n                    Daily Kos\n"
      end
    end
  end
end