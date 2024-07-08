Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3AA132121
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jul 2024 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446733; cv=none; b=VXwvNKDGP+Wt2Bm5UdX6vOPWX7WhzVqzA0IqAwtW3cjnjTcYO52RoYjvbRfCt6Qk1jE+h16DJFyvhcnTGT5QNo1LLBHvzg6j//gV4jtLJ/FAarApKvxShfHcIbvixqkzNMIzJeuqrl0piEEJtajDxJoQfB6cVJNhQZKz/Y3OAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446733; c=relaxed/simple;
	bh=YpwYUIf9U7tOTEu1GBLdmsWkfddjBk7mq9GVYpJ/N/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8XU1kI+1sn4ZzA9rrR63edWpCxsJIIeVPp2JU9JWzkKVTZQCN/O85XiYKV1zsh1Cu7QjmPjfQwfLNToe36Qm0lNxb7/FvCzZy2HM2lWs5B0W0dcOBKVqSsL+Zf2yqvDvup3WsNJYiB6DaI7/7jnt3F5TZgfZ6UYHGxv04/I4oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6zL6pnc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6zL6pnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403B4C32786
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jul 2024 13:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446733;
	bh=YpwYUIf9U7tOTEu1GBLdmsWkfddjBk7mq9GVYpJ/N/0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R6zL6pnc9gGrOL/xoqjkD7nRFxNJfvCFZ1fENJp6Y39jEQgsCTQu0WNkTCAhR7egj
	 f9E5lLsP6vfl+cQtLFt5WPsq3mRVfkw15Td3lI+wcmqHaTklxZGwGH7cjdmH/u4GlF
	 r/DseUPI3sBbgh2WeQyGe0pITwnZBVdcQ32EE8P3eq5Q/gtaFAMgXyR01M53M4dT+b
	 5WgcuH+y01wGGBkC8PcH4FLaUD9xjfZhyaE8FXQ9rT5Xdh/4QFW9h57ynzWU1dyBIJ
	 dqWGM5zCPTfOcOeVd4stCMTMg6YiWUMbJEmnOW/hJz8wSnUIJn/Fgy5wtHeK3xE267
	 IEXm6EoOhfJgA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58b447c511eso4956699a12.2
        for <linux-security-module@vger.kernel.org>; Mon, 08 Jul 2024 06:52:13 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy9QeCemzEX8cjKcrYH9mDK6JOZcjL1a0BnSsHMk0LGIBJhKSBm
	XY4ZpWRrgeBCTQ+s8o/58kcCzZ5mCcyLp8oYEc4LEVciPPgdlmKBB4L0G5h0jFPE/Vq/4jwnArC
	3YX/nHUtWJv6AH3JXQgF6lVHMksYnz6vOHIz2
X-Google-Smtp-Source: AGHT+IE4/nvPX0fWurvoLs6WfRvZIQx76b1avHbl0Uu/HZunJbxrerxLOB7KiXWSCNOI6zEAPfsQJzvRk4u5qo5hsRs=
X-Received: by 2002:a05:6402:510a:b0:57d:3ea:3862 with SMTP id
 4fb4d7f45d1cf-58e5c8264admr9901866a12.27.1720446731834; Mon, 08 Jul 2024
 06:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-4-kpsingh@kernel.org> <ce279e1f9a4e4226e7a87a7e2440fbe4@paul-moore.com>
 <CACYkzJ60tmZEe3=T-yU3dF2x757_BYUxb_MQRm6tTp8Nj2A9KA@mail.gmail.com>
 <CAHC9VhQ4qH-rtTpvCTpO5aNbFV4epJr5Xaj=TJ86_Y_Z3v-uyw@mail.gmail.com>
 <CACYkzJ4kwrsDwD2k5ywn78j7CcvufgJJuZQ4Wpz8upL9pAsuZw@mail.gmail.com>
 <CAHC9VhRoMpmHEVi5K+BmKLLEkcAd6Qvf+CdSdBdLOx4LUSsgKQ@mail.gmail.com>
 <CACYkzJ6mWFRsdtRXSnaEZbnYR9w85MfmMJ3i76WEz+af=_QnLg@mail.gmail.com>
 <CAHC9VhRA0hX-Nx20CK+yV276d7nooMmR+Q5OBNOy5fces4q9Bw@mail.gmail.com>
 <CACYkzJ6jADoGNuPP3-1wkk-kV7NOQh+eFkU5KEDEZgq9qNNEfg@mail.gmail.com>
 <CAHC9VhQQkWxMT3KguOOK7W8cbY-cdeYTJSuh=tSDV4jsqp6s6g@mail.gmail.com>
 <CACYkzJ5gAnbXX_aWy6952s2O5L2p3Mw14OUfo9Z-Od6_Dp2HLQ@mail.gmail.com> <CAHC9VhQ+KkqTZdvo0cT6-F1fJaG3QgBEnMQqHkiN-GToH37BuA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ+KkqTZdvo0cT6-F1fJaG3QgBEnMQqHkiN-GToH37BuA@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Mon, 8 Jul 2024 15:52:00 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6mR9mRGS8Df_U1yTBSamW2VRt4v9-6WQnkbhGDuH5KGQ@mail.gmail.com>
