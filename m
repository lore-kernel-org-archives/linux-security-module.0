Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932EF322533
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555225; cv=none; b=PKfAkJCmYpdowXnmbqR4IaGhopFRXGSgcA0g6rhLLEVbN1mWPS8Rv+b1CisINBfBTVOoDOEAbGF6er6KWeueDK9EHWg8kTg/HKRezrPqQg4PGWkNgjY22GURspMlJ/25O2bTJv4Zr4Dik9lHrcNA+pET6Z/nYemlEObB7vhYuC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555225; c=relaxed/simple;
	bh=MtqifYllkoj5l3UV1nR9ImSBD7av3EJIAelE4M0QQmo=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LEf1OEbg6cs5h7J00itO7KKNX45j7/B2GwbZD9QK5357DsgzcPJwkMPGcWssLyZ3O3TykGKuqQGnOMqeYP4rflsohq0I8YRkKazI0oPHz0mMZZNS3fV5s6UB1RiJLzYx+fLMmtrUiv2RJSzifRZsCSuMam6OXOSs7qi+a9GNgxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a9/1q2H4; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a9/1q2H4"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5148cbdea08so70083361cf.2
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779555223; x=1780160023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ocLvTQonLjBSevx07KXv0YQMai11QYlv30lGksLKoU=;
        b=a9/1q2H4rTtC0ts/DN6DFYNnSvtwGgtoLUmQZezbBbZeb4BRSyGbojOwDzCT8hAU0p
         vPEi2p2UqRUh32lEYSklT7Hx53+vW02RVV8ejb+rUpcqn5LWNdCtZE0tJOF+HxHuXwkd
         boGB0//XjWojkDxIxQY22sW4KxG+j636eoJKC521t4N/YL0HEVIz4dt66Ro1Dd29gicX
         gOX79248IjbPuJmip7qjEs7bXG9I/EkKnYBAB8QS/WA51C1aojsTWitbC7+iDzqbufgI
         m6zQ0sX/MZyKmuA1I/RL9hrtRtO2MRHCSydjbNPwDXum1UC9pwahrnzMdSLSVwHkvG86
         7ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779555223; x=1780160023;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ocLvTQonLjBSevx07KXv0YQMai11QYlv30lGksLKoU=;
        b=BMnXqQmxsieHTILvzUFfLggiUf5w21MRzMII5cGjjeBPbFErXKniS0AKTz+rKFYtP2
         GqOd2HKda2vK67eVzTbnBOSMuaFWGkcK+G56Lr+kKEv2CrzqfdtfyS915V2KwkgxKtuB
         UZSbftlmT5t6EfnEbyJjgo42zaAnEHS0x/vCfykL4CP8CvGnm//CFCdSpYmhPvBaSrze
         0PSQL4OZSJ1TAvHgyEJGepD/1trlAQRLjZfbtQ3zkZDTklDIwRUZ3sIs2huA75UujeZc
         zzqeR9EU9ydyUYRCUPq1opJWnza2YVB2mdWlqP9yqFSJMTrVxG6SFuiTFCFaDWjbn8G/
         lolw==
X-Forwarded-Encrypted: i=1; AFNElJ+ngqO6xLGE7WzH1kYC7VskS11fjBV4E8gSBixN37PCS8pBgIMoe9i4Uy0eNayUyNjKUKkL+B17ytvqVFOthrhDXZEoWcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq/L9iCpxfRputJvH6yCI2hpFJDYzTrylAG2jSydx+/rFAghKJ
	IPIRIoRj06mcRdoIhObSFyJiZ5RaGyLGmPlSSuiHGBm+0CahTh/b58s3+wxpou+sMg==
X-Gm-Gg: Acq92OE2m3pXU5WsgQN/LLtyxtzP5TdQdPbDV/ILdE+BnQui6tj7HxjOkHYaURF1p1G
	fIgLwy1HEzLXYmZX2L/rn5EG4Yqgbx2YFQGzWFOHORwLFLb6Pxo78TTMh5C+UYfkv4qHR7lTq2T
	lH2nslahAp7xeKsYQUT4Vl0p0IkkSKzKjZioar4viYlrhNdkle4FzgwqveMZSM1S1JFkZKKfrLg
	TeCMHaLfy/ntnh8CtIlj0/1+91h8o9GNwj6iaFtTUQdrLl/aRdtnr/nRBRt1J0EgCOV1lMNm0qt
	0DlZ6jnxmERIkGWkauiABCt2VeNV7wycThx0n2qkcQz7S/MxOOXJOm2MJwoMpaPsg3NG8y+wY4D
	ehgpf7ZH77+hFVVREeJ2QMM1tUjqyQEnjKn493u8nvUJeGKMyqoxMu6y2KncIxEFokALa1O/Egs
	xtis379FQ/uuF1+SJd9eWohhQ=
X-Received: by 2002:a05:622a:480f:b0:516:e047:2f2b with SMTP id d75a77b69052e-516e04730edmr66664531cf.58.1779555223507;
        Sat, 23 May 2026 09:53:43 -0700 (PDT)
Received: from [10.234.26.20] ([108.147.98.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81306d70sm49760846d6.35.2026.05.23.09.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 09:53:42 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>
Date: Sat, 23 May 2026 11:53:42 -0500
Message-ID: <19e55c1c1f0.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CAADnVQ+WTfgO636GqgxzJ6r=jENpG704kmNAsy-X8=WyjMOV+g@mail.gmail.com>
References: <20260523160025.16363-2-paul@paul-moore.com>
 <CAHC9VhR6RSq1TUgAyvHmaF01h87Cazy=BNJhk654BP8yfeSwng@mail.gmail.com>
 <CAADnVQ+WTfgO636GqgxzJ6r=jENpG704kmNAsy-X8=WyjMOV+g@mail.gmail.com>
User-Agent: AquaMail/1.58.1 (build: 105801620)
Subject: Re: [PATCH] lsm,bpf: fix security_bpf_prog_load() error handling
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On May 23, 2026 11:25:55 AM Alexei Starovoitov 
<alexei.starovoitov@gmail.com> wrote:
> On Sat, May 23, 2026 at 6:06 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Sat, May 23, 2026 at 12:00 PM Paul Moore <paul@paul-moore.com> wrote:
>>>
>>> If security_bpf_prog_load() fails there is no need to call into
>>> security_bpf_prog_free() as the LSM will handle the cleanup of any partial
>>> LSM state before returning to the caller with an error.  Thankfully this
>>> isn't an issue with any of the existing code as the LSMs which currently
>>> provide BPF hook callback implementations don't allocate any internal
>>> state, but this is something we want to fix for potential future users.
>>>
>>> Cc: bpf@vger.kernel.org
>>> Cc: linux-security-module@vger.kernel.org
>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>> ---
>>> kernel/bpf/syscall.c | 4 +---
>>> 1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> Alexei, I'm assuming you would prefer to take this via the BPF tree?
>
> Paul, I see that you're intentionally trying to piss me off.
> It's not going to work :)

I promise you that is not the case. I was looking at the sashiko results of 
the latest Hornet patch and it identified this potential issue in the error 
handling code that is an issue independent of Hornet. I posted the quick 
little patch above to fix the issue, and since the diffstat is solely in 
kernel/bpf/syscall.c I figured you would want to merge it via the BPF tree; 
if that is not the case let me know.

--
paul-moore.com



