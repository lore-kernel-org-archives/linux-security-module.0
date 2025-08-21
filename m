Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80922ED14E
	for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788239; cv=none; b=OSaG4Vy9nuhGF4OkgeRQYcneswCe3wUMGh0Ny5x7ISyuqqrop48sQt/sMdX1PcbDyB+3SxBdzXlfR5kF7qVXsVPjfmOeUxz+rXazEoAkydpFy80TuwaIA6/ILbEMpL0b0ampJe2YyExO5owjVGhzH0Ihbgw/egicXS3SctO3C6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788239; c=relaxed/simple;
	bh=Ry2BvjubiE3qPVaGysfioZvT0nO8pYwe45qM1x8Bcx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFggHYJ4GKCYfN0ESgpQZrz9qEL33tjFzOzdPpkvOA59zle0JPXhiZaildhw3zpCAx2yDTltfeP/i0joK8z/Inaow+3y3EGJKwhKFzD/Ye2B0M7YctXOZvEtqk4Efbfnx71pWlhJBoOSwX9RCuc2IbbyefvJxxCecYYcaxO76TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=T6MUUSTp; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="T6MUUSTp"
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DF1583F7C1
	for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 14:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1755788234;
	bh=49KadSM7LODad5Y3n0IT2vlw19Y4aDAkBqYuB5uoRcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=T6MUUSTp0/o1trdOzbvgMXPWkduNpuzFhwfyv2hxWFvBVuMjR2xMi20v79QUW/Ahu
	 b8qglrQPAkU5Yeeky4k57U8sJ61XXyHVr7e8LG33N7t/4lbBLwXPom7et61N7uSSkr
	 WYPSzKEiD1yUtYbN9F3AlKdVFXw9gkgJLouCaAgo9j61DDlrFwESfIKia7C3UkSOlQ
	 3MYtfcyt4BTc/hCJP5DDYrUSKuH/Fqv8gjheh91RCFXjCX+3f28IChVYavqwcLEkMJ
	 jzzVSoE+Bl8OqKDBaJzdZRnxGZ63DxbA/biQN062L3uKc7/R2+nM5NryQdM/O8zjXS
	 DYkfMCiDJppbw==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244581ce13aso23617985ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 07:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755788233; x=1756393033;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49KadSM7LODad5Y3n0IT2vlw19Y4aDAkBqYuB5uoRcM=;
        b=XpMMtnWJsByO0LfQgFmk3ukeGTY13i55fghrtPjg9QaJpFHK+KSbPrmbXS6OPH5MFy
         gaY+mjqv9nrotQoVpzsujwPte5j/l15mqpkP8ruwuR3RAZPReFkDnsgvhYA8uNZLLRIO
         JUKivckKKrQoRPQfr0UqxaXvbdNzgVjmCMJWGwAxtkMrcJfIfwGCUbF1A0D2vxi5dgpK
         2S0rZBtW78q15Zk2LwT7LkfVRngcVqOArFuLLiCa1HTm2aR1t5Ru1fQhImBGMIFv8pZS
         wqkZL6pr1fEnoI0E2HFj0212wCKMNj7rwOk1343zgaLc23FcuS4gBq4QjGfG7ic2qkHw
         VM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBppZTKUjzqcCQiqik91hxpgfwm4UNfmwir094Zy3QB04C8sk1H1ePtK49UT8AnXNFipYPUl/sgDAgLoI3ITJ0PzrrCRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1YfXdd/mdhhz1zPaDl5HtxCJIpDD6q97j5XeIHRPy1/wpwiw
	5A5ZwL4h8lmo1QafrGRy/F+LY0Jta078N0cqnRrbhVFUnPcjatC5l7A8tda11sjR1qpn8O5AhMF
	rIgVxoGRUU6S2cPAo6fusizAMghUxS+lXBVRb0TmCEGUT6K6ktj2aJFenWTpr98t7r5IdspmUMI
	99Jy/qX/YE6MoO68D/4w==
X-Gm-Gg: ASbGncuITVVB9cJBPFj1EtXXjwyk1W1o0Z1DFevO/KxQVCRV1joBnxVXlyypMTl9/xc
	vRuf6dFgZDXkmgkbr9QETdMqyBTBtDgBv7XHEFJRXXc8N80v0KUHLVX5m0xvBv0GeeirhTSb4hG
	XEkVT5vlLGw8QTKnyRZfYJRSCQMUYGkM2Goiwz4mKZd52S2urkel0JWeUhseARoYqT7J0wxUGMD
	lh9lzZU9Rh/CXoc25noiHxt2UGh/7RgdmvE1fRqfe33QnVN3vt8KI1in86U6y3c01GOgAQGZyOq
	lasAxzi8KouzKK0Jy7xnz8TDD5VtfmOdejZc0QVn2dtKmNirPrmvLA==
X-Received: by 2002:a17:902:f78a:b0:240:11ba:3842 with SMTP id d9443c01a7336-245fed69158mr34636645ad.35.1755788233409;
        Thu, 21 Aug 2025 07:57:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECZej/40kPiFRMnMa1YsijnxzrmXXgidDBdAA3jr7FLfXXEK5s+1j2gLpDetd0Mu08TyQJzA==
