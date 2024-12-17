Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73E01FC7F0
	for <linux-security-module@vger.kernel.org>; Tue, 17 Dec 2024 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734471570; cv=none; b=qUVRTxN64bE7/dXijH/E+sjPixsMMkH9lb4nxUxxZkMsju5isuK6YsOULXfyLCdHNoSS3t3iyD/Z1DOkdMyeonjslGThpX+st/Q04b23tp4mzcaCdtLgQcVbYWSE3fxfpCH0+h+u/EjLI1NrpvbwKMLwlGpkU4iR/6rgHH+R6Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734471570; c=relaxed/simple;
	bh=EpJAESYstREUkUwzWHiD+ccRjjVprfi+ihxLTuTqk3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9jB1yXySUXbBK0ZUmyrcIru3AHwgI3oSYKFyAuyca1wFv5DEYEZVCZib2Z7I+QHRuzKHffdB/hf65eNi1EOl2Tod2zx2BxG9kFrQO4exbJOdbylQ+B5DQ9bORTDktGP2SC/zZ/Os0G+oPt962FGkVr0IEBlc8sH+ZXdFVJbwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=e81GSm4j; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="e81GSm4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734471567; bh=MFZnnZvpOi5fa2Z3TyuZYvU1E7VYj06cS2HrX4jXJ4s=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=e81GSm4jkkcfg9A6/dyo4idSlNanZqhjyCaTjhWDxuyOJATGPG2Yh0JKn/saka40UJ9cM7cGvMMIDHRpFx+YNPzCX+z/185xDwO9jaID0X2gqZ1S8DI/76hYt5hlq6wiFIrHNu9hq6ESShzLBghN4EquAiHcBr3FU4BWlH53ZQVJvBrHvrtZ1Cr3sCBOJoM2bWrRXlikAUVs2e7UQtnbdYFHj47m8QjW66l61OX+L68sGkqhDYuzpB8LX0PnOOzXt8eYP76ekB70Yx9KbVp6ijP0+nCMFHaJwsrBddbMkbwkW+/oyoIv7DCRJBVK6BjOKaGoReSoLpsYxwS/6+7gPA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734471567; bh=8cYMTI8DCVz6dHBKFs/74tV83FUEZWCfnjlyr1tvAug=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=cF1DCMZIRzkBZ5BnrsVEhrTzZq4ZRuGGNUf1B7IiVgyI1eoH6REGdtoRTXCrZvPup+6e9jlrUq8L+P6+60Y4RZnh0lv/6psmaEIK44a+f+QJKxsIAWyrnJWJBjR7x9i2RjOjs51ES1I1p4AZJO0A2pv8aqufncoi+TMo2LN+ExCQHYne1oQgYNdiBqVJwExFqaWVumUUvbiEFc+MZsCIRx9m7nOwg9GYLJejxDAgcaCct2Wxd1F3ADsZoK61dcs8wdSQmdgQxWMuzyroUAlvvK0g7ojZcdw1r98IPGYRwGsmOQjZV4mcE3paj/21KmGoFm18pFLlysxDvvOaZN0yRQ==
