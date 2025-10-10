Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5EC26A1B6
	for <linux-security-module@vger.kernel.org>; Fri, 10 Oct 2025 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760131444; cv=none; b=RtzyHKruYv2wApAK99RZd3Zub/aaOpk+dV74rNnUdbiBRzoSkwv6CpKJ62V7h3WsYc9m2jH1HOZ5EZqFP08OmwpvoQAkEEbU87chr3mc/N46Mx27lOUbLw2ZMc1dqtXACKqjRHty2u/I1bnA4nBIawv5rXZDX7v9nJ7TTds3j1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760131444; c=relaxed/simple;
	bh=S72PbBKn/SIu/CGwvRLzgDVXz41qrj17EeC/J84/BlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrDjhosrAogPDMWZjQM70QXNE9xINrSiL+TWhpsj7a7xW1WukSWMNfKx9YSreJi9wW5tfl2q9rUM/dfCU5nn4MPfUeMmI9GTcq4jjMc2nTnFEqQGehYF5JN46pcTE8Lc1INx+fH38dVAfpFSRS/b00lvkBTWy+iZt62+N5qlCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=lEmF6bYY; arc=none smtp.client-ip=66.163.185.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lEmF6bYY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760131442; bh=JLliN1JG2MaC2THuh8kGrZkzyJ+IEx3Txs3LnmW6tKQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=lEmF6bYY6FSZXy1bGmfYfOIsqMqaj6Op31+nDlxUQ8VXFzGhuL4xgN8/lCc840/ic92jEIyXjDvhOi6GRyOdKFDnySfLgH12Yq/pL9hnF9W95IaWQTOtX3CKTl6yARPtP41XfpKT2R6OMCC6xJtCSwxRblwpuA+D7VV6ZDi3tFlGhobZ20pQ3hzEkytdpqT1LHs/OADZs0r6fUFqvdxSUAKzZYKumWUZjTxcpw/fkKTtGacSbNT16VUq4DASQLQ1qPokMMQR5XfEKVzZBaapEwwszBwbzKu7FvEmiKmaRw9/C7kUJZsgOG4xh+7nHkVtId3xEiv54/STOsOgRwLypQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760131442; bh=GMOI578hSCPICPKezTnq9pAYmtqve6bmOpuDV830XlI=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=K+Oas8xEAMBBw97Pt4W+jb7MX13y//BgqeareUY/CnuiUaBaW9nf9/l2UDPybbPI/5BjtDuCOS5S0o1W3xzGJqSdkBBanub7yrg6spcGNGJrJZBE2364/W6Je1ALpU54IOkFiZ+XHudJ7M5AucH4DmoOpd81/tbmw9eRfyYlkSfHSN2WZHxhrlpo1KKmmSnoZncEyim7AvUsWLXLZmnUNkC8v1mkBma6a0V3ldwq59G3VnY09Qvs89NOv38Mfe+lvHj9JKWKieiurvvu5SM5jMOcgRlVJAHwBhWvZhhtgAdlXQaaETrhru6I0dtiMGKZAzT3ivV4bgrNa66LAcEhKw==
