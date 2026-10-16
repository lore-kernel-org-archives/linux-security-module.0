Received: from r9220.ps.combzmail.jp (r9220.ps.combzmail.jp [160.16.65.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07C3A6B8F
	for <linux-security-module@vger.kernel.org>; Fri, 16 Oct 2026 05:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.16.65.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129576; cv=none; b=SP0kJzJFvhvNUeNoZmdFSqNGJe4uFLyQuJJogNipTboyM6mqEL2zEHmKQV3w0R7o1zUeFHrxvdtIxYl4gnY/NfHKBCHygMdTqeRwX0GR2ZojYOK91ZQMlGq4bUiD3O7CrdKmPGPr8dPf4hx7BO/sIy92wcbYj6yNDY/bT5ODAQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129576; c=relaxed/simple;
	bh=ebyI7XDSk1Lx0tbMrXAePp63eNec9TltndH6dU+gpCA=;
	h=To:From:Subject:Mime-Version:Content-Type:Message-Id:Date; b=fxYoikpe+usOjQWSr3zybaynPSUDY0buvSDxPXdy+eSjeTlVJhrBogo5ikBhB3ItFWysDkmB0HaKVIJjhubRJ26GweAgah4vam8f/hRr2FmRqwEB6yV06aYGvRGctSvyUR3XcYXGxByHrnqf4bFoefp4Eep9Gi48Rg9optLxOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chatgpt-event.work; spf=pass smtp.mailfrom=magerr.combzmail.jp; arc=none smtp.client-ip=160.16.65.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chatgpt-event.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9220.ps.combzmail.jp (Postfix, from userid 99)
	id 312FEC09D1; Fri, 16 Oct 2026 14:45:52 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9220.ps.combzmail.jp 312FEC09D1
To: linux-security-module@vger.kernel.org
From: AI =?ISO-2022-JP?B?GyRCJSghPCU4JSclcyVIIUMlJCVZJXMlSDt2TDM2SRsoQg==?= <info@chatgpt-event.work>
X-Ip: 105163600192535
X-Ip-source: k85gj70348dnsa1qu0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?MRskQkZ8JEdESSQkJEQkLxsoQiBDbA==?=
 =?ISO-2022-JP?B?YXVkZSBDb2RlGyRCJHIzWCRWRn5MZzlWOkIbKEI=?=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: 031q
X-uId: 6764315443486066694582431009
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20261016054605.312FEC09D1@r9220.ps.combzmail.jp>
Date: Fri, 16 Oct 2026 14:45:52 +0900 (JST)

お世話になります。

生成AIで「調べる」「文章をつくる」までは、
すでに多くの企業が取り組まれています。
しかし今は、AIが実際の業務そのものを動かす段階に入りました。

今回のセミナーでは、実際の画面をお見せしながら
以下を０から解説します。
・AIエージェントとClaude Codeの基本
・AIでWebサイトをつくる（作成から、公開後の自動更新まで）
・AIで帳簿を作成する（品番検索・過去の見積書を参照）
・実務での活用事例（サイトの自動更新、AIでのお問い合わせ対応）

━━━━━━━━━━━━━━━━━━━━━━
　　1日で追いつく Claude Codeを学ぶ入門講座
　　― 調べる、作るだけでは終わらない。AIが「実務」を動かす60分。

　日 時：2026年10月23日(金)14:00-15:00
　　　 　2026年10月28日(水)14:00-15:00
　　　　 2026年11月11日(水)14:00-15:00
　会 場：オンライン開催（お申し込みの方に視聴用URLをお送りします）
　費 用：無料

　▼お申込みはこちら
　https://chatgpt-event.work/ai-seminar1001/
━━━━━━━━━━━━━━━━━━━━━━

事前知識は不要です。エンジニアの方でなくても、
経営者・ご担当者がイメージしやすい言葉でお話しします。

前半ではAIエージェントとClaude Codeの基本を、
後半は実際の画面を使った実演と活用事例をご紹介しますので、
自社の業務のどこに使えるのかをそのままお持ち帰りいただけます。

ぜひこの機会にご参加ください。

＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
■ AIエージェント事務局
東京都中央区銀座七丁目１３番６号
TEL :0120-889-859
Mail:info@chatgpt-event.work
-----------------------------------------------------------------------------　
　メール案内の停止をご希望の方は
　下記アドレスよりお手続きをお願いいたします。
　https://chatgpt-event.work/mail/
＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
