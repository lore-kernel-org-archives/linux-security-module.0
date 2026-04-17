Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F93264E3
	for <linux-security-module@vger.kernel.org>; Fri, 17 Apr 2026 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776458536; cv=none; b=l+JtmS59pGgJl5qHhjVzTEbwZ/whoiBG9NjHBzYrB+5eyfyMNuNDUKbcaqqmUxii8Mm5FHKmqhl05fML8Ab3fnMtny+rH7aDbAvXmYQ2v1+sNOoZbyqI1xohm7bdWHnT0UuE98S/7D11z4hsTS+rzhxZon9B202znDWoaOWpZZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776458536; c=relaxed/simple;
	bh=Kwy9xhQS9wSZ1anmJLoHRofCLSOiYF8wU/V9WUxr/n0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAUJsP6c1lA5kxhVHxflRaeRZ/9RCLBHQW1bgfYr667SZNNNRvXDbJiali5Lf09sVIkjZbmlfSXBl7/OKvGVeV+irrpX6Boh0QD6MTnZEYm8jIAzYE+/24A+PIW0F8vvPtk9rOTMiC4aWenUOfO0jmHe6bvSDZXDVZbBWsrXEwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfpP1QAu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfpP1QAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503E8C2BCB7
	for <linux-security-module@vger.kernel.org>; Fri, 17 Apr 2026 20:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776458536;
	bh=Kwy9xhQS9wSZ1anmJLoHRofCLSOiYF8wU/V9WUxr/n0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VfpP1QAua5meXcaz0cUvCNIPDYrpAh/Y8eorqXTckd5/ho8oQxT0kMTE20rfEOD8W
	 ci6/lSKTgu2PtazfcCogylpxTGfF5KqoE8N1i2WOCzZGV0IPPHKrvxi5c5WEWcNX5o
	 DQs6UYo6zhLUL9nOUJOMNnwvSZqdprp1C8pZfKBoVvZSvYkl2oAP/ksSmOGxWsNylr
	 9Ke3uNIJoCETmyxEsl5IBJk6JhBzf06firyTTsca8YHLNHQKmhafORSXtwb6pjF7XB
	 0ZHTiJ6HybyzD5wofjm2cJMvdD7t5ri6jwG8kXUSNfBTtDrl4RkfyOY/b1dRNMJlIJ
	 K2g9EzxOo0bGg==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a3b0242631so11912306d6.3
        for <linux-security-module@vger.kernel.org>; Fri, 17 Apr 2026 13:42:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/01Dr9NjU7nKRTmvdsukzfB1EypKrkUHPKn6Da/7LtkNintb/P4mVZpnki1riJAKmXnzmrQXpHFdIXG2SA0EW+1sWTN+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxslBUaSH2jkzhMMHTrj+NsbNRUrP8jq8IfmHpO/TWefCd90Dkg
	segF9o1QtDE0zXq1anYzE/kaTrQTL4Q0LAteki57fJaxwLYsgoQm3uj5KhBDK81QXQIw6p16udk
	ouhYMD8etIO/T4HsTlxL7RYlcdEQ35RQ=
X-Received: by 2002:a05:6214:cce:b0:8a0:7c8:409b with SMTP id
 6a1803df08f44-8b0280f20c3mr71287416d6.33.1776458534898; Fri, 17 Apr 2026
 13:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-9-utilityemal77@gmail.com> <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>
 <aeFaQXkKNHFeE-oC@suesslenovo> <CAPhsuW648HdcCbXWMHaJ4uirPWq2WX3Ggx3AGMU6CGzhNYUREg@mail.gmail.com>
 <aeI_CXj6F-nI_DCL@suesslenovo> <20260417.ohgoh0Eecome@digikod.net>
 <aeJlHIoSjVPmccDx@suesslenovo> <20260417.aPh1ooQu8esh@digikod.net> <aeKY_QUge4okHjrW@suesslenovo>
In-Reply-To: <aeKY_QUge4okHjrW@suesslenovo>
From: Song Liu <song@kernel.org>
Date: Fri, 17 Apr 2026 13:42:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4CoskfaqEE5yS2LU_mFvNBDsKc5OX1+f=Lkduc2ykSdQ@mail.gmail.com>
X-Gm-Features: AQROBzA-e-POhonAeWCvE4MF_wVbgYEHHJvLQ7J5S2Pfg2GBOz84cUP9IG0D8ME
Message-ID: <CAPhsuW4CoskfaqEE5yS2LU_mFvNBDsKc5OX1+f=Lkduc2ykSdQ@mail.gmail.com>
Subject: Re: [RFC PATCH 08/20] bpf: Add Landlock ruleset map type
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org, 
	paul@paul-moore.com, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, jmorris@namei.org, 
	serge@hallyn.com, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	eddyz87@gmail.com, john.fastabend@gmail.com, sdf@fomichev.me, 
	skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 1:33=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
[...]
> > > > to the caller) and pass them as file descriptor?
> > > This "pass them as a file descriptor" is the tricky part. It would be
> > > very convenient if we could send the fd to bpf from userspace and hav=
e
> > > it be implicitly converted (like in the BPF_MAP_TYPE_LANDLOCK_RULESET
> > > implementation) in one step, but I just don't see a way to do that wi=
th
> > > the bpf_landlock_get_ruleset_from_fd kfunc approach.
> >
> > Song's idea to have a generic FD map looks promising.
> >
>
> I agree the generic FD map sounds like a good fit.

Well, I am not 100% sure a generic FD map adds enough value
on top of current __kptr solutions. This will be more tricky if we
have to touch file_operations.

> So this would be three parts like:
>
> 1. The new point-of-no-return flags for NNP and staging domain to
> execution time in Landlock. Selftests and doc updates.
> 2. The generic FD map implementation for bpf. Selftests and doc updates.
> 3. The BPF kfunc implementations for Landlock using the same point-of-no
> return staging. Selftests and doc updates.
>
> The scope of which is probably too big for one series.
>
> Luckily part 1 is pretty close to being done as part of my work for v2
> of this series, and can standalone as a preparatory series for Landlock,
> since it adds flags and features that have utility outside of BPF.
>
> Open for ideas on how to split this up (or even better, for some help in
> implementation or prior works).
>
> I'd like to get some feedback and figue out what this generic fd map
> should look like and get some more eyes on that idea to avoid wasting
> reviewer time on an unsuitable implementation.

I will think more about 2. If it indeed adds good value, the upcoming
LSF/MM/BPF is a good opportunity to move this forward.

In the meanwhile, we still need kfuncs to access landlock ruleset.
Therefore, any work on that front should be useful.

Thanks,
Song
