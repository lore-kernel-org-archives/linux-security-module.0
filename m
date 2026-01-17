Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25D247291
	for <linux-security-module@vger.kernel.org>; Sat, 17 Jan 2026 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768676244; cv=none; b=FMpKDA6qWp3ED1LPBqYGTLafHJfZ4P5yh3mg4YuAI8ag+SaaP3egsflijLqv0/wqa6P4Kqr/4X0GZa/we1/wJZMIrRegf/Gn80StAiSTtG2QjFopAjB/dVCuagE/QwhIo/ZWs4RqLwPmygyh6l8CXuKKUr50+s1BekmbgdljnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768676244; c=relaxed/simple;
	bh=xEEsF8SvIxzzdUDGfrYtFYaT+ImMLwTIvZe4aLqUY8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmQNpY9qVe4ceEDUwnuZ//G+CC4c+bWg+hw1+FTOVl2a7XVJxFIB8IMHmsKluynOSRSgwbYdsUTFIguqd1LxzfFL7YX/A0CY+gn9nGMcHG1LSsGFj33f15PTyaXe77tydZgOdrjT2DWmN9vvXdnvQPc0vPLsOT2FZrtlPXbfugI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SELkQ9mW; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SELkQ9mW"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7904a401d5cso31481067b3.3
        for <linux-security-module@vger.kernel.org>; Sat, 17 Jan 2026 10:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768676242; x=1769281042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=676KBkVSn71Fn3wKmokPJuD5dVRmQPkW4hcPXYMxdLM=;
        b=SELkQ9mWh24VRX0aLqhwx3IXjekg7yulh5qJjgxAJ5L/hD3gzrjvUIsyPAMr2tUXy0
         qcCFTIBgZ/wJuD7XHtRMdd6pjJVom7jVigiCVsDduUqgDKjFEDs1De/hUa4hylH7bdWU
         SQGprFpShFUhtdD7RhmQRiNfbvfnmA+Ew9M8f8FF4NLxVBexbsgo/8EmKQVkrNE6GaCA
         BTvT10/2GfetI6+P1I1kEY0Enftzo0V6j6RVjWK3h7k+W6uGreincywKPyhYYdWJbf1k
         0c8e/KiOjiV0ciTIAGTX+ULts0H04vPu76yCWnIBaWre9IbG49b/lZ2xp+1weNLaanNK
         X2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768676242; x=1769281042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=676KBkVSn71Fn3wKmokPJuD5dVRmQPkW4hcPXYMxdLM=;
        b=AhK9U+5NvLicnO2wuWMyc1rym4ez6ua8roCmB0kX3PGFCbPr/pPyvkIRbWVYjhsx/+
         Edg/lTFdZ+3fIhRuTVl8O1Sy0na0GOfgpH9crOGUYMDDsdILctXxfzIfGzv4jh9eU+ef
         JNGq//UHNIW+RHAa1YOSJ4EiD1RZMSUKDv+p5GcbQQa+JmMQaqOribp56u9CzeFqRnXq
         BRfvml1F9RCDADa0UxFJUMMz9o3WIN6r+rr3OBAbk1nRpsrCgGHu2ltuc1Udrp+64Mjl
         oFsshbJUhHbA6KaJNzZF4FRGk4ONMdoEi/tX7tO9Dtzvk/E32xoey/DAjDhMeEejwIgw
         S5kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBRlqsvikUgI83E9qdmU6KJvVYfQdlV6NlMIWmU4vsN2Wj0zLZBvgulG0SUTrIQAIkq33kYQfgpjYzLJe2WN92hwHsJGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0aQ3DUyuURixV7UZZa1oqnZ9h1VxzaNlgO9NBikjJqT9Z6jIP
	rRf+303AkHjRotrGpmuPg2eUG+FLR6TGKYo/ik941b0vnP0DWv5fuIxj
X-Gm-Gg: AY/fxX7uU0y4YGSH2XnTcGIvpFFOyD6kI7nh0sUrVe7oeJXkdVd7/psJwvoili3UziC
	a7blm+8TBNJayjo8ztOmEDvp/Ay6QQKVsaAEyhh29+YVGwIHLRX3iOQN937KOVprurJeD8lm2RP
	pVFeg49pCbT9ddKcQA0R1WnbU9IbN3Gam9iIToVZDAUq4h4BP1thcv49Yjs8u7Ew0rr1ZtrMKza
	6DXvYAxZbMut3GRFq0RFxWiXOc84W0j2EaEKJ8P5UOTBJ2vsTf95uLTg225NJvFQKPnEf5qI4QI
	NQjyz5EJkM2uXYB9ccD59gAvvc5BvS/v4AynZkMTQQbbLcDzzWvf07xMG9p8sOskdr2UFxXsGiq
	VouMi2e9Bm/Z9p+4OtT3BKt+XsKug9UnqKb6/LMoXWGZMbhXun2BCnalSeqGuBrIS2tNcozwuW4
	2jTlnXD7cBtx1Q8+yiQs2Tijnn+BGqHNRK9679Y3UVdasSnVsjQp4DvapxUTn22ixt57luqw==