Message-ID: <CACYkzJ6mR9mRGS8Df_U1yTBSamW2VRt4v9-6WQnkbhGDuH5KGQ@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Mon, Jul 8, 2024 at 6:04=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrot=
e:
> > On Sat, Jul 6, 2024 at 6:40=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Fri, Jul 5, 2024 at 3:34=E2=80=AFPM KP Singh <kpsingh@kernel.org> =
wrote:
> > > > On Fri, Jul 5, 2024 at 8:07=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > > On Wed, Jul 3, 2024 at 7:08=E2=80=AFPM KP Singh <kpsingh@kernel.o=
rg> wrote:
> >
> > [...]
> >
> > > >
> > > > Paul, I am talking about eliminating a class of bugs, but you don't
> > > > seem to get the point and you are fixated on the very instance of t=
his
> > > > bug class.
> > >
> > > I do understand that you are trying to eliminate a class of bugs, the
> > > point I'm trying to make is that I believe we have addressed that
> > > already with the patches I've previously cited.
> >
> > The class I am referring to is useless hooks returning a default value
> > and imposing a denial / enforcement when they are not supposed to.
>
> If a LSM hook's default value were to result in an undesirable
> behavior within the kernel that would be an issue regardless of what
> LSMs were involved and we would either need to modify the hook and/or
> the default value.  I am not convinced that we can adequately solve
> this entire class of problems simply by allowing one LSM, or even
> arbitrary combinations of LSMs, to disable or otherwise disconnect
> themselves from the framework.
>
> > > As the BPF maintainer you are always free to do whatever you like
> > > within the scope of the LSM you maintain so long as it does not touch
> > > or otherwise impact any of the other LSMs or the LSM framework.  If
> > > you do affect the other LSMs, or the LSM framework, you need to get a=
n
> > > ACK from the associated maintainer.  That's pretty much how Linux
> > > kernel development works.
> >
> > Okay, then let's not make an LSM API, I will handle it within the BPF L=
SM.
> >
> > The patch I proposed should not affect any other LSMs and is self
> > contained within BPF LSM:
> >
> > https://lore.kernel.org/bpf/CACYkzJ6jADoGNuPP3-1wkk-kV7NOQh+eFkU5KEDEZg=
q9qNNEfg@mail.gmail.com/
>
> The code changes may be self-contained within the BPF LSM, but it does
> appear that the bpf_lsm_toggle_hook() function directly manipulates
> the LSM framework hook state which is not something we want to allow -
> none of the individual LSMs should be directly manipulating the LSM
> hook state/configuration.  Although perhaps I'm missing or not
> factoring in some context around the patch linked above and that isn't
> the case?

I think you are ignoring my point that BPF does not want to add
extraneous function calls which at the least result in extra overhead.

 You have ignored the fact that BPF LSM never wanted these empty
callbacks and you still continue to ignore it. Sigh, I will drop it
now and will propose it as a separate patch so that we can at least
unblock the static call series.

- KP

> While I had issues with Kees' comments, at a high level his suggestion
> of dropping the last patch and moving forward is something you should
> consider as I don't see this a good path forward with all of the
> approaches that have been discussed thus far.
>
> --
> paul-moore.com
