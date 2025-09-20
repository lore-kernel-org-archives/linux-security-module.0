Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500EE31281E
	for <linux-security-module@vger.kernel.org>; Sat, 20 Sep 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758394746; cv=none; b=LPDYYXpiulX+/WOp2fp8eHsh+Ut4tnbM94FxTck6xOUEdG6YR/Ay7/FwuRI7DwFBnwRChBQv8YSkXxodKBOu7q/BXGXiWTZJhKQchKZhz22BA32M01zenPRmohK1wNhGPNbohUv1xUQHiznIxDYSGcRmTCCBB2ac4iRSmqYLNIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758394746; c=relaxed/simple;
	bh=kJKPqb5ITXNFMsS2LLt9HdEV0P6O3eXRMkxx5fWkKdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slMs5gnrpnh9cDAY/8ROeYGfKDMD1aLfDHt9nw7j+ddLiSnamYJJy9CG00r+NZXWDEYvWt3Hw5CbZvmbbUbTFoWBpTKhK8j17g55eOywWo2nVQRPRDqj0+2sdwHEArY8Racg4IB5Jy0lUpiZV7xcYuOnhpNvF4KgsbCOnC0GuOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xtn78Rp8; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xtn78Rp8"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-319c51ad6bdso483949fac.0
        for <linux-security-module@vger.kernel.org>; Sat, 20 Sep 2025 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758394743; x=1758999543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m2W5nx71xMSXVxU+RpAhVoe4BosDpZBLlHtgjTWO5c=;
        b=Xtn78Rp8rq+zMthPi/pRMYb1l3VTbMBqsUE5uGLQEbrRP2WzhIKDfRnvL9VwMrMfOM
         V7XTAMG3xBD21ymwobDlDV0j60OKgyxZ5dVo+aVXuFa2BsJpTdEo8VX8r9UI5+KJ3OYQ
         5NXjietMB7GpEaVwpvAFTPfVh6Z3gC+v/HioE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758394743; x=1758999543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6m2W5nx71xMSXVxU+RpAhVoe4BosDpZBLlHtgjTWO5c=;
        b=nISMssVkG4uL6TQBP8EQk8DpYCyScxWT4IkAYleWhQF2vSMOFZcVpckvUUH5BCtU28
         GRSZtWkGPAqY03wADwhOqMVE++eF9LWUrqQ2qkz3zLSv2SdUIh9w7Ek/jIcJZeSyv/8j
         5RvwDYuy0Q58qnR2Om8oXleJpiaO1I5eM9wL3vApoL9h3A7N3xc3hRUb+KLlAvfGgG02
         2IKF4wbBz6c3neOctzKEX0Op+SPMJJISISJStqdVXZ8NHVFNaCKCc27grjmAUwEXyK5y
         LMurGYX33UD9/q7FagW27qBuFDs3vbFEqC6/nijIO56Hb1Q/x6E4qUAsCbcDlhdRrk3r
         aQMg==
X-Forwarded-Encrypted: i=1; AJvYcCXSBpH2tfjUp/lU320sAjKPdXngDGf648qTJNIBRv7XTgBsXbuuIpX5pTigninSCu+HRQAQhCaPEMlWKTUzZWDSye+6kqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzknet2CLtv1P6wF3tHwdoZ9CIJ7+hBdHQ1g84bDwArSV3doDfQ
	UhOL6aWkCUZYABAQtut17RYSQ1AurEWHen+dm5qaTU8bTUhSOFEby12GtdKxGe78SoYwfEWh27d
	c69wQGR5vGs12YGvhrlx5g7QvTw1q08IY9ll31Pfh
X-Gm-Gg: ASbGnctMOUXFLpp6n3ynstWa7HQYG+in9OEP/X/NIvVLAYMEqqOQ7KwlohZl9Xi1fV1
	hR1P88C1d/TSLlQsjYX00K+7TwRAohTO6hoFnEQEBjiM/PxLKS8ceDJ0ZP6RUfDi0ZSWRuB4cek
	U8HnY02xA3wqNicYeFuzyS8S7GntB+rbnQJU2tnXkJsJeOhaReMaacqAaHR195lBn6IT5UnafJf
	dwLl+Zw6A6iarMvkaNNwNKbLQESTTmyWpPrsyWE
X-Google-Smtp-Source: AGHT+IEbtUOHoGxmH8+U+ohTvlhZagORiUWDUjw1ZNRWRQtq3uyJEEBBW+146XDI0TEaj7CC0DarjKctgvx9c6CKZAI=
X-Received: by 2002:a05:6808:4f6c:b0:437:b03d:9028 with SMTP id
 5614622812f47-43d6c2d5ea0mr1674830b6e.8.1758394743248; Sat, 20 Sep 2025
 11:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221209160453.3246150-1-jeffxu@google.com> <20221209160453.3246150-7-jeffxu@google.com>
 <CAHC9VhRBMTQvnBdSwMbkOsk9eemYfvCmj9TRgxtMeuex4KLCPA@mail.gmail.com>
 <CALmYWFvrasXnshO01YGWRyC7qKk4o0G88yAgkgjO1YBumF5zeA@mail.gmail.com>
 <CAHC9VhQKsjiGv3Af0iqg_TLNzCvdTaLnhw+BRTF9OEtJg1hX7g@mail.gmail.com> <87o6r5ac2z.fsf@gmail.com>
