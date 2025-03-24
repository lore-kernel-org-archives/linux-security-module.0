Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA2FEEAB
	for <linux-security-module@vger.kernel.org>; Mon, 24 Mar 2025 01:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742781509; cv=none; b=BS5qTFlRxTVelgoTtvmk5k2vB0Ih0S9KYS2IBtIpbVCieuPHjrVx9gDtKvfIiL84mNYumjycCSZ0em6CCgpArG1SaUTsHUGEt25NUZkCB7a5WBnxPL4w06wokZ9V5hA3MNkeJSHLkEfAP21b041hZ7Q08qYLQf/NRe/F6M8yeQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742781509; c=relaxed/simple;
	bh=GuExEUYwRBtnBm7j6nAp3EYn8jrBRxUlOPc1JxsWsrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osCOXqsPYUWoiL5STvKI/T1dxQtxI3B23RzDZqr4hM4LnwShkaKuVcLifVwKTdcSbOOZLOZ4tJGIfBmqyoPq6tsA1Lj7MFBaXThKaOuYrb3Z5JiY/ZHNNaFp4BIUzd2JANf+TIaY2M1cSiFPgjZdRKHzhTnjJcN4bIFUKiskKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=hrWsElIM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KU0Fckou; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="hrWsElIM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KU0Fckou"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id E26441D419E2;
	Sun, 23 Mar 2025 21:58:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 23 Mar 2025 21:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742781504;
	 x=1742785104; bh=Grah4IY55PCnEgSEN4vV4DKAoq9l9iUOMkhmn/rQ1Os=; b=
	hrWsElIM/hrXdQtE4BoLIdzBnIEH4S/0HhFtw7k5fm+z7oyAKnlI58uEC3EXuJyR
	66nYqbh6uf5TDwszycdM1VQiIUxrLQ+v8hzrjYvoTbl/oHYDhgiSsilAUEn0owRt
	RLatNpzPtvstd+ZREYdaYe2Jsq/chqEJ3Yj/ULUBZPbBtAbgiJzwX52t2bUre2OR
	/fEpBDmuwjys3wXyOHkbANJ47M3f2Yw2Y9B4XEydEQ/wzKNLD0sf+ROothc7ybHt
	CzgbfpnuFOe84eyA2sEiAUWsIrV0sFEU7AHPtZtmjMyi7Jt4xNMsyThSuERXO833
	IrPb5ohmxq+YRQ3J9Xj7uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742781504; x=
	1742785104; bh=Grah4IY55PCnEgSEN4vV4DKAoq9l9iUOMkhmn/rQ1Os=; b=K
	U0FckouzACIAGMvp1805hw2USC4O4hKJZiqNZ3X+FuAXm0+37uwH2RlXTNkZHAEm
	ya8RemMEWJqjB1uQe4yTXO8lLuTDiX04I3mOhFo+zwd0iVkMaPhVuEtVnibV2Htw
	Bc9a64ErQeUTdWIFVo34dWao05HVGk+yHUJGxXSTBfAGbuW6IMHVHOJeKz1G7s6D
	/5yNygh4U07jbp99RZ4QyYJhFmEvFqTcxaNJNLijA5F8cyXUywyV3+zkL4B8ZWEX
	SG+tS4kyvdd1Q7D+dibVmrHrKa/SSBkStSlWWo1MC7GSZJAjX9R3111ejrbHvGSX
	a/k5ctdi2uy1JfIDSFOZA==
X-ME-Sender: <xms:P7zgZw15WNirXKbZSTabLuljmIPBl69KFDMO2zsBhzFASUx9S9ZQEw>
    <xme:P7zgZ7FUX8Cr_O2vGYMgeDHr3-N2mDYLUTYvFHuyH5TImJmRerTdlK8xVBC0GR49b
    ulN8yOSOv9Gw41vYnM>
X-ME-Received: <xmr:P7zgZ45tOhc7y2pp-SNeA69NsDii_-B2tW3XCoxBfMJzD5quiy70lCCLGDgDVGKSOnrioIlXfpl8Y7Nv8rVn2wyM4wIk_O5L5qA-_LgxYpGO5x_frKCRy3ws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheekhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgoufhushhpvggtth
    ffohhmrghinhculdegledmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnheptdfhgeeiieduhfffheehjeeuveeffedutdeijeehgeff
    ieekfeetudehueefveegnecuffhomhgrihhnpehsohhurhgtvghfohhrghgvrdhnvghtpd
    husghunhhtuhdrtghomhdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprh
    gtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghnghhuihhn
    qdhkvghrnhgvlhesihdqlhhovhgvrdhsrghkuhhrrgdrnhgvrdhjphdprhgtphhtthhope
    hmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtoheplhhinhhugidqshgvtghurhhi
    thihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:P7zgZ52lGcpgRo0tOyzNfdVL2sMROIoJ1u1o8hLCW-4f0dgSooiTHQ>
    <xmx:P7zgZzFWtia8X0fiwRnkrQ_YOKH_tvfS1XIh6MDcblJRh1bs78qncQ>
    <xmx:P7zgZy9VJcE_p71KG3FgR8nDoby162UsmleD-0Si_zE41K0Fj_0E-A>
    <xmx:P7zgZ4kQX4Np3uc9O3e9NnFpe9BYO3C3L0tJVQdCo4ZVepliVKqv7g>
    <xmx:QLzgZ2NuZnhpptKBmOmp8bXcJz7AuAI-0zj363xt_gpP4m61U_7sA0uf>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 21:58:23 -0400 (EDT)