X-Received: by 2002:a17:902:f78a:b0:240:11ba:3842 with SMTP id d9443c01a7336-245fed69158mr34636285ad.35.1755788232980;
        Thu, 21 Aug 2025 07:57:12 -0700 (PDT)
Received: from [192.168.192.85] ([50.39.98.232])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-245ed4c7494sm58278825ad.99.2025.08.21.07.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 07:57:12 -0700 (PDT)
Message-ID: <6c69fc81-32a7-442c-8c7f-992eda9c2d18@canonical.com>
Date: Thu, 21 Aug 2025 07:57:11 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <67e72960-c985-48e1-aaeb-a4286cc8508f@canonical.com>
 <aKcskclwVVe1X4kP@mail.hallyn.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <aKcskclwVVe1X4kP@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/21/25 07:26, Serge E. Hallyn wrote:
> On Thu, Aug 21, 2025 at 12:46:10AM -0700, John Johansen wrote:
>> On 8/19/25 10:47, Stephen Smalley wrote:
>>> On Tue, Aug 19, 2025 at 10:56 AM Paul Moore <paul@paul-moore.com> wrote:
>>>>
>>>> Hello all,
>>>>
>>>> As most of you are likely aware, Stephen Smalley has been working on
>>>> adding namespace support to SELinux, and the work has now progressed
>>>> to the point where a serious discussion on the API is warranted.  For
>>>> those of you are unfamiliar with the details or Stephen's patchset, or
>>>> simply need a refresher, he has some excellent documentation in his
>>>> work-in-progress repo:
>>>>
>>>> * https://github.com/stephensmalley/selinuxns
>>>>
>>>> Stephen also gave a (pre-recorded) presentation at LSS-NA this year
>>>> about SELinux namespacing, you can watch the presentation here:
>>>>
>>>> * https://www.youtube.com/watch?v=AwzGCOwxLoM
>>>>
>>>> In the past you've heard me state, rather firmly at times, that I
>>>> believe namespacing at the LSM framework layer to be a mistake,
>>>> although if there is something that can be done to help facilitate the
>>>> namespacing of individual LSMs at the framework layer, I would be
>>>> supportive of that.  I think that a single LSM namespace API, similar
>>>> to our recently added LSM syscalls, may be such a thing, so I'd like
>>>> us to have a discussion to see if we all agree on that, and if so,
>>>> what such an API might look like.
>>>>
>>>> At LSS-NA this year, John Johansen and I had a brief discussion where
>>>> he suggested a single LSM wide clone*(2) flag that individual LSM's
>>>> could opt into via callbacks.  John is directly CC'd on this mail, so
>>>> I'll let him expand on this idea.
>>>>
>>>> While I agree with John that a fs based API is problematic (see all of
>>>> our discussions around the LSM syscalls), I'm concerned that a single
>>>> clone*(2) flag will significantly limit our flexibility around how
>>>> individual LSMs are namespaced, something I don't want to see happen.
>>>> This makes me wonder about the potential for expanding
>>>> lsm_set_self_attr(2) to support a new LSM attribute that would support
>>>> a namespace "unshare" operation, e.g. LSM_ATTR_UNSHARE.  This would
>>>> provide a single LSM framework API for an unshare operation while also
>>>> providing a mechanism to pass LSM specific via the lsm_ctx struct if
>>>> needed.  Just as we do with the other LSM_ATTR_* flags today,
>>>> individual LSMs can opt-in to the API fairly easily by providing a
>>>> setselfattr() LSM callback.
>>>>
>>>> Thoughts?
>>>
>>> I think we want to be able to unshare a specific security module
>>> namespace without unsharing the others, i.e. just SELinux or just
>>> AppArmor.
>>
>> yes which is part of the problem with the single flag. That choice
>> would be entirely at the policy level, without any input from userspace.
> 
> AIUI Paul's suggestion is the user can pre-set the details of which
> lsms to unshare and how with the lsm_set_self_attr(), and then a
> single CLONE_LSM effects that.
> 
yes, I was specifically addressing the conversation I had with Paul at
LSS that Paul brought up. That is

   At LSS-NA this year, John Johansen and I had a brief discussion where
   he suggested a single LSM wide clone*(2) flag that individual LSM's
   could opt into via callbacks.

the idea there isn't all that different than what Paul proposed. You
could have a single flag, if you can provide ancillary information. But
a single flag on its own isn't sufficient.

You can do a subset with a single flag and only policy directing things,
but that would cut container managers out of the decision. Without a
universal container identifier that really limits what you can do. In
another email I likend it to the MCS label approach to the container
where you have a single security policy for the container and each
container gets to be a unique instance of that policy. Its not a perfect
analogy as with namespace policy can be loaded into the namespace making
it unique. I don't think the approach is right because not all namespaces
implement a loadable policy, and even when they do I think we can do a
better job if the container manager is allowed to provide additional
context with the namespacing request.





