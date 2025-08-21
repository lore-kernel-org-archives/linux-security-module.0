Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36402EA498
	for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763944; cv=none; b=RAYLVHVhOFhoQ2tLOd6ByLnH7R+7hGr/BCFLKp3qfoWfBjehSU0MCvOalGpTsWQLFJz4xGHYeFU6j7aRdUV5qDoQSP8BJpQsKZUx5KWfSvE6u26sdRKLaQaZOKUrFTMztNekwqQjSB2MARNvDFlUYxbbTEaJWl32I5O/GazHtus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763944; c=relaxed/simple;
	bh=uwipK4RlTI/vQ2v3QROW9HyrQu51NNMUdnCOUUgx3YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTTkXbEcfafgb6clI+kTIVtTpxnjBNPNWp0nnXCMafQh3fXZKrnjhAtDNlb6WpJ0KHi8u4SoWZVZZxg5rk5n5XXdxd9itSitk0ZoKNiYPR9ZlpYIA1U0v6dIQMMrso5ZPDh1rz9Cj9SNWBLtYbjEVfKlZIR2Tl3FljbdUzOn7kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=L4MUosOQ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="L4MUosOQ"
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C04023F71D
	for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 08:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1755763938;
	bh=vQWwoXxr6VbB+o8afPbqRBzG7z+wpXJtLQfgnKgYKJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=L4MUosOQ0Mt2KdXE0ZD/YX1pnYPxIqAB0w2H9LNWny2po6fU3G76GfBUlnCYYhPzM
	 9vLs31E2EgpYfqGGOPfVC1DJQVpOJCHssM14tbIQtQyatW2ksrSO5QmmQHjWm5i+/l
	 wrs1kZZgfVzml1NZgyd/j9C2otfgoJcmoayYDYJc62KbxTVA2ACobNZpv88rVHLg4e
	 7F9w8LO532PaCKWEXEsudGWr+wEgXweDGjvYlW5XZUB5ddpfNHEX2mwyxbFHHOq3bC
	 4z7OG2hnAod68M4vXsl1/hqSxxQtx7Np/A2mCqdpzRtKsRo/bKPCG+QkYhYKJ9Sx37
	 vXytQe7eZPiww==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32326789e09so1538217a91.1
        for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 01:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755763937; x=1756368737;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQWwoXxr6VbB+o8afPbqRBzG7z+wpXJtLQfgnKgYKJY=;
        b=DLoXno2CFNHg2g0qvs/EnU3Qoce7meJzL2uhuS8fAnoehWgPIFhOChWe5VyvlwKoQ6
         WEDhN2GOeQM0Aq1CqeALPQbu+gOW4EsIwWhQI1QRQqZk8zPIW/YZvKHct7LToqFMFLZC
         kSpW4nat+rXw0aUOB5f+C4hn2KQ9zzlm50zGkUW3rSB7M/fixXInJ4R0HF6fD65SyFec
         kTld5xiYBA7qD4ucjoa38JonX7qRM69/TAOrYkAb4wLu0q3tNA5K66GzFDyG9U9H1Uvv
         Tz4Pw6IuAIXypheC28Sd11vHhy0/weyMGYhq+wk8RZ5MugMQeWcenmhkjPEsYCPyQBf9
         AZrA==
X-Forwarded-Encrypted: i=1; AJvYcCW4aSyVbv8SSgO/PPq8Vdm9Wb1cQODMDPy1+ud56/8+lMr1OZMhpBPi2ehXuzPdskmJY2kY9lv1aeQFDLaTNDzjPTOMRXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztzIZdGkHUd/NU1Yi9ET8LlJCP+GWKXXMYPFA0go5PYeW5Bftl
	clgLnyi2SiCoJXvQNQ4BeXuz2dN5GnwijqPaLPNeZqypBpA1FBcVQRmHyIr1M8n5ZeHQt6Blave
	BpKo0WUOSkSVMsINsztNNukpgL+QFkwMid47So8hDbUqfAIYnAvT4avJtgyArlvhB9Q2GdbM9B2
	s/LpGispw5yZslnRdbwg==
X-Gm-Gg: ASbGncsPZ823FB4jIidzPWUSrZn0N3fl0xotSBYNZ/m5TYLnZ5peIt45uwnK75HgdCe
	VelmfUndRqnNfWsvoiCl+FCYM3pEbsTD8WDHPEKLtKny2kbARh9PgMENc5JwqcHshHzFCTDNXm+
	NpMygLJCdS8d7H3XK8VLuKqcZv+N2uC58ksNHVqztOv/WFLuNFj6uTKqxta7XMdy1XSsvr0EajB
	qhnFnB6hGh6A+FSzbZyyv06a010KWmiPPaxBW74kdGEyMmbJKqFcD2RgpW8frcISSHokS4g4z3V
	x0jyiBMvJcDcloHfGKHaiw1d4HgmLVHhsXIoUzykR5/3BcPcrmwFOw==
