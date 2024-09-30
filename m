Received: from sonic310-22.consmr.mail.bf2.yahoo.com (sonic310-22.consmr.mail.bf2.yahoo.com [74.6.135.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15267192584
	for <linux-security-module@vger.kernel.org>; Mon, 30 Sep 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716266; cv=none; b=EpOavP6W8tCqEdzHupIVy4NQ/R0/t/Smqj9t77hSemYAWH5FbhDFdpam/bl/FOKayF0CYsFmTexVzG5k9DbcGRaiM02WKOZyYdJ6jSLp44fl2Z3dHBjBBEGZEg5iITGX2rzz28qCj7CNEgmld++LBCI2AFYI99n0M/i++CBs+Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716266; c=relaxed/simple;
	bh=jgYmi6n+M3i/tr/TCevHYiAHtA+9DepNap4HrUl3YlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3hjVaRwPw5PB3RK7xjYo8lp70+Z5MOfKh9JTL94esLYrA0X7ePxKR5VcECfPz0TmtufDscy1wEOz0RBwFyIOEm7hqj24SMLjeBiJ7pVM9hJ9lND5HgBazDbkTRrwINgGP83YYCdLhU56rT2j+yIrkAT8c47eO2APbxopxTQi+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WWklnrPl; arc=none smtp.client-ip=74.6.135.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WWklnrPl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727716261; bh=ARsJuCXumr0uXibVYrU8bdstx5OSphyqTSvmC3OEjNE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=WWklnrPlhnMLlKX/TJSwMSYzCsO7R4CQgsvu72/F4oiZRgZ/lYxWwE+3TbCdqsl53UVtPJXipX/8NXV+oXCWEE1YBQreipu94iO/AbED7cjoqEFGz4N5FZ+ho/BKvvTzBmKYwP2LHTmBj39OwWFwagtyBjCihg9fgaxbnl63+uHVW8QGs32ZEbOUcOUWgy/zexMLQhmgPR2uGqNVLQ+kc1Ut+hwcyohxOMgg3tLstC72xPS0kZuzjirC8Pd2uJLVllt32UD6Jy/XGsUEp9WtDfJifmiVZQIEp5LkJjVYNL9ZhjAtQVb9qv5EGCaEpp+LY/aANHwcd3vUgFE9hGjV1g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727716261; bh=lL7pqm1971hA2C7/0hCOd+IXUWFV0S5cjUWZP+1OwI1=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rpvwHWTnogkGCG0AUp6Cw0NFH0NWkSuBW549BaGn/yzWKn5vIJamvi3+K9kOrzj+zcruWkFU4Ezn7gIO9jJfOqPjLrWB1NDS1VCdkq6eD83s7mQQqUSM4noG4WKhthkteyfISneJNfXvEUlq51yAM/XXDyO9YhxqlmbWpKOhNJdRt93ItLGEnf+Omp9YrPVFBKnpieypDaRrMlx5yD/YRIUe8MRogfU2wBVf/iXyFeStpiFdd3ZAQCJqKSsFQ7iuT4+6+b/CindwgCq5sAVwuGjxp0NmLn+fr6ZGl5g2eCrSTLkUp7RLHRYM70mltzHZ0fgi9S9b1awAnnKMasJJ+w==
X-YMail-OSG: lSMRYh8VM1nRCVws2jwvaZRXQVozx9882S7X_5lDG.RiorR1U_qtQAOx8KCJFOw
 FLyDu8ITLVOm6AJa1NEboTwguORQUcG6eQSWqHPP2kkuZ7hRXQG6Eth8ZL2Pe3M_AY9err8RtE7p
 foDSLhWf3p247Dq6GFAYoPU7OlPMbWlphHlZKDxXnPfEpRva344RnLT9RgLFJ7gRhSjMCpdBOmN_
 K2OkVNcHPdDumeNhgGeSFzxNkF43piri0hkNoYPEH5.j1PCYv.MzUOey_GsLlHzj8kS7nrJiBdC0
 f9k53YyvQ18BDfGoS1kUDo7RREVawYAnAPYVs0ROTOA6fKhcSAy62wVDyOBKmzCc94Nyp05xPf9i
 oE8G1ZzGVMyToFqAhHaEwVdPZl4XBVnjCxDp94XrjApkkwHbStFxj27EYfUgmKXeP0aQNfI6iszr
 J_OkgJkbHTKudoofLT4fJOOUe88301wg1mX0nCmyO9Kv1Jk5qflUAUyunPAk08PN8mb9oXtlniMs
 OS22qUdR6Z9Xhe5azdpjb2tQfuDfNc2gmLHVNv8i3mpmdjolmkN4A6OiRwKH2o.mIO3o6Vy3xIny
 iunMLIayv1gaWnxXXlJwbAGOIpXl7nuqSba3NNBZAZlsJ4aEqKZIF4KOHeExL8g6mSDZrhlPjn.L
 4MKm2D_ZJ4.jERawl0dYvkk82Wm2NotJVH1rQpy2IAo1eQTJxmwNlETBQe3QhOQGj3AjYwyphU_K
 tHWAep_k9F7lduwjG836lXTezN31YevKmekftV.jJDOiWpj2aGi.7t77AgfPAIXDNbShu4yrqzR8
 v.0bRPaYk_lPOLc9Gg1TBXUvuiYW9Klh3M3WZLTLdAglIJZAsaDq9AxcclbBYGS.Eg1HMGV90ZY4
 eI14oyhTzTpaDXH4I_U1OOJ4iT_e3dYaM66vU1QHi2I.aZmZwZ1yTrsNRhieZc_gcp2.Fb324t14
 95dTnm_aUKkRrXbRohb_0lKTvzI_zIdDS_6ZUvQB8c2kOH2q_WSA79eMulo4I4CgT.KlFTkNpJSX
 k_7DDU_KMLG8lSoZdQZZmaB7OhNdeHZ8NHz4Q77rFSqMJHxbvBzPSpB6ch9mLcCVuj9ZkarEtPG.
 fGKjCI_CMiwlYVTDhbhua2wKYICIQBct3LTmKM4tbCzIW.I33nWVBPv8esTfZO50JnzltIJk6gcV
 E.PhzAx2H3HQfIC6PEKMVkI5H6h17j8s6N8fqZ3SIPt.FVYbctuVRaEc6A1ni.jkKqeE8QVtm6B1
 ksrLuD45uTJMx62mczTc5NGVls0_ivr5ijcf99loop_ytOYyHIoeNoVq7c5c1UHMrZaFM6fR5Zbn
 T1aBY8yQ19mtJXN3vdhvy7OjFZ9xbIoRQmAtE065OKFGwlmWkPtgtMU363z46Bn8ZM9zGpglbBdb
 w6c1PKYkrg6.RH33DFewT8dtHzp5ycqMYYU4ICVfkU8dnSYTQ8gjRGSeeKnOSiDNjgd0x6_8VXPm
 aHj3J1c9eK6xdZD4Br4P3.ph.8ZRTW1.7lwscgGbL2aaVObW2f9foHjsWHWEAG7tGbg0VlN4JN9Y
 wIj1ZJ2InrFRdiXDUW0c79zH6MMVbR_0uwHDSA8_MUTd38GzNt.GPb9CJMbPECE9i2UXxEK88hRP
 BKzp2Z4OtHc1hFogAci5XUP.M0PMpmKPYAkqsDWniCtN0rInLrDetdFFh22p0h_DwYxfv.PM3A2u
 wv6h8CYfUsW.pOhoi1Kk6O1GtUVziDOKPyHFVKS9YwQVP8U9L9JNWgo7S8rAOoQzgjhh2H52GiIq
 WJ1G4g5Wz9n4.xWPdUznrCsVLxE3Wi7i30WjYq5qzOqD16CjWhu_V81XLASOvXejkpvpFUZS7ExY
 qPCjvV5AeUWY51gRGTlNRW6n.CkJCjYsV1Ff6oeHTR.FVjHlEvqyq4gnkemQWHRJInqh1h4eWhCF
 hE_wvPuI9lfgMkynwCmoRtlyyHBBfyH2R2aEWIb4JYc_lWBpclz3_IpAcdWz0gkOlGKvJI_Of5o9
 a2eeI_Vnq8F7niclkL1mNCtAqhJTuzH1wfjBuwwWLEnmi_Gfn1zOGXODA3Ob97J9w09rrb4qmRy8
 aTL1U86D9n8rJWfOdEdU44NXUxTFJPQ1aeTGKEFqhbl6eiavhaEamsBneub6oivBWcq61NiJKTUW
 3qm1hJ0Qw0PI4n22lST8YszcYNR31lbWBDoc1.h9nbL.y3Ur1GXM62B3cEtypjqfR6pSd1cbP.xB
 OKPH9wkxXIeKTXZiXhZ3WhMQSdXjYgeR3g3DxNfvAA8whfHntnwwYQ.t33UsIidWKDhX14m2IhyC
 49r3NV64_uEE-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 092361ca-3769-4490-a58c-3f89002ab9dc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Mon, 30 Sep 2024 17:11:01 +0000
Received: by hermes--production-gq1-5d95dc458-24x88 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e3d2ca2c022e77beb9ca5fee9fadd2e4;
          Mon, 30 Sep 2024 16:50:43 +0000 (UTC)
Message-ID: <44e5dc02-9e8f-4939-aecb-cf0e05af8ad9@schaufler-ca.com>
Date: Mon, 30 Sep 2024 09:50:40 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] lsm/lsm-pr-20240911
To: "Dr. Greg" <greg@enjellic.com>
Cc: Paul Moore <paul@paul-moore.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <d15ee1ccfb91bda67d248b3ec70f0475@paul-moore.com>
 <960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp>
 <69e4014e-0a34-4fde-8080-4850a52b0a94@I-love.SAKURA.ne.jp>
 <CAHC9VhQq0-D=p9Kicx2UsDrK2NJQDyn9psL-PWojAA+Y17WiFQ@mail.gmail.com>
 <20240927085841.GA3642@wind.enjellic.com>
 <2ea23569-6fb2-4a4e-acc1-e3927dd5615d@schaufler-ca.com>
 <20240930105330.GA27787@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240930105330.GA27787@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/30/2024 3:53 AM, Dr. Greg wrote:
> On Fri, Sep 27, 2024 at 09:33:19AM -0700, Casey Schaufler wrote:
>
> Good morning Casey, always good to get your reflections, we hope your
> week is starting well.
>
>> On 9/27/2024 1:58 AM, Dr. Greg wrote:
>>> From a security perspective, Linux will benefit from providing a
>>> better means to serve a middle ground where alternate security models
>>> and architectures can be implemented without building a kernel from
>>> scratch.
>> Ye Gads.
> That certainly dates both of us, the last time I heard that phrase it
> was from Thurston Howell the III....
>
>> One can create SELinux policy to support just about any security
>> model you can think of, although I was the first to decry its
>> complexity.  Smack access rules can be configured to support a wide
>> variety of models, including Bell & LaPadula, Biba and rings of
>> trust. AppArmor is very useful for targeted application security
>> model enforcement. And then there's BPF.
>>
>> It seems to me that the problem isn't with the facilities provided
>> to support the implementation of new security models, it is with the
>> definition of those security modules. Or rather, the lack
>> thereof. The ancient Bell & LaPadula sensitivity model can be
>> implemented using Smack rules because it is sufficiently well
>> defined. If the end user can define their policy as clearly as B&P
>> does, its a slam dunk for any of the aforementioned LSMs.
> We certainly wouldn't choose to argue with any of this, given your
> repertoire in the field of mandatory access controls and security
> models.
>
> But therein lies the rub with respect to the implementation of system
> security.
>
> There are what, maybe 5-6 people in the world like yourself, that have
> the technical chops to translate the theoretical expressiveness you
> describe above into functional, let alone maintainable, security
> implementations?

Flattering, but a touch off the mark. In the 1980's there were at least
a dozen UNIX systems that implemented "B1", "B2" and/or "Compartmented
Mode Workstation" systems. Five of those even got NSA evaluation certificates.
There's plenty of expertise floating around today. The tools for doing
security analysis have moved from "grep" to "AI". The original TCB definition
for one system was done on paper, with a yellow highlighter, in a bar in
Cambridge.

Really, it's not that hard. It's messy and unpleasant and you learn things
you don't want to know. You find a lot of bugs and discover all kinds of
software behaviors that should never have been introduced. You become
quite unpopular with your peers with other interests. We were "lucky" in
the 1980's to have a US government executive order that drove security
into operating systems, giving us the rationale for making changes. What's
difficult today is justifying the effort.

> If there was the ability to practically implement just about any
> security model with SeLinux there would be no need for the LSM,

The SELinux team did in fact propose removing the LSM infrastructure
and making their code the official extended security mechanism.

>  yet
> its existence has arisen, given the desire to support multiple
> security schemes.  That alone would seem to suggest the lack of
> technical prowess that is required to translate theoretical
> expressiveness into practical implementations.

Nah, the technical prowess is there. The financial backing isn't.
Besides, it's a *lot* more fun to write a filesystem than an SELinux
policy (or set of Smack rules) for a distribution.

> A primary challenge to security is scale of skill.
>
> In the face of limited advanced security skills, we have hundreds of
> thousands of people around the world creating and modifying millions
> of workloads, on a daily basis.

Sure. Everyone uses their front door. Very few are locksmiths.

> I mentioned just recently, in a meeting with technical influencers
> here in the Great State of North Dakota, that we are never going to
> train our way out of this security problem.
>
> Cisco recognized this with network security and this fact was central
> to the concept of it's Application Centric Infrastructure (ACI).  With
> respect to scale, ACI is based on the premise that the manageability
> of network security has to be an artifact of the development process.
>
> One of the motivations behind TSEM is to deliver that same concept to
> system security.  The notion of allowing development teams to create a
> customized, bounded and mandatorily enforced security behavior,
> specific to a workload, as an extension of the development process.

SELinux + audit2allow. CONFIG_SECURITY_SMACK_BRINGUP.
These are helpful, but you're not going to get away without applying
some real brain power to your security model.

And that's my point. Generated security models are crap. The best
they can accomplish is to notice when a system changes behavior.
Sometimes that's a security problem, and sometimes it is the system
responding to anticipated changes, such as the phase of the moon.

The NSA once told me that "A system is secure if it does what it is
supposed to do, and nothing else". If you can't say in advance what
the system is supposed to do, you can't determine if it is secure.

> Another tool in the 'Secure By Design' toolbox.  A concept that
> entities like NIST, DHS/CISA and particularly the insurance companies
> are going to force the industry to translate into practice,
> particularly in critical infrastructure systems.
>
> Have a good week.
>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
>               https://github.com/Quixote-Project
>
