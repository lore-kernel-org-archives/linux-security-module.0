Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810BE288D6
	for <linux-security-module@vger.kernel.org>; Sat, 13 Sep 2025 00:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723625; cv=none; b=m/qfhFL2HcpyMQ7ySmACdwhWTB4jVYeZO73P7KloJvs8qmjac2Z26g9hd/L7iNYYExQcKkIopDU+O6CEygYWzHOk1pmbf1MjI+ZI0/WkESE4gPzLCfMnFYh2Uo5igf3Q6i/umTmIYOibNjG2fR4GOtm5bfeeMMCG9pPiaw4IHqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723625; c=relaxed/simple;
	bh=6ixjMQGo+mF9rxxhZunX9VzR5bs0JXrtOuI72NkTM98=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R5IWTEWXtQHuwjPYypnIi8/cs4mSsafpEU1tHVive1Wxl2liZ7np9UHckrDcXsv2DoBVFDNV+oYT3tkPGnEwJcyKGrpGpBg9qouVGaqAYb+AVi4NT7qXqqFqYawjHOlRFWwxLucAe8xTi1OnWgbozztwPZpM40zdIUVgnel43O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ggp4mBl/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ggp4mBl/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757723619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncBfGy8EE17qYCVshxa8cc5ygoQQollWUOgPghVnN+8=;
	b=Ggp4mBl/eGpVuJG+snCSL6z26drJnjTUm0xzQi0m+3unXzAr4d7bNp6S84CIJ1J1Ps8I9M
	kllHDluNI+sUgcmtame5/seZoENBFDxfBOfwJ3in4A1emsg8Th+eNFua7QtSm3malkBwqI
	w1wT48GHL6g7vPbJtuvoB/XKZ/fUqGY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-eeljpTf3NwinSP5w1xGgoQ-1; Fri, 12 Sep 2025 20:33:34 -0400
X-MC-Unique: eeljpTf3NwinSP5w1xGgoQ-1
X-Mimecast-MFC-AGG-ID: eeljpTf3NwinSP5w1xGgoQ_1757723614
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5f75c17a3so62884991cf.3
        for <linux-security-module@vger.kernel.org>; Fri, 12 Sep 2025 17:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757723614; x=1758328414;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncBfGy8EE17qYCVshxa8cc5ygoQQollWUOgPghVnN+8=;
        b=doH9mVnmtphkl9cImWSczItB3v7zlX8cL0f/JSlaDP7CrtLiZn4etXPJeBZBZ+DING
         k67pBrCxC6cAOnBonAUZi646l3nHvVKDipeIFdOyWNbZ7QRCYUSZxeiRmMDZFs6IEcQc
         PYKVAupffMApmZYNJrx4Drm7D0Tpti/H88QTVzwEZjG8iD4MijT1M1IMQU9caFri+FMr
         3ilQuGVvFtXSJoD9cVy1ySL01//yA7ndN3faPxe8bw698tL/SnIjal+KexfZo9gpRz9z
         9qABTHxtSXsS3XlRMRRUEyGhP8LOFJAHW/BB+OdW8ys4P4hTJQtP5yMTv0HSuNOmF/PQ
         DxVA==
X-Forwarded-Encrypted: i=1; AJvYcCUghaTDaNBPOnzZyOP5Clq0O4kbmwWoAcnRpLzDFiogYwWezj6JdSWZ0zdxxPclDjgS+gp3otMrohgwQzG+uS/dv+3Tr9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8p0H16LYkGyMLWQjeM7vMT1lVL28052MeDIVruIBnIAxKGaRt
	NY9qCT7s52ntryd5NFSmBD11Miw7GKNs8S/vqxHzJ9MSm9jCugx9StMWDJ/SssxaNy1Wxuz8hcZ
	bAiUIK338iF/qwHTisquftKjIDUdfSE5hQVsrIN9O5x4VVAhtAEQLI9/qyRfX3nDLjTsv4k72yQ
	r9Qg==