X-Received: by 2002:a17:903:22c8:b0:243:38d:b3c5 with SMTP id d9443c01a7336-245feddd902mr21659075ad.47.1755763937337;
        Thu, 21 Aug 2025 01:12:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrz6Ceb3iGn9WBPNAmYI3hI5vPAmwD2RalQSrAqxg3pEgK0u2USRcLhvfQGFcTR9NyAxZcWA==
X-Received: by 2002:a17:903:22c8:b0:243:38d:b3c5 with SMTP id d9443c01a7336-245feddd902mr21658815ad.47.1755763936877;
        Thu, 21 Aug 2025 01:12:16 -0700 (PDT)
Received: from [192.168.192.85] ([50.39.98.232])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640ae72esm4094081a12.42.2025.08.21.01.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 01:12:16 -0700 (PDT)
Message-ID: <9b6ce8f5-6400-4baa-94ee-069e860e8d2e@canonical.com>
Date: Thu, 21 Aug 2025 01:12:15 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
 <aKZ+2NMx+ZQhpySY@mail.hallyn.com>
 <CAHC9VhR-5Rwg132UsLdpJgM0c51HYBrBDivBinw3YcYqe0QTKA@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CAHC9VhR-5Rwg132UsLdpJgM0c51HYBrBDivBinw3YcYqe0QTKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/20/25 19:35, Paul Moore wrote:
> On Wed, Aug 20, 2025 at 10:05 PM Serge E. Hallyn <serge@hallyn.com> wrote:
>> On Tue, Aug 19, 2025 at 02:51:00PM -0400, Paul Moore wrote:
>>> On Tue, Aug 19, 2025 at 1:47 PM Stephen Smalley
>>> <stephen.smalley.work@gmail.com> wrote:
> 
> ...
> 
>>>> Serge pointed out that we also will need an API to attach to an
>>>> existing SELinux namespace, which I captured here:
>>>> https://github.com/stephensmalley/selinuxns/issues/19
>>>> This is handled for other Linux namespaces by opening a pseudo file
>>>> under /proc/pid/ns and invoking setns(2), so not sure how we want to
>>>> do it.
>>>
>>> One option would be to have a the LSM framework return a LSM namespace
>>> "handle" for a given LSM using lsm_get_self_attr(2) and then do a
>>> setns(2)-esque operation using lsm_set_self_attr(2) with that
>>> "handle".  We would need to figure out what would constitute a
>>> "handle" but let's just mark that as TBD for now with this approach (I
>>> think better options are available).
>>
>> The use case which would be complicated (not blocked) by this, is
>>
>> * a runtime creates a process p1
>>    * p1 unshares its lsm namespace
>> * runtime forks a debug/admin process p2
>>    * p2 wants to enter p1's namespace
>>
>> Of course the runtime could work around it by, before relinquishing
>> control of p1 to a new executable, returning the lsm_get_self_attr()
>> data to over a pipe.
>>
>> Note I don't think we should support setting another task's namespace,
>> only getting its namespace ID.
>>
>>> Since we have an existing LSM namespace combination, with processes
>>> running inside of it, it might be sufficient to simply support moving
>>> into an existing LSM namespace set with setns(2) using only a pidfd
>>> and a new CLONE_LSMNS flag (or similar, upstream might want this as
>>> CLONE_NEWLSM).  This would simply set the LSM namespace set for the
>>> setns(2) caller to match that of the target pidfd.  We still wouldn't
>>> want to support CLONE_LSMNS/CLONE_NEWLSM for clone*().
>>
>> A part of me is telling (another part of) me that being able to setns
>> to a subset of the lsms could lead to privilege escapes through
>> weird policy configurations for the various LSMs.  In which case,
>> an all-or-nothing LSM setns might actually be preferable.
> 
> Sorry I probably wasn't as clear as I should have been, but my idea
> with using the existing procfs/setns(2) approach with a single
> CLONE_NEWLSM (name pending sufficient bikeshedding) was that the
> process being setns()'d would simply end up in the exact copy of the
> target process' LSM namespace configuration, it shouldn't be a new
> set/subset/configuration ... and I would expect us to have controls
> around that such that LSMs could enforce policy on a setns(2)
> operation that involved their LSM.
> 
entering as a complete set, is certainly the safest. At a minim the
LSMs are going to need to be able to specify the set of namespaces
the are needed if you enter the LSM namespace. The easiest way to
do this is what you propose, take away the flexibility and allow
moving everything as a set.

I do think we might still have a need to be able to request entering
an LSM namespace from the set, but I think that at least for a first
its probably better to not go there.

