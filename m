Received: from r9214.ps.combzmail.jp (r9214.ps.combzmail.jp [160.16.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC297262E
	for <linux-security-module@vger.kernel.org>; Mon,  9 Mar 2026 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.16.66.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773027189; cv=none; b=uv5kInD1AucsrgpJ78itjqCbGwD6eT+leK9WIoKRLxtGrhv0f9D/Xe6VSYwm2KHzxB2MZYoMLf7s9j3JOrSIk6AidgL0ywOuFcAAcuAuO/+iXG5Xv9p2qQvBWcVGFoncAhsVqjxtl8hnn1R1Fvx5ZFeAKM7FgegGP9DpvJk+UIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773027189; c=relaxed/simple;
	bh=L/uOWRfgjI3cBGO4+3lTAFRKnSxCj5xszDpaK5Zrrmc=;
	h=To:From:Subject:Mime-Version:Content-Type:Message-Id:Date; b=cg+TyB/yuQmiZ5nm0gllusqqJOIguKt66jqYMpJo4q/vZSI7CgXNTBPj0C18/kx74baw1VKDKuC/P2pnRyvtuQqsB1++m+gzYooi6wRZjseM8xUexnQgSvIA/SJxB/37Bw2CF9/1y0J2fCjoLJpsyQ7JnuFPgWbgglwjMgd+iBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=p-healthtech.work; spf=pass smtp.mailfrom=magerr.combzmail.jp; arc=none smtp.client-ip=160.16.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=p-healthtech.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9214.ps.combzmail.jp (Postfix, from userid 99)
	id 1FE66C2CE3; Mon,  9 Mar 2026 12:22:39 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9214.ps.combzmail.jp 1FE66C2CE3
To: linux-security-module@vger.kernel.org
From: =?ISO-2022-JP?B?GyRCJDEkcyQ1JF0bKEI=?= <info@p-healthtech.work>
X-Ip: 17158810442901
X-Ip-source: k85gj79348dnsa8ju0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?GyRCTys0cD1wQlA6diRiMEI/NCEjPT42SDB3GyhC?=
 =?ISO-2022-JP?B?GyRCJE43cjkvNElNfRsoQg==?=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: 938j
X-uId: 6764244741486059624371161020
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20260309032240.1FE66C2CE3@r9214.ps.combzmail.jp>
Date: Mon,  9 Mar 2026 12:22:39 +0900 (JST)

　
　ある日、突然
　「労働基準監督署ですが、
　　従業員の健康管理の状況を・・・」とならない為に
　
　
　事実、令和6年の厚労省の公表によると
　労基署に「違反」とされたのは、21,201事業場。
　
　忙しい、人事・労務担当者が後回しにしてしまう
　「従業員の健康リスク対策」について

　これまで1,000社以上の健康管理代行で気づいた
　労基署対策につながるノウハウをお伝えする
　Webセミナーのご案内です。
　
-------------------------------- Personal Health Tech ------

　  　　　労基署対策につながる
　　 〜健康管理の仕組み化セミナー〜
　
　日　程：3月18日（水）14:00-15:00
　　　　　3月25日（水）14:00-15:00
　会　場：オンライン開催
　定　員：15名
　
　　　 　＜視聴予約はこちら＞
　　　https://knsp.work/seminar2/
　
------------------------------------------------------------
　
　いま、労働基準監督署が
　企業への違反指摘の内容として注視している

　「健康障害防止措置の不備」をご存じでしょうか？
　　
　「健康障害防止措置の不備」つまり、「従業員への健康リスク対策」は
　システムやアプリでは対応しきれないため、
　人の手間が多くかかり、対策が遅れている企業が多いため
　労基署から目をつけられやすい項目になっているのです。
　
　
　事実、令和6年の厚労省の発表によると、年間2.6万件が労基署の
　立ち入り対象となり、その内2.1万件(約80％の確率)で
　法令違反を指摘されています。
　
　さらに注目するべきなのは、従業員100人以上への調査割合が多く、
　従業員の「健康」に関する違反も22％と高い割合となっています。
　
　
　しかし、健康管理業務の現場では──
　
　　・紙やExcelでは受診状況が追えない
　　・結果回収が遅れ、管理表がバラバラ
　　・労基署への申請のためのデータが揃わない
　　・業務が属人化し、担当者の負担が限界

　という問題が深刻化しています。
　
　そんな中でさらに、担当者に求められるのは、
　「健康診断の受診管理」「ストレスチェック」「二次健診の勧奨」
　「健康経営優良法人の申請」まで年々増え続けています。
　
　では、会社を守るために経営層や人事・労務の担当者は
　どのような対策をするべきなのでしょうか。
　
　
　本セミナーでは、労基署の立ち入り状況を踏まえながら
　
　手間のかかる、従業員の健診・健康管理・健康リスク対策を
　ラクに、安く、簡単に仕組み化する「けんさぽ」をご紹介します。
　
　
　　知らない間に、労基署に駆け込まれる前に。
　　立ち入り調査で「違反」のレッテルを貼られる前に。
　
　健康リスク対策の違反指摘を未然に防ぐための
　ノウハウを得ることができますので
　この機会にぜひご視聴ください。

　　　 　＜視聴予約はこちら＞
　　　https://knsp.work/seminar2/


┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
┃株式会社Personal Health Tech
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
　電話：0120-984-925
　住所：大阪市中央区南本町2-2-3　 本町UNICOビル4F

　―――――――――――――――――――――――――――

　本メールのご不要な方には大変ご迷惑をおかけいたしました。
　配信不要の方はお手数ですが以下のURLから
　ワンクリック解除をお願いいたします。
　https://knsp.work/mail/