In-Reply-To: <87o6r5ac2z.fsf@gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Sat, 20 Sep 2025 11:58:51 -0700
X-Gm-Features: AS18NWAgq3wn2Sk2LOUvEfd7d6hzlOiiolow2BKEmFkCuGifdHV5pRX8Z7-PEW0
Message-ID: <CABi2SkUj2WoNpm6repAr0rkmQgFAmfRTYD0k=KcPUXjOd3tvhw@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] mm/memfd: security hook for memfd_create
To: Abhinav Saxena <xandfury@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Jeff Xu <jeffxu@google.com>, skhan@linuxfoundation.org, 
	keescook@chromium.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com, 
	dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, jannh@google.com, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Fan Wu <wufan@kernel.org>, 
	Kees Cook <kees@kernel.org>, "tweek@google.com" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Abhinav

Thanks for reaching out, it is great that you are interested in
Landlock and IPE use cases for executable memfd.

Adding  the latest discussion/status  that I'm aware of, related to
memfd, for reference

- Thi=C3=A9baud Weksteen (In CC)  has patch [1] for a new selinux policy
for memfd_create in [1]
- Micka=C3=ABl Sala=C3=BCn and I  discussed the security hook to block exec=
uting
memfd [2].
- Your recent patch in Landlock [3]

[1] https://lore.kernel.org/all/20250918020434.1612137-1-tweek@google.com/
[2] https://lore.kernel.org/all/20240719.sah7oeY9pha4@digikod.net/
[3] https://lore.kernel.org/all/20250719-memfd-exec-v1-0-0ef7feba5821@gmail=
.com/

Thanks
-Jeff



-Jeff

On Fri, Sep 19, 2025 at 11:10=E2=80=AFPM Abhinav Saxena <xandfury@gmail.com=
> wrote:
>
> Paul Moore <paul@paul-moore.com> writes:
>
> > On Tue, Dec 13, 2022 at 10:00 AM Jeff Xu <jeffxu@google.com> wrote:
> >> On Fri, Dec 9, 2022 at 10:29 AM Paul Moore <paul@paul-moore.com> wrote=
:
> >> > On Fri, Dec 9, 2022 at 11:05 AM <jeffxu@chromium.org> wrote:
> >> > >
> >> > > From: Jeff Xu <jeffxu@google.com>
> >> > >
> >> > > The new security_memfd_create allows lsm to check flags of
> >> > > memfd_create.
> >> > >
> >> > > The security by default system (such as chromeos) can use this
> >> > > to implement system wide lsm to allow only non-executable memfd
> >> > > being created.
> >> > >
> >> > > Signed-off-by: Jeff Xu <jeffxu@google.com>
> >> > > Reported-by: kernel test robot <lkp@intel.com>
> >> > > =E2=80=94
> >> > >  include/linux/lsm_hook_defs.h | 1 +
> >> > >  include/linux/lsm_hooks.h     | 4 ++++
> >> > >  include/linux/security.h      | 6 ++++++
> >> > >  mm/memfd.c                    | 5 +++++
> >> > >  security/security.c           | 5 +++++
> >> > >  5 files changed, 21 insertions(+)
> >> >
> >> > We typically require at least one in-tree LSM implementation to
> >> > accompany a new LSM hook.  Beyond simply providing proof that the ho=
ok
> >> > has value, it helps provide a functional example both for reviewers =
as
> >> > well as future LSM implementations.  Also, while the BPF LSM is
> >> > definitely =E2=80=9Cin-tree=E2=80=9D, its nature is such that the ac=
tual
> >> > implementation lives out-of-tree; something like SELinux, AppArmor,
> >> > Smack, etc. are much more desirable from an in-tree example
> >> > perspective.
> >>
> >> Thanks for the comments.
> >> Would that be OK if I add a new LSM in the kernel  to block executable
> >> memfd creation ?
> >
> > If you would be proposing the LSM only to meet the requirement of
> > providing an in-tree LSM example, no that would definitely *not* be
> > okay.
> >
> > Proposing a new LSM involves documenting a meaningful security model,
> > implementing it, developing tests, going through a (likely multi-step)
> > review process, and finally accepting the long term maintenance
> > responsibilities of this new LSM.  If you are proposing a new LSM
> > because you feel the current LSMs do not provide a security model
> > which meets your needs, then yes, proposing a new LSM might be a good
> > idea.  However, if you are proposing a new LSM because you don=E2=80=99=
t want
> > to learn how to add a new hook to an existing LSM, then I suspect you
> > are misguided/misinformed with the amount of work involved in
> > submitting a new LSM.
> >
> >> Alternatively,  it might be possible to add this into SELinux or
> >> landlock, it will be a larger change.
> >
> > It will be a much smaller change than submitting a new LSM, and it
> > would have infinitely more value to the community than a throw-away
> > LSM where the only use-case is getting your code merged upstream.
>
> Hi Paul/everyone!
>
> I am not sure what is the latest here. But it seems both landlock[1] and
> IPE[2] have a use case for memfd_create(2) LSM hook.
>
> I would be happy to work on the use case for such a hook for landlock.
>
> CC=E2=80=99ing maintainers for both LSMs.
>
> -Abhinav
>
> [1] - <https://lore.kernel.org/all/20250719-memfd-exec-v1-0-0ef7feba5821@=
gmail.com/>
> [2] - <https://lore.kernel.org/linux-security-module/20250129203932.22165=
-1-wufan@kernel.org/>
