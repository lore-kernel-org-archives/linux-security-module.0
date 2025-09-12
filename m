Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512073376BC
	for <linux-security-module@vger.kernel.org>; Fri, 12 Sep 2025 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711598; cv=none; b=FzI75fzSta3PlrI3WJXMa6r3pX67V1lewn1U4XGChYIYQ2AOP4/17bRKgdvB9a4/yWh0h5W7QyGNHrMP/AAVVk5nVabV98mL5gKSd8VmVtyVtCrfyVdEc6JHWRS6dWOQOB+HoSgWODc6G/Ur5ytEGtyCHINOFcmSjhMIH2E2R6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711598; c=relaxed/simple;
	bh=gcaCtOTSXV2XbJKiE3q73MLyt7PVw58fJiPF6uaIJog=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=M21BDgR70xSUjgQnIE5kG4dnPynn2FLqGs/AY9nzyWmrGem741cjg5v2iTMKgKBZsLEPiPa5YFfc7UvRi/DL9az/RK4HOa6sPusxMCCYAOvfAQcgg0CoczkTZ/lYQ+R6hkA5i6O6tSteVc1ImtXTDnaxlcnNHEk8kW5x1G4A3YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNmb4SFh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNmb4SFh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757711595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puZ5qQZ4d8umwYGFpsrfF5AtoSoF7QsuDi9Z2wL5SwM=;
	b=BNmb4SFhg5vtKEAZ2u88geYPbXKfOKLXJSc/lcuuSvdflUl61PxqRI+oUueNbUTRdcewi9
	xMCzqSBsrFKAmDmf/RonyTOgORuz5Oud3YJzivIxr1JiNzhhEH9Evm5/HsIvBr+Hf8rmWX
	SvptbA9Q/ZYEbEmcORc6zuPZlqIvKQI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-DnYpWeMlPgy8-Vk5691ieg-1; Fri, 12 Sep 2025 17:13:12 -0400
X-MC-Unique: DnYpWeMlPgy8-Vk5691ieg-1
X-Mimecast-MFC-AGG-ID: DnYpWeMlPgy8-Vk5691ieg_1757711592
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b60dd9634dso58720421cf.2
        for <linux-security-module@vger.kernel.org>; Fri, 12 Sep 2025 14:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757711592; x=1758316392;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puZ5qQZ4d8umwYGFpsrfF5AtoSoF7QsuDi9Z2wL5SwM=;
        b=RwA37ytVwzMAwRLyVEhc0puLMrGnEvID8bQvbSjY8/lZj0x6XAij6MXpZigcOHWPza
         8pZKAUjDsxoNVreZPEgWEBdXCqDXOnQLbeNUilXmL/08qdCu7RRQqAY1R1IpgOru6LTY
         oAuVM9OZvI6SDPqD2cJuIqLBiRhyf8pDXe0Y3DSf1YPJhJ5jB0oz8+o4GlroxRXwtA7S
         AB0m7QaGEekgmxLHOGPI33j5jQjhskEJALck1siK3WG1VOKBy2zvHf1X2NA+jBgCDhUf
         y0uDQ5iJ/pkkiEuf7+JgRKBoFF6lMz0oFqWKIGy5pjXnz2sX0yh1nwCe8RAUS4q6bLRq
         CCCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXVNaXyz4XusiydZTpkUHmkJRzULRLlRi95UCxdWoCisVn5lRLFpXXAX3jnsYAZ374z9OtjgmixhBssj9A8SEjcDT0TUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJUn2NFCOUVoBaHseru1a6xIpfYxZfoN7ikO5A9haL+JfBaPKG
	pLPslFjtpLfD92hyGHu5SCHevYMN6MS/FZBxkUC6PDxFTmAqLRW0t75puRTIcWg3OJzkhmjyrGi
	tacgqV/3su4gFIRWDPpEc7W2kWwbTRcBLnBgUGkcAuqPI2CJF0WWrwgM7A3HCj4+cQHN0sT5uoF
	eAoA==
X-Gm-Gg: ASbGncv6GfDI/Pt2GceI5DXH6cU8npVcdiZ+oVm8asQv13GtjHpWHiXHTIikL8uGEmE
	W0xUbTUavErNYc5M8jmgz3/Pg1rQtiD97RV1V1AAnCUIY7mw0CQJEuJBBGOcal3FcRrXpJRBKS1
	8HqoaWELfokPcelGwhvqBl+WuAwmPQpiQLFExR1Wy9xw1yXN+1hsXfjFDUXX2ZyC6dBNAXs/N0b
	uTq0i2rBbCpPSflWgQ2Kpm7FkAY+3FktxphXXhvWxqKnfZ0kQAr1sXsLkf1IJucFknj0r0751TV
	XfWx+P00tcfu7YUaovwVsgXsFDY6ws3Ft8Q4a+Cxi+ejWzZWvke7szcEgHI/O4xaSMRUVMIoPEq
	DeFxvO6Lbpg==
X-Received: by 2002:a05:622a:59c7:b0:4b5:6f4e:e37 with SMTP id d75a77b69052e-4b77d0a6081mr68549471cf.25.1757711592213;
        Fri, 12 Sep 2025 14:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMw9fpUjKztDhFj7vngF7IcasgotLQXC7Sz/FG+fDJqIxlNqO5vbKN00AADMBFHKIX07xTcQ==
X-Received: by 2002:a05:622a:59c7:b0:4b5:6f4e:e37 with SMTP id d75a77b69052e-4b77d0a6081mr68549191cf.25.1757711591843;
        Fri, 12 Sep 2025 14:13:11 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dab102sm29277371cf.33.2025.09.12.14.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 14:13:11 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>
Date: Fri, 12 Sep 2025 17:13:09 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock
 critical sections
To: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org, tony.luck@intel.com,
 jani.nikula@linux.intel.com, ap420073@gmail.com, jv@jvosburgh.net,
 freude@linux.ibm.com, bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org
Cc: bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-s390@vger.kernel.org, cgroups@vger.kernel.org,
 pengdonglin <pengdonglin@xiaomi.com>, "Paul E . McKenney"
 <paulmck@kernel.org>
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
In-Reply-To: <20250912065050.460718-1-dolinux.peng@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hzFRRiJsZDZ7_qwuB9efg4syj7zWjS2hd009NqN0eWo_1757711592
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 2:50 AM, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> When CONFIG_PREEMPT_RT is disabled, spin_lock*() operations implicitly
> disable preemption, which provides RCU read-side protection. When
> CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
> manage RCU read-side critical sections.

I have some doubt about your claim that disabling preemption provides 
RCU read-side protection. It is true for some flavors but probably not 
all. I do know that disabling interrupt will provide RCU read-side 
protection. So for spin_lock_irq*() calls, that is valid. I am not sure 
about spin_lock_bh(), maybe it applies there too. we need some RCU 
people to confirm.

When CONFIG_PREEMPT_RT is enabled, rt_spin_lock/unlock() will call 
rcu_read_lock/_unlock() internally. So eliminating explicit 
rcu_read_lock/unlock() in critical sections should be fine.

Cheers,
Longman

