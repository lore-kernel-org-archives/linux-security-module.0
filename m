Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D8538DC8
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720562889; cv=none; b=ISH5iUTUp17kI2RFBu1wju19w5uNEaLQZ8pJPo5qY77SW1u7VGNg4rJVBHTlsbpqDb7xOWDEU3egME4YgSGAJc7QdRe0nlgRc5RFGSnB0iKy1KMv0gKMy6+PI48FNWW12qrhWB5gxYg3lHgMDHrF4l1ZZg6Y+ftBwATDT/x+Ac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720562889; c=relaxed/simple;
	bh=2k7VOvRqY3D0hrLzlelIiwfgGkIyl1K1DAd0zYSZUrE=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=FYsgJICH4KLdJV1F4VwETDeVzhI3va34+SzvF8/fHX/fWUu1gvb5psu3Agw7skejcjHH6Bhdn/ztYhrSfrm5cds8oVe6o+TRXx6OGpmtbkY+UyuOpbtdy6RPyUNi3xOvcwRTvLrAX0AlcIaMQ1i0HEV5ptgexucy5IMTPnelbIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MtRqs3KP; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MtRqs3KP"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b06e63d288so28741606d6.0
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jul 2024 15:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720562886; x=1721167686; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jW17lCBOMhyKx8k6/o5x0ILSTdWOXJnZ/B/NCwzr62s=;
        b=MtRqs3KPZwebP3VKkm5bxEb5CpiPHIZcRw3Q0i8WYbAWvYHhf0YqlJdW6fW+Ty0E2S
         ib0liVqSflx5TWnZ/YzWLc37QKI2juKYHoCdtgryCU/CBDIqyIBjXH062jhpAXC1HOVd
         n2SF2iHFw7iUIV6BZ58pyQiofA2dUHauObWRzXs5cCZtQ6t+bSuFgQ2ZVrG6rZ5z8vQc
         PcU9lpArWkcqNx+DwpJWnWM9LoSCG98OQN6nu5k64RBXfUPD/lxsGtb4q3SbsFZ4bMjk
         6X97SFA4sRPYe7D3gtEavYKod3hFNXOZIXbyZ7ykIJOYmQxydwSuDgwlnX/Klu6CvR0J
         rzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720562886; x=1721167686;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jW17lCBOMhyKx8k6/o5x0ILSTdWOXJnZ/B/NCwzr62s=;
        b=kAu+S5HuiZAxaB3vaeSmrU9jNS3YbHEBKmtqQPTi83/I8l6dD72xrViBJz//FSeURb
         rFT5VY/smV+Mik24XASWEfkXt7MuqspBtnlc1lF/npCgEevwJpFYxrrWhV7So0zqN8dw
         ahnKb7GsjdiN5VbyTunmSNLbbzO3eeh9ImPCNw5xTbwtrMGo3hSKEWNt/4lyEw/+e/oy
         ZsW34REIVovaqyY5nhkZW9jyH6S/tGepe+Q7SdlerlkRJKVZPZyCEIORRIZ9sHoHSP04
         8M8bUE/QLBBt+7/QEVvGYP2jZ5tUn5D+DtN+gji5XycPxtRWve2/HBttd/i3gnR6og6j
         gdtg==
X-Forwarded-Encrypted: i=1; AJvYcCXVwstpB7egRwsy27AsmywmCeLmXM3OyN8Sk4COz3AzsV7qJpxkzZMALxg5L1IiicR04ojf951b47mB/xZgdEMaJd+G/HbqC+B5A+sVeeMR6+kcxiJL
X-Gm-Message-State: AOJu0YzsxQCVXH63GmagIjrmh4EGIGvonNCdwxGj+EA//yKhYFNJ800j
	Oqq2GjkVYdQ3n4EhZqxqT0B0GPKgnNr4l2NcbtfX5c+wCR3XOyJ/clb8rGotFA==
X-Google-Smtp-Source: AGHT+IEAuskAlltELcCLhHLFq019QiqAHPKytUWrtWQFsScHqUqmKdWZkatSKl3uiAYL8xDOKn1Ygw==
X-Received: by 2002:a05:6214:1254:b0:6b5:44e7:62c with SMTP id 6a1803df08f44-6b61c1c50aamr58427646d6.44.1720562886398;
        Tue, 09 Jul 2024 15:08:06 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9f2cd4sm12393586d6.52.2024.07.09.15.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:08:06 -0700 (PDT)
Date: Tue, 09 Jul 2024 18:08:05 -0400
Message-ID: <1ce72483abcf8d2a53592ad81cdfd69f@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, mic@digikod.net
Subject: Re: [PATCH 6/6] LSM: Infrastructure management of the perf_event  security blob
References: <20240708213957.20519-7-casey@schaufler-ca.com>
In-Reply-To: <20240708213957.20519-7-casey@schaufler-ca.com>

On Jul  8, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Move management of the perf_event->security blob out of the individual
> security modules and into the security infrastructure. Instead of
> allocating the blobs from within the modules the modules tell the
> infrastructure how much space is required, and the space is allocated
> there.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h         |  1 +
>  security/security.c               | 12 ++++++++++++
>  security/selinux/hooks.c          | 18 ++++--------------
>  security/selinux/include/objsec.h |  6 ++++++
>  4 files changed, 23 insertions(+), 14 deletions(-)

...

> @@ -5665,6 +5675,8 @@ int security_perf_event_alloc(struct perf_event *event)
>  void security_perf_event_free(struct perf_event *event)
>  {
>  	call_void_hook(perf_event_free, event);
> +	kfree(event->security);
> +	event->security = NULL;
>  }

See previous comments regarding the *free() hooks.

--
paul-moore.com
