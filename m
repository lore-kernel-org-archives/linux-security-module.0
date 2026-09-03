Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1C4A1DF0
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437815; cv=none; b=N+TTJkJyT4n8KtwZj8ZZcVn3FRjM4kBGKAyirNNk/raAATpMdeBqQtT9dO9VH75HK4VB1Gc0WT1y8cA/86mqx2MXcGawpvjVWq3r9zTcBjrcaMbOu7myVepFjrt1HM6hBJdX3Qhr1S8C3VWhev/OWsKhdI/iAd6j+PTmdzFbSE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437815; c=relaxed/simple;
	bh=nNkicwNC6wvB/mONAXakrfnhE2JYMGQwTgh42CBx9q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9kcbswX1ZiEzkeRMl9hmAjHPtLUjHYCz5MsP8sII5sMpnbdjOxHHVpi9ezX10Xiitsxvtq4rorjRACfDO8hxylUsstatCqexz6UDBjrb/K+JjuOY1rlrp7Cx36ajqrfWfb+Wogz2E8Mdusaq78h/ZI3DACZv/VrvZmT33LtSzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9GQS6ZC; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9GQS6ZC"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66d258d1effso575842d50.2
        for <linux-security-module@vger.kernel.org>; Thu, 03 Sep 2026 05:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788437813; x=1789042613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vbJAOVw8uKJwq4n1b45EMvb8ousiK+i/6Hz5ojzhM6E=;
        b=J9GQS6ZCVDRv99cbnUmTsvgeuObPNpTkVOogyq9jcRhWElPNxT50E8jHwSxknG2wff
         fTnsORUDUc9dWWE66FZNPl4G1fhzog/IhlrRGtMq4VH3QLn3AmvX+mZPWcHvMTbDXkCI
         eKySyk+7ZcmYjccfjP6FjyBjn6WPRCvFhIojGdVMQDwOu76hZlCq8fL3V2Yw25yMVnxr
         ZwmhA2sPbpLLCBwcqeyFEkaA6KF0bPcPhUnLUh7WIAo1V6JwrRNBwC7we8KJTdKQwoN2
         pyscE3IqMqNd00EwucXzf3UF6CtMOQVSOPA5rEcAylC1LIDQjo9bdc7W3hnAKnin/Ulr
         qIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437813; x=1789042613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vbJAOVw8uKJwq4n1b45EMvb8ousiK+i/6Hz5ojzhM6E=;
        b=GcrGFE1wY1QNZ+aMja9aEk2kpAYewLJn/UquJ79dIW3A21URAaIkHD4b4UfRGGHtDK
         1N0TsoAaw8LR68mKGbrSjHr2uSiCo+sr8aOzCgugRlStg2elDo/i3SWW9c03mw4cLbsC
         Svqw3eO7mIAbW60uVtSU8oLYU31sG6+CrS8+HqLVDwgSt+YMub3h7iX0L/WXS9MtCDb8
         l2NkMmgXgn+AblT1ClMlEoCS667ywjkJaQTJGZaeb86HNO5XbV7j8/fybLllr2mkfKCD
         DjGSYo4tSADHw+/rgoJOULnSI+thIBYc25x9qA6lScrxWBd6f8y5zSoPzHEgtYmaDgvp
         vNUg==
X-Forwarded-Encrypted: i=1; AKwUvBzIp3fy9/cpfFtScI7OGW+wXJ7z7novCDln2ycWj/6njSHe7fBR9n32NoA7qqN291KGD8rJclujpreODdrYVqeNFj4JoU8=@vger.kernel.org
X-Gm-Message-State: AFuF++mxy7Cn2YOJR2EJLXeKcr0a/aCzhDogDTQagZzZhhXK/toc60Vk
	58SdzsPJWai2Q3Ri53SvNNBcTqapUoDUtammX/Jzb9F5B7NzpzviLNdo
