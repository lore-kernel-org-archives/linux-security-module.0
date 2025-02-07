Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38658192590
	for <linux-security-module@vger.kernel.org>; Fri,  7 Feb 2025 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738950791; cv=none; b=JDrFDRINzM+O2e0I23pFkSaYkfgniPcR+OpJYN6Qzd5a75B+tbosJG9xZxtJ4H5wokmli/pDjQJsRFZJajMzGkGR++W+uAXpPQdWtfS9ZqlCfvI3WXQn8tLjWKTaKQfMulvnxAOrfEnFzE2PxIu/EcOcY43BPgs6T1jOup8E0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738950791; c=relaxed/simple;
	bh=6tus+45IcuqY/ci66YxHQdmPkAfJI4x1ypN4MB31OPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yjmu2jr2bkX9vglHF4bZpudsfG+kpnS4nCfSPRjLc4xPDbiaizkmCLRGXdUZ5j+KgK59V0g/0tvxP/pZwwgnZEcTHyOYdQ/S5hvUNgn0mwYszlVR9jA6ma4CQoFGQ+PRJ6BD5lPFFwrOL9afqV5MeM62g1jp7LURVT884IDDpwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Y3P1hZC0; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Y3P1hZC0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738950788; bh=E0D622Eg5VzAFxelkC9+AvvK9/RqTNq9RU3uUYOhneI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Y3P1hZC0mJYBdLger73R2gNDhQvtViQgScruVhGONPUnH9kb3J/1+S+ZYyo6pMJnJJUm6uBdbIs3h8gO/oxhtrQSoOe198ZOtCVUEizmJIPD7Eq2JRcdibZsgPuUvWm/bc4O4FD9G3qiDuHgOpHmtF1dLD/B1zGf+KRxYa+UVFJKQon6erWpmgofHPnArOK6VN3QQMr0eaVF+jDgoRIw0jB+fTlYs+vKSxkpE7PKf25oQGGxeKpQ3zfj0LPauOk0pJdcE9Dap9/ExvAu0//2OBUAP4O9JkSscUHaBGYkT2mt0Kh46MN3zsVfmEs5vjtYfeIFL1cZ0Ve0m00rBDoU+Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738950788; bh=jRHnUs3wUphjH2k+QaqHsXvvtAC3WkQiCke3B7CWfg8=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=VvPjDHbwoDuwIUwpE1U3eh4nap8BBsqxevUF1bk4FMeyCQ9FSf9REKghMIbk8G9ZAk0s68BePuVErqGyBtgEIRl2ubz8SrFwCISYmJHOGN8LcgUDvt3tLdfX2XOCYcGY1QpuhUhkzYdTiAPeKQkp/VlZWMmTG5UvydPqs23JHOTOgzUqmkuq6EOjB/Z0VL1laxnObt+pujYw2eEFVL04oBgLM+fNStMvhVPYle/cmK86N3AjVI2ygG7jDqGBHSuECS8aolShYYz7bJs9Jgwu1L16UKdxDefHgD1WoDnVl9sz4txkBrhao5jRkbmTyb9eF1RJzVpSibMgfhHSIEkISw==
