Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A932F77B
	for <linux-security-module@vger.kernel.org>; Tue, 17 Feb 2026 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771328021; cv=none; b=JvBtMvCSfUTuclfvW9FEDjLGGH1mSuFPS8SyBJTsXIIF+ZxiLaezyqSkgzf071Iuu97VTtrS2f4JDKOZOh3qRsDkrrxfghCycULsDVm/QYkKUkPYZSP+TeVtNjqybF38jpAiySRvhgG0Y4exFntH+a5ePCQG5kH5WfhapdvDwDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771328021; c=relaxed/simple;
	bh=LCWkprODDHcLHDlO1sccq2mb01PMEJemVBWCtCogBIE=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EcBaPm/b+jX+FAcXcPE5aZ79JzrNVC1xqNK5cEPsBF+uJGip8jFON5wqf2/2KNkAJ3ftuYXGDh1y0/36nG7q8T1GRUYa1ii3fSd3Zqfi1ZFyQNEG4t14UUx+KWsnNIvLIJowTwdOfibRn3T70sXfZ2GIF6R/ZWvKlLDgPL6Zkxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KjpeFaGU; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KjpeFaGU"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-126ea4e9694so1354058c88.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Feb 2026 03:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771328019; x=1771932819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1saam8bI4x8eSRZNX5XiEocUPcHbRPLqKTAYYrB5K8Y=;
        b=KjpeFaGUw1iNBuy/5JJU94GN4UL3pzvD8EYyglfMEmRDpX/hc1NtphDyV7SlH16DFa
         v9hTKXtUXXiaBpdBW3duUWLd46ya4xbnn0f96Aifusg2aCu2bBKiM3VSlvC89JT1azDa
         4V4cTIQr8n3kSHcrmuXMlZwe0ytSopgtme3HzwQbScnPiZhfs9If3KKJeimpqzx3PbPt
         otp+Ei9OXdv/uXNYxjwc+z/+D5J1/S3h9QYRy97gA6Y82rx/ws3ECqrWUXWA3+4xwC1O
         xMw4l3IV3HkQBPxKRUVOXAgrB+ML/tjPjRb+VgvtSoQaopLh3MXG+5xUUK22aAH29Hvc
         qaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771328019; x=1771932819;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1saam8bI4x8eSRZNX5XiEocUPcHbRPLqKTAYYrB5K8Y=;
        b=XA/0VtpC6gUz4a5kFLjC2fLq5JJxvfl8i41RlPZpEZPqPDoPI3kzAElgfh+UAtAtt6
         RW770s0dSGni3FJk0wT9vCSHB7CzWKQK/jY9Jo+r6CuVpimtLhiBECc4uLE57EB1pPe0
         gDvRN9MnCcpfibG6EHWGW3yA/zGAUVFJlhTKVsQ5Ob08FJgOda7TANohFp8f7m9u0IJQ
         rtiZgmsISAQWFBeULSHEbn/X3DfFl0OBaep++A9nagROVPsOKTUYhT3d1AOrrAKOVdUx
         YcBd1ZiqjoJwrEY8h21UUQzRJzq4E76vX2zDaY4zHR7kshOkhscFWZ2FBt6jSbHEvt3N
         /Plg==
X-Forwarded-Encrypted: i=1; AJvYcCVqWOCxJymoW4TuwYCAbE6Nc/28xit8xm6u9QoyQE0heO8qtqBdv4Hd6vXYG4krsx7nA+5JoSRAhUFi2CeN/qqe9Wu5cv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9KJ5jwxnb40l9QR6y+ATGWlBROrogHCqj7itkGToMAFBJ6xV
	0EEw/GeQstKwJ4tDWug2MND3IiDKoeXVj48vudlJkhTUnefCGqzJDp4CVzh8SrqwcF37Ip9iv5f
	B1WM=
X-Gm-Gg: AZuq6aL4m+TE1nI583PWmH2ZOUcs5GjFjl3KBzMTTS2VRBMsPfdDwDzx6vpomHHoPfb
	SaP04OKC8dGaJLuyilZu5wosacH4qroHU9nYB5kca1uCaH5vFBLgrsDFj6bx9/MTVgetQhuCkBr
	mOBpevcfPRXbkhw5wya6HgsbSYgcnlLZN/IJY/QWraIDsdv6iUCZhSY/q8oGl2t3VtQS4v64t1t
	sJp2jh7687SGGcPFS52+8n8mLIPlqtIOwOTDhYdlSWygFzY2ZdHiraBZZWcg9dYyGzw7AFpW1Bd
	i9eXexTfPylHwBDd7ZViognRrJp+wMsOUmU7hX8+Q4j+4Rk4zZQeKI91czkkqUm4QS2tIZJTOvN
	ZH6zKpKFHlXq6iwJmqTRUZRYrKrvGO4cnaBmfkfExiggnfh5zR63D4YQ6XYxhcSGZI8XNK4Xolc
	VeebLZCpwsbKClsBvaelHUdtcaj4MqxU5vW8k=
