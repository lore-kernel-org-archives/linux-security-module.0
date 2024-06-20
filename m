Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D762F1B3753
	for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903582; cv=none; b=f8/YwM8vO+vfb/34DskD/9EqfdJZ/ltN+hc6/SAb8kVCkWxnXr7eYyu3b+ONeknmdsq8HIWTCr/F8DZ8fXUN0+m0elGI2dyOjh7ntVfg/Mn9f08e/nopY/nPTuWtNoDsaW38X673iHtDw1yrip+UWU8Jo/+IxtveVie9gywBQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903582; c=relaxed/simple;
	bh=DT69cig5T+HJP3QxES/sQY6L1UJ1ASS2EvGp9fZoQmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=SfnT3CYtO+Gyfbik77nV0uUATKZ/xuX6ja6V0o+eOvB0FIGxmjpw6fCo760VJvy/rjK1I+zjLUlXB3xON7UbhuBtow8JqcfhDUQpssqUa1PMGNCMUuXSDEn4opdTY6GqBIztnDlrpS9HljY6w2RLdLmsfyTsxQswfKVU1XZZpP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=IbEjxjHS; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IbEjxjHS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1718903573; bh=1dCjEj3mjJczEwo7yId4dIQ2YxYDscmgCFAd8ToOFpo=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=IbEjxjHS+10Sb9GVaFgGhe19WCp1pdY8u1MiqWsyYjthtICBWpi9oNUdQHaAgU1nmLrqE2vvf89dFED1r8tezUiVXqpiQ1L6mEM5GomqwzRmQrdQAQCGQ8nm2UyHosG0n1KxL7R5zpL25jSQhyeP8Wn390n0tyff7IK+JH+yyG9fYiEm6eN+K0zqyUutwHA4H38RPhsphtfj6jKKPVd8Ok3pTqvjeW9cnNVOJ3B8Ew78GxO77jr8dRdCyoUS1V9rt4fI/lnlHQZd938paabbgL0xFODFfX3UsgAbTo8cbjqEfeGmAGRitoz6TeqNfqh0WvJuE0bkLyR2K7YyRUpELA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1718903573; bh=1bWW3Kg/6Os1ArxamqCvxQN9fkzpqFvh6TPzIPMnxdp=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Xs9bVI9goccYKLOg7cTXcGteiCW/XG1sisI0wd5+JdSeNLnrgZSFhhGZ9TgpkJ6eVnO+nBJwQpVY7wSmD439O2daRmhyb5JodT9puERST61c4+27NBBowZRwwncngrctnhlkWNCbl/34A/IJ+ZYzeez1gHXwzZy6R+VYS/eSHn8B5If+GUmbzRIBoNk2YXNQ16jr8zyeEBYADfJBEnNQYFL//Dw5WJsY8a4iRgBreFfEPthbSAA7dj7zQEfo7MXARCpjYkoKAzD9RTwJNSWBHIgVeVU8skTi00nPyEg/VkQfX8M9jwZlClhsbcKVgagxwa8k/gyD5M2Re0lCKtlwXQ==
