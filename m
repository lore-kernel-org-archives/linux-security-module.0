Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC225C83A
	for <linux-security-module@vger.kernel.org>; Wed, 10 Sep 2025 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757548503; cv=none; b=koGCOqbW+xcEk+V6+u33E78R79ikvXWfn/04nhswm1yZE1OZmVFOOa9moS0evmake3XG05NN1QmSNQNMl9FDykIgX6+2rx3FsnZUovUUFDqbfjwSksEcOzUgSj3BmCivkfzY6jnfDE1T79IhSQGDRbqlo+40qv/4El49f8ZfBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757548503; c=relaxed/simple;
	bh=fRtZYbfbd6omoJ4LIkXLTbFoXGtaueJnUQAjTlL23yo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=pvHpeWQvdIHllhebwAFI/sHBmi1qK5zFixjToc6CiUd9nWCT46GbogZWV4htUqOHtiPKTU3T53b55uJvQcxN6WBdOkYw96p5YpjraX7wZk6lt/Ejj6G2wp6NTL1vQgsCWYEcrQLIoiwRX3w/6dNIS4Aem6ZoqeclShA9nlRCG78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BOK5Z6Yw; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BOK5Z6Yw"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b6304714a1so2122081cf.2
        for <linux-security-module@vger.kernel.org>; Wed, 10 Sep 2025 16:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757548500; x=1758153300; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/HfLa8Yqtql3zEvelgL/5X7ecSz0Hv6t+92asxhHDU=;
        b=BOK5Z6YwrvFTbfzFz5dP7bHpVPQqUcNGx2QMmYFiKQtDvnNhONCSp8AAo4uZqTqrBs
         PW1ddG8nK3Qd+Q4Bd0snhcijUX7pv54B7inmQxCP702zIOcba1FwjuWOyOCWPoFQ81y6
         H0MqSzhCFq03cKdyo0yhpm384AgvNTv5iIQQFgBkshc9IYXkQe0gWkpfrXd/c66Ifk/I
         xPVlrhGUKy3b7/YAjJieKffEp1uQv2M6/ScCeteQnSac/o52K6v5A4j5iYfAlsdbOmMJ
         RR4fWZWhQX7nRn4ijlO+5+UAmh0gFi9NXNsjuMK9nq5g9Q6+2xNfPBZiIhi25kdoC8TY
         JzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757548500; x=1758153300;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3/HfLa8Yqtql3zEvelgL/5X7ecSz0Hv6t+92asxhHDU=;
        b=X1+wWW7u95wxp/+w+Q57jeokoCH/6lP1ONibq9r4WLQPDYfyFcKyJ+venv7Xaa7XPV
         bOyOrYbm/VXxPTUe7diN+1fDLltSmqC+oVPZ5biFS0uTYeUP1+5A/ITGIfvNNEFEveys
         KjXswoaYELkVh86kKqVKXDjjuSLtpzGoDhQNs1lfbDVSs71/ebz1oDxikwRiTzOEIkM1
         4fxck/tWbZp/OU/zpCtaCmIaIIuBYTs3i1lZLFb89IqRB6WNXZi3MwLqbyZWJTV87wxf
         iHMQMlIJqMLazS/8QLR65MCy3vLLGdKveej1AHOsmPS+KLMEwl1gIRDM/0YF6A+tV+Ey
         CLFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfyBCERuNAB1o57Q8mPt1kTDGrcQiYbQG6QtNTY9ogtAsqs7zjTVadjUpR5D+kpyalGiknF/xhtE27c113eBWNIaX2Fps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtukiZ4pnernU43qpBNSDxoPy3HAtH4+bgm7nmjdDdJ46jkEy6
	5HvzJLSKElTJN7Au4oj4A/qGUWhtcrE2ddsbTt2QWXd38/J3B/8TamU6WozwuJbF5g==
