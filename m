Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8C4AC17B
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441192; cv=none; b=oGLX8G3nMON0GiqgQABYcpFDtANZU+luiXPsv2hCAOHFZM0h3/4YGMHJxQU+LMZc2aUrp0ndGEiSjC2T+0FcFRP91tbq1tNMODO6BkfjuX0dM0j6djCE3DLRBJvhoBXdMn19nzZgC9iQ9Zhp6qFovFhdzCdA11sxuWr7Goxk+00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441192; c=relaxed/simple;
	bh=YfhrJ/RsU4qXyUHZUbgKLATh3vnW+x8pyI+69lFyI1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHSHys2MsBh/lk6OiNsNNPAei47qw6vh7gUQizLL94SMWhe8mM83ZCfuiVFJY0f5q9X9K+fC6/+AZW1sXA4F21ht/dwv6/5Oignq1SgIf6wKpMMjJR+QDPMNJMVptSrFhiugFn/933Nuui+u+L8ZYfsq57u3uTi0MxaVpXBVWDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQ/9Nbbl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQ/9Nbbl"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2531f453eeso339056166b.3
        for <linux-security-module@vger.kernel.org>; Thu, 03 Sep 2026 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788441179; x=1789045979; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F7q5cK/wUKU6kkZjsGx0QcDU5b5co3Eimifh5j77YDE=;
        b=nQ/9Nbbl8weE1toKLcVNPmybDARfVabaN+NcqykJwLqGLsZum0rdVcib+YNZZqYxa4
         AZDA3QjSNCGKqbjse/w82dkwZLVY4Kk6KDihgBhllIQJHSoW0vYYQI0bTz2M/XEtKtii
         tZr8Ldw1WxRtUJmNSK/SEjBXZlj4cIdTvxZkNma1KD8CxZXK7lRQBGP2bV0d80H11pW8
         jhFGpzubdRHAuw6n2mi5YkKXxkg1Yo7kBknUe5LEREFqHbNz3uFmQ5I9EpNmfycsXSaZ
         xECJnAjE5RQShw4ZABqWHaJHdfHqI1ZWAw1NDdbAldl+U0km0N/hYEbpQ27MbPVQIFfv
         NMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788441179; x=1789045979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F7q5cK/wUKU6kkZjsGx0QcDU5b5co3Eimifh5j77YDE=;
        b=skbutXzlFAZzlN7euhI8qPEvtPrATLD2DnkdvQIRjnZHBX4WlU69geutWO8l6ZK6fX
         jqMYS7UEFvYMuE1nF/8IFppxz6xCYIuP+Ou+NYW4IM0ZM2N4oclenf3/deaUprW3pnv3
         gPoen8rKwwYG3RddOu8IgIWNZHbcrwI5/ZkN8QA+/aGGA7yuMEuYNELhZEMak1gMaj3V
         AcNamNk40MLqXcqMVxGEmGO6VolimQypyNF0z21oUXHkghOzDiVNAhM2japGqZZjdM86
         pgzgswKk2qndjp5TvLs0Y13UKViJdfZumvqpiI6ugZTW0MZsXNlE7nnmPVIaWt7T29ol
         sLBw==
X-Forwarded-Encrypted: i=1; AKwUvBwK56TNotSu6SYzvfVq9K7HwoIrJwtA1hJhJcz8QPKvVkvNGjKCtt4bavy15TffmoYbL7ByAywsMxplce5W4BWZ0gdnN4s=@vger.kernel.org
X-Gm-Message-State: AFuF++niPvBJCfOBhgzadIiiog5ScGz4QNHajO+4hW6soioer5i2Vh+4
	fkBjYkxdA9joIWhQTboUHRndACS32AJ6EuU2NW+0hKTQN4AoMrEEnKU0
