Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2661C140E5F
	for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859813; cv=none; b=qKQXOWQq0Bu58df+2zSka2DmdTejEkQXLSa7Dg9V+CYoqge4zbhL2J0Fhjcc+4NA4kpRKc628vvqeVLMBvbLiwn4X8g+uEHFocxShTuWagWyRYzKyHsnU4luh8O833j+sJAE+o39u+3mEVF2SRtcXmliFdgpyZy+JESmM/A1sJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859813; c=relaxed/simple;
	bh=WKEEldzG3P4tTqjwwVgTXV9mDd3HrksHG1WMp2fKO+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyCex79teq8uevJm0iFCmpz0m0xP6ZbuMBnawvYtxMe+V9m5OUdMDd1x1ph1WhCg6JP1IIn2ONAn9k9TkGDQaH9FnbLUnLJTN9wFFgRxYaVT4FaTC+4GlP3KwhYJr8s0UC4GwyPlJZRhU5xCWXeoXguqnBF2BKv5ISA4HWI7XSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g6caoIPL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g6caoIPL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48378136adcso26828335e9.1
        for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 07:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771859810; x=1772464610; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cvylslB0cghRhn2uE5QYrZxBBOEu6pvSvmy9YcvE5G8=;
        b=g6caoIPLG2Bgq4FHLtPDNuA9QyP32/7SmFowYP6rOjo6bvslUKnWFe2htx/hc0BQ/e
         fdjij7/AyWZy8dd/VhWBPOKezw38nsAC8Hk3Mr7CZIidSUAAxRQO8iRfOOj26hVBXpLP
         V3xGlA8zLlrxHgBBzzpjJ4eGSujtjXuFz/OLtDFBV/KDsQNVFgPVmqPnWxwhAwVXX+8S
         Q3ti0gvvZOFtsIVxAKrLZ5QNageSq7p+l+syB9B1zMKoxS6h8BtTWRv7I8W7c23+2muG
         kSlGDr0NBiRNd6s+g7qYMHUuz34ngQD6TCqr/GuNSRrs0VQz7gOo0De+ye7dIhuCLDGF
         LAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771859810; x=1772464610;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cvylslB0cghRhn2uE5QYrZxBBOEu6pvSvmy9YcvE5G8=;
        b=QjRQ9oDac/yWjB1y+qnQ5H6UBm0r9WSuJv6fLBloHvHfU+toYda+N/350seAWHUafS
         34OuxpfUhAr3dW8EcDm3T2bETtIJnVUph3ZI8cxfCpRyMv/Dy0BJQOufaEfSD0MIOnhC
         RE5ISJEtXkMG97NEfiwq0Ypl1Ed/kEjnEnSH/nbLttuBE3l3EHhrPr8l2F7GzBSusY3o
         8gmKlm/2P8czNPxYUO4R5W5E8s9OhyWeT2DyK+pTmV7BI314AY8q5wiUYtqR9NtzzfxN
         pFkNT2uAgwy3HJqJbfaRIbhp/02F2u4wfNzmiWE6Hsx9o+cItjNZCa6g90PgMlQ+t2i4
         xIXg==
X-Forwarded-Encrypted: i=1; AJvYcCVCHcgdKbmCFuIpUTG4L+dubG92NwVSt7Nn9mq1xWPX/QeJKoDU1ooX4Yr9S/5iNorUDQ3Zf2ZVpk8JuslZTXZXuJ1xS/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuUdu0coruMtcmco1K7ZYxrl3YAg5wZ5weEb0u8cmhH1wVv7lP
	s/zCZly0/F0Q2jd2usIBiTliKluUt6ERl25/NI6Ys1YsH7o7nHCZ/RXzS9HhmFd1Gw==
