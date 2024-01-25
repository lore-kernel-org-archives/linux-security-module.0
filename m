Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0410F6E2DB
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194802; cv=none; b=CyS38lMXjuFQsuGcl/qeG1p+dYx2/F2eebtTC8PRjiIjvmT/jowTRJsKAr9wbn33zVZwlM09rtD97VcB2B1vKMtyDzAmvsqcOBBeyLNbSkTSZAD/rdpFN3CjuHtlkDixbtGxOd5Bhk6uy1JvUh/oJPcYLfw6P+Ut8UkRIxTEt20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194802; c=relaxed/simple;
	bh=NVvEtQm6kIc5iJVLjWQ7WGuCykEqscCeR/8JE5EYsvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFHi8TX2K0vbsvMH1vXmLFgw67owDvBKku4jvO2RhO7bHoe1/TrnhUg4XNSN2uqEZ6ZwpeTqmW9cRfrhN9gA71Y+5bZCOrqWEcAamRY0MAwrwwP/NKCgerT62/ehvUAw3a7p+XaHI02L/5HEbzHizMiCk6CiyhcZ6D/JXtBEo8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ywe7DKeV; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ywe7DKeV"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55d1d32d781so471a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 06:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706194795; x=1706799595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVvEtQm6kIc5iJVLjWQ7WGuCykEqscCeR/8JE5EYsvU=;
        b=ywe7DKeVLgmbEvuvIhAhxDlugmvDF0137qywdlLrLQAVIsCRrVwDfMXqQXzEq36zjN
         duhRuPbxnbbVBkSA6B34HESH1+ZU+cq+/bn3WVjJLv1QCeqU3mLoHKvlcQ1wk3g5Nkb7
         fJ5nv4lzoysO7zQrUYZ1zwOgr9d94il9rv2tVJNh15J3p1NGivQZ8FE03orEoGVUp8eT
         1ZFkjzC8V+ijBNBGX/b6Jj3hWCSYoA5hxYJmPMib8ghWY3Hx4v2hphFR9R1Gav146njq
         5m6TnU35zJc5pSUcnhIbdGXptRXalwJkv3HxfSGhnq12zuUcmpdv6jzVJBuWhNx2yIid
         +npA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194795; x=1706799595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVvEtQm6kIc5iJVLjWQ7WGuCykEqscCeR/8JE5EYsvU=;
        b=NWcBDPnRbtlBKsL0wv4ndf3LQ4k02PJFVqxcq9Zubp0R2egBGWa2YEEwrWgGkqg8p2
         5abasqfbuydk3tHV9XfwZPqUYREjydYt4eP2b6KmKoLWaIlwbIAtjzueS5uFpmJ1UbQX
         FL0EpXDeJ0uyEkqumm6AWqFpAyIiwlJfAcsf+RtoVRYgpwcf4kg2GAJrrFbcjR/pCNIn
         FS1KzuovrUWXPEHqvtMcngFpfeeJxUNZKx8cB3K/ieetAb6d1b1ZqjHKOxhcPdchQbhe
         3BQ0dwgufA+pnasDxwPBHOfGMxzn+clON/96wUCkMb+eJlSu1C7LxP+d0eO3vdYV/RFM
         gTAA==
X-Gm-Message-State: AOJu0YxL4tRp0i3nQ6tYEJiKdVLtWhBJlR9QGYwlAEeHh/bWbhgzyrya
	o82OQcGoh/ahLtTWpxSWtuLUVSAFZfkcJUgfAgSbDSdT+neWQSzfNgp+qqfoyLM8i3iG6Bak542
	AHh2dVGwCFfanpYSx4LXoYjiRE6zGfyt8Rl9e
X-Google-Smtp-Source: AGHT+IGIh91e+GUrEWI2VlgkJRJgEwPq3pQit/1u6pod8dk+ZSjuV2o1xzEEvMsVGi6ZGj+bb5Hul2/ERa0C1CI5xvw=
X-Received: by 2002:a05:6402:c08:b0:55c:e50c:c66 with SMTP id
 co8-20020a0564020c0800b0055ce50c0c66mr233529edb.0.1706194795113; Thu, 25 Jan
 2024 06:59:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124192228.work.788-kees@kernel.org> <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>
 <202401241206.031E2C75B@keescook> <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
 <202401241310.0A158998@keescook> <CAG48ez1tcxtEwWgxSUqLDcYbrkY=UM3hz22A0BTvTYq4BGpM8A@mail.gmail.com>
 <202401241348.1A2860EB58@keescook> <62d1c43c-18e5-4ddf-ad85-c47e5c58d79a@I-love.SAKURA.ne.jp>
In-Reply-To: <62d1c43c-18e5-4ddf-ad85-c47e5c58d79a@I-love.SAKURA.ne.jp>
From: Jann Horn <jannh@google.com>
Date: Thu, 25 Jan 2024 15:59:18 +0100
Message-ID: <CAG48ez1BwRBy67=c7bgsNCoGHaw82tyU0O_QJjbFvQYVd9Aukg@mail.gmail.com>
Subject: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Josh Triplett <josh@joshtriplett.org>, Kevin Locke <kevin@kevinlocke.name>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 3:35=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/01/25 6:50, Kees Cook wrote:
> > Yeah, I was just noticing this. I was over thinking. :) It does look
> > like all that is needed is to remove __FMODE_EXEC.
>
> I worry that some out-of-tree kernel code continues using __FMODE_EXEC fo=
r
> opening for non-execve() purpose. If that happened, TOMOYO will be fooled=
...

I just scrolled through the Github code search results for the query
"__FMODE_EXEC -path:fs/exec.c -path:fs/fcntl.c -path:fs/nfs/
-path:security/tomoyo/ -path:security/apparmor/
-path:include/linux/fsnotify.h -path:nfs/dir.c
-path:include/linux/fs.h -path:security/landlock/", and the only place
I saw in there that sets __FMODE_EXEC, other than copies of core
kernel code in weirdly named files, was this one hit in a patch for
the 2.6.39 kernel to add plan9 syscalls:

https://github.com/longlene/clx/blob/fdf996e0c2a7835d61ee827a82146723de76a3=
64/sys-kernel/glendix-sources/files/glendix_2.6.39.patch#L2833

Debian codesearch also doesn't show anything relevant.

So I don't think we have to be particularly worried about that.
