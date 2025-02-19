Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F29220F082
	for <linux-security-module@vger.kernel.org>; Wed, 19 Feb 2025 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002028; cv=none; b=hOwD9NPhyOFxWT7cxEeQJEaU1cHy3D/OL5bN5O2b+zx1ujcubGC4oUtTUxHPRcRt7K+lQsDlGLGomDCAHKx3AzO76LDYOA8baIGQHZK26eskBaQrfuX5o4hAfc2y0ZG9GVzV/KPx10VB/jHDNLvTWlb2oWsF/OY6KZWmX7kNAP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002028; c=relaxed/simple;
	bh=4E17d89Gr7KvLukAOxwi96ycgDwXGgKT5r4A+k6UOIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rvy5CVwhEcU/USr9wRrKsGsPnRXWb3Xh2SHNQov++049w1YBfNqQVDq2oKc8n7D/+dpdlXnvRW8rNOY4gU30yE+aNbj+MpOBmWLWULnpqgwE/PNWxDPabg/43aZpe0Ty4/X5Yx5KG4J8PyCnlJ5w6h903GWGRUh7Orrmgm9zpEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Hnuh5gok; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Hnuh5gok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740002025; bh=a/9Hn0ElINPQpiyOiqOBMNFdk9RHFOxc0g3EO09WZtk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Hnuh5goklhPQzWhi0DmtHUwkh19Lh1nWX3gmYP7ch5LjvcjsJFyhzsUrT+6VVKrqphPSNWJNS5gGHbqBYwHThBSldPQsYYy2438viJCxCnv834pNOIXD57rXYXaZP8pBCTYA3bOC+Lcf5Wg+8qRn7SBl+Csr/BsbHOSkvdkPaDQY93iOmY46renByVKynPgzglLOKSRFREZsq90OoAhWM6fw2BFqoL6OpTI0HVbnK5jhElyMuzOWDNZxL6kDXPhR/4zqJqW9rerNQs2h8u+ny5YRv5raVTNmopxvo9wpWoMIPqYM5lEnkn5Ane3fXz+xNmBZtgW5eb6wpVGy8zdyOw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740002025; bh=0mQ2rW/9T2zObkSac05m6X6mJcxutWdB4N978KQUq8B=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ts+KpQucqQS0V8xogdnQiVwJvtAEWjODHksKU+bQae+njm+MI+S2sJhnsJ1BfqusYXIqqq08/62o3aIVb045b8WfkKq0HhQkW+ng+yZv0BdhhykND8ouWog4yyf4hPzed8WWDhFbirzb1DIwCA8vG8y94r+ejnP90Vpv8SlO5TJEI5Axq/665rUn+YHFDQKtvdRHfB/c0Bye4wOb6RgeaH4/uhCO91bBGugHeLsBLU/L2hR7UO1i5Gv0aQ/wx0gFjfj+h168A63qjCZSQEG5i7zeXPy8lbv72xegsSJL8/Ptmj5Nei8LQ9drZC0RJJwDicDJpt5jl8NeBpHm/b6dCQ==
