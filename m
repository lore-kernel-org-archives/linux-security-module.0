Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3896E85954
	for <linux-security-module@vger.kernel.org>; Wed,  7 Feb 2024 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331990; cv=none; b=UQQAvsazEJT6pS0w0uqrvk95jgh+m1VuIFbsUrY7Ph/scjGCWdu+AlSruQtvFiPXAN6yHRdkMS1hDpe19sGazRk/wPRMsC5kxboA2xreAEyjOOykWBP2K1wFTXJPD3KtaqwE2nFaGb8zwfkMSUPaoPhBtpK4CUt7hygO1tQ33qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331990; c=relaxed/simple;
	bh=Pt2UZ0RiMjRIAFx5U5G+zTj509nqmvAjvwFZ66gIr18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxb8TvEUuf9GCRprzfefoV9T3JHOf95jUS4gH9LMnwtzKOkamxanbBnO6eX7DrUOlKTBrXJdoEenGOPJZLP+RbzHKd2iIVP5O0xCFOD6yKAOebcI81hAxZhyG3ph+hAzJFu7TYFJyCZi6qoAzMDTELg1h/4zq7qZoaXxPpnByBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ESECJJdf; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ESECJJdf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1707331986; bh=Pt2UZ0RiMjRIAFx5U5G+zTj509nqmvAjvwFZ66gIr18=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ESECJJdfFHMB7Pmf8ipRr1r3zc9ooe0LWg4pyB6aVZiPQivsnep6Kx6pe0evUj5y8r6/JM8TZayovBWf94VC9pLlwCnKpiKrDzz+2OYQgktmna9L9wcvwvWM95YFUqsh/aaS8yQg4cC2mOoAAl3r9W1SOw8Vge9rws0rFOnANfwVa9xR/zYncLwr3A5FMxzHBOb9Tcts1NqyH+L5CTJWsti3FrSqEcLyLaivGZXPfeZtBnIfxeyQRXusVUlJxCDixmtd6M9tBK6XUMb1rBaygxEXQ9j3liHfDl2T0xZN9TcjwRbd007mqpNy7Ansl9oZUgTVcVG/ZtXhWi+5kE1Myg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1707331986; bh=VY27/Sd0qZfhp79BzheCfSMJIhGIo8cFPGIPAmcTJxx=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=lGtnrjatq8e5EAug5mA/t6xgNjd9URvNE2u0xV010WX9wK+vZulLnzai/qvCALso+9JBB6XejMgSp209OmbRm6yZig1sTWscelyLbIqGsG27HIb9HjCyQahWV2IF/0QbajmpBOeB7W8guwFmz5W4r5EcHjtDtfAyNKw/+C3y3MWuLOYSXpVpjPTFYtny0gBVUpntklggZAJQ6p2GoyT2xlDRVv0W5CTd8V4HT4OhlZgbtbFjIQpd4QPIyho9AUNzVtgWlehPubvTQPAUnWJk1wGf1jRQkssltou0wAYRy8nob5Y4vR9d6m9oJ/Wy0Ukyn271jRQSUqGcLFTTcsxobg==
