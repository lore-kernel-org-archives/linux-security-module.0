Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B90528A40D
	for <linux-security-module@vger.kernel.org>; Wed,  7 May 2025 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632281; cv=none; b=dK878KFPQri5QnU//6oSTklET9pVROEUbdUXNDSfSUggSO7+gOlnwAL4ez/rkd0NGE1AW47qnHm7CFezVNngVYlF3jO6EOzmed3uojjWVW/rstMi879seXmNTx9D/uYQcYfKL8EIcZQFqGpAyQvyLnZJFKijB7k/EYDA4rBu3LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632281; c=relaxed/simple;
	bh=0bhqYQP3PQ1v+FgerLpzRYXmaHS7tm0meVxdVOpXWiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lThATtAC2KirsUYKHc0Z7rO9otF2HX8/retaxa68Q4fxPKchbW1wJ62gXJzXEopPMNeFNBDj6VcQtHG1wOq+Gfuo4/P9myqszABhfNLO2Kfjm0sAi2OCo586zUaz2enOJ3PR85hFYOCAEwyfIXXEqdd2PvjOq/VX+FvotNnLxUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=o0Mrf65N; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="o0Mrf65N"
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B1E663F2C8
	for <linux-security-module@vger.kernel.org>; Wed,  7 May 2025 15:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1746632277;
	bh=Rw+ajBmKH1oYIOuaY57PRGZktJSoo5Qqq7a4MCBkd4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=o0Mrf65NfwNBiOmnh3meEAh5qFTJFXPSvXLQxabTk90IQDrNQitXsMPdLTSAZlf0D
	 GdTMpCHW48UCr5EQ6fV9BKJx1qJI7yaEVpDqYvgc6KCT9EKEBPTWtNlo7sQEa45Srt
	 ALw+wiWAmQGBl3RQNillKl3wzw6oJ1ypALAVeZ89dk1971wpMDo/+1wKzZn+nxSE7n
	 ZKkUUwvvZNvlMiYft3zBR1ftbnUM5KtVVRWFUkmrgiLFCHF1LPRtKFkAhik43B73HF
	 v0MSMEBfsKpodmM0hgjBUpTjlcd6pYV0GHQbuzmL5STMI530w8obMADQgaQ1lHh/Ug
	 xdG65YqiywzFQ==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5f628f5f9e3so5995012a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 07 May 2025 08:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746632274; x=1747237074;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rw+ajBmKH1oYIOuaY57PRGZktJSoo5Qqq7a4MCBkd4k=;
        b=MQ913t2IlUv4RLx0pnal49rml8SIHrWxNh7uGD/zztTxvko5R60Duv0XZf1GCJHLKs
         lWVIjceT8CRM5isKq0qKFcMeOxjlHUkmRor2EMEdYcEwiooVFyfWPRwwT3KzwkkW1eNJ
         IKxDIMI2ZyXgdrND9AKEaorSnN6Enrk6c3n8UBM95LImizZs3VIHN7+W11diUxwXLz2/
         jZcX4qmJIeDHD1FIC25V0/hm8R6VzTsGZRAC/b2pcI0D8ll4BzXEgqOxU9ptMZOpyZJv
         Jouh8xcZu4Yc3R1L4doWnBslwbTwc8xwSpC+sVJ1uQUOsuqo9dLVVOFVfSLVDyjWyMsq
         1SBA==
X-Forwarded-Encrypted: i=1; AJvYcCVFoOkXAi5GnWb9bxAEgVqZyuYYfuBU8GClPr8ktEC+JGvHqsSqkref+mWDOGZtvTSHruwHK8wRSxZAOoqUUvrDQtheRbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeiZO6OUZPiouYcr2JOC8QLODOJFSrxAB8vQqjPi7Hj/JVbcOT
	MKr5yLWGN2clk3L7I7CgFBdO9lgeZe9Nr0GfgIYXNSIt9swIfbW6NancPAMj/YP2jviOOZ+BHI1
	hhhWDIaY6eZYacw5l8RYn3gNbJbZ1pa2PJQmb5GHFeHdSXjknHNcwApM3vFV6E0QCPtz59qoIgt
	T89YJjrrQSmw7TFb35YJeFspZv