X-Received: by 2002:a05:7022:a91:b0:11b:9386:8260 with SMTP id a92af1059eb24-1273ae8133fmr6281319c88.45.1771328018825;
        Tue, 17 Feb 2026 03:33:38 -0800 (PST)
Received: from [172.19.249.226] ([205.220.129.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cc9376sm15800764c88.16.2026.02.17.03.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 03:33:38 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Christian Brauner <brauner@kernel.org>
CC: James Morris <jmorris@namei.org>, <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Tue, 17 Feb 2026 12:33:28 +0100
Message-ID: <19c6b606f40.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <20260217-armer-wegfielen-ffb2cdc60283@brauner>
References: <20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org>
 <19c67cca5d8.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <20260217-armer-wegfielen-ffb2cdc60283@brauner>
User-Agent: AquaMail/1.57.1 (build: 105701604)
Subject: Re: [PATCH RFC] security: add LSM blob and hooks for namespaces
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On February 17, 2026 9:54:42 AM Christian Brauner <brauner@kernel.org> wrote:
> On Mon, Feb 16, 2026 at 07:53:11PM +0100, Paul Moore wrote:
>> On February 16, 2026 2:52:34 PM Christian Brauner <brauner@kernel.org> wrote:
>>> All namespace types now share the same ns_common infrastructure. Extend
>>> this to include a security blob so LSMs can start managing namespaces
>>> uniformly without having to add one-off hooks or security fields to
>>> every individual namespace type.
>>>
>>> Add a ns_security pointer to ns_common and the corresponding lbs_ns
>>> blob size to lsm_blob_sizes. Allocation and freeing hooks are called
>>> from the common __ns_common_init() and __ns_common_free() paths so
>>> every namespace type gets covered in one go. All information about the
>>> namespace type and the appropriate casting helpers to get at the
>>> containing namespace are available via ns_common making it
>>> straightforward for LSMs to differentiate when they need to.
>>>
>>> A namespace_install hook is called from validate_ns() during setns(2)
>>> giving LSMs a chance to enforce policy on namespace transitions.
>>>
>>> Individual namespace types can still have their own specialized security
>>> hooks when needed. This is just the common baseline that makes it easy
>>> to track and manage namespaces from the security side without requiring
>>> every namespace type to reinvent the wheel.
>>>
>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>> ---
>>> include/linux/lsm_hook_defs.h      |  3 ++
>>> include/linux/lsm_hooks.h          |  1 +
>>> include/linux/ns/ns_common_types.h |  3 ++
>>> include/linux/security.h           | 20 ++++++++++
>>> kernel/nscommon.c                  | 12 ++++++
>>> kernel/nsproxy.c                   |  8 +++-
>>> security/lsm_init.c                |  2 +
>>> security/security.c                | 76 ++++++++++++++++++++++++++++++++++++++
>>> 8 files changed, 124 insertions(+), 1 deletion(-)
>>
>> I still have limited network access for a few more days, but a couple of
>> quick comments in no particular order ...
>>
>> Generally speaking we don't add things to the LSM interface without a user,
>> and I can't think of a good reason why we would want to do things
>> differently here.  This means that when you propose something like this you
>> should also propose an addition to one of the in-tree LSMs to make use of
>> it. While the guidance doc linked below (also linked in the LSM MAINTAINERS
>> entry) doesn't have any guidance for the LSM blobs as they are generally a
>> byproduct of the hooks, if you are looking for some general info I think the
>> bits on adding a new LSM hook would be very close to what we would expect
>> for blob additions.
>>
>> https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
>>
>> Getting to the specifics of namespace related APIs, we've had a lot of
>> discussions about namespacing and my current opinion is that we need to sort
>> out if we want a userspace API at the LSM framework layer, or if we want to
>> do that at the individual LSM layer; there is a lot of nuance there and
>> while one option may seem like an obvious choice, we need some more
>> discussion and I need a chance to get caught up on the threads. Once we have
>> an API decision then we can start sorting out the implementation details
>> like the LSM blobs.
>
> I might be misunderstanding you but what you are talking about seems
> namespacing the LSM layer itself.
>
> But I cannot stress enough this is not at all what this patchset is
> doing. :)

Likely also a misunderstanding on my end as I triage email/patches via phone.

Regardless, the guidance in the doc I linked regarding the addition of new 
LSM hooks would appear to apply here.

--
paul-moore.com


