Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166A91EFFB9
	for <linux-security-module@vger.kernel.org>; Wed, 23 Apr 2025 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420314; cv=none; b=gegh5b1jG/orbujfD3Df6hEPaBMGc3/CuXInpYPs9GqonAIAUdizINzYQ1beTif37prUWLjwW9B8yNyUhX+1LTKkZ1/IxR06MPqGBaUYU4p1eV4qchuZLaIEfpOVrKLzoIhmCyW9G3HliBHw4drqgOL8LyfmfEGG91cPc+RTBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420314; c=relaxed/simple;
	bh=dfltnVDi73/5hTrWgOjN45WtUPQNs0TGxn/zfAFbiQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFqk5fEtSSFdsgMXdYrTL5Q99zgQ7yrprPFPwTuzKZzz1l5vkNNreF6Ce8NFn4FhDmiPcZgx6QGmmFEi03S829pv3eYTvW/MuEhHFnuHw/HsD593Cp00tBmwNJThI1x8U9lm0TDRCPONql3LDzWO+A6b4jIiPuZ7zIa8Nar6M7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bZzYCZ+T; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bZzYCZ+T"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e728cd7150dso3995437276.3
        for <linux-security-module@vger.kernel.org>; Wed, 23 Apr 2025 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745420311; x=1746025111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrb4cp6hW0fCVaaBrIzlwgSSHEadSZhLW+hKEQ5hufU=;
        b=bZzYCZ+TmRLi3ogRZKOu2SDAhb0XKNKOPMt4v2TPEjrf6nYYU1iOePcyHvphB+KMPk
         Fv+Jnk5zXNLtUQoy9xRHv2mX2NjYaHMkCA0m/7R9G3HXqFiLS+sodLK6eV0LWvnYttGk
         K1IXpXiFQystUEpLGcGFVdoWJxs2E5HXpVjkl0JI6T6XA29MSHm7mSFMldsummoEMbeB
         8EeKEYRIBSL0Ga6+mR8FA2nvWiuwVL0WOpNnF1qK87LaGvBoZXdQnuRO5AxAadtfYuBt
         rQowGJ4kzyAOvwQq+msNuV288Mx4E+JIngkNeM9WRYMqhIGjkGdZfTd3GQB7O6F18W6R
         zhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420311; x=1746025111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrb4cp6hW0fCVaaBrIzlwgSSHEadSZhLW+hKEQ5hufU=;
        b=nBIKNRSfJPPfO8JTMpm8g5jK7JeOY2y4YEaEH0+r3pIWEGZ8jmgfyfDRIpQ4dJCJQA
         fACKGFdAFK5mSvmb1h6RydmnxJvscIDRHtE4XfQO12gilTR7QgpHAIY7VG41ISTvwVA8
         psBqj/dFo0y9ph4MD5rTIqk0TmuRCaBLHDZ/2RK/JXOKwuBVPK1hunRQYbvqQGI8vXl5
         Terysls0ELFyW0JawqsZ56BcN7BEMuIgec1IgkSWYm9L7IUD8s+234cqh8SNu3mYHtFw
         iajLjuYFtsPl0dYJAdbIHxlK/95KCiKiUQgk9khXfbR+nniwfVcsd6GCW6qN3rhcHYZI
         OmOg==
X-Forwarded-Encrypted: i=1; AJvYcCX9LvIA/qHKK7+lvtCtHKI6A7MQlOSgfIP9BqA95k8C3s2i6JMdrDrDbZyRXxNUM64gp/lgFUDFQdVlkr69kJbxpW+P8T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXDbAEW7B5O7ZVihhNMq+dd8leUBFYNYf8hOWu4DeIR8nJ2G45
	OkFDIcspjXGq/M9Wp7qRtgiHBQeFOMjGFJcpU4gH1OqzMcejqHNYxcwOoKZADLQeJs7bqSOG0NP
	ndshXxB21rcTO4Ty7Ddg6Jv1bdXQJUhBzHx7M
X-Gm-Gg: ASbGncun5FRaLgtYG7cDXjJwObnLH0lBWDu1tBMjrpkBjitJt+7P9fYQv9bts52kHO8
	TwzooGDFqQbMxRU5ZZrTDvMM7Qs62svxDrC5Gwibu+srZ4BINZc/jeTzoocvcPWJle2iOy//DTc
	7JUWYBk6jWS9hYU7Hu9bPtGg==