X-Gm-Gg: ASbGncseJjKOh0G6H/fDZ69bCGR2MnAJgGM6qdeGlntoAkBmCosH9c/FPEsFqhPKxYD
	vrBUJUT4aBQg9voOycws6xoe8a2RamMkGVUwG7aWgZvawPSGYUka7z26hRn8aHrq9Tiz3VJbKH2
	1i6MD8O9BPdP7GeP+S8wBPVN5ZXGPzNxqe3z+cBKtJtbowoju6zTTlzhM43Mc7Xv2nMslmcn48k
	n01BlSbGvBk9XVnRmfdF76cNAGOIw3OwlfjL4Vv0EFWNATNs1klX1x9XydOj870So/45hEfT8ZG
	oVz9mJxE+1vFQHi4WlBnUHOH0ucQpLyW379IohxhwbTNruhSUX4SqxU/vrpdHyVyF1ZfPhG3smw
	7I32KCUCR74nw4eSyDxHxREfiWZPsgSG8XcoZe1blFy8udDRBLwgT16TzzGKdkST1Xx/FmS5+LO
	ncYA8=
X-Google-Smtp-Source: AGHT+IF1RCQKVRC9oL3MejA6XNFuaAoxCNzD8WIsd3dkiYO2OtIYOOD7ahfzbCgVYhdOMyAogD761g==
X-Received: by 2002:ac8:5842:0:b0:4b5:ec99:7815 with SMTP id d75a77b69052e-4b5f83a5152mr188388181cf.19.1757548499922;
        Wed, 10 Sep 2025 16:54:59 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639daba5dsm776951cf.31.2025.09.10.16.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 16:54:59 -0700 (PDT)
Date: Wed, 10 Sep 2025 19:54:58 -0400
Message-ID: <ea31a17a30e6bb284168353606436752@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250910_1926/pstg-lib:20250910_1926/pstg-pwork:20250910_1926
From: Paul Moore <paul@paul-moore.com>
To: Gerald Yang <gerald.yang@canonical.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: gerald.yang.tw@gmail.com
Subject: Re: [PATCH] Audit: Fix skb leak when audit rate limit is exceeded
References: <20250909131056.3395574-1-gerald.yang@canonical.com>
In-Reply-To: <20250909131056.3395574-1-gerald.yang@canonical.com>

On Sep  9, 2025 Gerald Yang <gerald.yang@canonical.com> wrote:
> 
> When configuring a small audit rate limit in
> /etc/audit/rules.d/audit.rules:
> -a always,exit -F arch=b64 -S openat -S truncate -S ftruncate
> -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access -r 100
> 
> And then repeatedly triggering permission denied as a normal user:
> while :; do cat /proc/1/environ; done
> 
> We can see the messages in kernel log:
>   [ 2531.862184] audit: rate limit exceeded
> 
> The unreclaimable slab objects start to leak quickly. With kmemleak
> enabled, many call traces appear like:
> unreferenced object 0xffff99144b13f600 (size 232):
>   comm "cat", pid 1100, jiffies 4294739144
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 8540ec4f):
>     kmemleak_alloc+0x4a/0x90
>     kmem_cache_alloc_node+0x2ea/0x390
>     __alloc_skb+0x174/0x1b0
>     audit_log_start+0x198/0x3d0
>     audit_log_proctitle+0x32/0x160
>     audit_log_exit+0x6c6/0x780
>     __audit_syscall_exit+0xee/0x140
>     syscall_exit_work+0x12b/0x150
>     syscall_exit_to_user_mode_prepare+0x39/0x80
>     syscall_exit_to_user_mode+0x11/0x260
>     do_syscall_64+0x8c/0x180
>     entry_SYSCALL_64_after_hwframe+0x78/0x80
> 
> This shows that the skb allocated in audit_log_start() and queued
> onto skb_list is never freed.
> 
> In audit_log_end(), each skb is dequeued from skb_list and passed
> to __audit_log_end(). However, when the audit rate limit is exceeded,
> __audit_log_end() simply prints "rate limit exceeded" and returns
> without processing the skb. Since the skb is already removed from
> skb_list, audit_buffer_free() cannot free it later, leading to a
> memory leak.
> 
> Fix this by freeing the skb when the rate limit is exceeded.
> 
> Signed-off-by: Gerald Yang <gerald.yang@canonical.com>
> ---
>  kernel/audit.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks Gerald, this looks good to me, merged into audit/dev with a fixes
tag and a slight tweak to the subject line.

For those of you wondering about -stable, existing kernels, including
Linus' current tree are just fine; this patch fixes a regression found
in commit eb59d494eebd ("audit: add record for multiple task security
contexts") which is only present in the audit/dev branch.

--
paul-moore.com
