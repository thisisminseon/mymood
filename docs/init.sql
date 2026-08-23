-- =====================================================
-- MyMood 初期データベース構築スクリプト
-- 更新: 2026-08-23
-- 使い方: mysql -u root -p < init.sql
-- =====================================================

CREATE DATABASE IF NOT EXISTS mymood
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_general_ci;

USE mymood;

DROP TABLE IF EXISTS t_order;
DROP TABLE IF EXISTS t_review;
DROP TABLE IF EXISTS m_user;
DROP TABLE IF EXISTS m_product;

CREATE TABLE m_product (
  id          VARCHAR(10)  NOT NULL,
  name        VARCHAR(100) NOT NULL,
  price       INT          NOT NULL,
  category    VARCHAR(20)  NOT NULL,
  image_file  VARCHAR(100),
  description TEXT,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE m_user (
  userid     VARCHAR(20)  NOT NULL,
  password   VARCHAR(100) NOT NULL,
  nickname   VARCHAR(50),
  status     VARCHAR(10)  NOT NULL DEFAULT 'active',
  is_admin   TINYINT(1)   NOT NULL DEFAULT 0,
  created_at DATETIME     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (userid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE t_review (
  review_id  INT          NOT NULL AUTO_INCREMENT,
  product_id VARCHAR(10)  NOT NULL,
  userid     VARCHAR(20)  NOT NULL,
  rating     INT          NOT NULL,
  comment    TEXT,
  created_at DATETIME     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (review_id),
  FOREIGN KEY (product_id) REFERENCES m_product(id),
  FOREIGN KEY (userid)     REFERENCES m_user(userid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE t_order (
  order_id   INT          NOT NULL AUTO_INCREMENT,
  order_no   VARCHAR(20)  NOT NULL,
  userid     VARCHAR(20)  NOT NULL,
  product_id VARCHAR(10)  NOT NULL,
  price      INT          NOT NULL,
  hidden     TINYINT(1)   NOT NULL DEFAULT 0,
  ordered_at DATETIME     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (order_id),
  FOREIGN KEY (userid)     REFERENCES m_user(userid),
  FOREIGN KEY (product_id) REFERENCES m_product(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- デモデータ
--   管理者 admin / admin1234
--   一般   tanaka / pass1234
-- =====================================================

INSERT INTO m_product (id, name, price, category, image_file, description) VALUES
('P001','コットンフードビッグシルエットブルゾン',8900,'outer','outer01.png','ゆったりとしたシルエットのコットンブルゾン。フードで顔まわりをすっきり見せます。'),
('P002','ハイネックバックル ショートトレンチジャケット',13800,'outer','outer02.png','襟を立てても抜け感が出るショート丈のトレンチ。バックルで印象を変えられます。'),
('P003','厚手ニットジップアップカーディガン',7900,'outer','outer03.png','肉厚のニット素材で一枚でも暖かい。羽織りとしても使える万能カーディガン。'),
('P004','サマースクエアネック ノースリーブブラウス',4200,'tops','tops01.png','スクエアネックが鎖骨をきれいに見せる夏向けブラウス。涼しい素材感です。'),
('P005','ドットレタリングプリント イエローTシャツ',3200,'tops','tops02.png','鮮やかなイエローにドットとレタリングをのせたカジュアルT。コーデの主役に。'),
('P006','長袖レイヤードTシャツ',3800,'tops','tops03.png','重ね着風に見えるデザインの長袖T。一枚でこなれた印象になります。'),
('P007','フリルタイブラウス',5400,'tops','tops04.png','首元のフリルタイが上品な印象のブラウス。オフィスにも使えます。'),
('P008','チェックリボン半袖ブラウス',4800,'tops','tops05.png','小さめチェックにリボンをあしらった半袖ブラウス。甘さ控えめの配色です。'),
('P009','ボーダーオーバーサイズニット',5900,'tops','tops06.png','太めのボーダーがかわいいオーバーサイズニット。体型を拾いにくいシルエット。'),
('P010','カーゴワイドパンツ',6800,'bottoms','bottoms01.png','ポケット付きのカーゴデザイン。ワイドシルエットで動きやすい一本です。'),
('P011','レースラップスカート',5900,'bottoms','bottoms02.png','裾のレースが揺れるラップスカート。歩くたびに表情が変わります。'),
('P012','アンバランスレイヤードスカート',6400,'bottoms','bottoms03.png','裾の長さに変化をつけたレイヤードデザイン。シンプルなトップスと好相性。'),
('P013','ブーツカットデニムパンツ',7200,'bottoms','bottoms04.png','脚のラインをきれいに見せるブーツカット。定番として長く使えます。'),
('P014','ライトステッチワイドデニム',7600,'bottoms','bottoms05.png','明るいステッチがアクセントのワイドデニム。カジュアルにも上品にも。'),
('P015','フラワーミニワンピース',6200,'onepiece','onepiece01.png','小花柄のミニワンピース。一枚でコーデが完成します。'),
('P016','ヴィンテージフラワービスチェワンピース',8400,'onepiece','onepiece02.png','ビスチェ風の切り替えとヴィンテージ調の花柄が印象的な一着。'),
('P017','グリーンヴィンテージフラワーワンピース',7800,'onepiece','onepiece03.png','落ち着いたグリーンにヴィンテージフラワー。大人っぽい雰囲気に。'),
('P018','マフラー付きフレアワンピース',8900,'onepiece','onepiece04.png','共布のマフラーが付いたフレアワンピース。巻き方で印象を変えられます。'),
('P019','シアサッカー半袖ワンピース',6600,'onepiece','onepiece05.png','凹凸のあるシアサッカー素材で肌に張り付きにくい。夏の定番です。'),
('P020','ポケット付きネイビーシャツワンピース',7400,'onepiece','onepiece06.png','きちんと感のあるネイビーのシャツワンピース。羽織りとしても使えます。'),
('P021','リボンフラットシューズ',6800,'shoes','shoes01.png','甲のリボンが上品なフラットシューズ。長時間歩いても疲れにくい設計。'),
('P022','ドットリボンスクエアトゥパンプス',7900,'shoes','shoes02.png','スクエアトゥで足元をすっきり見せるパンプス。ドットリボンがアクセント。'),
('P023','レースアップスニーカー',9800,'shoes','shoes03.png','どんな服にも合わせやすいシンプルなレースアップスニーカー。'),
('P024','フラワージェリーサンダル',3900,'shoes','shoes04.png','水にぬれても大丈夫なジェリー素材。夏のお出かけにぴったりです。'),
('P025','スター火山石ネックレス',3400,'accessory','accessory01.png','火山石とスターモチーフを合わせたネックレス。シンプルな服のアクセントに。'),
('P026','ユニセックス ブルーキャップ',3800,'accessory','accessory02.png','男女問わず使えるベーシックなキャップ。深めのかぶり心地です。'),
('P027','ヴィンテージニット帽',3200,'accessory','accessory03.png','くったりとした風合いのニット帽。かぶるだけで雰囲気が出ます。'),
('P028','シンプルフラワーレイヤードブレスレット',2800,'accessory','accessory04.png','小さな花モチーフの重ねづけブレスレット。手元をさりげなく飾ります。'),
('P029','シルバーリボンネックレス',2900,'accessory','accessory05.png','細身のシルバーチェーンにリボンをあしらった上品なネックレス。');

INSERT INTO m_user (userid, password, nickname, status, is_admin, created_at) VALUES
('admin','admin1234','管理者','active',1,'2026-08-01 10:00:00'),
('sato','pass1234','さとう','withdrawn',0,'2026-08-19 18:40:00'),
('suzuki','pass1234','すずき','suspended',0,'2026-08-21 09:15:00'),
('tanaka','pass1234','たなか','active',0,'2026-08-20 14:30:00'),
('yamada','1234','ヤマダ','active',0,'2026-08-23 11:33:31');

INSERT INTO t_review (product_id, userid, rating, comment, created_at) VALUES
('P001','suzuki',3,'暖かいですが、少し重いのが気になりました。','2026-08-22 16:55:00'),
('P005','tanaka',5,'生地がしっかりしていて、洗濯しても型崩れしませんでした。','2026-08-21 11:20:00'),
('P005','suzuki',4,'サイズ感がちょうど良かったです。色違いも買いたい。','2026-08-21 15:05:00'),
('P013','tanaka',4,'思ったより丈が長めでしたが、履き心地は良いです。','2026-08-22 09:40:00'),
('P023','tanaka',5,'軽くて歩きやすいです。合わせやすい色で満足。','2026-08-22 13:10:00');

INSERT INTO t_order (order_no, userid, product_id, price, ordered_at) VALUES
('20260821-152000','tanaka','P001',8900,'2026-08-21 15:20:00'),
('20260821-152000','tanaka','P005',3200,'2026-08-21 15:20:00'),
('20260822-210500','tanaka','P007',5400,'2026-08-22 21:05:00');

-- =====================================================
-- 確認
-- =====================================================
SELECT category, COUNT(*) AS cnt FROM m_product GROUP BY category;
SELECT userid, nickname, status, is_admin FROM m_user;

SELECT order_no, userid, product_id, price, hidden FROM t_order ORDER BY ordered_at;