X-YMail-OSG: ENgimUcVM1kJgt5J_ADVIHI4k6Osjq3Mpu2oY5Y3qz3JT5hPRKdoiDSQtkR82.P
 _pAyXHNqhSMHxKm7gOUtcmuwhVWlw1JZthIcjYiwjppQpRa.2uBTfplbr6ZciLqujAzgsD9BzQFz
 ZkEBsJW9gUbGBKP3aT889JD9kNe9.B33Xc0Iu2w6FTrkW8KBlXPOMNOseT3LVy1czGPxk3evfuDC
 RPjr_HaAp4uf.ivE0tyckDzj.XDl8O9a.u3dkGGnFryfs_5GVFMIvwZtDKY3KBXSWKsBgM7XcsQF
 9Rp2GbbkSlrgaQ4rLP3eW5OZA8JthPbJo7i4C0U8oN84ex0tAjZK5dm82zVf.UfQNXpu5ju.sq8Z
 kvd4KzKEZJ77n7SaS5x1IQs.Qj8n760ZdMO6OJB1uQqLLfvwj09u02JKCgPEA8vKF7LC_LOdXQ.b
 u86rJLVk7IvNtOxDXQXxNFd0K0yL2uWoxsWCnWAuF8d_YJvpJOwwKKctjzxmQH1bK70VrKkwBkwl
 cupCfn5kgiRtk91l45fRvKkQaaeqCXP8tYG88gj9ZoLt7Yzz8kR6mN2ISOju_PzFERe3mw36baPP
 nXCXZV1QfuoHvYWXBz83Q757wSbq4NqYd9eNQ2m3uuDIv8nPgOzAD2yTwY0J3Syy9Wgsqp_LiS__
 BbYFtQLg3dDOxv4Gl5.zTrAK8b11g0eW.2CZWd2zVw78k_oUev.6N99ay3Kn2eG9KnUjOe6F6sS5
 2Vz61SUYb88rYEYZLBPPwhCgVfMIvwzc4t6tlUpObhrX9vLCotwpbWChqdVWLmgKokKD9HZtPith
 7GOSxxMbmdik52ny0aJ4Qw9yz4dvl0oiYfGRLaNNrBStHC.HyYGACwpdrXMQVX1TSOfF1dpL7GM.
 3J5IlAOc79n.FQMxcJAD4VKnr.AvKA_n50G.0d9XvIcKrcBs350HcoC_rhQ4T4WI7TrdKwks3RtH
 YZ914jmi1uM5GP4FwWBaLbLtDlAf_IvdJ9ZoDmb.NpyYWQlUbg7enmaHI4v1aNTQnAJdBR6Igycu
 6occye37k5QjFY0dZrcsqpNVDLrkW6oBX3GyAh.4RsNY3N_l8GqC0cowWJ9Iy6uGIVfhs6sDgzOE
 .T5hwuBRe5xJSKkjYrdKn5lEIoQaEnHYKUNUhhx3wwdkfci._J17Iu3cUfiZ4Hyp8JrMetpRmUoq
 W9V9BbaERZiPPURdbtLmxSUf4Va2x.oOvCCuf2MHb8T2KdzDHWczEYpUf5Sr9L8yhaeGqFMl1zNW
 7x4SoPjo6hHs_6SnvqIhCnS1Rtfji4RNtQeF2w4fvLcvF_jq51Z_JzmH5eyF7848oY823ZIcbXp4
 9d2TbYi2AvIJcLVeMMVNjxlZPCzmxYnCDutEkMootf2WVS0uR7Lk5RY96rlx0IaBB2.V9zX.jl24
 Q4I5OocrwTmN8WVznRDkXqVddc9Y3uw5V0tV4yd.T0VrZKNNk1cD6939dc30IU2UPOfD5k9pHSzy
 55uxRrxYikfr5WdndJ1L0zInwJXWZRr_EDKDGPxDlMRTS99FMyAssCJHXKYPp8UB4Cn8dwJgbXM4
 .9.kYD9tYeg2ev6EXQ0BDHl8beIDMdQIcYDmwe1CHe77toNekiYqlmG0.tRucLOTUXM8U2L7igi3
 NrUAcC.EiFhQpWuoVC.E9OgtY2knUGDCqq3erBCwtZXRKm9YED9kLKntw8VzvxFTiyyLZ_urQnId
 k8MV0Ye.3y031hGXkZKSNDxJzxZaWHa9n3LHcAIRTnEwice1U9aghbzXIA.BAQ.5EbcguY9Ozd7q
 zgIt6DgBevL.khSUiAGN60VToI2cwAzlD5sJuJfPPysH.0lJcCWEZo21A1dGIaYWWMsF3.afAy0C
 HrQ2XYyTrXZkbZHFVp107OMTg_D7HlI.xwSD1sQ506qVSjM1xaT9K7b6axNqkpVo2CLX5hm7Ls_n
 B5eF239VvLvojiZFV4.w158yr2F1dw5EvL1WAx2hadgriSFgCU0SeQozvKU9rKIoQQxFEztbqsiu
 QmTfS7V_5oXIh2kijItoFiV2MiVN23j.xxuKaNdOw7NfOs9nWfY7dZY1ulAOJp6kokr3ShJyBq1M
 QR_pZzvieNvqr1p3rkEoxMeD4WJOR9bI1Fr5IO_itL33GjCw501EP49SnsfWYJMCB2oTJpVp4eyq
 isXL94rzALV31uR1oJ51M1Wb_Q7sLbcLRpMc81zVqQbQldpy4uDI2IT4OfGopaKQQYIN5z7jzBCg
 j6WNPLSNkXfUHApUpu2FnX3_EtZFa0HEyP6AlLsBAj7O.EtT6.C.lnknNr9SisIMmH4iihS2aPRk
 .EqBbOg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: eda89079-59be-4dc7-9d88-5ef5a8b8f9df
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Jun 2024 17:12:53 +0000
Received: by hermes--production-gq1-5b4c49485c-vr5s6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b15db0c57ebca36900b26dc3d8ea6aed;
          Thu, 20 Jun 2024 16:52:38 +0000 (UTC)