X-YMail-OSG: _UxVbOcVM1nxaZvyfPReqJ9AQyefEZZQo3N6wKwEl2fYFnJ3_DGH39WKV9fkgs0
 nrLywup3JF904VSdvNp_ahRlhQMIEdQAYyA7GQoU7UqQdd7jpf6nVUUNtCGhw78_2SvQaphQMmgE
 s0l7wD09tHQTpQUwN6mgiWDXa.rp_c6gc10KP25fprzIQOvqpg8GC4LYWONlvnfyk5_HLzQ0TXCl
 nZWxJlBu02dFP_KzA2trIVd03nG7Yt.I2moW9.vFLA1dzRq_e8OU7oz91r7bCNxSn2zlBOifdqsG
 OVJI7IIokuu1Eomf_k44NnHY33yHqWOUKyv1pjWjTmy7rIcNs.B98Q_s6nn9htjs5UlS6aQ5tzXV
 NhMait5M6XypRCgDiGEkn6ciEwowllJtaymfPkLF_uyHXVkQXAVdES2fMoUp_O9kUnHiYy9C5mTX
 8O5J8GwlntGwO.d6x0UoVF1KnjgWkjgYCSt0zKoeQHgm78K7GhO2hsfeEyL3wXa8NC.kLVKl5eh.
 WunJpT.fskpNmMH7WMbRuNE7qk_6gFToFUNGdzP8QBnpHUCigTwH_Lx.Pc95DIRwMHJnUtKbj_gt
 YjbunmiAUogdO2yuxYXwNP6ASHyUf16lt0Dew36bYXyBouNlnszlYW.bjqbgFGBEjS13uUZMm7I6
 .0SHgeDK4KIWmgi5tK0W4E8ZO.dgTauQtXqW26Q4ihIPk6uzhuQz5WigcKrwpZtfSX6o_GyK030t
 RHm9A2yRNtYRbqe1_060qGL9K3rGaxFlLYn72alDMRCnUW7LEXDz3kZnrUbSe9etDa4UKmconUqp
 wMXuH_Yzs4G_TCsftikPb._Er0F_gCyJMddJ3Tsjy5QY2_ntTv2ht8_A_cRr9R1BePL3pCFM4XMR
 Ul1T1bniIhIwsta.DaCDV2JIBkimkZkxQgRUTyfkxvV7s4WeEHOTP3rjFZmY_mTYVYmUYL_DSu0i
 KNDy3BGJqZUq73wyQkWFfrUH0k_oVkAEQEAgrM5FynEgtnpNfrnr2DRta2KizQbwQDPIA.Inr65F
 G_VZM0xzcJvfEINIzIDZ73eoXdp26.etHfkiHO4kPLRzUQFh_CmHhqPDMzQ5HUrQsG9QXYKRyowM
 t97cyUZoxXzQlu4WuNJ2e0_MUWkyDOV7rhLUjg2pSuPCIhXy5Fj.ea.eIBtxOE6B5T4f0kTRWEP6
 40LESX00A7_vJLAT6OJ4s2wXSYaRDQtX9EO5awlsukzZFRM8BnegV24PMw4KzP_N7jsfJcsilOmR
 d1CYvQ5hfULL_x8HEEMrACtyYh59v6EVxWOUu.dpSHPA3U.F1AO1HteHKfG_gdrZVz9SLKQTLtbk
 o9cZv48yhZuf4nTVMwQqNg_KBMxb2FU0Jm4HJXveffWOAPMV.8fDr1zKgz.RuQcLh2BZ_whGzfHX
 q2pAk5VHsNnGKAs87ofm7fLIqpHcikiwb9BT7sFNE_BzdjVLlIXGDsLMgKMoI6lwuxOTFY4ytLZu
 opg1.N0MFTcrU8wLjv3cbQGvXJna6D90QpXbWi6jlI9oDWFWLhjdUS_1h9oyW889cp0Kxz8o91tm
 MlKrWaDaXYW0gL3Wqclq4_1Px8Bh3kMNF6svYNptG37BO5Q6t9GiBRtZuVzruGBVO.ZsUu3CVgkA
 TL2Nrmm6F720ONN1sEJ7B5giFyNpxbEXC.YYkl47SKjLuVhd.vUcumAWn0X2wcVIB25zaUAtCD9d
 rPkNUSqLCrzi5h3QsosuFwSMB0L5Q2J_bLmRcVTDYLKnr3iGPjmNKxQeJOJWrJ5t5ZoP8jcCAMYt
 SSxl5svGjaVvYtgDHdIAx0iirnJnC3.RNcDv38tU5d1t3FPfJ6fN1zDmLQrn_onjpm9db2DtTDNw
 dMyu8J0MvMvKJwxJAmUm50Y9Q3Dg.29FNp8yuSvkcrJgKtT2GiNox4vyQnrx_QN83zjJlaEqr_YS
 YrY03IhbzZPVrCAw3mTrxKo986duknMTlAMTkyElY1oWGFatPZ2mB_ThtKq506auqsWm_LjhCr3E
 Ehdxonmb.lWjFrJRKMYqPFRXpCVXuKkGdIbOjd8JCcX0CGgW3xQE.FXLJQAuFH7AgO76mNJN0rKz
 VpNxPk5xH7u9Rt5P3nsJNiHky0CpoJ.2YIK0mSvNPhE8aihwLmjQVhu1KElVBL32oZs4vMZZxJQG
 kfmUGqLWiCJFZaGoC61N8lk0Qhx69xszaLmNzR1P2EzxT9YHmrmIQmvcFCI37nqpvQxPKSMEyoQ0
 1UB5mWPY.R.HzU9oPiFCUnPJoI3j7Oq90hH6pQW7Brn2y_up.nr5TvakJhdTWZ0tehQyCqBt_doZ
 rsZHvfrodiA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d4282650-3caa-46c8-8dd3-397f3742bc54
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 19 Feb 2025 21:53:45 +0000
Received: by hermes--production-gq1-5dd4b47f46-mb2l9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4b7cd1b6895677b7aeeb6fdc0f33fc3d;
          Wed, 19 Feb 2025 21:53:40 +0000 (UTC)
Message-ID: <730132cd-b016-4fd2-a239-031c6ac9a5c9@schaufler-ca.com>
Date: Wed, 19 Feb 2025 13:53:38 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smack: remove /smack/logging if audit is not configured
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250117214655.3138888-1-andreev@swemel.ru>
 <5589ad00-89f9-4f87-9de1-c869fa527c8c@schaufler-ca.com>
 <3fa2d093-8070-48ae-b595-e2441966c72a@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <3fa2d093-8070-48ae-b595-e2441966c72a@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/20/2025 3:16 AM, Konstantin Andreev wrote:
> Casey Schaufler, 18 Jan 2025:
>> On 1/17/2025 1:46 PM, Konstantin Andreev wrote:
>>> If CONFIG_AUDIT is not set then
>>> SMACK does not generate audit messages,
>>> however, keeps audit control file, /smack/logging,
>>> while there is no entity to control.
>>> This change removes audit control file /smack/logging
>>> when audit is not configured in the kernel
>>
>> Is there a real reason to do this?
>
> Not more real than there are real reasons for
> fixing typos and spelling errors,
> removing unused or duplicating code,
> keeping one tab indentation, etc.

I have accepted this patch. It is in smack-next.

>
> The matter of style.
>
> Personally, I deprecate fake controls,
> they make me (as a user) think that
> it's me who is missing something.
>
>> I can easily see systems that expect to turn logging off getting
>> upset if the interface disappears seemingly at random.
>
> To me, the system builder who compiles audit out, on purpose,
> must be prepared for special treatment of his system.
>
> Certainly, I may not have a full picture.
> -- 
> Regards,
> Konstantin Andreev
