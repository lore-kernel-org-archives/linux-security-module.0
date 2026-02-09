Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1952459DD
	for <linux-security-module@vger.kernel.org>; Mon,  9 Feb 2026 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642682; cv=none; b=j28us5gd4nNM3b3tBimYVlLZX99ZS2dB/PQ0Iui0twBzFkctTX2V2PViDVS6jhM4nlgQntAL24eiOCd1lcWgysWqlspmccZlqvh+oBLjyqsVqWweWJXJWcKAjMs9V6I4/5ZxiOYcaQ/Qf5RoUdOvk/+gvjKaTMYADgQLqXB9L4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642682; c=relaxed/simple;
	bh=nz7xgFpCfdKjzovaoou+lsV8BSq2VzEECg5mAb9gIo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sziRqwZFfs9PaBXiVaqu/I0PpZTErvrVv+n1vm0o9Fc2idyGJImJxlP2R/F+WzhJhUf5EzldyJZoJ68+/AEvQ3zjyJKeVYoLjxcVZh+Oi0XE8Awba60KINzHnSkXEtUWEr6zAyMq7G3ULnf9Qm7Tte0tuAWRFTzZBHN0kIEfi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kG71LqrD; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG71LqrD"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7927261a3acso30315957b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 09 Feb 2026 05:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770642681; x=1771247481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TR6QttVFbdDnEnkz0W7bo0zxZydfzz0ZBdgCZm0i73o=;
        b=kG71LqrDs49VRhUzeWLEi/N6gDL0TvRNVVqMwxDLogaRS6M0xXsgbGb4cKut0HLHOl
         YoIQY+/ntTKi8kAKHXbvGMLXF6GmPeQOl1x8W0eK1d69YHQHdya9ofGl0vNIxe7hhVhi
         1VAsQIjoQ1hmS2PnZCeZlHKUlTbRz8tn+qf3jiYVJpGUlYPxP/kuAznt6unwQn4bcLBk
         cTlG7KaAYzOZTjyL8rMqrhT78kr22mI8+P6ohaKH8H67MVW5rCImb9d4K8NGXuKdAmvf
         8VcLgg/rWgThep2UmOnjuSJaWByBDfMqm0T7KXQ35tjw/KDNc2bH7ayobd7BpG6l8O/v
         6gZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770642681; x=1771247481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TR6QttVFbdDnEnkz0W7bo0zxZydfzz0ZBdgCZm0i73o=;
        b=Ri93xejdBvuoqQtLHUByd1wfvXgOC9vTUP5i2Knu1jo4XxiKTa0S74Ke5gFrjTokHx
         WIKnvbIRsP3HO05KOLcGC4vNU1qhLcYf6VKv6XM44w1v8BTqAT5MiStjn67GQR8ugwV9
         aJpg/TzMT6ELKtRvFYv/OGQJmPbgQT6IVJ18cSLxeS2EVcVv01Olw2w3+gH5wQMOuKpc
         rlexjFd/rb+y/cM4nGJeuN5/mioQeGews8Vz50SbjrNtT5zB2gUbmk6HeADIAlSiQzhd
         sjYdnfSMvn13O41WpZJEmoQ/t6W7sFHyNesHH+cGlnQRYWrUM1g+/f8duN3dZqvnK2rg
         xL2g==
X-Forwarded-Encrypted: i=1; AJvYcCU1JTTmH9FKg28b93ayvSVCBnC/eJ14CIk69mUeieGOChg40f2vVkA/u75970H3gdRPZVl/AM6FDLjjZarh7zbU2yiilXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVJJoGuSA92uvgVy5Ng4IdcNwFHS8s4XnOF3ECIe7Hk8+l1Dp4
	rU69qtzKLqnXLe9RdM7SfJu8aebxpS+knRzp05CJsL9q8UFfIkSJfQPz