X-YMail-OSG: QViyLlAVM1lqRfNBRuqD07fIT8i75AiBHNyy9FcnQQCpVFz06OPPYNWXIe_G.7x
 p6CB371qA2g4xtGVOF7tAMSnFL4Jb1STwdp7HX7NEjqS1MciGwg.ZSZsqBAeHLigPPhPdq5QEFyy
 Qkls.lpdRfouSH_xy9_.z2AuMJUxb6ncK7S1dPuWyMr6jFrmvXqjtccKSQfe0laDWbFeAadPzhmK
 VArGGxWIXpd35cYl60NPjxmJhcJ3l67TLJZZ_0ueR4NnVItA0U3GqOsFkooirayg7xVhRxhy50HZ
 RHK7i8FFO_RWITDopFsiKlv2lV7WEyi6MB7zHsJ5TlNa3wFWF_jiqOFtPAmpOv8E3gxnWTWmPBPI
 Vp7FzMGMVDs3JDvZVS0BfLCnAYKXcppf7yWxBNrVyJv4ZCMJGl0nEUvZryly._YZ8KELz7LrLF87
 rNrjpJ4aS.HevsykZ0zNoLBNBUvMRIGuX.x.2cPc4i08xajKuvcxUV8emhSRAacLtaD8sldKDokA
 tZ_pgG7hCdbPW2t8nwnP8xhHsf6f.WjyjUJgt6wr2lDeGNeS2XUuEgqyr0DEevb3GXfPFRDq8Y1c
 DDMEEB.F3HUEKHciTsLMF0D_VsyPG2obMHvmY6rsi7Om3hh3.1t9dqu1yLKIbiz0oU3dmzvvDNmf
 .diAzTbtGqeL5NTwUr7rePTXmUQ8NSAcq_naO7U8ievh49Uv26Fv6Bhki.8Ltum7kl4kwig5F5XC
 FLrXzagAOOq5VUpP1wvQJNBOv2WGSny.Mn0DS2NYBdNUA5NcvGefgAYQMH6jdpzYnpvSVkLfDV3C
 byz5xVnInBA72JMzyEsfigFMCh4vVs3v4BDZL3lvVb2vobBIb73cRKBMe6o6Wt7FFaSjx6LpRP9z
 XzOs3IYBvqm41_ebO5jgrXwHAJPYkcBtpfDUTpwd3apOYKQrrvikrZ86_UDQJGOfLwsZjeENQVF9
 VQCXJlCyJVUfZ8htUL8B5aDZItS8tmeLhVzWzUkrMqrtu2po3vNSHceepqSqCTxqTs9po.PmU4LO
 axee3KxuXR9vfPWL1SdZHt6DC.rl5qU4tTG1zOPBWhZrDAlZVugXgFVPdmnMpjLP0wGbt8492uTd
 H1STJby_Sbm2.qGYykC.FJkMbp6lQi_..aLfdYNMH.sWnzV1aoQRTcwJgveLal5XxES0y3HnGUYS
 RWIpbKYCtSk82OkDLMKAYI3JBmzHYYpvm.JYbzr2mtJ3rtFG_DrAOaqwW5EWKz4damNKRj01nf22
 RvgH9UuqzUUzYH4.CEnCUy3WQk2TYAhF5.Z3FfTS75YvRU4j3j.3LbFi4n.M_CJ6nnWSWYDN9WTw
 2MrSzbgU1lKJ3AXzFEs2UXtd6InzfHtsjtkY5rO3ZNVu5qSaJyPqWrqKLASuNLp8540ZKnK.79QV
 Sr6gUMcKqIPi8YSNOIhLnO5Dj1NlZ4bH4pvBxpNSAts6FZD0EDtgY6tRCrwy4TUiofD_Vvf8NHA3
 xjV8CMEzmYldEfL2TaVxRQ2bmCMzL9qU_g6Os41Dyiek5bXDlhSvvPZIoZxPclmxRZXXsZap.NET
 jZOHJJpk8D_nSvacYWyhw1gSfR3kykbygFJl6by76jQkpZR7hIiDPPiWV0zf2KeSbHoGlaPDnOBK
 ep6Bo2rnnDAyjdGOLaLawVp0U2IHbDdwh5PiXUZHrgKQ0gw576S4.ICA9gjXzaRjobweipFouQqp
 VKOlxILgPRauXeU8Kl0mcuwsNL1nzoyuwSF1HqpRrThos4pvSEUL1h0M7qIVNLTAAxj6rMlKakor
 2dCOalysWJRCF9jI9x8o0flw6zAr9sfyGh0aeL16e_c.UwXs6RSfdbq5z13WRVplFvbcmmBT2AMg
 beteEiamPHFB08geRuzCFDU6Guw9NBm1VqSY4A7wMZVbjwlggaC_N3UB70uy8xIDXBjp.Xqh1DRT
 cPptzRUU3gJupoygdhm7BY64GjxW8H80znYV9HDJ2WiBV1ftkFGKosoAJtmYcKl41ybgZlxmmz0U
 hRurcqBebQtmmnKzKISBz5k_jfpbb7aPYV0E744XQtgjATZl_etMQwnNs.B1SgGBEcsfm51Vsg..
 Tx._eAxwsFALqxPh6YlfVrMKxJW5BCBs.99gdoJWwOoOGd0eX16Wa0XjtD.S173kLu6yHORyjvDM
 .E900in7mtHnKDdEQFk7rEmPq_yGtYLWW7V3PCSTwx5AatUjIJccwVDquhu5TBOAL6uTml9FhAJ2
 J8PrrDJTO2QeZ3jvhJWHVp.P_VrCz9XryZYIMEp.9ZGuuhA4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 40b94c5c-efe7-4bb5-8b7f-63e1369507de
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Dec 2024 21:39:27 +0000
Received: by hermes--production-gq1-5dd4b47f46-wrqn7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 82894e06ce5306d6207d6522cf15808a;
          Tue, 17 Dec 2024 21:29:17 +0000 (UTC)
Message-ID: <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
Date: Tue, 17 Dec 2024 13:29:15 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable IMA/EVM
To: Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, kernel-team@meta.com, brauner@kernel.org, jack@suse.cz,
 viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>
References: <20241217202525.1802109-1-song@kernel.org>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241217202525.1802109-1-song@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/17/2024 12:25 PM, Song Liu wrote:
> While reading and testing LSM code, I found IMA/EVM consume per inode
> storage even when they are not in use. Add options to diable them in
> kernel command line. The logic and syntax is mostly borrowed from an
> old serious [1].

Why not omit ima and evm from the lsm= parameter?

>
> [1] https://lore.kernel.org/lkml/cover.1398259638.git.d.kasatkin@samsung.com/
>
> Song Liu (2):
>   ima: Add kernel parameter to disable IMA
>   evm: Add kernel parameter to disable EVM
>
>  security/integrity/evm/evm.h       |  6 ++++++
>  security/integrity/evm/evm_main.c  | 22 ++++++++++++++--------
>  security/integrity/evm/evm_secfs.c |  3 ++-
>  security/integrity/ima/ima_main.c  | 13 +++++++++++++
>  4 files changed, 35 insertions(+), 9 deletions(-)
>
> --
> 2.43.5
>
