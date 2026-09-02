Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A70F394788
	for <linux-security-module@vger.kernel.org>; Wed,  2 Sep 2026 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377519; cv=pass; b=fcYvPSr6ZBoIFQldaBfJjLd5mnC9im9LHCacZq0OjohraF7NiWrMl9wyoYN0LuEOyWdu2zeR7ETfNjtkv1hRUByJzLQsWxmUYnCXjADuFCk++DBcTG05Zre9i+s5Hx1HFa95+soM8BkVPnhetVp/Tbpj3T8drq8lNQlkgTRyoO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377519; c=relaxed/simple;
	bh=zzjKGij2xv9IwtzyPmqyOdFHZLosR5uzYe7NgB5WR5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlQsFCiSWGoa4sT9dOAPJB9LlpMw5nCUPZh8U5rFCVmlS7kfmZTY0d1nzuUN9CuoNHlotVe7pQr/4XSJ0KSNX6O1l4tSrZILI5qFkU4DZ61lZ2NdQzu0z1E89UPH90mKYBhf4NNpQwqIOs0cHR0CDMjxvbah5mgbGrIdAvqWa6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcO2qkaa; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcO2qkaa"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-867a943b149so26007967b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 02 Sep 2026 12:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788377509; cv=none;
        d=google.com; s=arc-20260327;
        b=NDVp8Jc0icAliUbZciZnxDKbtPG73/53d4hhuPTWmPST7mF+W6lMg/xZJYSonC565f
         zgGv0ZXUxrvieVGvzUMof/eBRhD+XKsdlw/XnzSYVx7QBj29IJyGsmb/k03MzxQCwY75
         mpLK70MhcdEzQxhzwkIAnHcluPUEIzjw/TmMGzo4rl/cnoEjgbsbpI2teEWSZGGWMNy9
         eh70lcbvamZDWbwHYp0tegkN8gWx034OtTCPaInbyZ1muIVsyMcfAdj3JaCrR9Jj6HsP
         3qsCzqyVduW3kTT0rYPJWnIZt9s180VkxfJxCxlp/pRX3B3yvzavxnJv6FwYGiGDjHl+
         ES9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4xB9mu0NfOZSjIYdWgzuHULYbUQ75NlZHyzkoQqQjp0=;
        fh=H6oABgYfmdXZbBqf4ooK44oLu5UPRxe7/DSClHCIkw0=;
        b=KI/J//D4QhrdPtaaWYvjyb0W94MfbTC0GYtkbDTO0m1eLo4mpCB29rAS+t1J53az9t
         fcajvZGo2Pn/xwMBkNv62k7Ysfi8oewUzvxCSwSB31cx6hZjnsO6qAM3ZR75OPY3TwlE
         9J77zLjxtylrCyxwRcfySGcyzjiPJUty6HvL2ktfKyAmLxr7XgThGujwCD7AcngrbzrB
         J7vA8v/2DAU8rgR8QgMp7tbpIv4Ii7PcVj9IKYm04O0s0lXhCWu56oj6SCBbcGZVkNdF
         1p9z1MYHYTxXwO4sEgMpVAanYlSESE4relP5NaMJiZoRhkT+HJD6+lQkaJXt7eq2J+m+
         Qr7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377509; x=1788982309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4xB9mu0NfOZSjIYdWgzuHULYbUQ75NlZHyzkoQqQjp0=;
        b=DcO2qkaaBXedEGfgIDl640T7TUGQpfBI0bwk3Wm3h1pK95XzF8ohcf5fi8xyh8vU51
         R/pNmsRDVBG1rN/OjgqkN9qQgzUFV+QU+Qa/t0++RD/wEHji62+/3GoAfWXzw0gV6WuM
         Xpvn2U8BVF/xK/94xntkvljMd6fpWBCcxeG1xnkmq6Q7ElqHfgq46f5czvPzFSwKheit
         VXYCneDkWeZORbud5Wjr9p1r0dqh7nIFO809NCVxh+SOHMKZlE77dVd/4HbMO0ue1FBe
         0sGFD5v6qvpxde73ixUPI9R1lPUy/myC13Moruz5OHXUcHxOg2fRZjWsD1/BLkKqa4rj
         9keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377509; x=1788982309;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4xB9mu0NfOZSjIYdWgzuHULYbUQ75NlZHyzkoQqQjp0=;
        b=dTO5XzwgzJP8LcmxC+smV7F9KvWICHcGkcEU1wCW+aUpX6VFOnoK0KbY0r2n6OViwO
         Mv7YvijgnhGx3SU2QnFk6U3IRkeXw3pUYmkc1w7RJFZ1PDOgB9BM5XRp1Gag39Zam5yQ
         cAkJXugdTE4TaO/0Hx+w2VfiEmGD1W7KpAjGh+C6vSuIkFCCdRVpeBBKQGTnkHyaZ65v
         M7umXN6yff643MtV+AW5eKmERvg0sciDbta6wUHNXzOIA4OoGltV+SegtmmMvyA6r391
         QFB09BR9+CxiIOnTASUI7z2GGPTSuLJotdGRzby9eWYas79bUXyXly0A2QENPM2FtYR/
         QduA==
