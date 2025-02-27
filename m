Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E51C701B
	for <linux-security-module@vger.kernel.org>; Thu, 27 Feb 2025 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674876; cv=none; b=C6PoDY1cDCy7k14MdG02FRCr8jPgyszppb+PUTzCiV6sPivalOkopuVkDhwSU7A5uH1B18uALGdK0jfzGUS1Z/EWZ6MH809vc007oR4iSCwHYBwPivusqsGP5UNH2OmtsYaZfCoZYfU0aiwdoP4TaXi5UHzxmpYJkisZjEj+itw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674876; c=relaxed/simple;
	bh=ILmTD/IZsa5BMc1gaQ14DSF9LoFKPFwAyT9iegItuTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcYjEbS8fjQQycRyfMZzQ8fPcqOWT8qU0QBK1HVKO+sOglocz9VbCRasPPCKgwOfcTTiMQs1u1Vm7lov2Nb7cGchG5PRASnatRQWY7+vxlFQuLFCC/TMx1JMaKbH1XOQSiGZrax8k8HMB/iig7vATPO8ZlkaVZQYnD1i7W5rdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=eoDsxAKk; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eoDsxAKk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740674867; bh=dtxm1x4SmJAjPr/SXPTydAXxNE8fMb+1ByuAcQdQtmM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=eoDsxAKkXl155c0oCYAIUenNZ09C+L94nsP2/+14TbHYIYZzVY2wRRlqsjN9L99V0z/QkuyhzyLHoj42IaPiJEPqRQ/vHZTyYFrooItAn6pM18k4I+ckMbUdDOYUk3U0+P6OypaGL1Q4w8etlXUGIiK3iPD145TpEhSJLVONL8Bn8u20s6fdO5XSXnphD+LGbWc4vUK7T/pJt8HB9S0h7yS6nQKfVXQoG7IS1eTB+4t77qw5yF8FeARRj9WKvLp1tLQIF0gtHC9yghwZjKDVmgqtlsrycPvq4vgx9q9/vEpWufwlUUQ6F5Hk5C9zdvOsvLxYGvBWFDfJpOup/i3G1w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740674867; bh=IpzCKdNT8Kks9du8IT3QCYIQrrrM0mke5CrGrrlBXlL=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Z5gKV5sWoo+1UYRk1dVBkcWARO2uky78xYuk0U6CPfwWQS2xjdD4PToEda+00ACzI00pPvcWObZRHIB6K/4iFTqsErgqrH0JycDzf05NQq+Z/F9PsNpnUM2OnZ/opne1Fg9mn0pbM+gbW8y9+WvpgTU/vtz3c+KienkIMWjwLoA+/23h34hEVWS5lALfwxGGGGpOr1/SPY0oQF0+xbQ5yvkZ6KL8u/g1TYjhn0O6rvx9Owpi0NIbhbbZIpHVgeR+5CnqHjqhq4UM75I+Ln2RgBgpfIarx8plqJOrZpkkCKmuKDk4buos1Vm6/dPvfliia+nh+VNacSGSGQeNxxZTWQ==