X-YMail-OSG: pK9bDiQVM1mWyMMIMazhkPULn12XYnNt050NXYTkhp0Z0VgfjSy.3wS_BznhfG_
 F6cL5NOL_s2Tyb2m18BOHIskiB.OzNXqOX8G9E8ZXZoGnHYPwcPcGO8YTziZA7Sa804wYTRkXOFe
 K9HtdP3d3GXRfeR5lOcezHjksREVnAp.NPqhTC_8xshNAfEyg4dIuHe5_mNU9THow1MX_ICv12CC
 rfl1trDKMsO8VI44RANktZprP4y6lgFC_PwAPC6kQiHsTVzMxgxJy5NDWvV962aed7jJnmJ51eYl
 BHcUqKogw1J76LXvlpZnohXQQQiVJo_vkAyBH0r2QYcw5tj0iaC1.AfP8sK0d2ZMgNN2BmEJcU0C
 .DOTNBgTMKMSyMSzi_BOPpF097zUSRRDCucEugpJ0tNiBSPve1uK0U1CM1xeYvERtYK.Q0avqCWj
 cv3YY3Zl8wb61koGnw7KXyHdrmsrXYzxn6yR6Sd3UCx1UNoVapjfAlbdADxpt63FDwk3ck_QAVmo
 SqaEco.K5WoTWFATrw2sArHYKsm7IEzVU0lDwjTh9ESOzjqPL2qO3nZo5fn7gc73tLJMWiP9QVdh
 76G7YYRtMhfLaE8PFl7KM1mzHq.JIkM1S4n4YQJxP1SUazUlAHLdnNSWDFmnNrdoKC5Bbi2NC3im
 DyJsOTa5sQNUBG4uzK0SLTl6REW9B0KY5zJZ.lSPBtiHa_3TnaJTBy3y4hLlWCKYkuic0HExDtRS
 DGAs2CKmwJSjwX8k5n4uvXiZh39vIRz_aGb5KAuEiae3m85gKAoHKo2EcWZNayyg8_QtrxXrVCMo
 loxbuItVDHfRvSaZAN8mb_.PMdmG86k5jz18zS8B_S1g2_W7JQZyIydHGlwZvjYUD_Wjcx.mzq14
 odNsR3BsfW9LXqCaFCsbHPN8WtpjhsuUFbFK5PAcfPNNAecfXy8amuJjSLhrIzcPoVGIOw1QvqZ_
 Vwyp5EM1LfEjgApidGIYvixgIr1RBYzayv1ah0diBjQ8Nef_L941.257qHPTOgvKt2mQWBG6Duqr
 hFhm1X3RMVv8SN4ARAoFtqmo4B_i65iiyBQ6V2ZytvqQkKpnSeUNKFlHy4.rBqRhYlOsYRZBcjzP
 GhWzkYC_V863XPEKdfULPMxvrE54kAoRjCxxvQmvhB6EYkhx8IaymMMN5gBaQOirAgwXAgLGdbT6
 HiJEZibBl59w8Vxn2sh6O7FvTimcCZ.IvQPbEOESYdR16r7AGkNlKbMhfWmp8hnZCG1jZk03GnIn
 7rciSQ1lAyz5k5xWFZFyU28DZz.lkRKkJrr7UiwBfcXyhZ5WhizNG70euceBXAh078qBqN7AyFAM
 Rif1M0.OlYrRI_R0KExbqSx9lo3arn_IIMZZtMSmZx9ger53ZGMZy6MgwDcdQDMp2y0qCZNIQFu1
 HH6fIjiW6xkKGQiTLOYpmhIaBgYPMqpoMpl7VCGz30whVa2xKjf3wk36_4QOJywKLnDLNGJLspVl
 Efs6UJjAGX8bxe8aVV8OMMF09KeA._i8MbRY5ZG67AKUxKVYsWrTvlBz5XLievbZhKgHiUZ6xdlO
 mV6LXdgtzI_Z79RdveT5bYHqZQLHCyXtEcd3eqCVhYvN79ZdwvKOBh6A94OiIFLKEd6LkfVZNjEV
 .Kgw0ryjHHu2AFHzB9DkdtFXsJmsrmCCxzZfBIAWqv4M8XvFea7jDlT021DsdtLv1s9mCV3KIgF.
 eWsRLv9b.J_UjXe2GnZ6eAmyXVynWq8FMaOHAzU4N_8BJpQdRB3cnYIXkdR1EKojOsbyPYHcnkM.
 igyCr5_JkOZ6IY.V2CwLpFTYTRqM1oZGIXqaePAoBOvRZEKbQdX65HLzSaOLWJKoIQYzAbZ_k_ON
 UgGYYgJ6DNq4hkoVH1V6dLR4x0gj6GetsVePNzNml7CVQ6e1QflBDSFgw0ob7LzLRMDemXMnAKPe
 rH2zuLRsXS61uDLckBYT4BcnPtdcDQvUB36Wf2c1U324CwrdKRwEUsrAtQ3lvV0f_8I.eE1D5qye
 GLCJnaY2gIMpfqp5LNS9HWPO.pl_v05p02CPo0hStalwf0uwX6bjsiEW4bx_VAzNLszubUBXR3ex
 dclUkroovE.QCRxb6YpzI71JuG0g_ZDfmIlbpncHPovwhaSF2DTlAnn7FIS_zHkldE1_DNtPIdga
 hxZVUKs2_4MhRqr24uzQbUYUWJCiggICMkA40_DxvI4qNa2Pvz5V.QXxzGV6LgTk9HTa1MRHY17E
 rz_iKog2hlDa8dyvPMa0GgLoTOm1UjOGpHADyR4G3V2toVZEqi_uTa1woXqCAFWI.2.viMv0OWFF
 UXSHELn9PtfQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 99bfe466-c062-4074-b9bc-43a5cf428d87
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 7 Feb 2025 17:53:08 +0000
Received: by hermes--production-gq1-5dd4b47f46-qfm2r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cc25759844ad2fee9b1eaa997ae650cd;
          Fri, 07 Feb 2025 17:42:56 +0000 (UTC)