X-Gm-Gg: AZuq6aJdS5Jl2EdHITQdczbusVrwmOm9Xnr0t7LlBuqpwGkS/oZ3AHN5u12gp4f//2r
	v8827sGfaeBYQVA8Y9CUgd9TVGQ6Iv9cCjI5RAq7ULot1S53GvI1qYb1TqaOtAsdwQ0IELYiHpt
	bwAVm+wlACb3dvcwlFV5fM8Gw7Or1XOPZnhfaYgqhaG6RYr4fpXTnckZuaPmprdIrp2RlOB8L/F
	SNi4B/Hruq67EuHNRYeyhwTjjcHYwWUz1QfJ1eGYh/UFacD3qV07gd1r+8RRXzFyNFd+2rG30eV
	ZvlsAHpb7VQjw5oAKGm1nQXeVQxoxcgBflY4kbfTZXxtBOMbRh6GN4nApsOYTit1cRQco/lABdG
	7hxKFX12Cmbkz2Rn8zIJt/5f6+jY1lBjefqko/Y9wtyzAoJpzB303glq8Y67QEYk1vHfqU8YncB
	7gG5cmjyPiSlsQOdg1kJcxoFMPZvxY+J1+/6r8M5nIVgfvNGLmKQUv
X-Received: by 2002:a05:600d:1a:b0:483:b2a8:33ff with SMTP id 5b1f17b1804b1-483b2a83406mr52916855e9.4.1771859809994;
        Mon, 23 Feb 2026 07:16:49 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:7e7b:5377:4d5f:ed4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc068sm260871055e9.4.2026.02.23.07.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 07:16:49 -0800 (PST)
Date: Mon, 23 Feb 2026 16:16:44 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Ding Yihan <dingyihan@uniontech.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	syzbot <syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>,
	Paul Moore <paul@paul-moore.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in
 restrict_one_thread_callback
Message-ID: <aZxvXARvYf6aQBUv@google.com>
References: <69995a88.050a0220.340abe.0d25.GAE@google.com>
 <00A9E53EDC82309F+7b1dfc69-95f8-4ffc-a67c-967de0e2dfee@uniontech.com>
 <20260221.5d8a306bcaf1@gnoack.org>
 <20260221.3ff0e30e4010@gnoack.org>
 <20260223.52c45aed20f8@gnoack.org>
 <32095877A7CB47CB+bb9e1be8-59c2-46d9-b1ef-f22d2d8c386e@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32095877A7CB47CB+bb9e1be8-59c2-46d9-b1ef-f22d2d8c386e@uniontech.com>

Hello!

On Mon, Feb 23, 2026 at 07:29:56PM +0800, Ding Yihan wrote:
> Thank you for the detailed analysis and the clear breakdown. 
> Apologies for the delayed response. I spent the last couple of days
> thoroughly reading through the previous mailing list discussions. I
> was trying hard to see if there was any viable pure lockless design
> that could solve this concurrency issue while preserving the original
> architecture. 
> ﻿
> However, after looking at the complexities you outlined, I completely
> agree with your conclusion: serializing the TSYNC operations is indeed
> the most robust and reasonable path forward to prevent the deadlock.
> ﻿
> Regarding the lock choice, since 'cred_guard_mutex' is explicitly
> marked as deprecated for new code in the kernel,maybe we can use its
> modern replacement: 'exec_update_lock' (using down_write_trylock /
> up_write on current->signal). This aligns with the current subsystem
> standards and was also briefly touched upon by Jann in the older
> discussions.
> ﻿
> I fully understand the requirement for the two-part patch series:
> 1. Cleaning up the cancellation logic and comments.
> 2. Introducing the serialization lock for TSYNC.
> ﻿
> I will take some time to draft and test this patch series properly. 
> I also plan to discuss this with my kernel colleagues here at 
> UnionTech to see if they have any additional suggestions on the 
> implementation details before I submit it.
> ﻿
> I will send out the v1 patch series to the list as soon as it is
> ready. Thanks again for your guidance and the great discussion!

Thank you, Ding, this is much appreciated!

I agree, the `exec_update_lock` might be the better solution;
I also need to familiarize myself more with it to double-check.

—Günther