X-Google-Smtp-Source: AGHT+IG/fceHlLAvfRTRS0P2WxVYWY6W2qpcAP7O5FgVfhVAPQQlK7YTjIHBvDEGerQ6YAtAZn4/7289fAM+NKp9VmU=
X-Received: by 2002:a05:6902:2783:b0:e6d:e429:1d70 with SMTP id
 3f1490d57ef6-e7297db6ddcmr28402430276.12.1745420310961; Wed, 23 Apr 2025
 07:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422184407.3257964-1-song@kernel.org> <973cedc0d38496b2096992bf68c72e67@paul-moore.com>
 <3897DD89-5B9F-4257-B273-A4DDEDACD56B@fb.com> <CAHC9VhShOxu4Q9yV3tkST3P9SoiL3j3ET_O4_cPAV1ES5usd-A@mail.gmail.com>
 <60CAF154-DADA-4C46-ADE8-403318EFDDAD@fb.com>
In-Reply-To: <60CAF154-DADA-4C46-ADE8-403318EFDDAD@fb.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Apr 2025 10:58:20 -0400
X-Gm-Features: ATxdqUGIrGhiiUI_OOkro4NEtNvkQJEdJfDP0J4FKH1Yfox7zDBJm77MX47eWtQ
Message-ID: <CAHC9VhRQzEGvMxyZY5Ke+GFYHr9OOF=-cTVqsK14=cfGJwy1bQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: make SECURITY_PATH always enabled
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"jmorris@namei.org" <jmorris@namei.org>, "serge@hallyn.com" <serge@hallyn.com>, Kernel Team <kernel-team@meta.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 12:57=E2=80=AFAM Song Liu <songliubraving@meta.com>=
 wrote:
> > On Apr 22, 2025, at 2:13=E2=80=AFPM, Paul Moore <paul@paul-moore.com> w=
rote:
>
> [...]
>
> >>
> >> However, I don't think existing CONFIG_SECURITY_* are doing the right
> >> things. Among all the configs, CONFIG_SECURITY_PATH is the most awkwar=
d
> >> to me. Say , if we have CONFIG_SECURITY_PATH, shouldn't we also have
> >> CONFIG_SECURITY_INODE? IOW, something like:
> >>
> >> #ifdef CONFIG_SECURITY_INODE
> >> int security_inode_rmdir(struct inode *dir, struct dentry *dentry);
> >> #endif
> >>
> >> #ifdef CONFIG_SECURITY_PATH
> >> int security_path_rmdir(struct inode *dir, struct dentry *dentry);
> >> #endif
> >
> > Without putting much thought into what would fall under
> > CONFIG_SECURITY_INODE, I think it would be interesting to see what
> > hooks one might be able to make conditional on such a Kconfig knob.
> > Using security_inode_permission() as a simple test, it looks like only
> > SELinux and Smack provide implementations, spot checks on a few other
> > security_*inode*() hooks shows similar, or even more limited, results.
> >
> > You would need to spend some time to determine what LSM hooks are used
> > by which LSMs and adjust their Kconfigs appropriately for the new
> > CONFIG_SECURITY_INODE knob, but if you do that then I think that would
> > be okay.
>
> Well, I was hoping to simplify the CONFIGs by removing one. So I am
> not sure whether adding a new CONFIG is the right thing to do.

Ah, in that case I suspect you're going to be disappointed as I'm
fairly confident we don't want to consolidate the inode and path based
hooks under one Kconfig knob at this point in time.  If anything, I
think there may be some value in adding an inode Kconfig as described
above, which I realize isn't your original goal, but still ... :)

> >> OR, maybe we should just remove security_inode_rmdir(), and users of
> >> security_inode_rmdir() can just use security_path_rmdir() instead?
> >
> > Those two LSM hooks are called from slightly different places in the
> > codepath which has an impact on their environment.  For example, the
> > inode variant doesn't have to deal with directory inodes that don't
> > have a defined rmdir op, whereas the path variant does; the inode
> > variant doesn't have to worry about S_KERNEL_FILE files, the inode
> > variant has a refcount'd and locked dentry, etc.  Moving an existing
> > LSM, especially complex ones, from one LSM hook to another, is a
> > delicate operation and might not be worth it for such a small return.
>
> Given there is pushback when a new LSM hook is added, I assume
> removing a hook (or merge two hooks into one) may be a good move.
> Well, it is totally possible that I underestimated the complexity of
> the work.

The funny thing is that the difficulty in adding LSM hooks is one of
the main reasons why I am so hesitant to remove an existing hook; you
can consider it as perhaps an unintended consequence of a general
hostility towards the LSM.

Regardless of the above, yes, there can be a lot of complexity
involved in adding, modifying, or consolidating LSM hooks as there can
be decades worth of assumptions both in the LSMs and in the caller
that need to be considered for each change.  Of course that doesn't
mean such change can't happen - we have plenty of examples where it
has - but such changes are often more complicated than they appear.

--=20
paul-moore.com