Message-ID: <a17e67db-c983-4955-825d-167855601bb1@schaufler-ca.com>
Date: Fri, 7 Feb 2025 09:42:54 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
To: "Dr. Greg" <greg@enjellic.com>, Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 jmorris@namei.org
References: <20240826103728.3378-3-greg@enjellic.com>
 <8642afa96650e02f50709aa3361b62c4@paul-moore.com>
 <20250205120026.GA15809@wind.enjellic.com>
 <CAHC9VhRq0PrH=0n6okkvfed=8QQOfv-ERA60NNWvLXetgrB_2w@mail.gmail.com>
 <20250207102024.GA6415@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250207102024.GA6415@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/7/2025 2:20 AM, Dr. Greg wrote:
> On Thu, Feb 06, 2025 at 10:48:57AM -0500, Paul Moore wrote:
>
> Good morning to everyone.
>
>> On Wed, Feb 5, 2025 at 7:01???AM Dr. Greg <greg@enjellic.com> wrote:
>>> On Tue, Jan 28, 2025 at 05:23:52PM -0500, Paul Moore wrote:
>>>
>>>> I believe the LSM can support both the enforcement of security policy
>>>> and the observation of security relevant events on a system.  In fact
>>>> most of the existing LSMs do both, at least to some extent.
>>>>
>>>> However, while logging of security events likely needs to be
>>>> asynchronous for performance reasons, enforcement of security policy
>>>> likely needs to be synchronous to have any reasonable level of
>>>> assurance.  You are welcome to propose LSMs which provide
>>>> observability functionality that is either sync, async, or some
>>>> combination of both (? it would need to make sense to do both ?), but
>>>> I'm not currently interested in accepting LSMs that provide
>>>> asynchronous enforcement as I don't view that as a "reasonable"
>>>> enforcement mechanism.
>>> This is an artificial distinction that will prove limiting to the
>>> security that Linux will be able to deliver in the future.
>>>
>>> Based on your response, is it your stated position as Linux security
>>> maintainer, that you consider modern Endpoint Detection and Response
>>> Systems (EDRS) lacking with respect to their ability to implement a
>>> "reasonable" enforcement and assurance mechanism?
>> As stated previously: "I'm not currently interested in accepting
>> LSMs that provide asynchronous enforcement as I don't view that as a
>> reasonable enforcement mechanism."
> You personally don't, the IT and security compliance industry does, it
> seems to leave Linux security infrastructure in an interesting
> conundrum.
>
> For the record, just to be very clear as to what an LSM is allowed to
> do under your administration, for our benefit and the benefit of
> others:
>
> An LSM asynchronously streams an encoding of every security event that
> occurs into something in userspace, somewhere, that interprets those
> events.  Is userspace allowed to directly signal the operating system
> if it detects an anomaly in one of those events or a pattern of events
> and at what resolution level can the signalling occur?

Not to throw a wet blanket on your argument, but you can do just that
with a combination of the audit trail and Smack. Well, mostly. You can't
retroactively deny an access, but you can change the Smack label on a
file or change the access rules as desired. What you can't do is detain
an event while user space is queried about the decision. That is, I
believe, the fundamental problem with your approach.

>>> If this is the case, your philosophy leaves Linux in a position that
>>> is inconsistent with how the industry is choosing to implement
>>> security.
>> In this case perhaps TSEM is not well suited for the upstream Linux
>> kernel and your efforts are better spent downstream, much like the
>> industry you appear to respect.
> Fascinating response from someone given the privilege of
> maintainership status of a sub-system in a project whose leadership
> preaches the need to always work with and submit to upstream.

"Work with" sometimes means you don't get everything you thought you
wanted in the way you wanted it. Refer to the work on LSM stacking,
which looks very different now than it did when I started on it in 2010.

> Even more fascinating when that individual publically states that he
> is employed by the largest technology company in the world because of
> that companies desire to promote the health and well being of the
> Linux eco-system and community.
>
> For the record, we don't respect any industry, we respect the need to
> address the challenges associated with how we are currently doing and
> thinking about things.
>
>> paul-moore.com
> Our apologies to everyone for being a voice crying out in the
> wilderness.

You aren't crying anything new. It's not easy to address all of the
issues necessary to make a chunk of code acceptable to the Linux
kernel. I doesn't help that you're crying in a language in which much
of your audience is not fluent.

>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
>               https://github.com/Quixote-Project
>
