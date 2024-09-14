Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D9E748F
	for <linux-security-module@vger.kernel.org>; Sat, 14 Sep 2024 00:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726274196; cv=none; b=j07LRMZLGrvL87N28exvzfQwJ67VVvwoE71iV35p6QHCbiSVFocZsho9pG9lG1MSFMoYASLNaMfc139Bfs1RvuGD4F5FdR6yveroT8Lo4UYFkh6kVJkpKR5fGy/6+auRLA9oV+OvlG7y73WULpZOf8Jir49JObJJq246XbiR8yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726274196; c=relaxed/simple;
	bh=HVYWaizPFvOoKMVkPadUmaQzD+XrTBx940Oi8uHO9mQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=sLa+jzR65JYzJHhrqXitHN4X3NSdGvuU89p/rIOQ63EYdRpoeWYtIJKKcDH0f7/iPu8HkteviGuaT38gYM364BJyV8i1NXqQ8i1aQm7WE1yq+q0whN/kvuaBYafHtuEt3z6hmETYcw7pfkqc7TigsPieA1eAIqguSvJw1Tm+nl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=C3kB5Xej; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="C3kB5Xej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726274188; bh=zE54Jt3wm6Ao2eRXWuC6wUEP7H3d1PYU/MEgqkriwe0=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=C3kB5Xej1T21KJ2tU5TTPp0/oSYQIHXZyXPRnaRCmwLKvj3ID0xzdPJT37ji3syhbtN8QsOrPWFoeSqbgQu2W2gLJiouQXRhBrCzR9cPw9U98q8UY/EaFpEj9BhLVeuXxm1H27ek6HkgNRCkS9YHEvafeuuqghJizVsfHIk94yyHcUTwot46AdtADJGCqs6jxFNK4Ch5S/x8OaPZPHkX0qCaNLQIO84UwKgEQtyeRed7raJPcfIIPbA3Y8qwDdB7TZfQU7MjCHqwEuclJcvGlnDFIF4IwgmHjfizt1spg7k8fQiTgPeIG2EpU0mBbZdkrU3mi+f1iLSnleBUDH8bYA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726274188; bh=OwGmLgrXvlihVKg7C5V7vA0nJNGQwPSDXm9kl6f6R6w=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=ip7/0Hsiy0hON1zc7YFRnDveKmtEWtK5kuDPVanAVKkjCC0gNCZZg//BxyRUxHdRXqOZV328wxbEhu5s4NXmixoA9+xcuwdF6W1YasTdTrIhEjJ8dhLhftrhLnDRUUHre7G5wPbGVf1vY6gsrCoJCahsOwRFnI4N5af7UYCq8/MXqtomGz8p/RwMf4NakDqwIpC2kktCYns6SJvxXVAEV+CmRYSShU1YDUmChG04n4teQ3bnH32NXutUb+MEO0uxGSjnTxYlEuuiOHuC5bxAIJdKr2gLWiiDFML0JqIeZA3ZaFr6ySBnm/JUGbE8pNA3r7aCt/zzGcpufT17tun5Xg==
