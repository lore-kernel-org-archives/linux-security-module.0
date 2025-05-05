Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202892741C7
	for <linux-security-module@vger.kernel.org>; Mon,  5 May 2025 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482049; cv=none; b=klhse9S7mtpCfLcBc3Wx+RnbKY4rUvMQf8k6gad1rf3wdd+Osg0q6wQ0uMIvqvmJFXJhw7ULrc9XvDp5tkC4ZVsKMTcHkpQVnaM9bU3Yak8DiOTf5vyWGd9W9j1lLe99vrRAmH6eRnNTioWPIGFSzFRgLlIgu9N6zgy0/P9zuSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482049; c=relaxed/simple;
	bh=l4Pz2fXhRFkScVawwUfIObJ9G9RasdUigdOMhKz/i5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9oFHJAvdRQv/kmJhtma7TLuuOTIo73KlGA/iPldfti0Z4HQMEr5AZZPhik7XuDXtU6ueb+cNHVU7tLvpSu3ZKf+wcqvrcnDyzvhbb/bcVVrzErlNENb2j9QxVp8xgfg3DtO5j+RM+QQIzSUPM6gcMh+/kf2DPa0qnrJBKUzr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IseLED19; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IseLED19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B66C4CEF3
	for <linux-security-module@vger.kernel.org>; Mon,  5 May 2025 21:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746482048;
	bh=l4Pz2fXhRFkScVawwUfIObJ9G9RasdUigdOMhKz/i5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IseLED19qo1tmKSX38D0iyp8UTZNuFDyqArm5R8B4g6FQ4BQ3w/7N51FyjwaR+0X8
	 aPr+1/vI+TPePsY8+9iBV1YyfzitZVjVNqwI5VZrAxtYvg82snaUurm0DUAMyzvwQA
	 4TrjCUgir+sgOtbYkwYKoouMhL0FEmz/6bS+JhyiNcH0z2o22Rt4VD12bi0XttO99Q
	 cpsJMbQQwmxvzPI6a2F7U992JLvEDntukGIvB+FTytl0Pb3oVduxF+GwYDL+oFy7Bh
	 /lnPlD+rVJYYcsouPfpqkSEcB2cGJvswSUijrOEJ8ES2TL/+XxaVkmUr1L3Uq4DM+8
	 2fPJtE1xOiCCA==
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4766631a6a4so64408041cf.2
        for <linux-security-module@vger.kernel.org>; Mon, 05 May 2025 14:54:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXESJ/Oq/Hc5w7ZRhnJVc9BbdSjHRxWMoMIpDD01obgC58165dN5k5Okx5gUS6ZsGIW+kroYHJu8rx+boLfngHPg1p1YV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWULQHcaCp0aZMBELv9f/WlY0E6IWinpPsrrZN/jB7a20CHP8V
	jHCx0EG4dvF01ZyMsJNOpfuemAPQKOIkOIOyPvSPFV1ONxIJ9b4XM4j75AqoH9vbRbP1TOJDVzj
	lknt1jpx2ZBJomTWMWMkQNPREDQ4=
X-Google-Smtp-Source: AGHT+IGCklfzuRgHRqfy/Wo+tg02RNf6bNq01S5tFJZOJHiqnCw/4QP2Qf4BR+6KGoLyRsJK5Cpx+xrwMAIPjPfb4Og=
X-Received: by 2002:a05:6214:ac1:b0:6d8:9ead:c665 with SMTP id
 6a1803df08f44-6f5358a3368mr10722836d6.27.1746482047759; Mon, 05 May 2025
 14:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
 <295201ef-5299-4bf0-b0ee-6e1e2a74174b@I-love.SAKURA.ne.jp>
In-Reply-To: <295201ef-5299-4bf0-b0ee-6e1e2a74174b@I-love.SAKURA.ne.jp>
From: Song Liu <song@kernel.org>
Date: Mon, 5 May 2025 14:53:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4U5ULtOQ9ucucs3bs+jw+EbBzrCfhAuvOCO=1g5aWAHg@mail.gmail.com>
X-Gm-Features: ATxdqUF3FeI5Ao6a5LSj495mqKGkNodUW8XiI3fpvS9VExiPP01F8wlqyyga0r0
Message-ID: <CAPhsuW4U5ULtOQ9ucucs3bs+jw+EbBzrCfhAuvOCO=1g5aWAHg@mail.gmail.com>
Subject: Re: [RFC] LSM deprecation / removal policies
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	Fan Wu <wufan@linux.microsoft.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 3, 2025 at 4:47=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2025/05/03 5:01, Paul Moore wrote:
> > ## Removing LSM Hooks
> >
> > If a LSM hook is no longer used by any in-kernel LSMs, there is no ongo=
ing work
> > in progress involving the hook, and no expectation of future work that =
will use
> > the hook, the LSM community may consider removal of the LSM hook.  The =
decision
> > to ultimately remove the LSM hook should balance ongoing maintenance an=
d
> > performance concerns with the social challenges of reintroducing the ho=
ok if
> > it is needed at a later date.
>
> What about BPF-based LSM users? Since BPF-based LSMs cannot be in-kernel =
LSMs,
> it will be difficult for users of BPF-based LSMs to respond (that someone=
 wants
> some to-be-removed LSM hook) when removal of an LSM hook is proposed.

If a LSM hook is important for an out-of-tree BPF LSM solution, the owner c=
an
add a BPF selftest for this specific hook. This does not guarantee the hook=
 will
stay, but it can most likely detect unintentional removal of LSM hooks.

Thanks,
Song
