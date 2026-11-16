Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825397;
	b=w0agKAs1Ggse8fUCN9iYaeKYRFR1XDvm+Oygx1IctH/l/k+Ssz9VhZaFVW6D/XfM7xlg
	 VVqRSLdo3mueti6aQ1512Z4f9iSh7No9chGW8sO+d39w9dFrYfZRM86skzIqFIss0py2F
	 LFgb4D4cWO0mBC1FTBpzNI9y8iZ+vmukU8Du5b0EHuDIOc/Ldu833vA1lphmezH9Ou9rt
	 JMZFGXLeNTBCEOUF35z+un7b8mg/qNyiD18HfJFVH3SJOUwiO/nKd/lv8buIyB2N1ks1M
	 sGp0a3UBuEEKpYdDgH99dR2d22XOup23uukks78tb1uLb8ag4iHRuUqKI+N2mPo1yvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825397;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir;
	bh=jnKD0Sg1HXJ0QpODcDAb1+nm/wAvXB84pIyCwDBO52w=;
	b=Sx6V/71cm1mT+BLh/vbVJ6hZRYSbCHSN25A5eKgMYJZ2JiBUR/JCDg5jt2KKLW20ygy6
	 ugKH2TD9ASz5hu+BEn6+Z3PaA/ewT46yzxAqlYH1AiQQ6VA+GeiAA4FH8G6V86mGUxwco
	 zlweVeJgMnzwwLChlAlDJE5durnKzoiWakusWGYcYJrm9QxJb8oPoegAja/KqkyB9IRVX
	 UwfZxrTagQjlsFd5yQJM3yLde7JNJxGZRFuCli108OkTEZ+TRBacDn06+3+cxsRJ9UzxQ
	 oKwfbDBMxGh5nQs+RbWaabmsuNCP4yhSmWS6KFa8bUdgCwt6tQvcVZGJ94uKK0wYXew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=VB5ZIZJc;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6AF606A880
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 10:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA6AF606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=VB5ZIZJc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=jnKD0Sg1HXJ0QpODcDAb1+nm/wAvXB84pIyCwDBO52w=; b=VB5ZIZJcQnnGMeJZ5ZvFY/KwVd
	nKh28ZgdryuU7CTAwHo5zC1wMl1y5KBSf77QeqC2kHnnGueaBSHDpHi2054MyOhwcoq9GEKovC4kV
	9uPlwpm2dm5QJWM78j3bzfA22FBtccDjFMsqze/YSvtE1isQDyespzMZyrz9VAlhVLJPyjXMAtWMz
	P/HmuNt/pTjhWYouIYmPXPM65JOUdy39w7d+/EIpGqMNOLgoWPiAZhuKXeJzTNPlVKvIPOUM5yGOH
	Vod+HHFj2Pv4iwxpk5NaAciRE9eP8nnL4iV7TM5Yb6AyzlW9z6aUvXUNSrq9iq63Ujj3Axdjln/3s
	m+7+Jn2Q==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:16639 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1xSu4h-00000004Pfx-2NyI;
	Mon, 16 Nov 2026 11:36:34 +0100
Date: Mon, 16 Nov 2026 11:36:26 +0100
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security: update lockdown_reasons[] reference
Message-ID: <avrcbw4sbtHruptl@archlinux>
References: <3283a389cc21862ab98eb891436568fc1d23b869.1794505077.git.baruch@tkos.co.il>
 <9923142e-8775-4a5b-b016-7a2a9b743198@huawei.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9923142e-8775-4a5b-b016-7a2a9b743198@huawei.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On Fri, Nov 13, 2026 at 09:50:18AM +0800, Xiu Jianfeng wrote:
> On 11/13/2026 1:37 AM, Baruch Siach wrote:
> > Commit 59438b46471ae6 ("security,lockdown,selinux: implement SELinux
> > lockdown") moved lockdown_reasons[] from security/lockdown/lockdown.c to
> > security/security.c. Update the documentation comment to match.
> 
> Hi Baruch,
> 
> Thanks for the patch.
> 
> However, Cai already has a patch under review that moves
> lockdown_reasons[] back to security/lockdown/lockdown.c, and once it
> gets merged, this issue will no longer exist.

Indeed, we will go through Cai's contribution for this.

Best regards,

Nicolas