X-YMail-OSG: Em84oP8VM1ml5.f0dk7SiRsXWzsKH_7C31bwWKSJgqElsE3yJrJ6zWU0JDSIDDm
 7utPZasw4FL_VRFHuA4MCSfylgOVzkXWlSck7AnpUKZD2cvYpRytT4XIJKHbvEJQI0du5ntrxbQb
 PKUi7VSMeNq9YEIJV.9wCx2j57G2FMkvKbC6HQ_3_P9AmRc3Nhgz5Y_0Qyy3hhL.k4cELf9JX1Mh
 108aj3izWJoKD7IJXPdwmLV6Cr5A76UsuTXhORs39MAWyJy2p6RFFWEA44JKoYpUoJ7uUMUEX6QJ
 1zquHYmxUfR2gmpXbnmIRyAFDfc3Swq4UHK6zsVldW1W_8C5DSJjA7Ssv5xKK7ak_81iuY_vUgkW
 ACIlAV6RXKLBZ_bJu5FPNK3nfzHjvPrSWYnjqbbrXmZJ6HW3soQ0TnbD3E4TftML8SNLKa7TQDbv
 qYFbgYMosky73UGCrGHvGGgM78pJe_ntM3Yz2tGJ9ri5x_8vICV5MkxPAd1TiUZQRRDCKW552CQ7
 OpfLsAMvGuzsUAqdmxbEQbF7haPRbBKF_MOX8WPcRxgSAU0q9BKgkpwxAlN2fpkdd412jyB5RTzV
 34QclsJyKTjirDopYdJ9DVImxYFDKBsuSxaWVRZ4xHBTEYtCe0z5FvvexUz3BTY2Oh5DdDccHDns
 siVjIa63qWB7Wi9MfGvyne7GinSwFgskDG4dRGwz17J_iKRseoDCU035hfpUl2a85s1_RC_AfhX1
 duemmi.EhHsVaqMvtYzklLy_x_bkbhrGcyYaefo_haTIBRrWbNHz.5bS66kdXBVKleGzIc0NKikN
 5A53oi7BZSACHxfkEKaPoNulMANIBJp4q8Xtv3ISMet7.ld_8D8IboLpkxqttiXX0jTUIxYWd3R2
 5cefsz7VWpEJAm32DeEB5fk2zWEq_c0fLWcVObLhsow6M2JoutLvdWn4cvefvTWGbrddFPg6mVbb
 EwaDjXP9f7x0fECjiDGZrtodMbx60tgw9gai1loocc2w9Jc5SAAWgS.NQ3rShsFHuCU9bLzNT.Qp
 AmmyaXiO7WUspiVWgqIAL0pmmsZNcFcbLjHEpTHdcrKRgVq46quHR58W8Wc.EWlNHuZMrlUT1dd3
 MVUvXpF.v7DDC6mKCF9QHUht5W3ZOcyx4gaMWP83jKi2ZNB1cvb8W4Xx.o5J4QeN.TvkcSfReXvj
 eH03gETFlpnu0Wh3i09eGV4m3ZGCAN2.Qc8TVgKZE8uNFFXWp07R2DRDj.wDpTz_GCSWrHYB6Aj.
 JneLpL2I3Knv.W_XOXIZ8J5Zy4iodL6QSzn7.8OqECnCLwhDSzuLj4xhnp4CIUlxFImcb9sZwBpu
 IAp3nkx5mqgQvFWThGhOr50tiar.x.QAzVofFQEazOVB18h8yWaueuloGeWenKEZRcjyilElkv8.
 3voJTNkmlV96BF4gTpScV5Cz0_WHvXmixfD2fwSXm9UKDBwg8PfWsYLomIPezBYRIfa3bs8XY.pE
 2g86m5LbA4GXOxCI4j_Acc_6u.3MchE.iObShHMVO13UqEDv5Lg4Mt8m4Ro9MC1yb49YqdKDq42M
 qAjJ8kvS5OmC8g.Rbg8bwhpIcvb3EDAnKPwJCcCgg8CeLgG9XDGW0qc.0Wxh5.lg0aUHeeRTyPZi
 5UUIpxj3yXzkR9W2_QnbY8WspNUp32ypyCmgnt8XOwPRclo2R2MlB8w5rB2_eo0awyMcFR.X8EVY
 TvRP7VDhwC6aD_EjR2pmGAh24p_3l8D58pihgu26qAOv_P269Zovqbaku8mtQ0oCs6QZfzQCCPLD
 x4mXuRyCpT6d5I8DXNFQHUwwQ.xiZ.lg82IegMzxRH4bdhqaxLFWehPQyhtA7E_QkV_ZN21WG7DH
 rM3ibHvOsLHsFhHyw49uOXxko2IXDvJT4vxiFMyE6.uiCZlGI2BKxO7yeTmdtKs2oUnb85UzfCT3
 95Fd3z93eps6934nJ9zX13MjATTX0IzanOOJr33ovhlCDElCkH0jcMlufS48RKjBnVqTOtbfn.IV
 CkppyDsW.LGHKvq7_GM74QbdsWojC7S25aFhaibAYXIo2H2WeGoExusipoBhEq9F5_cCj.kClf0j
 lA5yLIrg2P_buqLtF8XREsF1DiIArbtFb_Vf6IXnFw9mD2fJ9aNchNQNx.kbJhyQSXG3nASbGODf
 Z74jy8VQFWUjUsvYGS5XTDMmhpOt_HsYDkgW9VOQPqNJ.yIzWIG1DAobOVmjcSKbS5qoH4VTg7ks
 ES7oeoXmyBp6FP_5_2KpBlMck3J7UyrOGxR.eyLL6s2PvJzF2JP4V5LnO8Hgo2mompyke_w--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c0e7d490-1059-4c2d-b368-72ff8cfae54c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Feb 2024 18:53:06 +0000
Received: by hermes--production-gq1-5c57879fdf-wt62k (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8d941fa5d548be17d5b9eb6e942a4f5a;
          Wed, 07 Feb 2024 18:53:03 +0000 (UTC)
Message-ID: <757dc423-f914-44b7-98bb-fde5cd42d33b@schaufler-ca.com>
Date: Wed, 7 Feb 2024 10:53:01 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: smack: Possible NULL pointer deref in cred_free hook.
Content-Language: en-US
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <ad9dddfe-0fa1-40f6-9f8c-f2c01c7a0211@I-love.SAKURA.ne.jp>
 <fa719d6f-1960-491e-89c2-ed2c14d184fc@I-love.SAKURA.ne.jp>
 <2fa0a73a-1d03-4937-8599-e4560297af3f@schaufler-ca.com>
 <f15e4a73-02e1-4758-a8e6-0edd27224c0a@I-love.SAKURA.ne.jp>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <f15e4a73-02e1-4758-a8e6-0edd27224c0a@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22046 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


On 2/6/2024 6:54 PM, Tetsuo Handa wrote:
> On 2024/02/07 10:39, Casey Schaufler wrote:
>> On 2/6/2024 6:31 AM, Tetsuo Handa wrote:
>>> Hello, Casey.
>>>
>>> I confirmed using fault injection shown below that smack_cred_free() is not
>>> prepared for being called without successful smack_cred_prepare().
>> The failure cases for smack_cred_prepare() result from memory allocation
>> failures. Since init_task_smack() is called before either of the potential
>> memory allocations the state of the cred will be safe for smack_cred_free().
>> The fault you've described here removes the init_task_smack(), which will
>> always succeed, and which is sufficient to prevent the smack_cred_free()
>> failure below. Are you suggesting that there is a case where a cred will
>> be freed without ever having been "prepared"?
> Yes. If smack_cred_prepare() is not the first entry of the cred_prepare list
> and the first entry of the cred_prepare list failed, smack_cred_prepare()
> will not be called (and therefore init_task_smack() will not be called).

I see your point. Thank you for the insight. This is the first real
case I've seen where the "bail on fail" approach leads to a problem.
Now, on to the fix ...