X-Gm-Gg: AZuq6aLTnxCDj5FDPP9lIvg1tuDFMT9Ls9WHebGZ3QF2EDi2+xJbkPLCS/lzlUMGI56
	Wcf09OIMTxIvdhzVsv+rRfD/cqOO2zUlHdHJnCtSl+AbMGGT2es83eTF1NgKMMVk6FJIs+yM1bo
	v7zMIEHWtALcNS2xYFrHzc6wbrkn0VPnCKJ2MshwxaOuNf86xAnCLTar4qxMK1V1FKOWgsy46Jr
	kyHmpHm9QIOahtyv5p6beASnU9lo0FROiKrqbqjDeKe6XpLygXW+2R/2QpmjuFIdZnBWC9UerTQ
	agIREiPUZrxf/ZEbMFyGdhwxlerdEzb0+J2ySdWrWcRvt8nQeIfGP8uw4aFvn9z3xZHXGLi1U05
	hBhAKiKoO6DASIW426mUA4EEe0XZ6qB2Ww9Gnd2Q3+cB4MLlFyOTb5hHwoOknLknWYkOT7MXY1I
	5dHxJt3GtupYlcUZAbI0FrJLpcqgbq0CH+sH30wt4n3P8FFESOmFmgYKeh35FvzdspfLG0qbUom
	I3HCtWj1sepOYHE35iM
X-Received: by 2002:a05:690c:6a0d:b0:794:f3dc:a771 with SMTP id 00721157ae682-7952ab96270mr100634447b3.64.1770642681046;
        Mon, 09 Feb 2026 05:11:21 -0800 (PST)
Received: from [10.10.10.49] (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7965705d5a1sm4723217b3.46.2026.02.09.05.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 05:11:20 -0800 (PST)
Message-ID: <c060c613-146e-49eb-b9d8-da28cbb680f7@gmail.com>
Date: Mon, 9 Feb 2026 08:11:18 -0500
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] landlock: Control pathname UNIX domain socket
 resolution by path
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 John Johansen <john.johansen@canonical.com>, Tingmao Wang <m@maowtm.org>,
 Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>,
 Alyssa Ross <hi@alyssa.is>, Tahera Fahimi <fahimitahera@gmail.com>
References: <20260208231017.114343-1-gnoack3000@gmail.com>
 <20260208231017.114343-3-gnoack3000@gmail.com> <aYm1RWtV6Af-zEHf@google.com>
Content-Language: en-US
From: Justin Suess <utilityemal77@gmail.com>
In-Reply-To: <aYm1RWtV6Af-zEHf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/9/26 05:21, Günther Noack wrote:
> On Mon, Feb 09, 2026 at 12:10:12AM +0100, Günther Noack wrote:
>> +static int hook_unix_find(const struct path *const path, struct sock *other,
>> +			  int flags)
>> +{
>> +	const struct landlock_ruleset *dom_other;
>> +	const struct landlock_cred_security *subject;
>> +	struct layer_access_masks layer_masks;
>> +	struct landlock_request request = {};
>> +	static const struct access_masks fs_resolve_unix = {
>> +		.fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
>> +	};
>> +	int type = other->sk_type;
>> +
>> +	/* Lookup for the purpose of saving coredumps is OK. */
>> +	if (flags & SOCK_COREDUMP)
>> +		return 0;   
if (unlikely(flags & SOCK_COREDUMP))
    return 0;
>> +
>> +	/* Only stream, dgram and seqpacket sockets are restricted. */
>> +	if (type != SOCK_STREAM && type != SOCK_DGRAM && type != SOCK_SEQPACKET)
>> +		return 0;
if (unlikely(type != SOCK_STREAM && type != SOCK_DGRAM && type != SOCK_SEQPACKET))
    return 0;
> FYI: This is a (highly speculative) safeguard, because these three
> socket types are the only ones that exist in AF_UNIX (compare unix(7),
> 2nd paragraph).
>
> In the (highly unlikely) case that someone adds a fourth AF_UNIX
> socket type, this means that Landlock will start permitting
> connections to these sockets unconditionally.
>
> I am unsure whether the safeguard is useful, or whether we should
> rather group that (highly unlikely) future socket type together with
> the existing ones.  *If you have opinions, I'd be interested.*
In that case, a new access right could be added for that new socket type.

So we should only handle the ones we expect for now, and reserve the option for future rights
to expand the capability.
>
> The fact that these are the only existing AF_UNIX socket types is also
> the reason why it does not matter that we are now (in v4) taking the
> type value from the server-side sk instead of the client socket.  The
> check will either way always pass as long as only these three types
> are the only ones.
Last time a new socket type for UDS (seqpacket) was added was 2.6.4.
UDS are also part of POSIX, so they're pretty standardized and not exactly likely to change.

>
> For now (and probably for another few decades :)), as long as these
> are the only AF_UNIX types, it does not make a difference though
> whether the check is there or not.
I think this is the correct choice.
>
> —Günther

