Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A1B1B87D3
	for <linux-security-module@vger.kernel.org>; Wed, 19 Feb 2025 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002429; cv=none; b=H0qnNFYxuBgUHHVrGTVbD1EJR2mAVsJ+tj67yuzkE1YJ3LJGYpgS0WDWXRRerrH+20Yrn3f1/lBK+q4fCJcXC2OcGZk1meHbbi50wV6eNYkipAe+LWxd044nFau6QkDz72Zp0qg5GL3vk0gOBVVt/6MiWkAiCsqew7lu8TOKoB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002429; c=relaxed/simple;
	bh=p5lxr/7Yg8uoE/udMMTQdc65QMVJnF7Q2atCyf79uS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nwj2yssLL2CT5toTRk0ITIo7VR+aJMiyGf3Si8D5pj5JYIdI+NvYnkW3TglvHeW5SbyGWnmJrakY5NX611pNlEuBf055rnPzmQrkBeBgWAZ1tl6FVamClzSovYVYNbUS+L19bs7iv9Rea2f1QRYU9A174sCKmkmDgt2ZZruBnaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=LY9w8d2d; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LY9w8d2d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740002427; bh=7lepMhb1ZtNZCpzupbwL34GqoGi7KEOrY1Ykp0YTjEY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=LY9w8d2dTVqDQB6Z180gPIbXNNnupJSdAPrfrXe1dE5BnhsVqeV9HdTEW+BfB+zw6CZDOic0fBT3iOzduIXO9LeatPOZrwv9alyNRQWK4XLvngMwDX45PS+ge6N7Od9H3dKZ9U756de9rTxtavjCZNAICKDKvfvA1YKqH/zIq3qISbimgd2d/lRiYl5y/xBtgDg9CKKSUBEM9iRz7h38s45j2RUQk0hqzDea0eGd8S7/KOMX2nwChHyWEciKq3hX0hW+R4rgMNQQl0chlkdtTVlPVvOgONbQyEQWebnkBwk3t6+1QKiWV6TEUtnsz91+WYr357yrJnsH1nbDvV03JA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740002427; bh=8jWi6At/3xx+1H8Z+rgzGPLYvl3cbtqW5vwANQ+pkdx=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jLRtMyaJiR3WTM1moccfDYvPVNrdvXhdVKuYBrbnDvy36Uv416Vrucnnr4sUnRkrLzg/zpjmumdC45EQTOwPM5nrrlINjprvY9MkD4u21Cgd9dSGwtiupA0J5upUz5nGOOr7MLJwq3TgQN9HNDTIVb5xBhGd3VcyYg+5Caz6Bj5N2xGZpYxMOpYfpTcugoS+i0yVAXTyKGz79sQneJPrCzlwsPecAgzvcN3J56i0oWeV3xceUbjuG8ppP/omOGlxl6z6qmh/qQ32/2Qf3l/LwUpKasE8O0tkyJjJtUqXwiJHQonJHSlzHoNQVVraupKyBkJhrIH/SUue+ThIJPaTbg==
