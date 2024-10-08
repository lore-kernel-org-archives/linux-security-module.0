Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB11A20CCDC
	for <linux-security-module@vger.kernel.org>; Tue,  8 Oct 2024 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412531; cv=none; b=DT60g5P1ESmy6pOQuDZsiXrQIm4xA3J1OrKdgHq3c+PEDGTpH3vmPgRCd6iOaiO4K7Ix4KNjDmfK86K24T5yWoRObjppj37R0yuvN6m9DrMHs6J5+Si/a9GKrDBYzciT7A5e7frw9vAePnFHoLy2JewfvKTuuhqG5iKMZ6loRvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412531; c=relaxed/simple;
	bh=N1bztF2nEyn1H0E0epOkKEV8XHk6AdEef/+UQc4GkcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmQDLI3uuqOwRrxlyDHWXE0WGYPhGyAd++i0tPQBXVr4z+cjp1Sngght4EY7by4AyiStqZhpzet4TvE1/i8YSUjdX3YfUud3HtNQZGJtKEcg3Wx8FhiqHWBm+n88rKu9PcPo9hlITocx9uoz+kbsLn/7EVr6qv5LDMT7asBdHrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=cpGnH/5K; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cpGnH/5K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728412528; bh=HL5BOpcuVd9I44iQJAedgR9TxToL599NaIMxA9giEDo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=cpGnH/5Kn6THxB+9ZyT6aAbzUKa2cOskhFyqMlVZPrbO+Ad53a3QaQfiwRzpaFzsUgMPW36O+Bg2eC3ZNF3FUe1sKJn5IOZmZVZSrhE37eQTLsEi62JYJw6Gch+DtJx8Pqr5qapQNgaJN/ogknr8WbLEGDKKe9jWrBp6DDPQUdT07q9QZR2UHLFFVgbj07PQlG7Vm5MZf0pjPA9thuo1RO5QYReqJrOM0QEhZwxrO5Wl1+35dLLYDoItWA7Qlgu4TjiiPzS1ORKD4VPNJBFaYuW3+OTexZt2WS32pTA+bNfSzJMQJhX30NSr4WxUU4XurTXWrSsvhz1V45k1hj2Hdw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728412528; bh=lQtu0xXW2o470AzmFs/Fk/8c1nJ2JG2rwx00J+kLmPs=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=U3NAv2zYcQYwrNwTW90uD7pynQF2QdaYGBR9HnGarBYnmjVCRPZd5AD1tYbVirCBDBwAW2GhKllLPSnRmCyoVIrEFbweL0kpvWJZY9OtzI7b94PLfNAQbgxATbTvOIN3JTN6v46+ziaSyGzGCbOA7y3a0jYQfTDFNaL2+jPxciWFAxk7lxaJnGYp5VVWC6D06jXMVjdP3o9i2iUVyzumL6es1PS+iGsQONv4O3W6qXow0O9iWDNcRtijOxwMjCw7MRDkuoDpdWubOtfRxBLRMW3ZFnXi/9ZhY44V/KdhrWpu/KHfLuN1MC4ggcj/5Jv5uDoXiLymA9KPGw6tu6ptlQ==