X-Forwarded-Encrypted: i=1; AKwUvBwqyIkwWlNr/MHlOQxqhs72PVelj0gP6FxusGUykCy7uzjKyM6CHYW6hjvusGxWuIVaY5dUUj2fC1zyjkIo3A201UeW/es=@vger.kernel.org
X-Gm-Message-State: AFuF++ndy1GmWJfX9SxpZbJfdp2QlunmWqQ5QH8yRL0RUMZZ+26mdvjd
	Cj1ldlk1xtamazUHt1vEBKIBdEFB2YFCdBynmG/7LyXQv3HtwwBAbadr/97zEPmUUVKUJng5cRU
	oXfF9glPV1bbfMBUT/wirW4XBPH4EWTY=
X-Gm-Gg: AYBFou3o5riYKfIHTYxmhhjZi0D8UcK/IdPvXfgQlBcOkkcIgUcbKvfuQ7EHyueUqR+
	6wM/NH1rJdkx/yhKTt2Rw5S2ePWnNKO4bJUJchlvGnpye8y2rtHud1CBpOqtuIbr2Jt/Jbhxr/C
	xUSluCxmF1RbfQPapMTwrJ7J85NOB/GXJAaNCTFz6PAQt+dgpGasW6kT/sOAERRPX7veW7t4BHD
	cCuP+qm8SGptcwUY9tsCasahX9V3RZmOU9jVxq31Z1aaGOM12ISESY1EfTVjK8OXUOauZ3jQTQJ
	vODYaAOuiaNlFcp2qQpYry4LxDci+cVXCGpiEjOJ9imWP7MEJljWhqna1IvtSganyfKVDRoC/Q=
	=
X-Received: by 2002:a05:690c:c512:b0:864:6fab:adff with SMTP id
 00721157ae682-86c509d9cd2mr39132517b3.14.1788377508601; Wed, 02 Sep 2026
 12:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831110934.241898-1-a.s.protopopov@gmail.com> <DL514LM5TA6V.IOW7P2WM70BE@gmail.com>
In-Reply-To: <DL514LM5TA6V.IOW7P2WM70BE@gmail.com>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Wed, 2 Sep 2026 21:31:36 +0200
X-Gm-Features: AcwNN1V2Rt775pi-2pC2GM4FeyRGEHYTzRhtRvIQQntbTC-IwI8Yk3niV4K0Pwc
Message-ID: <CAGn_itxwZcMLtass5fZQ5XqgUtwTaJHfUGxg_SK7h_vqEgpmeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] Add new way to add BPF LSM hooks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, John Fastabend <john.fastabend@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 8:07=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Mon Aug 31, 2026 at 4:09 AM PDT, Anton Protopopov wrote:
> > The BPF LSM programs are allowed to attach to LSM hooks. This enables
> > operators to mitigate known bugs without a need to reboot or livepatch
> > machines.  BPF has shown very useful to create such runtime policies.
> > However, many APIs and parts of kernel aren't covered by existing LSM
> > hooks and this would be beneficial to extend the coverage.
> >
> > To simplify the process of adding new hooks this patch series enables
> > BPF to attach policy programs to hooks defined outside of the
> > official LSM list.
> >
> > One of the reasons to add a new mechanism is that in order to add a
> > new LSM hook an implementation, at least one in-kernel LSM must be
> > added, such as SELinux or AppArmor, and BPF is specifically not
> > considered as a reference implementation [1].  This is, however, not
> > feasible for the use cases and capabilities covered by BPF LSMs,
> > which are not directly comparable to those of traditional LSMs.
>
> This is no go.
> bpf-lsm can attach to lsm hooks, but the machinery has nothing to
> do with LSM. bpf-lsm is exactly the same as bpf-mod-ret.
> So calling everything LSM is actively misleading and wrong.
> Patch 1 starts this misleading naming convention
> and then later patches add fake LSM hooks. Sorry, but no.

Got it, thank you.

>
> pw-bot: cr