X-YMail-OSG: oAjEVwUVM1lmT2xZSVwuI5hkV0KRGeKqUqorq3mSqy0dLetVt7k5AROJ3BDJgaz
 9RTkCsJ1ueoxhneGGtU9SOPgfZedphluh9bIGqMQ2i6542rIrh3.fPbiAGUHeOFKPlk1QWbmY.Tf
 LcTxjQcmF7chK8VRU0hG2bU2OT39Jc8gpNWlfrgwYcV_RHbQbN9YwGFqe6oLMj0z13q81LnOCnIH
 FvfCe7aj2OdchA5_AARQu_uqzlCfA1f1DXggPzHGXkZ2j07zEdRa.H5.al5En.HRjc7GtskF4wQS
 8zNQ6RZlIKUGO_1KQQHL.Ww_yMaESkvDh1WkTIDgqR6mbSesLE6oh7NPSoTMrK2JVxY3uhc_T6kU
 BqS8zwxHoATAsR7RXOKxNHfTyhhByfWTGgbK.Ed49l4J1drjK69BV3UUiucDUtyCL9rZAQaulOF5
 KRTQ1KWWh5OuNItJmLcxdqbs5qLBOv9GOLIfxkRwz0R0BTh605b7kC.xgnuLsfWtzXqxJT_SHoy0
 MkCwNCV32oC80IIC_Ua0Z5NLWV10CNvkbIKM8sG46yXNu6hg_OJcGpxqyci_qVfvjQnVWjRR9KZ9
 iBmXP5mkmjzEgDEvNTq5OXo8FnQdiO0TCkhk2WlCDB9k.f4y2T7q2itQMhWk9.sIW0jCqLAw1220
 DLJD3ivGhtYt5Ng326l8Q97ggjj3KrtUEqCQ8snnkXBHKJSEvD5dYbRtpWuuThXJueOT8_HEXY2F
 XPF02rkewD69m6AkzDNwt_5EG_0Z5SfSxqSpk1sbvieZ2_AtqxKmp6vIPJqA5DhyHijFFKAwgC7h
 KEArAQcyVCnOWCU76kFNj9ToF1kHNHgeH6GX5OeQQGwc8aKz2xzDvIMXcqOmoBywcvOWU9QFFX9Q
 EpLjQVYXTYu9Kd3g4Zr4UE_RJvPm6MOygqmABWbAJijfgegZG3ZlJSKzaC.TZFyUPIEsE756etvZ
 rHWWCkyJq_DdAd.uDepBF0mIySJPOT__stehQQHSRBbHf.yEC.pYOE6AKuszhL0NK7onN75PQnSn
 1OX71ZgxrakJhEbm6fjHoD5DfX81Kgr3.5pAqf7ATAhsxgmiYjGsgqKyaX2zXk7vNBIg69Hok1QG
 wwcHh_uwftynYIYgeYvXR9LEbkLJ7rERiMNIzD5_0uwbCj9OQvQHF7wmSW3x4j5eRxpJcjQlK5LE
 cE4xnkuBgoT7OoQUUf9U2Cd_J5NXDiLp6Y2Da_8b.aCRb0ULCVCkq0IWe4A6tSwNDA57nCketp3M
 R9VvQqzDrqA2.VfGhIjVL4i.gR7EhFWJmC9fr0VU049RRGCH5wfht0SeHk5S8im55j4k_XTjbOc9
 dKz4uC9kvr76OEVgYVRTw9lw1zcmQBjPD7xqEJbz4sTzP69XKn8KEVrMo.Ro9bEEa0Be_hBL56L6
 wBXrbVXa.bVqKTzeEUtG0CHtw1viQ3UcJ5SrzKl6ECdQLoQUozgmndj6OZSclsNYVpndZwG6zCSZ
 dSJ3AZRGXuGWNjGZhguVjiDNE_w7aoN9bFPMc5MroOnfwM2T0JbsfWbvR_nwE6VA9oW1vboSgjRC
 JQLHDMGyxKFwd2EAxaMx_2oZ79ywYLqznP0PrkYHeKfCqpRCEwm48L.olKRNiQxyMTqWMKu5X05g
 F9yergycJaP5G1hIo8LgoMT.nEvoJ.UcPxKRShSEwJGlsrh8jU9HeKeeYLIzT7Z5sUAmB6zRlL0G
 mbNYU6BzG0kCzjzg7r8LOxU_t6r7d0JkJVg9.gNmsPzcyjFJG5yDxynmiB9uTORZhC9kSDTVEmxP
 IP_8QwT1NBTQVPPVycGnXa0uTxaqnW6UrhDASTXgpuFvhqJ5kGEQ8m64Umb24_Q6S1vX9nMqM1E6
 ykYa97h5TSbzwAEx9VMEAHY9YhSHzn.DAk8oDlrfRiD8l5HAkMQmhzvkMyQP4WNozzg1HSk9.5h0
 4K4GzBzAoZ8VUcWq8.2pdE2JWmw1kG7a7S1xWFEz.huadxiEUPxnjUyBKg0V5DDeA6nCmLU33HWT
 b3YhRHfe60Aa_eZT06ZlmAeEiTiB5g8UKk7s44ge1ZdsCxF0ep8XUhnrVF1w1FobkrXcdq1bRdFT
 q9y9r38kdyqTTWLl1YEcQTlhVTBHKWHLdstkzbaEqyfq_wmUXbqO4N8wsNaAKTOTLKpSqF3r5Vlp
 .DL01Eh1HmckOoqFGLxreAFFthee4CKliv_iu_M88WtqsN.xeg7B.JxIwCr9FtbDjK1cGNwZXaiA
 SVH6XoPdiEOMWRDwiJce1ndOtDRfHiK.9gTk-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 58252655-7da4-497d-92f8-11479b545252
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Feb 2025 16:47:47 +0000
Received: by hermes--production-gq1-75cc957d6c-t9f94 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bb7759726b1596cf55d3257f985390a7;
          Thu, 27 Feb 2025 16:47:44 +0000 (UTC)
Message-ID: <b60f2453-9c7a-4e69-9520-8088c09f4070@schaufler-ca.com>
Date: Thu, 27 Feb 2025 08:47:43 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
To: "Dr. Greg" <greg@enjellic.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, jmorris@namei.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240826103728.3378-3-greg@enjellic.com>
 <8642afa96650e02f50709aa3361b62c4@paul-moore.com>
 <20250117044731.GA31221@wind.enjellic.com>
 <CAHC9VhTphGpnVNPkm0P=Ndk84z3gpkJeg90EAJiJEyareLUVTA@mail.gmail.com>
 <20250225120114.GA13368@wind.enjellic.com>
 <2b09859e-e16b-4b58-987c-356d3fffa4fe@schaufler-ca.com>
 <20250227121207.GA15116@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250227121207.GA15116@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/27/2025 4:12 AM, Dr. Greg wrote:
> On Tue, Feb 25, 2025 at 07:48:31AM -0800, Casey Schaufler wrote:
>
> Good morning, I hope this note finds the week going well for everyone.
>
>> On 2/25/2025 4:01 AM, Dr. Greg wrote:
>>> On Tue, Jan 28, 2025 at 05:23:52PM -0500, Paul Moore wrote:
>>>
>>> For the record, further documentation of our replies to TSEM technical
>>> issues.
>>>
>>> ...
>>>
>>> Further, TSEM is formulated on the premise that software teams,
>>> as a by product of CI/CD automation and testing, can develop precise
>>> descriptions of the security behavior of their workloads.
>> I've said it before, and I'll say it again. This premise is
>> hopelessly naive. If it was workable you'd be able to use SELinux
>> and audit2allow to create perfect security, and it would have been
>> done 15 years ago.  The whole idea that you can glean what a
>> software system is *supposed* to do from what it *does* flies
>> completely in the face of basic security principles.
> You view our work as hopelessly naive because you, and perhaps others,
> view it through a 45+ year old lens of classic subject/object
> mandatory controls that possess only limited dimensionality.

I view your work as hopelessly naive because I've seen the basic idea
fail spectacularly so many times. That includes things I have written,
such as the Datastate LSM.

... and don't play the stodgy old fart card on me. I've been working
on making the LSM more available to new security models for years.

> We view it through a lens of 10+ years of developing new multi-scale
> methods for modeling alpha2-adrenergic receptor antagonists... :-)

Which is relevant how?

> We don't offer this observation just in jest.  If people don't
> understand what we mean by this, they should consider the impact that
> Singular Value Decomposition methods had when they were brought over
> from engineering and applied to machine learning and classification.
>
> A quote from John von Neumann, circa 1949, would seem appropriate:
>
> "It would appear that we have reached the limits of what is
>  possible to achieve with computer technology, although one should be
>  careful with such statements, as they tend to sound pretty silly in 5
>  years."

New good ideas can shatter old conceptions. Old bad ideas with a fresh
coat of paint and impressive new terminology fail to impress.


> If anyone spends time understanding the generative functions that we
> are using, particularly the task identity model, they will find that
> the coefficients that define the permitted behaviors have far more
> specificity, with respect to classifying what a system is *supposed*
> to do, than the two, possibly three dimensions of classic
> subject/object controls.

Squirrels are funny rodents. If you model their behavior you will declare
that they are herbivores. In California (where many strange and wonderful
things happen) squirrels have begun to eat voles, a very carnivorous
behavior. If you believe in modeling as a way to identify correct behavior,
you have to say that these furry creatures that eat voles are not squirrels.
If, on the other hand, you look at the environment they live in you can see
that the loss of native habitat has reduced the available fat calories to
the point where survival requires changed behavior. They're still squirrels,
and no amount of modeling is going to change that.


> More specifically to the issues you raise.
>
> Your SeLinux/audit2allow analogy is flawed and isn't a relevant
> comparison to what we are implementing.  audit2allow is incapable of
> defining a closed set of allowed security behaviors that are
> *supposed* to be exhibited by a workload.
>
> The use of audit2allow only generates what can be considered as
> possible permitted exceptions to a security model, after the model has
> failed and hopefully before people have simply turned off the
> infrastructure in frustration because they needed a working system.

It's a poor workman who blames his tools. Why haven't audit and audit2allow
been enhanced to provide the information necessary to create your analysis?
I suggest that it's because the value has been recognized as unimportant.

> Unit testing of a workload under TSEM produces a closed set of high
> resolution permitted behaviors generated by the normal functioning of
> that workload, in other words all of the security behaviors that are
> exibited when the workload is doing what it is *supposed* to do.  TSEM
> operates under default deny criteria, so if workload testing is
> insufficient in coverage, any unexpressed behaviors will be denied,
> thus blocking or alerting on any undesired security behaviors.

And how is that different from running SELinux in permissive mode?

> I believe our team is unique in these conversations in being the only
> group that has ever compiled a kernel with TSEM enabled and actually
> spent time running and testing its performance with the trust
> orchestrators and modeling tools we provide.  That includes unit
> testing of workloads and then running the models developed from those
> tests against kernels and application stacks with documented
> vulnerabilities.  To determine whether the models can detect
> deviations generated by an exploit of those vulnerabilities, from what
> the workload is *supposed* to be doing.
>
> If anyone is interested in building and testing TSEM and can
> demonstrate that security behaviors, undesired from its training set,
> can escape detection we would certainly embrace an example so we can
> review why it is occurring and integrate it into our testing and
> development framework.

Sigh. You keep coming back to a train of logic that is based on a flawed
assumption. If you accept that observed behavior describes intended
behavior the arguments that follow may be convincing. I, for one, do not
accept that assumption.

> FWIW, a final thought for those reading along at home.
>
> TSEM is not as much an LSM as it is a generic framework for driving
> mathematical models over the basis set of information provided by the
> LSM hooks.
>
> All of the above starts the conversation on deterministic models, we
> can begin argueing about the relevancy of probabilistic and
> inferential models at everyone's convenience.  The latter two of which
> will probably drive how the industry does security for the next 45
> years.
>
> Have a good day.
>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
>               https://github.com/Quixote-Project