X-Gm-Gg: AYBFou1MRiM9RfxnRilN2ABC3fCZ5D+0GTudMOFjT0BtgvB3FLm7n6urVlXdPi5rSHs
	YBxP3R4X7OGhbsUA1hIAJzZ1W+2DC7Svz7v6297Uz17CLShRvQSMz1xrOEsf5FDuG8xsfSzx9A1
	/yhhiXg64fusGYb8jRDU30L3R/53N7TQWuHGNjnPpbnxf8ym0QxnE9IE7WoF477wFeJJxOMP5GX
	2cFvnDV15Qil9E/t+9g8Ytlj33o/ook0soUvyAs9PhxFCFxFhiPMkJDPgH6NKgCSm5uGEVnYeod
	TiJ8qsHGrAIauY3P7qQWYO9i0q2pgxNMCduqXNOQZ3YkJcrVCXIY6PmEUTxdha595pOxzSKvvOW
	QATW1NrSLDe0Dy886+2ZL8WqZ7KhNCmSmQwfn7uFk1QANSGbJrt0iEeJm6lowONvvlJKedAZgp4
	4rOzljCF8NYkQDoVHjGM2wtpsT4PO/emiN5L9zXx/sCbhTfJehHNDxiCTtS0gLzCKL6PuSZWnV3
	l1ckHV/2c+7Q9TJPXXLuA==
X-Received: by 2002:a53:d005:0:b0:66f:8796:a553 with SMTP id 956f58d0204a3-66f9bb61924mr4641633d50.3.1788437812747;
        Thu, 03 Sep 2026 05:16:52 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:b12c:f7a8:92d:b215])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c18ac450csm38308717b3.40.2026.09.03.05.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:16:52 -0700 (PDT)
Date: Thu, 3 Sep 2026 08:16:51 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>, 
	John Fastabend <john.fastabend@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH bpf-next 0/7] Add new way to add BPF LSM hooks
Message-ID: <apljnyb9nNRuN2xg@zenbox>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
 <DL514LM5TA6V.IOW7P2WM70BE@gmail.com>
 <CAGn_itxwZcMLtass5fZQ5XqgUtwTaJHfUGxg_SK7h_vqEgpmeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGn_itxwZcMLtass5fZQ5XqgUtwTaJHfUGxg_SK7h_vqEgpmeA@mail.gmail.com>

On Wed, Sep 02, 2026 at 09:31:36PM +0200, Anton Protopopov wrote:
> On Wed, Sep 2, 2026 at 8:07 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Mon Aug 31, 2026 at 4:09 AM PDT, Anton Protopopov wrote:
> > > The BPF LSM programs are allowed to attach to LSM hooks. This enables
> > > operators to mitigate known bugs without a need to reboot or livepatch
> > > machines.  BPF has shown very useful to create such runtime policies.
> > > However, many APIs and parts of kernel aren't covered by existing LSM
> > > hooks and this would be beneficial to extend the coverage.
> > >
> > > To simplify the process of adding new hooks this patch series enables
> > > BPF to attach policy programs to hooks defined outside of the
> > > official LSM list.
> > >
> > > One of the reasons to add a new mechanism is that in order to add a
> > > new LSM hook an implementation, at least one in-kernel LSM must be
> > > added, such as SELinux or AppArmor, and BPF is specifically not
> > > considered as a reference implementation [1].  This is, however, not
> > > feasible for the use cases and capabilities covered by BPF LSMs,
> > > which are not directly comparable to those of traditional LSMs.
> >
> > This is no go.
> > bpf-lsm can attach to lsm hooks, but the machinery has nothing to
> > do with LSM. bpf-lsm is exactly the same as bpf-mod-ret.
> > So calling everything LSM is actively misleading and wrong.
> > Patch 1 starts this misleading naming convention
> > and then later patches add fake LSM hooks. Sorry, but no.
> 
> Got it, thank you.
>

Adding to this, there was the previously proposed "killswitch" mechanism
which may be closer to what you want. [1] Unsure of the current status of
this work, but it's a better idea than creating BPF-only LSM hooks... 

(like a bpf_override_return helper that doesn't care about
ALLOW_ERROR_INJECTION? unsure what would be best here)

Justin

[1] https://lore.kernel.org/all/20260508195749.1885522-1-sashal@kernel.org/


> >
> > pw-bot: cr
> 
