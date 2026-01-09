Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13436827D
	for <linux-security-module@vger.kernel.org>; Fri,  9 Jan 2026 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989941; cv=none; b=onG7Eh9oWGOwQ1lsJfemtPkIR642hS3mEiboJ6wz60yh/V5bfjqwJLVyZu/2ZWA1lZfA2G59o8BZQGsLyEDrAcrZL3uAZPXgcBOsmk9j71WuTRNSQD1QX/8Rg5gb4gk82qaRinC+tXz0mE7voaSBnPx6lsGJQg8qxalG5HoSREY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989941; c=relaxed/simple;
	bh=S+2yrkdOite85BucNrnsDp6+hmYs80fNYcDrj8TD1EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWOIKUGafvpaGzXJf6ARlOETBB/lpbJcQH5JQNPfB5dheYWG+Mw6d1tt4S4bwXFLB7skhadu0WkTbmg/aS+UZ0SNodGNfEzCzIpQkOW4bhFdFp5oEkVq3mlEAweuvfgBP5iZStBPwG8pOo4hwY9JPnur3P++pZgHdRnx3sC2P34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=rIsiuiR/; arc=none smtp.client-ip=66.163.190.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rIsiuiR/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767989938; bh=05/+8xoSDH8K/xInxJpLTAEy13sEgB1WR9SfI0ffREM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=rIsiuiR/Fza/m21pRV0esEVk03PWfXOSNAiok1wcema/YmCGsU6UvpPOlzFMq70KIYubD27p/IDd4xKeRSeidYGL0dFOA7rT0sehb1m0gwXTWi78uufDN9XBZ3xxmH0qPYRmywGeDgfENZus4gRASamckFhOOJRR0IjqdZpO4W95FsfGE/oq8TXPhAmFZwBKvOIv7qwLx5R1XWnA2AKXXmpZq/S65YWTuel5eZgzxuOFE8dnxj2J7qigUdFl/ytD2XjTKicgE8YwEZnVvAGOFlfivqY2Obwa8X9XQUcGEqG0GsggkEVra27ywMYQeRDK9/KRaIndKTcbW8uJsDbjSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767989938; bh=hFUwOOM2HEY/yAQPvKjtWpC2JB7M9ShCnTTIim4QNlt=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=pD8575TMWq6dzuClvD/hnTVgj/4sncRqcJ+jQ/61IOAIHVYpp6xYOn2KLWoTSPuxOIlLdPNAyglfVm0XsJBLU5J7560sSFwqAEmUv7YpWQIIXrArexS+8yvB537N0gJtNnKT+vhKRCDM4YMSN5uwL6+aCU/IF3aUAf1r1dOpXy7SleFa7C7cPOqBGnLB+Flb9XsigUn+SD1/7VTz8u1QcjF6ucPvuMNVUSMgBmGo5Dd+HIIGpzXFYp4cW5S675MJuz6lEYApivOpAVneYLJgWbXZEZUVlTC+ic9rDoFqeywtadPizeZcIZyR9aEw2C4tZ0+ZNFAO7FlDJwJ+R4a1rg==
