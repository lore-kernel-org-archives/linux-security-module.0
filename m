Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8B5FC0A
	for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781393367; cv=none; b=Kr/N4bBf+pe0eES6eN3lzQA0Y/cnjNKYSb+at/77GfGEal5pTre4dUD4pWsdTHDGTG4/u4EzNR/ecvn0O78180HzQADrO0j6FN87CH2K2unI8BsY0ErwcAe8v4qdp5/PHIqt/STxmgH13ieRtW+5Hteq7OZc/GUA3IUCvFlLj9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781393367; c=relaxed/simple;
	bh=FeunYxTQ20QVXHtamKD9y3ZA4nZm14K23tmnTCQUTWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRb0XRqdLpwOqy7Q29893QF5+PGI05CXmKmWBmk+gU1YDOn/5UqXV0zEQ/qo5TX8xzH7AfCTAu3avxD10+JYcAFWfgp5mRdLx8jdHhvqbCK9of32ZovT3D2UMOpL+ExnTBG/gCFq0FT14saE6Equ0O7DdSnQxsRNvEjDSJfBj6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Tu3GLQ/m; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Tu3GLQ/m"
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C200E3F185
	for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 23:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781393362;
	bh=2cQ35Uy1t8wPqUI+pk9yl3MtHFjj+gQLsjP+hSrbKIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Tu3GLQ/mtaq+gd9xvy4+dhJfOgTY6RzYeAt4eXJNgqvfny4fVcVMdkSLdp71FrZjr
	 H/YJ4XhxdQ9Pe1YkvMT6VzcPU+ga+fPj55aWhvKzIJEqmr6X6w+rlsnWTRlX8IG0jD
	 cVasHCyyf8wlR4ms1/nQCMy9GHaIp2J4AZirPaiH0arKnl3jmk13dRYH9BsAhj9M4u
	 2bZJM+t+sYrboQeAdQ88jomgRVZ74WjH/E8kTWD3HnlIB0pyQJ34iWXvmO8JRraO//
	 bDIR2mHQgIAuCNyTqfPbDcZioZGXpsKTxj6xiMJwaL0lcjshsVBqiAtFQqvrjZQIw4
	 ZuFvIgJvsOjskl3JLFcufGe0GzIM+gPs+Z0eRqgHoN7hTpL22Y0DREPjg6z3mQIZjK
	 t3poysiDyCH+T5d6wKGQa4N6gcG/4BULGuZweWHM4TrGPyOJYhXmKQRPfIVMg1mgAg
	 6WWaSX2Bzp2FPEYuLacxwBx0fF3EXlUHKJxFN2gsMlHLAX6Z3huBifE6PNqWA71tSS
	 hk+bGPFIt7Rmq2X1yRGi/g974vyWAZqPpAmbyfd/YkbCcM+VKWJQ6OR0Ks757n6BaQ
	 T1ql0bDkfXc0ZT+WbCD1eEkzU0ZJtbuy2TNoEVys8ZJf2xQ8eW21kKZZwuzqPUaiiU
	 gzASTjnmKFNAUsOm88Il5N58=
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso1954409a91.0
        for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 16:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781393361; x=1781998161;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cQ35Uy1t8wPqUI+pk9yl3MtHFjj+gQLsjP+hSrbKIM=;
        b=JJ10JCEi3IaKL3pPKbsshvlzsoSrrIpRvN6tnHom5fF7Ad8XoYuAkuOmmCyTRYvQs2
         l+5suQiJvlG/PglnAbB7Q6tgzkcIt6bOvPJkksQXQhJ9h7dWkc7hCXSrTh99uTaV+5RH
         2z328w8ZPAmB15gJQ6hN7SQ/GFZgrB0HG1XbaqTTsIub3oln4SB5BEic9bKd4xrFHYLL
         59EQhxvibYPRIV1DRvQ7ZNj9xGaItINTqiupPkwM6Cxrp7Xti8Ozo1t3FVCC7VNlt173
         x2IRx7hNmqBRvRSLaTTuvkv95emG7RPmVu/zTv2ZnIuzfq/dKu/7geTKmqwo9zsHYxMa
         b2ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8DvsMa8RPoZErNsoauF4czUGIKsmdyOkU24d9XkEpEoI3DVi/Dn3oXvqk4HhFX9qECr7a5z2JI6hDIc3kZoDjYz0lwMhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGOC/xfYxCn1m909GR1CbXa6p/bKYgioaqBah35h3YXRHyBK02
	HMFbo8qYcS7IYFYq3enDsKHKkN1MfWVwgMJ/+L5bD5wmrAqsx7EESSGkHvyEaIUz7CBgK9yJNyI
	kPc0P5p4baDDwOaHyLNNgszNb7hqj/hB/hODjmhDTpVe1lAAub0dgmWn7y5TSsoN5hpn3tXgwPR
	TylzTIQyf7OWA3c8SFCg==
X-Gm-Gg: Acq92OEgGlY14UG7N/ubCd8H54GCh/94iYstP6Bku7ty2ojMvTy3OLvHzDjMTlskwKt
	OSzrzlpQ2RHaHniyG+zHUCY1etgc2CtD+9X3LBlcsnNGqUqZqbqaKP5BCXQT/6n8xpbEjFzvMQg
	c12ko5d9eKMaqt5sAYEqQCzuRDDo4XLqYkC5Kbjp6jRBjumsWjFSK+y5fC05Vk3blSiNnJn1q74
	RzGsDgY+WNZZV92v8Zuu1LNRgCPgD+jJkzqUDENqj4LHK7h03OhC7ysFen/AvtWuogv943Zolaj
	P6nAtt3gFBpDzSBBV5BfLdpOV2gI6jKPGPEJrr+9pSuuTR/yLwxjkrcl4vllE6OQMsYyd8FYCYs
	YMv8V9NIWwrLMpqmxQnnN5u5LSr3zSkgOQApq
X-Received: by 2002:a17:90b:1808:b0:368:147f:bd27 with SMTP id 98e67ed59e1d1-37c2bd5b02bmr5322485a91.23.1781393361012;
        Sat, 13 Jun 2026 16:29:21 -0700 (PDT)
X-Received: by 2002:a17:90b:1808:b0:368:147f:bd27 with SMTP id 98e67ed59e1d1-37c2bd5b02bmr5322467a91.23.1781393360635;
        Sat, 13 Jun 2026 16:29:20 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c86651a0090sm5119636a12.26.2026.06.13.16.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 16:29:19 -0700 (PDT)
Message-ID: <1c87912e-7d7c-49a9-b964-3568e63e74a0@canonical.com>
Date: Sat, 13 Jun 2026 16:29:17 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: hold cred_guard_mutex for lsm_set_self_attr()
To: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, casey@schaufler-ca.com, serge@hallyn.com,
 linux-security-module@vger.kernel.org
References: <20260513180506.760657-1-stephen.smalley.work@gmail.com>
 <b99c011e6d988fb98ad017265115b323@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <b99c011e6d988fb98ad017265115b323@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/26 13:47, Paul Moore wrote:
> On May 13, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
>>
>> Just as proc_pid_attr_write() already does before calling the LSM
>> hook. This only matters for SELinux and AppArmor which check
>> whether the process is being ptraced and if so, whether to
>> allow the transition.
>>
>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   security/lsm_syscalls.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> Thanks Stephen.  I'm going to merge this into lsm/stable-7.1 now, but
> hold on to it until next week before sending it to Linus.  While I
> can't see why John would have any objections to this, the extra time
> should give him a chance to respond.
> 
you would think?
well finally getting this far back the backlog (sorry)

no objections

