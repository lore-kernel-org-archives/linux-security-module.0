Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F7331E163
	for <linux-security-module@vger.kernel.org>; Tue,  6 May 2025 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746490902; cv=none; b=F0XFwvA57HJx1ciefo7idFk1wJLup+01IvANzEtmlJBxc0I5OzJxzlYxrbPQE0bt0WjbPjcM6S/rDHqnNwnHty/PRU7juJsOhDOMsc9msw6hNrc7QoBPGOm0qLdsaZ6cr2hYfStJPd0ZAyCUVefE5I5M2A7HwxxsXNVUM69lCZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746490902; c=relaxed/simple;
	bh=AtDKckcds667iu9oDsou6O2i2ETY50cEHmCvGTB/aJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=by7IjA2sjq+Nw2kqP+X9bcGVuUYYOmQY5colZg+QFtOB6Vz3qGmysuc4B3hkAsyWCjsKT5FSeoboDgD2hDbwAxZwJVKM7J25qcX5VV6kqoZ9uRr3GG00BXFLBl+wXLeWIaeQcxXYxNi5ZHsNDrjRjnpCmPrVuJLrr/TvD48uB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI3hsFJr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI3hsFJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAEFC4CEF1
	for <linux-security-module@vger.kernel.org>; Tue,  6 May 2025 00:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746490902;
	bh=AtDKckcds667iu9oDsou6O2i2ETY50cEHmCvGTB/aJU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dI3hsFJrJCawW85Fmn6xhuGuuaUl3N7nu03FJPtnYjvyXZwwA4e5r2+keAIVACmSP
	 1hNqWyavQJZHBxCAbSTTTggKV6sWW6R6lAvoy1hQL4xZqDUXpthCIqUkQjH+VmeDFU
	 dnDRa6r5QKTavzy9MeDSOWSBU7IN0y8RwG3j+tzx7DMRlcIaGniD04cqfnVWs+rcQH
	 ILAElsVKfV4C3vybvOy39a1eG7tlehrQ9sgeM1SA4mIJqCdw3+roY0A2BDLy5E5BYF
	 xMiUFgR8BpblfnkUo7Di2YX8FvQQHaQ5JBJ1hM4oynfPMXGjxLtvxlFVz9wSEKn0up
	 Bp7eNuq2YBQoA==
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ecfc7ed0c1so47319356d6.3
        for <linux-security-module@vger.kernel.org>; Mon, 05 May 2025 17:21:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkUvdALjUfXF6Hj0xtu7T3xlgfuETmIzpPFqZshCBLq4Vp6HjzRQPx2I8TLJBwzli9IDcdpNstXfn70xWOg0Xj4x4eeCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz73F5IpUhQ1bo/jLqdPW9SO9xbFn9zeirZ3wv4/50lqCCm67oW
	8TmwDozJwY1IJWMM9pqbTe2E4aulkB2pOH53o/t5H3jHJL8j9zWXGLpZZp0VXjJFwsc/SqTqRi5
	xEjk82LIU4gvYT/Xjd+f2dLzYBF4=
X-Google-Smtp-Source: AGHT+IEE+di7C+Mup+fdRHVAiggVfXa7tF3dfapc04RR34jWvgZLeIQoU1ztXWBPsZS3Du4DEIjsYRM31xV7BDlhdr8=
X-Received: by 2002:a05:6214:1943:b0:6e8:f2bf:7262 with SMTP id
 6a1803df08f44-6f5358ee090mr15468686d6.41.1746490901386; Mon, 05 May 2025
 17:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
 <295201ef-5299-4bf0-b0ee-6e1e2a74174b@I-love.SAKURA.ne.jp>
 <CAPhsuW4U5ULtOQ9ucucs3bs+jw+EbBzrCfhAuvOCO=1g5aWAHg@mail.gmail.com> <CAHC9VhRBkqzEkJLyZ2gbdyfU6C3grGSOQUY40G2zA5+HnQZ2hw@mail.gmail.com>
In-Reply-To: <CAHC9VhRBkqzEkJLyZ2gbdyfU6C3grGSOQUY40G2zA5+HnQZ2hw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 5 May 2025 17:21:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6P8mR=5w+5wV6Wf94-ph9wQ=XYw0Dm8rKZ9H-brLJpAg@mail.gmail.com>
X-Gm-Features: ATxdqUGnUA1qBNJdt2vl1NRo2fv8f55wADrVQj929m_QSYWxe9bVv2J0ZvFKG1Y
Message-ID: <CAPhsuW6P8mR=5w+5wV6Wf94-ph9wQ=XYw0Dm8rKZ9H-brLJpAg@mail.gmail.com>
Subject: Re: [RFC] LSM deprecation / removal policies
To: Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	linux-security-module@vger.kernel.org, Fan Wu <wufan@linux.microsoft.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 4:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Mon, May 5, 2025 at 5:54=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> > On Sat, May 3, 2025 at 4:47=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > >
> > > On 2025/05/03 5:01, Paul Moore wrote:
> > > > ## Removing LSM Hooks
> > > >
> > > > If a LSM hook is no longer used by any in-kernel LSMs, there is no =
ongoing work
> > > > in progress involving the hook, and no expectation of future work t=
hat will use
> > > > the hook, the LSM community may consider removal of the LSM hook.  =
The decision
> > > > to ultimately remove the LSM hook should balance ongoing maintenanc=
e and
> > > > performance concerns with the social challenges of reintroducing th=
e hook if
> > > > it is needed at a later date.
> > >
> > > What about BPF-based LSM users? Since BPF-based LSMs cannot be in-ker=
nel LSMs,
> > > it will be difficult for users of BPF-based LSMs to respond (that som=
eone wants
> > > some to-be-removed LSM hook) when removal of an LSM hook is proposed.
> >
> > If a LSM hook is important for an out-of-tree BPF LSM solution, the own=
er can
> > add a BPF selftest for this specific hook. This does not guarantee the =
hook will
> > stay, but it can most likely detect unintentional removal of LSM hooks.
>
> Sure, however, like you said, we aren't going to keep a LSM hook
> simply because it is used by a selftest.

Agreed 100%. If it makes sense to remove a LSM hook, we will adjust the
selftest accordingly.

Song