X-YMail-OSG: hj_K0qsVM1l92HVyJBxvE.yOYHHP8HsCY5icmN3yiVGbE01Wrt_SWYs17rA.P4q
 UgWYe2nMn_ENZ.4zeSchJVCw1BK6JfupH2g5qHa2CGLKfwOSYtyt5a3iAY8J.dLW6jjMw7mKWcId
 HLNoJvkBcleet8dYBsAvP1Zq2AvdNTuqmBhFeE2Z.fm5740wKcyq8x1RUTAurdJBZwW7dCY2aMLc
 mL_5_NTgf5i0qjieiEV91kOYM19zVRQCPGH7kMhVS7lsrhQtU_a3cg.mrkAvFtyNyMV10khHxphj
 F0mKITRqSg4DF168D_jZ6VXi5nAvJOinbWa4ZGjLxh49DPBtmwFZHtLJWA57q8EVRNWA9KqljyHt
 uELu3PzG1Y_p5FdRpq7P_hjKAfweTGTYuLtnq2If.2qQNY7gnmFL6I01kT0rkj5cLCCqhVkSuAVD
 hM6249wYb6.Q.j471twZ1.vfCzLTb.G0r1EJXH6fgekbHyYyN0b5ybILAuGvvQYRWsoaqdMYQSL1
 6Yzd7cdk0oGc4OveyFRGX6lh1OuvcB7fYbIKh8CZNGRYtaEhyvrE1eK5NJGF8BxyTgezz1Pij4rE
 P75X6XFtU1KyQsuJgad74aX5b5CjgHmJ2Z06APr2Y6x83HxZilERseulj8ALvnPs1HxEkq6a0L5O
 HapQUB.IAtiMhUWJbPzhjWLelaoGfrExF0BsbA3Z8WjD24ePLO_hdx6MmF7PoWd655u.V2RPzpOE
 2bkwAkYiJNFS4BF9rERzXU.sa0W7d1ThhJjl2eQSOYArMGNmmw3ThOrQ3aeCIOSQVhY1lcazTB2K
 cDQOqH0jJzaF4WMr8eOWby8ZFH.tZZGrINZsR7AYQBNGgUSxO4XH2cvJfuK0y21rbut4FNxTWM5v
 Qh3ozC7zwwrlj3SJlz24WNFCyF0gG0MLo.jxj8ecl8aDfe0cEWog8RZuSboLiEd7Y4Zx_CIaVCma
 hVao5wLtCrObvajoUNWQSFQVFBLg74I5adQvo53aJkBWbtqo1CaJQy4yhhzBZwaK5B32LNzeL3QX
 UVfoVCECcasaKE64iHuQaiJqUo2n3mJz3FTeYv7CggS0b1nbgGfRVzUIFN9St98_WxUMFBk_J5Q3
 pBTFGp05JD8K_x1qSdoO_cgIEttjgVo1ipB7GIB3lU2qgbNFOY43RmI99urHY2s.UhACjHWoWMZW
 F9Xsfyh3DFcSs6qmqLVHH1p.kqn44_E0mXVvPGhmERLwuh2mPl3q.NhgqhNAa8qqgQmW7WXhjxkk
 C7vL8Z3GIiun69185akGsa6uH7UpWqvvTUfa8ekQKtP4KxuqrXtC7pGJHS1bnyMfwofgevlZuOS.
 6JNpLDqK_1u0ZVkWfYy4t03fQ6nFQiIf_bnjgcv51lZe6aXCU1gp5oaT86_AZLf.itv4JDPUUOtd
 AiDScIC.thYeAVVle1sc9gJclQUhy.I9nGiA_9kieHPo6yW0V0lWrekSRzo35QC1iPJ0Cr3625np
 5B8HOXWEUp1Cl18EWmM2txQ8iK3h7IEOJrvL6mNvtB4qjHshNnW3PvqorCCjxrbMG7HVztBkax1i
 TzBoBertrMliR8ti_eGrE5ALcWFjgNmoaZh3T6ie5O73ldmlTv41IhlNJVY2oMxTH0lPdLt0rGjH
 hnure8H8tb..33FUrB1pKK3XOuBYtp4hBPjZcFuyRNuCbK9LCPG0LjhF_AJKiFAb0wxxHYF6OIXb
 C2i3iDTGOQNwljpoDII3T45TRZMUIqnA8DLZbLJ39dleONdSQoHpo8DQy7JVfzyn_0Do0GLrZNGC
 pJS352W.OBUFqJAsAQznyGUTH43miTUMAw81sEFjvITQmqWEPj5SAHkFp_wdNBas0oBQTSFszIFN
 YAY8kSSNQbiScafdRPnDk6FKaFzytLegpFvxfaO22gYg_aeypUWhZqdIzuq9_6h9U9fLLQEH2JUu
 wkTRkmdVLWm_FPdxUYfX85yxJGpJ8gNdgAamR.roTgso3k2DQPUF7i7W9kjZZg5p8PCvdwVIRRfE
 i1a7vFHtmH6jndvt199NFU6X01WpUwbYxm6XfsvyeLDWhJvSlMQeTvNSE5lcCVDFFCjtuMmiQm8z
 _P6952lyxHJWZsLjLxaO4zpNhBqLXQGHmKO2j2wGH9ABpUY7FXih6vFZ87TWF.kLViiOpfXJDpE_
 udg1SkJ1lPmTBMx4ZDiAC7BK0cevHLKHJFt6R2FgV_B1FjOzcD.w0bI1SImML8SLS9_5zF55Wc7U
 cV7AmPOYTJcsp5dLQzsoLF7uhtPLZ05ag7x_JEIZ.r5Tg3DZi0WfQrHGkiokOJS1oegdfKrFHPsH
 cRoweaY7N3S8WY1uzOHlwPa0d93U-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: edcc4e0f-3264-44a5-b08e-f1aa002d6f1b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 10 Oct 2025 21:24:02 +0000
Received: by hermes--production-gq1-66b66ffd5-xph5s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 698bef460da1b112e1d4caa5f84dfae0;
          Fri, 10 Oct 2025 21:13:52 +0000 (UTC)
Message-ID: <950745ad-b818-475e-a8c9-fe0a9e82c609@schaufler-ca.com>
Date: Fri, 10 Oct 2025 14:13:49 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] Wire up lsm_config_self_policy and
 lsm_config_system_policy syscalls
To: Song Liu <song@kernel.org>, =?UTF-8?Q?Maxime_B=C3=A9lair?=
 <maxime.belair@canonical.com>
Cc: linux-security-module@vger.kernel.org, john.johansen@canonical.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, mic@digikod.net,
 kees@kernel.org, stephen.smalley.work@gmail.com, takedakn@nttdata.co.jp,
 penguin-kernel@i-love.sakura.ne.jp, rdunlap@infradead.org,
 linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20251010132610.12001-1-maxime.belair@canonical.com>
 <20251010132610.12001-2-maxime.belair@canonical.com>
 <CAHzjS_uBq8xGCSmHC_kBWi0j8DCdwsy4XtfkH2iH6NygCcChNw@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHzjS_uBq8xGCSmHC_kBWi0j8DCdwsy4XtfkH2iH6NygCcChNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24562 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/10/2025 11:06 AM, Song Liu wrote:
> On Fri, Oct 10, 2025 at 6:27 AM Maxime Bélair
> <maxime.belair@canonical.com> wrote:
> [...]
>> --- a/security/lsm_syscalls.c
>> +++ b/security/lsm_syscalls.c
>> @@ -118,3 +118,15 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
>>
>>         return lsm_active_cnt;
>>  }
>> +
>> +SYSCALL_DEFINE6(lsm_config_self_policy, u32, lsm_id, u32, op, void __user *,
>> +               buf, u32 __user, size, u32, common_flags, u32, flags)
>> +{
>> +       return 0;
>> +}
>> +
>> +SYSCALL_DEFINE6(lsm_config_system_policy, u32, lsm_id, u32, op, void __user *,
>> +               buf, u32 __user, size, u32, common_flags, u32, flags)
>> +{
>> +       return 0;
>> +}
> These two APIs look the same. Why not just keep one API and use
> one bit in the flag to differentiate "self" vs. "system"?

I think that's a valid point.

>
> Thanks,
> Song
>