Message-ID: <9b672b38-f580-4278-be20-9b9ca1f0cccf@schaufler-ca.com>
Date: Thu, 20 Jun 2024 09:52:36 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Yet another vision of Linux security | Endpoint Security
 Framework
To: Timur Chernykh <tim.cherry.co@gmail.com>,
 linux-security-module@vger.kernel.org
References: <CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=kzCL8zc9jHxAC=A@mail.gmail.com>
Content-Language: en-US
Cc: Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=kzCL8zc9jHxAC=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/20/2024 6:40 AM, Timur Chernykh wrote:
> Hello!
>
> I'm here for yours' opinions.
>
> The modern Linux, in fact, does not provide convenient options to
> write AV/EDR software

Please don't assume that everyone knows your abbreviations.
Audio Visual / Editable Data Record.
Sure, "everyone knows" what AV/EDR is today. Except that many of
us also know what it was in 2010, 2000, 1990, and 1980. Confusion!

>  with real-time system events analysis as far as
> unified system security events. For now we have only inconsistent
> self-made events from eBPF, audit, fanotify, etc. eBPF itself is a
> cool technology, but even CO-RE sometimes works as not expected or
> gets broken, for example:
> https://github.com/aquasecurity/tracee/pull/3769/files. This hack (one
> of a huge amount of the same hacks) looks a bit "crutchy".
>
> As an EDR developer, I have an idea how to fix this situation, using a
> unified endpoint security framework (ESF) placed in the kernel. Its
> must:
> - Provide unified and consistent security events;

"Consistent" is hardly a term you can use to describe Linux security events.
Is binding a socket to a port a security event? Where is the security event
when using io_uring?

> - API to communicate with kernel:
>  - To send program-defined events (as audit has);
>  - Read events from kernel;

A comprehensive set of events is likely to overwhelm any user space
collector. 

> - Trusted agents delivery mechanisms (signing like kernel modules);
> - Has a possibility to control what happens on system e.g block some
> file operations, binary executions and so on;

Performance concerns (locking, sleeping and a host of others) are
likely to prevent this.

> - Has a portable and flexible events structure which doesn't get
> broken from version to version;

If the kernel's policies, mechanisms and structures were more consistent
you might have a chance at this.

>
> For now I have PoC, which describes the concept in more detail:
> GH mirror: https://github.com/Linux-Endpoint-Security-Framework/linux.
> It contains all listed above points (maybe except portable event
> structures)
>
> There are an examples with:
> - Security agent:
> https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/main/samples/esf/agent.c
> - API: https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/main/include/uapi/linux/esf/ctl.h
> - Event structures and types:
> https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/main/include/uapi/linux/esf/defs.h
> - Main ESF source code:
> https://github.com/Linux-Endpoint-Security-Framework/linux/tree/esf/main/security/esf
>
> Questions I'm interested in:
> How does the community feel about this idea? Is it a viable concept?
> If all is OK, what should I, as developer, do further? How much kernel
> code outside the LSM module may be modified to keep further merge
> acceptable? (currently not all LSM hooks meet to intercept all needed
> data).

User-space arbitration of kernel events won't work. It's been tried
repeatedly. I started seeing it in the early 1980's. It always devolved
into a kernel bolt-on, with sub-optimal performance and versatility.

>
> The general purpose is to make AV/EDR software development easier,
> more convinient, and stable for Linux-based operating systems. This
> PoC (as far as technology idea) is inspired by MacOS Endpoint Security
> based on MAC policy.
>
> Best regards,
> Timur Chernykh,
> Lead developer, F.A.C.C.T.
>