X-Received: by 2002:a05:690c:5:b0:788:f56:afa7 with SMTP id 00721157ae682-793c538fc89mr55340037b3.40.1768676242375;
        Sat, 17 Jan 2026 10:57:22 -0800 (PST)
Received: from [10.10.10.50] (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c682e088sm22672137b3.31.2026.01.17.10.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 10:57:21 -0800 (PST)
Message-ID: <62eda124-de91-4445-b163-9dfb8039d08c@gmail.com>
Date: Sat, 17 Jan 2026 13:57:20 -0500
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] landlock: Pathname-based UNIX connect() control
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>,
 Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
 Tahera Fahimi <fahimitahera@gmail.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
 <20260112.Wufar9coosoo@digikod.net> <20260112.a7f8e16a6573@gnoack.org>
Content-Language: en-US
From: Justin Suess <utilityemal77@gmail.com>
In-Reply-To: <20260112.a7f8e16a6573@gnoack.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/12/26 15:53, Günther Noack wrote:
> Thanks for the review!
>
> On Mon, Jan 12, 2026 at 05:08:02PM +0100, Mickaël Salaün wrote:
>> On Sat, Jan 10, 2026 at 03:32:55PM +0100, Günther Noack wrote:
>>> ## Alternatives and Related Work
>>>
>>> ### Alternative: Use existing LSM hooks
>>>
>>> The existing hooks security_unix_stream_connect(),
>>> security_unix_may_send() and security_socket_connect() do not give
>>> access to the resolved file system path.
>>>
>>> Resolving the file system path again within Landlock would in my
>>> understanding produce a TOCTOU race, so making the decision based on
>>> the struct sockaddr_un contents is not an option.
>>>
>>> It is tempting to use the struct path that the listening socket is
>>> bound to, which can be acquired through the existing hooks.
>>> Unfortunately, the listening socket may have been bound from within a
>>> different namespace, and it is therefore a path that can not actually
>>> be referenced by the sandboxed program at the time of constructing the
>>> Landlock policy.  (More details are on the Github issue at [6] and on
>>> the LKML at [9]).
>> Please move (or duplicate) this rationale in the patch dedicated to the
>> new hook.  It helps patch review (and to understand commits when already
>> merged).
> Justin, would you like to look into this?
> Please feel free to copy the wording.
No problem.

It's quite long, so would it make sense in the notes?
Instead of directly in the commit message?
>
>
>>> ### Related work: Scope Control for Pathname Unix Sockets
>>>
>>> The motivation for this patch is the same as in Tingmao Wang's patch
>>> set for "scoped" control for pathname Unix sockets [2], originally
>>> proposed in the Github feature request [5].
>>>
>>> In my reply to this patch set [3], I have discussed the differences
>>> between these two approaches.  On the related discussions on Github
>>> [4] and [5], there was consensus that the scope-based control is
>>> complimentary to the file system based control, but does not replace
>>> it.  Mickael's opening remark on [5] says:
>>>
>>>> This scoping would be complementary to #36 which would mainly be
>>>> about allowing a sandboxed process to connect to a more privileged
>>>> service (identified with a path).
>>> ## Open questions in V2
>>>
>>> Seeking feedback on:
>>>
>>> - Feedback on the LSM hook name would be appreciated. We realize that
>>>   not all invocations of the LSM hook are related to connect(2) as the
>>>   name suggests, but some also happen during sendmsg(2).
>> Renaming security_unix_path_connect() to security_unix_find() would look
>> appropriate to me wrt the caller.
> Justin, this is also on your commit.  (I find security_unix_find() and
> security_unix_resolve() equally acceptable options.)
security_unix_find works for me, and seems to better match the hook
location. I'll send an updated commit.
>
>
>>> - Feedback on the structuring of the Landlock access rights, splitting
>>>   them up by socket type.  (Also naming; they are now consistently
>>>   called "RESOLVE", but could be named "CONNECT" in the stream and
>>>   seqpacket cases?)
>> I don't see use cases where differenciating the type of unix socket
>> would be useful.  LANDLOCK_ACCESS_FS_RESOLVE_UNIX would look good to me.
> I did it mostly because it seemed consistent with the TCP and (soon)
> UDP controls, which are also controls specific to the socket type and
> not just the address family.  But I agree that the granularity is
> likely not needed here.  I can change it back for v3 and rename it to
> LANDLOCK_ACCESS_FS_RESOLVE_UNIX.
>
>
>> What would be the inverse of "resolve" (i.e. to restrict the server
>> side)?  Would LANDLOCK_ACCESS_FS_MAKE_SOCK be enough?
> Yes, that would be enough. My reasoning is as follows:
>
> The server-side operation that is related to associating the service
> with a given file system name is bind(2), and that is restrictable in
> that case using LANDLOCK_ACCESS_FS_MAKE_SOCK.
>
> Also, to my delight (and other than in TCP), listening on an unbound
> socket does not work (see unix_listen() in af_unix.c):
>
>   if (!READ_ONCE(u->addr))
>   	goto out;	/* No listens on an unbound socket */
>
> (You can get it to "autobind" during an explicit bind() or a connect()
> call, but that creates an abstract UNIX address. (Documented in
> socket(7) and implemented in unix_autobind() in af_unix.c))
>
>
> –Günther

