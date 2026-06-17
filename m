Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0052E737C
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708204; cv=none; b=S/6DJr+nSCxSCXF0XoZirt06wnL0O5Q1b/TbUzYrj1iLrI/bSnGTIQR1Zi/5ngyZmZWRO9MYkVN6VvtpGCJ+g+Uy5fs5Hec9CLIApzztefG1pcsYc3sV+ba5ZdBvHlO4l8H9scd9rN+E5SGYnfjjw/R9HBeHpt4efHBxVXXZHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708204; c=relaxed/simple;
	bh=jLvFPPCSufCagHlW/IGWQJ3nznNVY90TbTzLqhLKM6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uqh0Jv5YS6FOqQARGAR/SioXbkoiJGKac2PJEQrXn5TIhVKb4nLUlI8RJemRxp115arFLmQxOff5U4cGuR0a4Q53H6pfwTjfLkBlNqqus+NDQTznobZ8nYxftusuDZfL+0eB99nXX1KKOhj910rdmHkhUP1rBdySXCjTTTZqFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=R/QeJKF1; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="R/QeJKF1"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e6b554044fso4773221a34.0
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 07:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781708201; x=1782313001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4CE4dGHxysrbEbtWXCcWqanLPSQjan49LM4OnNIvfY=;
        b=R/QeJKF1Bw6TXpMYiFk4blA2HBGMI0aVxiy7ToWmZ2bkQYeYWIXqXG+KYq78nNTGLR
         qpOWjbeMVRQeCKe5SYxxQUtgy9HgwcLqRxkoYs+nBWQUo7NBggl+53xcnL3kGRpKHc1+
         TG2QL9ZXcTLA2s2wfQNqe/bhVAOYKyYbNzOaftGFUbwBLtskERzxvahEmHzyqlPJhQlJ
         LDS52nkNGhpXaJ9FWwtO0vb996bH6YZsAHPhqEm4XKGmLpYV1A8P0CO4W0Uqz3XV6iOM
         TZ3T1cR2nAHcweCYo1tOsm0ShmIifESA9aTofBntLc1FqbI0PkHU3sYwlWjoe+Sm29LQ
         U9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708201; x=1782313001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4CE4dGHxysrbEbtWXCcWqanLPSQjan49LM4OnNIvfY=;
        b=bnYJmOzKVl4hY+iNVvd9vL5oQqcuxN//E1iUGQcFdNewcF5Sy1TMVl3QlZAYageMbh
         gKy0EPTzTyae0B2BDvwhp3pts8Ljm5F6AxIhRXcIrBg7WLyZO2oEGsYR7ON1XevXyw8l
         j1LIJwMtJeMHkTaFIBTfk7+l+6+9Wm/LnMGspd7/DHaYgiuN10kxBz0ak0xXGEYcrfHY
         PmNMTbGrW5bSpq5PFVjlSVHEzTJtJCSPqV+jrSHp1Efsxe/2r81J65Q6rwciPztjEq7/
         3h9/ynGXzSThr8FnDH4gRzc4RWZOX+T7UoCmBHvQy4BoIXGeqxlINuABn1o+xL1lPn5O
         oeKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nGH+lIbBmm0t0ShvehEuhPxQEcp1Joc0Dmpqu34qee7s9F7BRYUqbNG7TJ4jTxA22HGDEgmHe5KfhoJNHemh9TYQAesc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2YKFCcqoprnHlP6gLmUkYCQQluyxF+5msL1WCWRCoXo99bf98
	DbwK4oh3T+9VjHjmJY37C7b9g5tFvW05o1/m18v1nDeKsB+LYDVl/cIFwVdzGmQTB/DLKe2CyPY
	1DpExUEs=
X-Gm-Gg: Acq92OFWQvSH+gdYER7GdTjXtnQBa8OmJjwtbjfViIndioNlpFqMA5SwaGrnnQRvDmH
	zGfBKL/i2lHXS2PUXkqWWtV6ZCkB/NA/EibD36lfckPXbp7TERszG/SkUnwQ6Og9BpVNTRyHLon
	uIK81PmCF9+66wSd4vpvo2KDBNBxggN4h2byb/mRLa6UawLQLcDqyvfpT6t3amszCswJtKqsGhf
	7GMKaBUsgE5Svj1dyghPUbxV6ZFd+jU8r5w1uku5af1QYP3P4k593sQviKVzGpcRsOAYBNokPw6
	wmvV4VvpBcmmN5hJYT8yWuDbIoiXjYuawDSXk/k88F2k0xgaS5T3f+rf1yZp7REo+zSomEl5DdW
	FgOJdZ33pfvwuyE/Svvrfff+qqQgigHQIMegYhYINhLhqIeB6ccSWimuOQgKvgDS2gkEv95W0TD
	mdyhWDo89rWxrs1bxatoE7ly2MBnetdx3jfm2sUaU=