Message-ID: <5cff3b2b-998d-4dbe-897d-7622d07f6791@maowtm.org>
Date: Mon, 24 Mar 2025 01:58:21 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-security-module <linux-security-module@vger.kernel.org>
References: <cover.1741047969.git.m@maowtm.org>
 <5d683299-fc53-4763-be49-9a91325a832c@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <5d683299-fc53-4763-be49-9a91325a832c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 06:20, Tetsuo Handa wrote:
> On 2025/03/04 10:12, Tingmao Wang wrote:
>>      bash # env LL_FS_RO=/usr:/lib:/bin:/etc:/dev:/proc LL_FS_RW= LL_SUPERVISE=1 ./sandboxer bash -i
>>      bash # echo "Hi, $(whoami)!"
>>      Hi, root!
>>      bash # ls /
>>      ------------- Sandboxer access request -------------
>>      Process ls[166] (/usr/bin/ls) wants to read
>>        /
>>      (y)es/(a)lways/(n)o > y
>>      ----------------------------------------------------
>>      bin
>>      boot
>>      dev
>>      ...
>>      usr
>>      var
>>      bash # echo 'evil' >> /etc/profile
>>      (a spurious create request due to current issue with dcache miss is omitted)
>>      ------------- Sandboxer access request -------------
>>      Process bash[163] (/usr/bin/bash) wants to read/write
>>        /etc/profile
>>      (y)es/(a)lways/(n)o > n
>>      ----------------------------------------------------
>>      bash: /etc/profile: Permission denied
>>      bash #
> 
> Please check TOMOYO, for TOMOYO is already doing it.
> 
> https://tomoyo.sourceforge.net/2.6/chapter-7.html#7.3
> 

Hi Tetsuo,

Thanks for commenting on this RFC and thanks for mentioning TOMOYO - I 
wasn't aware that another LSM has a similar permission prompting 
mechanism already (and in fact, I only recently found out AppArmor / 
Ubuntu has also built something like this [1], although AFAIK it's not 
upstream'd to mainland Linux, and the current implementation may be 
somewhat coupled with Snap?), and this is valuable and interesting for 
me to know :)

I've tried out TOMOYO and it seems quite applicable to the 
"firejail-like dynamic sandbox" use case (i.e. use cases #1 in the cover 
letter) I initially wanted to enable, and so I would like to investigate 
this further.  If you don't mind, I would like to ask, have you built / 
are you aware of any end-user-facing GUI for tomoyo-queryd?  There is 
one on GitHub by someone else [2], but I'm wondering if you have tried 
to, or thought about building a UI that's a bit richer (e.g. like the 
one in [1]).

I've looked into the TOMOYO query protocol and I was thinking that, if I 
do end up building something for this purpose, it could perhaps support 
TOMOYO as a "backend" (and in fact that would be usable with the current 
feature in TOMOYO already, whereas a landlock-based one would depend on 
this patch).  But if you have already tried something like this I would 
of course want to know beforehand :)

btw, maybe this is just me not looking hard enough, but is there a git 
(or similar) repository for the user space programs (tomoyo-tools)? I 
tried to search online but so far I only found source tarballs, 
including the pages on sourceforge, and I'm wondering if there is a 
place with latest development branches.

I want to perhaps submit some patches to the user-space tools (I assume 
they should go to tomoyo-dev-en?) if that's welcome.

--

With that said, I should clarify that I think this supervisor feature is 
still valuable for landlock even knowing the existing TOMOYO query 
feature. The intention is not to duplicate what TOMOYO already does, but 
to offer flexibility for landlock users and feature parity (with TOMOYO 
and things like seccomp-unotify), and allows program sandboxing 
themselves (or other children) with landlock more flexibility.  The 
second use case mentioned in the cover letter would benefit from this 
(and a user-level / system-wide sandbox program can also choose to 
leverage this, potentially running unprivileged etc).  I will try and 
prototype a more interesting example to validate the practicality (most 
importantly UX) and use in the cover letter for the next series.  (Will 
also rename the series title to just "Landlock supervise" to avoid 
sounding like interactive permission requests are a new thing)

Kind regards,
Tingmao

[1]: 
https://discourse.ubuntu.com/t/ubuntu-desktop-s-24-10-dev-cycle-part-5-introducing-permissions-prompting/47963
[2]: https://github.com/Intika-Linux-Firewall/Tomoyo-Application-Firewall
