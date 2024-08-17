Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412C14D6ED
	for <linux-security-module@vger.kernel.org>; Sat, 17 Aug 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723912004; cv=none; b=ar8D7oCQk88Hf5dfUpAUukrnO4U1uAraCyXTQjeng8GHKR91VffZZ9DjqfYcxCMxobA/mcvNTqkNBuGQJxiVLrSxxHC4xU52rYOBAOd9/vJ8Y6883zV2H9WduAIBgKjZt17fpLmAnt4Bj82ECugot+PofeVRAdIyKi974Qy2rvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723912004; c=relaxed/simple;
	bh=9dkMY8jFzFQfn6EKGYFPV4tiA60zbFODArOLJ5YzeIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbV+smICeRpt9gCWNS3PMN+t1IZAsBohaI1acNeKf5VOlKBvAk7WLmkpEZg/NBz6ycg9InUu7vbef1CwfO1VBxKW3kPUOniM/dG2KNPFXm+7XDS4DvyUL6+keHpH+PrGU7xvilN+UYr8KZuMUeYfiqgMWxmw79+DMdfKmUnwplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cwhDIYNS; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cwhDIYNS"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso44107171fa.2
        for <linux-security-module@vger.kernel.org>; Sat, 17 Aug 2024 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723912000; x=1724516800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bJUpF+ZilJ5tJUWYdG1B4XodSC5itu+LywsKXdFMvvc=;
        b=cwhDIYNSIoISsX9G0ssFJ4b5XfsGCZ3GELP4tTqIqAPmBt6ee1vr30jJd8vAyHxr/V
         qLBA/puludwtc4wUalH4fkqJjRNKpY3Xu3CaUFqnRpLkOrZsVru1uqtKV+ux6N8UQfUK
         fvkGXrT/jxAwOJWCL4gTra/n3SGML3rs80A6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723912000; x=1724516800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJUpF+ZilJ5tJUWYdG1B4XodSC5itu+LywsKXdFMvvc=;
        b=H8567UAC5YQV3KfYpjyHllpO7RsQhc0SrI6NX4haTT7ET4aujrFubVBx4a0gBnhQ4h
         QfmHg9Y6LG4yHAhL1p/JC28f8YMMaFiJxmhoQynl2IgAze8+uNRRI6gUnXJHlNmDnOWs
         ZVaeU7ZzVBCWl5hNAsekcaSh+Vd8OXeuR9kDKHKUw1vj5QLNe7oQCjbX9Z51XCBmMxq5
         hBICZ4bktYBbz756BZYnD8ug4SKYEeA3e42rdrryP+h/ZDXAeUJNKwpujPf4Wk455Brh
         AEeg03WPWpQl2vR/JrG0p86nqGLmCjyPOEjQeIhOJFAwzIL7fZvCcrabMN3jZNH3stbt
         Qa3w==
X-Forwarded-Encrypted: i=1; AJvYcCX6g6FusNxZb+Kzh4dOGioAAWm08Usg+MHGxBJQfMip1LyEYdQkTx1GJsZ5ARw5cnXFiCjNC7p00mh8v8MgBISV65BwRxgPDfMsP0LGkJDfEVfNgywY
X-Gm-Message-State: AOJu0YxKVXQLl241R9ILNAQnzKDb5S9YkIZpYUFRuBR229kTIhMgLrAW
	LIyzDHuLd1lYih6GvuUaB5QHz6143/0zk3YBsP86HK3OLOZ/Yc50+j700qQ0n8jSbk2IDhW08xC
	3m7LUsg==
X-Google-Smtp-Source: AGHT+IGF6Q56GhRpUnRz0qVaCYBKFbE5aJWMO2xZJKlOnDN7HCGDLjV0CBXsnEFx//LYBkR+bIjW9g==
X-Received: by 2002:a2e:a9a8:0:b0:2ef:2c68:a776 with SMTP id 38308e7fff4ca-2f3be5d9f6bmr62177741fa.37.1723911999651;
        Sat, 17 Aug 2024 09:26:39 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383947187sm414709166b.166.2024.08.17.09.26.38
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2024 09:26:39 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bed92f638fso502189a12.2
        for <linux-security-module@vger.kernel.org>; Sat, 17 Aug 2024 09:26:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWJkidFfI7Z/Gzz4KT3u1piWddPhiPfn1GjfHG1ABAVOPUWGaWR+E/i1z45HJ08PL0roac/va3m/n6SnQL2LxqCg9mOsvLTI3aBjSeNF2n1BNz8vRT
X-Received: by 2002:a05:6402:278b:b0:5a1:b6d8:b561 with SMTP id
 4fb4d7f45d1cf-5beca527ec4mr6027442a12.9.1723911998605; Sat, 17 Aug 2024
 09:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817025624.13157-1-laoar.shao@gmail.com> <20240817025624.13157-6-laoar.shao@gmail.com>
 <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
In-Reply-To: <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 17 Aug 2024 09:26:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>
Message-ID: <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
To: Alejandro Colomar <alx@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, justinstitt@google.com, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Aug 2024 at 01:48, Alejandro Colomar <alx@kernel.org> wrote:
>
> I would compact the above to:
>
>         len = strlen(s);
>         buf = kmalloc_track_caller(len + 1, gfp);
>         if (buf)
>                 strcpy(mempcpy(buf, s, len), "");

No, we're not doing this kind of horror.

If _FORTIFY_SOURCE has problems with a simple "memcpy and add NUL",
then _FORTIFY_SOURCE needs to be fixed.

We don't replace a "buf[len] = 0" with strcpy(,""). Yes, compilers may
simplify it, but dammit, it's an unreadable incomprehensible mess to
humans, and humans still matter a LOT more.

                Linus