X-YMail-OSG: sPiifZEVM1nv61aNn6T8cy5izBNRqWDD0Wk1dm8SuniYHPsDvdxHZBUjdcjuqKU
 QTUsUhoiHQs9J_v37Xw5aTqem1WtwS_2kduzrOSrBZd4dzYxyBp2F5NCBOJt1L9BBSBU4fljfN37
 vJTOFF_bJUijS.h.0.g63ORu4P7GqMuOod0h43iFhF.DJzC5YD_xDYSxGubxwIKlsp4xvNL0mNuK
 YSzddNyY8VC8l4UeYOInknZvVGnVYllXDaDlyU3iTWaK_FsbpGTlesuhbObFQPlXoULKBviLuaB3
 ukofOJfF5jw5UhoX7kd60yz3PBqxkyIpoVIJ9zXzqF34rmeurjBEdhIHsw7AEvJX_i15oYL9GKnZ
 zLPrbaviUg8ikE4tw96wlxCXt5SP3uG7mpXxe4D86zhVtfw0gUwqZ._iTKKHYgljJSmlrz5TOYKf
 G8YyH5qluYuVZeyqdd4TPFi3QIJRHalI_xLPfyi.C5FzT5cC240ljW23fdER0OIClPScaaoh7WnK
 BbQzUof8RHkvzlJxrqsicZG2j0h5KksB8eAKyx2UwXqXesyymj0Ul0wk03ZN2Wb_s1z_Fp5otmFF
 77YwH5dBiZRxsS9266OlTwXxt_pnuiq4eZ.aqIMmO1gJtcs0B2Mt20BT_LOsFRqxFAvQxqJZ5JZA
 ifAu3VFSPkygYXIvuh1gSXJqbkfPRLkF8ccTajRfBTtyRHWi69aC7iWNyCsZLinQyJBHbVCoMSZO
 uET.koa_3lINCDfoxPN0YWyoCULu4zPkzBwkSK5fDC9Aci5UAHVAD.vvLKgI6PcClWNF.V9mI4ly
 zgKUBQII5FKmTii1zDqD.fiu7yiKSb9o2FUvMamXrs61cKEj5o8y2_wojugKaRdMcphOq6NKVYJI
 Ud25R4Z61_tC7ya.IAD267Fd.9bqXtt7UWxZ6XX3UAmuFbhLueDmL.o9GyN.bxYEw9SCFPrjzAgf
 p73R8OznckrXegWCnbw94rCr5FX0o0lWgPncvA_u2dbXLutJRA7Yvy6y1XoySZ9MJidG1XMrKrxM
 c98Xl8DV8KhQ9gz7I9PkNn0eZGHetwvXoxYuKNyWKD6trOpQ52LDYbmldA9UdqReX9iTyFe0gqCx
 2PZzjsJknNr2Uc7bZA1KHS0JlXTm_fmk9QcjnX3tgMN42gz1hZu3_NsExA8ViR1kMOc8M.LXoXvr
 q_gldSjJWdHYAK9MjVJLiBWCz7yNfCPhO5klqrvIX6SHAg7cIvaJ20UtoLktttVLZfuMhmMsn_s_
 nxNPrwAaqBmLiYBsf2V0zTjE4BdWur.XTs1iovGycE2zt27tyidEaNNXDCXEEgxDPi3FzYqKHTl1
 SvESHuRyuX7.NCHDhu_8xeZ8HoVIheYvDzzz7spS_4Ca3Wy25mVdDMGcVklILNEqc4rAw7fdrVuu
 vij7u8.mWoF7cNQawAnvT.4Etf2kfCZ.lujOzYAvL1Zqf38sghpJwmIwEZWieubGmwh2DAE1XGMb
 LySPXnF260MmxHagtqNbsghSUMqASr9rXQgAU6MRSIj8wU1Mxjku5hYp7mv5Sf5Uow5iS5lPf0Ld
 fkqPK574EQsWLj_5G_.CkL6IOcWr3bPaiGIo3YyIvRWALLlEg80JkaZYwsyhGWFhnR9S_D5yugpq
 1s03uWW6_2lcIS80s75w4lCUuQAyGoX3wlzjzNO21bN8SLa2tmD9sl.YhcHSxWLwT5pVDoafq1fd
 c_vqtQvzZASRUGrsP6ZAzbiUW79gumk4An4msrzcSswOw44g18BC8AcrJlWTrHYC4kkKnSEtMpq_
 fhpsi5FUGRAxkTiWWcWkW69tCUsMdXlbN4caEoh44Nwo4.KDFX237oJByUPFnTuZ26YkYdTzqwcN
 iZauDZSN6dS68jy.NVVPvmVC6n2xtk1dW1O_uV77tuRGWrBqQb7SiK7xvR1S_l6EbLQNTRNplDtd
 7G669ZsSMeK.4oEoJrDh0RWYjx5KWdx82JcXwfFb8aTwCSe6hV1CN3fS6QZ8mSLFsMKzun3Iol8.
 J8LIpaLXpwWM6dhMBp8A5LQ3TVqNWIVB4kYmTKjiyumBHTteVb8MrWGbLrbSN1_bgEeDKP78uzt6
 5.CMsz9YGFK8.tMRDTIDMfe72ZMIIglYNr37LLup7gyB1f0Km_DRG7YjfVcHbgxS.skHrBsNEmPU
 wwXaJxi7dl4isEUqK_Lhabo2DMZdqb4q.xxvFtyTwGynjAoW9jjSgkTlXm4lEdJWmoWOIYExNmIW
 iNeJzXGX752I9oHSDhUmEpvbQdIim0mID_ClHRBA_NsHCHc3hJVFnUYXUCsT3FAbQS5z5T9TKQgM
 QzAtqOnQcoBPEMw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cad0941a-1029-4d8a-9828-88bb3a330c5f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 Jan 2026 20:18:58 +0000
Received: by hermes--production-gq1-86969b76cd-qmsdz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d91babfe764ca1a2782f1f9b2daa95e7;
          Fri, 09 Jan 2026 19:58:41 +0000 (UTC)
Message-ID: <2ea2e67e-8fcd-43d8-8cda-7df8d678d2b0@schaufler-ca.com>
Date: Fri, 9 Jan 2026 11:58:39 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Improved guidance for LSM submissions.
To: Paul Moore <paul@paul-moore.com>, "Dr. Greg" <greg@enjellic.com>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260108154604.GA14181@wind.enjellic.com>
 <CAHC9VhTyvEVLGLJkkyQnSZYSj4-YHPz82BnDEUwMjU7hHdbFoA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTyvEVLGLJkkyQnSZYSj4-YHPz82BnDEUwMjU7hHdbFoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/9/2026 10:51 AM, Paul Moore wrote:
> On Thu, Jan 8, 2026 at 11:08 AM Dr. Greg <greg@enjellic.com> wrote:
>> What is not clear in these guidelines is how a virgin LSM should be
>> structured for initial submission.  Moving forward, we believe the
>> community would benefit from having clear guidance on this issue.
>>
>> It would be helpful if the guidance covers a submission of 10-15 KLOC
>> of code and 5-8 compilation units, which seems to cover the average
>> range of sizes for LSM's that have significant coverage of the event
>> handlers/hooks.

Good day Greg, I hope you are well.

If you would review the comments I made in 2023 regarding how to
make your submission reviewable you might find that you don't need
a "formal" statement of policy. Remember that you are not submitting
your code to a chartered organization, but to a collection of system
developers who are enthusiastic about security. Many are overworked,
some are hobbyists, but all treat their time as valuable. If you can't
heed the advice you've already been given, there's no incentive for
anyone to spend their limited resources to provide it in another
format.

> I would suggest looking at the existing Linux kernel documentation on
> submitting patches, a link is provided below.  The entire
> document/page is worth reading in full, but the "Separate your
> changes" section seems to be most relevant to your question above.
>
> https://docs.kernel.org/process/submitting-patches.html
>
> Beyond that general guidance, at this particular moment I do not have
> the cycles to draft a LSM specific recommendation beyond what has
> already been documented and reviewed.  As usual, the mailing list
> archives are also an excellent resource that can be used to
> familiarize yourself with community norms and expectations.
>