X-Gm-Gg: AYBFou17s086gdCjEOPgi4LoCBfTtH+59g+IYhZw1QMA2+38WxPxOcWP+KlaobtGXPm
	eKZFim7YqS0pyLecyBAssW9etfmX8liMXtlp3tNbHhQAXysaTE6pPjVlmbBvjSwSRH1lQG+LmJw
	vEJ9y5rS9oe4ZLR1pVnqKe+b//0QS+WjlMI50AJIyC3d+kStS/WmQiNB8+8FmgVDnfrM/x5xjkH
	AFJX7cdOcR0mF5vTVkurBgkE2+LwCik2jK5iYt2NG9L1i3RJpwvmOBGjh1Chpmbvrp2EvQc40Mi
	blH5hlIDQ2OHGrkblWIeKhCnEzZQsi1Cin1N1LkLu5vAAHVU4tXF32Ig7FhHvE9BLmybQ+kCjZ8
	kAPeCJM8MyVAGzOs79F2wR8IV792zO9CnSk3bAC60UDqN8TYEe08vgKZnu7ADDjpkCQPiLxo8fM
	F917BdPt7611bS0kc6fqGQCB3y7N9wZkj1XYx9kPJPUSSjddXz6epYKjegYnlP0Qwqa1GE
X-Received: by 2002:a17:907:3d49:b0:c25:c7a9:7b8a with SMTP id a640c23a62f3a-c25d54b6d03mr830373566b.12.1788441179056;
        Thu, 03 Sep 2026 06:12:59 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f419d91bsm96400266b.23.2026.09.03.06.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:12:58 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:23:31 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>,
	lsm <linux-security-module@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH bpf-next 0/7] Add new way to add BPF LSM hooks
Message-ID: <apl005R08S6jdbWg@mail.gmail.com>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
 <DL514LM5TA6V.IOW7P2WM70BE@gmail.com>
 <CAGn_itxwZcMLtass5fZQ5XqgUtwTaJHfUGxg_SK7h_vqEgpmeA@mail.gmail.com>
 <apljnyb9nNRuN2xg@zenbox>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apljnyb9nNRuN2xg@zenbox>

On 26/09/03 08:16AM, Justin Suess wrote:
> On Wed, Sep 02, 2026 at 09:31:36PM +0200, Anton Protopopov wrote:
> > On Wed, Sep 2, 2026 at 8:07 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Mon Aug 31, 2026 at 4:09 AM PDT, Anton Protopopov wrote:
> > > > The BPF LSM programs are allowed to attach to LSM hooks. This enables
> > > > operators to mitigate known bugs without a need to reboot or livepatch
> > > > machines.  BPF has shown very useful to create such runtime policies.
> > > > However, many APIs and parts of kernel aren't covered by existing LSM
> > > > hooks and this would be beneficial to extend the coverage.
> > > >
> > > > To simplify the process of adding new hooks this patch series enables
> > > > BPF to attach policy programs to hooks defined outside of the
> > > > official LSM list.
> > > >
> > > > One of the reasons to add a new mechanism is that in order to add a
> > > > new LSM hook an implementation, at least one in-kernel LSM must be
> > > > added, such as SELinux or AppArmor, and BPF is specifically not
> > > > considered as a reference implementation [1].  This is, however, not
> > > > feasible for the use cases and capabilities covered by BPF LSMs,
> > > > which are not directly comparable to those of traditional LSMs.
> > >
> > > This is no go.
> > > bpf-lsm can attach to lsm hooks, but the machinery has nothing to
> > > do with LSM. bpf-lsm is exactly the same as bpf-mod-ret.
> > > So calling everything LSM is actively misleading and wrong.
> > > Patch 1 starts this misleading naming convention
> > > and then later patches add fake LSM hooks. Sorry, but no.
> > 
> > Got it, thank you.
> >
> 
> Adding to this, there was the previously proposed "killswitch" mechanism
> which may be closer to what you want. [1] Unsure of the current status of
> this work, but it's a better idea than creating BPF-only LSM hooks... 

Yes, thanks, I've seen it. In the proposed form it is not realistic.
I was going to discuss in my slot at lpc how we possibly can 
approach this in a more safe way, powered by BPF.

> (like a bpf_override_return helper that doesn't care about
> ALLOW_ERROR_INJECTION? unsure what would be best here)
>
> Justin
> 
> [1] https://lore.kernel.org/all/20260508195749.1885522-1-sashal@kernel.org/
> 
> 
> > >
> > > pw-bot: cr
> > 