X-YMail-OSG: tEVtgpUVM1kecB8htSH8ZxPWU94_2RCMds8chALGZrRxEn4bmiIU4Ebos2iHA7u
 Tl1CL72v8FGn7wJFA4a.7VDKaI8bEayyG3ymqlPJIWOzmvXEU.BEKUY1VcE5K2JanBLxXWMIsqV9
 644yX6r0KmOn71fAJzr5JdjAhy5ZQVe9lRe0xFR00zcIu8OdxMzXqbIGyBvkX2IRMOww2G4vBp9n
 ycrQrXBVmVpqqNPkVIO8B0ydPsK49HyfPd6StJu9pLj4.C7jjMs7NLwuzxQrett06q0BC.hQTs1P
 tQQf2cbQ74l1p2f3ateQo.c4dGrSaiFItSDC50IE7BP7AvpIpn2kZSN95YSst6Ta_ysLQ9tDFS49
 k7YA62XvM9YSm7WtgxRisLgnri2qSpZUzfe9uyvN6byZs_PeCdxG231Rdoty1drMCFhzB65uw2q_
 zy6r8HdXOT0TgaLHdtLpcvGLgI1pAtHXb_ftuBj2YPuVgfg492VTwzM0AbGK2p.cqPJPhRDreRrl
 CA9iXq4vb_zf.nS_T.ZrbdhTcFbXSdm5w1mn6NnXM0jPagKn728CCE82vE82zSLn_Qwq.n21R3Yb
 V3d1Q9lJibVHUk0JobbGzYcuXNeP52UJs90aiGhe9K0BA0WVedMl.BITzYKHknop7dE_ivJd2gpI
 kqNiOP5OgIiF4qWINclYDWTe5gYXdd1KEN7HJlje1EmgHMkTwm7mkTvqyYi1pPy_1GA0KVP8ToQ.
 6ifRvLADUe.Hi8X1EK.d_Don5f70Df8XR22pjpttwKFU.jOj3UCndhVNn2Ot0785fdVsCv3o.BER
 .BllIdhTdYxGwyydvWkHrGCA3LsjWvTrTBMymQ4WYmF3CYT4md5R4HXXm175ky4w9X_O_DW2jmk5
 o33VBdgDqtax9_2BLD49dHY3Shoq5gKZj508UzcetMrN9R0xg5KN1optqAqs8p3t3VwuN1qs0U2R
 QGNP1Q2k89vLaKR1WoowHMD6TJ.47cf_9TIJd_gfF4.kfL.YNdKBlrQY.CzYpp.1x7xTJ_0ZaOvY
 gdomRAmbX7JV3QuupKCQ5R3Zi5J.44v6_S2FNj0tQ..3k0jlfjQdjZmOuNBH7fYZNyElfccrKBc8
 UDHQIw1QAF4eXg2qizebTCTs18DBhRFq_6oBTcxmoXmFPrmxFsKf_JUF76Z_cZfUhJYN7XNp6clk
 KXctL5EmUw8Wp6VFv98fKQ7AxfVsR_7Y6S1PlMUFkVN99YzyCNcr3IrfzlIMiVKnvtO.cXrknf0J
 F.F_L3rlbGnB9HaLSGU.CJTy6E4dXP4rNHv07ja.pcCmfD7eVYpjGJhYwAAegycWhIWHQ5RQMaSd
 KTB3uisKzpHTKvHcKG2RYy0acbMQO3PV1qn6MmZ576lw6bmaC_McbcdHeEW0cupqNfdjyIljmivy
 sFKFuZhqLPXAFW_41idP6RNcwwsra2o8sjWa4Bu7FmumrpaVrONrXCpZ2.q0RprOwALJcCeppGg0
 kna4LULxqs4A412hnqX0zVOOLxBealr5TWF.3e3dp9O.E7658t5v396FuH8SB_LOjaRBaWQkbPQ5
 hv0H4t3kEBh8fQ6yaN_0.tvIQ4CMJPjcUKvkeTke7T9MqGcfVRPbIbvzlwiQqEJ3L3xFveyoqtjw
 hT0pPziC5qOMgZjn1y3D_6yirfxddvuLLxfPsFIDzZuXD9puNpsn87WVSjNhGEtUcUWMVDLqzF.P
 8LLKgJ79vfTUwulZB5gw9R2IvB2EhnTjbo2B0fvUEmpiFxCFXaSxXW06xefOkirKzf.dYjQc..hx
 Gya1J6xpFV92fRdxLxno4K_oBo8FjpCZ.0LDl57S_sBOeWZorCn2Jq.M4V8tK.qCzAnQTL6lvwBn
 gzvzpTdDFIWwrUhBrlunJlT2OPbjRzEw1GDlVOajopBlG39YgIDDcMMfd7BDUIylvpoSG54Y3.1X
 1ENuN2ybUaL8ckt4QTMsG6kNsMcNS8It6SKt22oeFLgWnJ2DNS8rje.k7h6Sxiy3UUtAasQJX.Ek
 k751AJ6dJiwNebtdvyk8X_qkZ7bEbmdu9Gob.Xifozos_0FEp4Up_OQ5hLlj5gmbUF6Lr3cr1FiU
 Mg_54ohWHnomsZbRiiGtyi.86Z35eBCFIJKm62sbLfaoZMZD.0CORCDF.G5DGQXJyy05a3J0NFXI
 YrqQLk3.FHjWEt9U7_d15eEcdvUq5BH_N.toZgQfinhh9GVnuwMMx0jWwJOysyuOmtLINrLCLoVu
 ggfBrTQ6nGhOZW0uUefGdHoVDW6lvgGpj9N633Fi7ZhyqZ5BTJg68hVEZFn7vGmn5hJzRdDyjfUP
 OlQYCy44T9C5Ya83gHeJ8LrSPRedIYWjVtqBF6g--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 213773a2-f4bc-4c95-baa1-254bc33656f5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Sat, 14 Sep 2024 00:36:28 +0000
Received: by hermes--production-gq1-5d95dc458-24x88 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 23a764f4fc0e6237015cfda9103fbad1;
          Sat, 14 Sep 2024 00:16:10 +0000 (UTC)
Message-ID: <b14d039a-7b06-4552-ae61-fbfb4e912b4d@schaufler-ca.com>
Date: Fri, 13 Sep 2024 17:16:09 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LSM List <linux-security-module@vger.kernel.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 GiSeong Ji <jiggyjiggy0323@gmail.com>, Jiawei Ye <jiawei.ye@foxmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for 6.12
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <b14d039a-7b06-4552-ae61-fbfb4e912b4d.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hello Linus,

Here is the Smack pull request for v6.12.

There are 2 patches. One is a simple indentation correction.
The other corrects a potentially rcu unsafe pointer assignment.
Both have time in next and pass all tests.

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-6.12

for you to fetch changes up to 2749749afa071f8a0e405605de9da615e771a7ce:

  smackfs: Use rcu_assign_pointer() to ensure safe assignment in smk_set_cipso (2024-09-03 08:37:17 -0700)

----------------------------------------------------------------
Smack changes for v6.12
	- rcu pointer assignment in smk_set_cipso
	- indentation in smack_ip_output

----------------------------------------------------------------
GiSeong Ji (1):
      security: smack: Fix indentation in smack_netfilter.c

Jiawei Ye (1):
      smackfs: Use rcu_assign_pointer() to ensure safe assignment in smk_set_cipso

 security/smack/smack_netfilter.c | 4 ++--
 security/smack/smackfs.c         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