X-Gm-Gg: ASbGncuO2b3FRqhDIuLUXZKbvlqixAldD5SQf06GZv6s+CsyPkj2ije4L+Q36Diphf7
	HER4FLC3kt6PXj1/Nko22du8mz3oYkzhgnT0/zmXBytDZZ93dxNqOHKNw6qG4DwWKIVhnliOt5/
	uWltjY/nSDxAgIRjEFIhkWoXex9mHxRTceqb8Ele5YPpJXA4g341cZEq7bVu19kXQeI9cXI6zHM
	+YcPngTEtStEudMUJzSeUybweO8ASwqgbdnMOFfLEcVEfR5LLyoTbLJOHjn8bqiJmILo6/9M/yS
	TR9lLumLRs+38CcMO9IQqAdcp1RmABMYrJhIKzEsOYiFbULtk4RXqjLB2hkQKJCoNeg=
X-Received: by 2002:a17:907:8a8d:b0:ace:ed3b:285e with SMTP id a640c23a62f3a-ad1e8d8971amr360967566b.56.1746632274312;
        Wed, 07 May 2025 08:37:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIiet74C8oMIdKA/PaSf8H9s5ZGkI/NebFPYSp7/1cEBiQAWfXF+ATv0VmOBrz140lQ6CMAg==
X-Received: by 2002:a17:907:8a8d:b0:ace:ed3b:285e with SMTP id a640c23a62f3a-ad1e8d8971amr360964566b.56.1746632273838;
        Wed, 07 May 2025 08:37:53 -0700 (PDT)
Received: from ?IPV6:2001:861:3280:410:2ef0:5dff:fe60:6274? ([2001:861:3280:410:2ef0:5dff:fe60:6274])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1ee0b7e4csm159333766b.52.2025.05.07.08.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 08:37:53 -0700 (PDT)
Message-ID: <705fa834-b680-4a0e-9996-cca0565b0987@canonical.com>
Date: Wed, 7 May 2025 17:37:52 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] lsm: introduce security_lsm_manage_policy hook
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, mic@digikod.net, kees@kernel.org,
 stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
 takedakn@nttdata.co.jp, linux-api@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-kernel@vger.kernel.org
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-3-maxime.belair@canonical.com>
 <9c68743f-5efa-4a77-a29b-d3e8f2b2a462@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Autocrypt: addr=maxime.belair@canonical.com; keydata=
 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
 yriCIKEAbLqHTyj+RhbroZmv5q3X7iVq
In-Reply-To: <9c68743f-5efa-4a77-a29b-d3e8f2b2a462@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/7/25 12:40, Tetsuo Handa wrote:
> On 2025/05/06 23:32, Maxime Bélair wrote:
>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>> index dcaad8818679..b39e6635a7d5 100644
>> --- a/security/lsm_syscalls.c
>> +++ b/security/lsm_syscalls.c
>> @@ -122,5 +122,10 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
>>  SYSCALL_DEFINE5(lsm_manage_policy, u32, lsm_id, u32, op, void __user *, buf, u32
>>  		__user *, size, u32, flags)
>>  {
>> -	return 0;
>> +	size_t usize;
>> +
>> +	if (get_user(usize, size))
>> +		return -EFAULT;
>> +
>> +	return security_lsm_manage_policy(lsm_id, op, buf, usize, flags);
>>  }
> 
> syzbot will report user-controlled unbounded huge size memory allocation attempt. ;-)
> 
> This interface might be fine for AppArmor, but TOMOYO won't use this interface because
> TOMOYO's policy is line-oriented ASCII text data where the destination is switched via
> pseudo‑filesystem's filename; use of filename helps restricting which type of policy
> can be manipulated by which process. 

First, like any LSM, TOMOYO is not obliged to implement every operation. It can simply
expose the one that makes sense for its use case. For instance, I don't think it needs an
equivalent of the manager interface.

If TOMOYO wants to support several sub‑operations, it can distinguish them with the
syscall’s flags parameter instead of filenames (as securityfs_if.c does today) and reuse
the code already employed by its pseudo‑fs, as in the AppArmor patch. Supporting this
syscall would therefore require only minimal changes.

Line‑oriented ASCII text is not a barrier, either. The syscall can pass that format just
fine. Because a typical TOMOYO line is very small, the performance gains from using the
syscall are actually greater. A brief benchmark is available in [1].

Thanks,

Maxime

[1] https://gitlab.com/-/snippets/4840792