X-YMail-OSG: 0hTPg.YVM1lYOdn5TGyzuqv1w6AvtuqVTaF434oiZpdQtgSKtGur59PtZKlFqaY
 8IIAG8jrcjXJgzhJSkKZrVbXnK_ZduGv1dRgflCZF1hxB5qDqVSQdY5yFI0cGm5ebPPBuSw84xzP
 x0_XUmTAWvvs2VmT9w2sqGgDVVGUIzd7JkurwtnhXUecKTlk77s4WR7Xujx.BxXn4WnKhQHRvJ31
 IRxX9N0cGEbqk2AzQHadB37_ICC6N7j75a8TUCXiY2P9bbIXx3uF7hXQO4pG4NAPvi4tDp2Np4_P
 QNIpSpT3QzxVfFE58NkWIhCJ_Ax9MxS4o_Ilc7ynpEU_lhrjvL96BwEjUtuz01ZkfB9bFzY59Em1
 a72uZ_yDPSs93FeWpWSLMJJXMLDhfMMtzjY0zwMalPw4aPkAABw4HzBR9K7ph4GlulkkFIR3o1BM
 DE4AGqrRGe9Btuu_d7fw8UPp.jMZafnAAwDR7ufRyEoiNzQ_qze4Q1d9MsX0qdcZx_k2_ohjCxFJ
 6lLqivnIBmLF2IJJZUjBsPHq5qzH92Bvn8z0dHODHxhfYTYgWPWkTBQzEZjMPRpFOsCz8fEZoQb4
 5Dv1cLcHtQXsUow.flo_WP4rfXgpeBxx824tbe7J4gBaQPhNNcyy5ut3zlqoy0xL9PeKpt8RQjBu
 1L148wQT1msEM_xM5ksvswnVFpHFQPnzzGrsyLKrUZ59nitC8H9Tg6y4MP3rSqYO6jXVJmdZmMLz
 .5z8M4uDPZClg7kqq90u7Vra99Jjbfe5lvEvrtjIczK1vAaLKQsGuZYIRZYQgghSDmjswWCIm_Zi
 LhnW6T2hfrJSBOQbQ.4MlJq_zJTthZEKVGaTP.1inNexXqfdESDKJYpAKHvacqHKB.6DGbvMWS1G
 .CoUkBY4Jke6HdaiZiBXSZDR70LpOlIcGW1vKvpfiS94SCi.ovSJXVqa7ZUik3uKW4.kios4Oo92
 tcalqXI4l_yC.fG1XomIUJfMZZff4tnbWun6e2iazc1hHnMLrdtSZPIVYsGGyRtRFC17SpLLu8iu
 YyAIqzy.P8HonTi.oSvCXbtLhlue_816KRKPP.21u90iZJYj9tQszys01.vuAeAYwdZ7hJdLgrmy
 P9R.MPC1Eio2qPkgUpTLCotjX1_zbmHSs_.mISCEe3g1GwXWwlFdwwBPZH3nc6LGJGg0_zI_ntA_
 0yxaxDVHGK_W2qXd3ET33OeeXjBdUT44ePf7IrBvcJDjajQdXqRHGuQ9xyt9tkFfuEwnfFyGvZqs
 H5e1Gvli0cyyiOn5UYIqw2YCEondJjstGbRUmlHW0Tt1n2A0Q9qnobuXBFCXtZU75_jP3EhsqFL2
 oA9Zg9KlRkRuV_xtGaVCaezLlfK4fIsdLr_l_wpKMNk49vuIW1ZaWpIuoRdE6WtrFIRq.KeUHiBf
 0v8je_0z89L_xz0wgst2SNN71a3Q4a0CrRjzFzl.UolTTsH8azEGLDSU5Ve1wWwHSjVYpXWsYP3I
 xAvwQ3j4sU0fFLxZcXj8ARwnvMMos_NCAyWIt.goJFRtCn3Erea4GZ09d8RjNSa6F.sPwKcwgNMh
 ZH9VkuM6YwLA3tM0ZKpgXDb.OnRqngDQYtAq7lE.HuHydrJf4UjBWYDRTrQ6ZLKYK8C3zKviSBEa
 K1w_BIq4iQZ7chIS7ldYy4O67FA3IK_wQBm_N64fWMmkIcs9AtP96xrohvauTtlr0PtuXxjEVRu1
 A0ujnjmEgbGAhf_lPy3Nf.hRHnpoMyH8BD05o8qkOcRvU7Sdugb1VhmY98HwbCI50N5cOUoPgxuk
 A9N87QIaGckA1x0CQNCaOQOuKgqA9eFcM2L7x.0.dForplOJgcBU0bBZlDJexkoDbNift3cugLlq
 5tnLI099JltJ2w3gnfXMkLeSpdBFcbzQC2Fc1rcWl_Oi3I35u4GZd4Mub1c4Tv5.Og5dhqsCIylG
 N6pCiamoJS99nwcJec9Gq.3kDTqZ1F3MEUqlex9lgMBkOA8yVRVx_GtZRkwOg272QMznwDAGnbPa
 TsxGfhNPzz5Wd3a59.ZGBYDI9x1QJYWJh_hKZ8PRd2JeDaHX4GVtZ7Owz2W_.Wkj8sWsZhumKZvA
 9vBmYawh1dkh55WChjqVtaM5LqHPiKfhNTeXRUbxDoHK75nyN7rxldi3qOMAEMiH0IWsz.DkVGJk
 IC1Cqu3suu.YhNsEZa3nH9mFDiUMGoCMUIgcXAN9sh3vLrKXgnbPxl1X.oVP3l5RiqgWI6hbljmX
 7wA6erSEqTXUE0FEMDOP76LtN2NzMk8Z7dMUhrh8GQ1D8ylK68uGxkwnL8wlNzz6uBiv9voT_m4v
 6H8s-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 871ac868-874b-4215-bcc1-d5dc6613ba57
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 19 Feb 2025 22:00:27 +0000
Received: by hermes--production-gq1-5dd4b47f46-pfhh2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a406640f051c837991ba1bd6e84527b2;
          Wed, 19 Feb 2025 21:50:18 +0000 (UTC)
Message-ID: <9c0a3b8d-76a6-4c65-9bf3-106c24dfcebf@schaufler-ca.com>
Date: Wed, 19 Feb 2025 13:50:16 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] smack: recognize ipv4 CIPSO w/o categories
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250116234043.2904723-1-andreev@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250116234043.2904723-1-andreev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/16/2025 3:40 PM, Konstantin Andreev wrote:
> Before [1] SMACK did not recognize CIPSO w/o categories (sensitivity only)
> [1] tried to address this, but did this wrong.
>
> The 1st patch reverts [1],
> the 2nd patch addresses CIPSO w/o categories better than [1].
>
> [1] https://lore.kernel.org/linux-security-module/20230124105037.23108-1-arefev@swemel.ru/
>     ccfd889acb06 ("smackfs: Added check catlen")  2023-01-24
>
> Konstantin Andreev (2):
>   smack: Revert "smackfs: Added check catlen"
>   smack: recognize ipv4 CIPSO w/o categories

I have accepted these patches. They are in smack-next.

>
>  security/smack/smackfs.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