X-Received: by 2002:a05:6830:82ab:b0:7d7:d524:bc88 with SMTP id 46e09a7af769-7e90c5df04amr3235437a34.10.1781708201582;
        Wed, 17 Jun 2026 07:56:41 -0700 (PDT)
Received: from [172.19.0.220] ([99.196.128.98])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e7a3c2b08fsm8359310a34.8.2026.06.17.07.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 07:56:40 -0700 (PDT)
Message-ID: <cece4228-01b9-4550-ac19-e773a1fc5f24@kernel.dk>
Date: Wed, 17 Jun 2026 08:56:25 -0600
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Landlock: LANDLOCK_ACCESS_FS_IOCTL_DEV bypass via io_uring
 IORING_OP_URING_CMD
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Bryam Vargas <hexlabsecurity@proton.me>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, Paul Moore <paul@paul-moore.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-security-module@vger.kernel.org,
 Tingmao Wang <m@maowtm.org>
References: <20260616201633.275067-1-hexlabsecurity@proton.me>
 <fcfa9bc9-4f7d-478c-90a2-ec4efd4c7d43@kernel.dk>
 <20260617022541.328550-1-hexlabsecurity@proton.me>
 <209b76b4-e028-4af7-bdcb-b5813fef32fc@kernel.dk>
 <20260617.aeNg7Aeseez4@digikod.net>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260617.aeNg7Aeseez4@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/26 8:16 AM, Micka?l Sala?n wrote:
> On Tue, Jun 16, 2026 at 08:44:55PM -0600, Jens Axboe wrote:
>> On 6/16/26 8:25 PM, Bryam Vargas wrote:
>>> Thanks Jens ? noted, the fix belongs in Landlock. Micka?l has the full
>>> report.
>>
>> Indeed - and hence no need to bother anyone else with it by blasting it
>> wide. I've already explained this multiple times, but on the private
>> security list, when the occasional AI report comes in on things like
>> this. Hence why it's a bit tiring to see the same stuff come across,
>> once again.
>>
>> For the landlock folks, I'd suggest taking a look at what hooks already
>> exists (and existed, when landlock was merged) for selinux etc, that'd
>> be a really good hint on the existing surface covered.
> 
> As I explained in previous (private) reports, there is currently no
> io_uring hooks implemented for Landlock because there is no use for
> them.
> 
> io_uring "bypass" was already mentioned to us two times in March but
> io_uring personality credential is not a Landlock bypass.  The Landlock
> threat model is about enforcing restrictions when accessing new kernel
> resources, on a sandboxed subject.  The credential identifies a set of
> access rights, so in the case of io_uring, the subject is inherited by
> the io_uring personality (i.e. the file descriptor).  If a sandboxed
> task creates an io_uring personality, it will be sandboxed with the same
> restrictions, which is BTW an interesting property (e.g.  pass a
> restricted io_uring FD to processes)
> 
> A sandboxed process cannot create an io_uring personality that would
> bypass its own restrictions, so there is no Landlock bypass.  Inheriting
> or receiving a file descriptor is not restricted by Landlock because
> these are operations from outside (or before) the sandbox.  If we want
> to restrict them, we need to restrict the processes creating such file
> descriptor.
> 
> Inherited or passed file descriptors are outside the Landlock threat
> model because Landlock is only one part of the security policy when
> (willingly) interacting with other processes.  In a nutshell, it's the
> security capability model (where an object has some associated rights).
> For instance, if a process willingly passes a file descriptor tied to a
> secret file, then the receiving side can (and should be able to) read
> it, being sandboxed with Landlock or not.  The scope of Landlock is to
> drop ambient rights, but if an *unsandboxed* process is OK to pass a
> sensitive resource, then that's a security architecture issue (i.e. a
> confused deputy attack).
> 
> A nice side effect of this approach is that a process can sandbox itself
> with a specific Landlock security policy and create an io_uring file
> descriptor that will inherit the Landlock restrictions.  It can then
> pass this FD to other processes with the guarantee that this FD will
> only give access to resources allowed by the Landlock policy.
> 
> Landlock could implement the security_uring_sqpoll() hook, but for now
> the use case is not clear to me.  We are working on controling socket
> creation according to they properties and I think the same approach
> would be useful for IO_URING:
> https://lore.kernel.org/r/20251118134639.3314803-1-ivanov.mikhail1@huawei-partners.com
> 
> I agree that this might be confusing and I plan to improve Landlock
> documentation to make this clear and simpler for AI to take into
> account.

I think updating the documentation is a good idea. Most of these are AI
nonsense anyway, and it'd hopefully help if the documentation reflected
what you wrote above. Even if not, then at least when the next one of
these slop reports come in, the reply can be as simple as just linking
to the documentation.

> BTW, we also have an opened issue to add io_uring tests:
> https://github.com/landlock-lsm/linux/issues/23

Nice!

-- 
Jens Axboe