X-YMail-OSG: quio1GcVM1krtO9p4KkBRLaTqrm7b9HH9u67A7MBscU3ZPdjeTDdW8eELTrcm57
 3SXK.VOC4RbDA2xQr1swvuZUgNdtCRvTAcp3MrKe9igNhid.ZcDFyRWHgIwikRlnChbypAoQkbvQ
 HdDeB3F9SJOY9I8SI5JMFehhucVzIwd44AOozlBj2i71WQf57KBPVp7RW9DtqEXfm.vl9a.KWwP6
 F_PVL.z1TY0PiuDsOSKS5QfRsP8Nm_njnCDUPW4bxcxWb.WOlY4CAN8TNwKeN8LGDDWBSHxvmjUH
 dGIBcbZRClTtUlTUgef_4lMWbi3kLmGl.KQeunzfdh7.aCrbV9ko9gNVixNym18w6Z5DL0WiSUU1
 gisI6XN_jgXVXJQFNpPqoOeSp3j.JSfTMrHW8NExXZSeGBy9SnLgZWBoTmTyxrD3bvfgf05C0.Pg
 yYsExE3uddj4BXCG2udiyZdAs1.4HPq4TWAPDuYScSeJ1MocztwAXPu_cOlPrmukPnt7CUORfwof
 qu10cc6RIa1TWr9EKBVk3wXBs2gMwqpl68BN6WwQb26DbuVC3Qr2LMF6tq6NN9FoxUC5667lyPTS
 2VLj7hF_esBrwfzZqqMATBLQZmzJ6ZFdXDHn.m89H4IJcE2aX_wWKIVcIs7kFO2IVSbRa53t0w_e
 5Sj0xm9.JIHnbXP0lx6O5IsjKrt_ATQhCtkXpO3Km_5nRaM4FmHs7lN_HGtkSZFzpHX5__wNXWt9
 KuXhpvSjO8kdm.zfi4OLcPaSHV3Tg4T9KNgBQtx5X0cQOdeLt0_tQon2QWwP3ZmmS7xuGoBrp0O3
 34ezOJCGcbrbxkH1bElmAPpV96c_HLbWDqELX.4PPg0T_rVFfwya08MvrXQjnXCPS96ddMruKnAj
 LYCaeUkMO2REQpvjXx45pGsFP0HOCgOLC81PTD_TpSrbYG5yfaNd4tKVHUHacs41yo3miTewi.FV
 jgTZuNwM30UXbMiA_b5ZPsKFd09PBTBVlvcgP2Ks76juMdctJq6fB_PHqU1OJ3VzxJDwFv1jzdUV
 AES2_ma51xSDji7rYN0d7ilKQ1lHHr7vF58B8_QPounXKDy8_41Mfu34PtWvE8TQfCjlevcuDMxL
 741uqOMJ.ymHiE2_n7TIdEH4ACBtzgBGF1xXsFetx3OcjoEP._z72rFT_ACzwm9h1rq0DGaxVQPi
 02SyR63QgDOsGLQEM8bi0axT7JcnHI0btJvKa6xgV4_pfOsBocKDtoor0nQsh9znP_fj24q9_MRe
 AQD2RUzjYz7gIhgPe9JpV61MV6IgMUayTAKny6MwLhNhEbUiimVyOPhPkDKPR6WOIL8s2MkHS33D
 GoQzPfhbzTXpWX2T69nOG_lzQ1Jqx0KerT1ZpC3fWzBMGzMFeDBKzJZPPqCe9tingrTpnRjy.1iJ
 lvDO2eeBU.31D.l_uIimlggsI5K5VngvPN7sOMRzdXd5vOVsU7_vHooASzICwKlkxxNDcFQw1U5X
 7vOUyFhtcha_Jdp.X964RMqZvifnxTwIBtolIiuoNmdL4lydezM_uWZqVyH9vPKKyzP4ho409sdZ
 cPWAUcZ_JLGTubXxeFWKNBMXPSuLaVLLQoZs3Dki.FvzoptW1dBGagMoTa5kO.ESYC4M_ozQ2zIM
 FZqk6q9fZVp_.cVOKRSYiuRg67SDLWng0H5jFMZHblj0vIMa_LJNNMD7mE4mPXmCRcEGjEbb9aBU
 1X14FMRDmaJbnaqU2vAX3BjQMR9Z.6Wpky_PE.V26OUA5C3tsNXan0bnRKrlSMs0gmttODS.1NJN
 KJVSt1REPE1py4tSs9ELp3bZEZj4TJt9YLaAeA8HNeqXboA3gWzm5zxuyiD014Wc3EkhJPExCoQn
 TJHFvNrB8P5YKV4gw.ErzVRS1SIfKu5JW36NfCuq2YBtKg97rbwInWW7gkOngd9cmVZuCOFa4Z8P
 ax0UGz2KGdCqXb42uQmp.3ahJmmg7_8_FIhJO3_e3Oj0YbQDDuhkq9i3KniOTaoXfYSRl7359cXs
 ZCgyfNZ_lPCBAQIaTxPSgUih.dvnzg1Iccin8gAN3DHfvy69MHNROEbxOn0huZTksVaxzKvkqPvP
 7WC9XQMLhJw1Zrsr8j1nnYA1HFzhr98mCJ8004mMOTi8pYqc2hibWymHtNIs1Siuwxv5dbONOIiZ
 bKfT0kSqaFoxWBa942Uuo7Z9zD9ii2PAA07DmIek_Rn4MU2ViNITsCYXkVq_GDC1x5mfAMznZu0v
 91LVwKIJZ23adkvfNaokBAtNQ2p.UOgXS8gBMHVpA3QyHiUZDffDaT5eMpPS8JFw1fUCmNQVE8P_
 fXf7vpNXwKWzRbCsld6RL7dwW75F7N8RBLCo-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 039f7a34-ab00-43a0-8ae5-12dac1431324
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 8 Oct 2024 18:35:28 +0000
Received: by hermes--production-gq1-5d95dc458-jflr5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 60574d1afa6c8ee7d0e3cceaaabf2a2b;
          Tue, 08 Oct 2024 18:25:18 +0000 (UTC)
Message-ID: <88954576-5e62-4d95-bdf4-3913ffea68c2@schaufler-ca.com>
Date: Tue, 8 Oct 2024 11:25:16 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: "Dr. Greg" <greg@enjellic.com>, Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 LKML <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net>
 <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <20241002103830.GA22253@wind.enjellic.com>
 <CAHC9VhRjq4B4Ub7kbD8uLZxL_CKSm=z+poCXBMmcfs=8ETHj3Q@mail.gmail.com>
 <20241008111442.GA23889@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241008111442.GA23889@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/8/2024 4:14 AM, Dr. Greg wrote:
> ...
>
> Which we also believe justifies more attention than what it has been
> able to receive in 20 months.

You're right. You're also not alone. There are things that you can do
that will help get the review you're looking for. Developers who attend
to the needs and preferences of reviewers get a whole lot more attention
than those who fuss and fume about not getting what they "deserve". My
hopefully constructive recommendations are:

1.	Lead with code. Save the documentation for later.
2.	Incremental implementation. Don't drop the whole mess on the
	reviewers at once. A patch set should be a story, with each patch
	introducing one new element.
3.	Emphasize the similarities with existing implementations. No one
	wants to deal with novel or clever code. If it is familiar, it is
	easy to understand.
4.	Thank your reviewers. Complaints about review latency typically
	increase it.
5.	Do some reviews yourself. That will get in the good graces of other
	reviewers.
6.	Be brief. The biggest single problem with reviewing TSEM has been that
	doing anything takes so long. Multiple paragraph responses to an issue
	don't help. Say it, say it once, say it in small words, and use as
	few of those as possible.