X-Gm-Gg: ASbGnctrDTZ6gARDnlT4dScpuj1cL1Ua3rLbTz30g+yMT0DVnYeF6+E3bNO17ZJj079
	WEvy0/rjOo8rBGNmGY5/E2KAd6BKQ/DxN9pQCMCZcRYMC1sVAdEGYE1er1/3YQuSoomvBu/AUtS
	54pXjsSMPT4s1OtU1HgUPUTq8aLgxjtqa6b1wgMGgR7bQbC92Hm/c/5eX0yxqTMpG9q+OwdDwVQ
	rw/MPtfAL58ZqwUbWlk7ZjbyYFZY522cRXdVB/b3YMlmQSRKo6anrezWxdZB2hkFvSyi8Jd9k+G
	jXTTB7aNHI8HxnuL56WhKNlSipmBBHICM8tNteLznJ6z0N0cMhTHszRUiYJWKvwLpiAQImuS827
	yFvwd+g8zaQ==
X-Received: by 2002:a05:622a:1a05:b0:4b6:2f52:5342 with SMTP id d75a77b69052e-4b77d1ab3a1mr68076381cf.79.1757723614312;
        Fri, 12 Sep 2025 17:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRq8wbBNQnbSCZtG/tvewoa9dvMcBJkb7MXthP0yviRVZ6G/ctSPGgxUCMnelFEMNwo4BLAw==
X-Received: by 2002:a05:622a:1a05:b0:4b6:2f52:5342 with SMTP id d75a77b69052e-4b77d1ab3a1mr68076091cf.79.1757723613947;
        Fri, 12 Sep 2025 17:33:33 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639b99de1sm31462791cf.8.2025.09.12.17.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:33:33 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9d06c0d5-e20c-4069-adca-68a2c4cf6f4f@redhat.com>
Date: Fri, 12 Sep 2025 20:33:31 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock
 critical sections
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <llong@redhat.com>
Cc: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org, tony.luck@intel.com,
 jani.nikula@linux.intel.com, ap420073@gmail.com, jv@jvosburgh.net,
 freude@linux.ibm.com, bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-nfs@vger.kernel.org, linux-aio@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org,
 cgroups@vger.kernel.org, pengdonglin <pengdonglin@xiaomi.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
 <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>
 <20250912213531.7-YeRBeD@linutronix.de>
In-Reply-To: <20250912213531.7-YeRBeD@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qZhKU29XrX5g1kNrEYtulxb5BOZBzWzYmC7M7pDNnnA_1757723614
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 5:35 PM, Sebastian Andrzej Siewior wrote:
> On 2025-09-12 17:13:09 [-0400], Waiman Long wrote:
>> On 9/12/25 2:50 AM, pengdonglin wrote:
>>> From: pengdonglin <pengdonglin@xiaomi.com>
>>>
>>> When CONFIG_PREEMPT_RT is disabled, spin_lock*() operations implicitly
>>> disable preemption, which provides RCU read-side protection. When
>>> CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
>>> manage RCU read-side critical sections.
>> I have some doubt about your claim that disabling preemption provides RCU
>> read-side protection. It is true for some flavors but probably not all. I do
>> know that disabling interrupt will provide RCU read-side protection. So for
>> spin_lock_irq*() calls, that is valid. I am not sure about spin_lock_bh(),
>> maybe it applies there too. we need some RCU people to confirm.
> The claim is valid since Paul merged the three flavours we had. Before
> that preempt_disable() (and disabling irqs) would match
> rcu_read_lock_sched(). rcu_read_lock() and rcu_read_lock_bh() were
> different in terms of grace period and clean up.
> So _now_ we could remove it if it makes things easier.

Thanks for the clarification.

In this case, I think the patch description should mention the commit 
that unify the 3 RCU flavors to make sure that this patch won't be 
accidentally backport'ed to an older kernel without the necessary 
prerequisite commit(s).

Cheers,
Longman

