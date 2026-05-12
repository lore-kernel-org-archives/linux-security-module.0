Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B83352F86
	for <linux-security-module@vger.kernel.org>; Tue, 12 May 2026 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609255; cv=none; b=Kodcgsp6U0bpYsKZtZR6v2ffO6ZWoMlym8D+mw3kxmpIxnQHDyUGH1gGVVi78dSQYJpjmM7CdJmlm09Hi/v9XlWr0RsLjRfZutdHLzISXwOmfidIc/d8FUcJLMDDpZlSrfNdR9ZDAdH3lSxtgAYxqoO/WG2RtRqO336rjOSBBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609255; c=relaxed/simple;
	bh=1+WG2MzbBw4FYQ+ZqlnfYUFJjE67o+yVompxx5/7iXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0z/2Y8TKmQ9MguCZjRwxX+/9IFIqCipZ/ckspfOXKH/R8YTUhEio5Ec7TQnV0QScfq8DxOjGpALwosc+EfMsCuD5gdD1fEdAIkSFRKSF7m+W4EJLYRo5xsAONGmQamDsrp62cJcJyfygkb6+z3gXJ9+KmwRCgoQ5pRFzAMz4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q10Vsoaz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q10Vsoaz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E402C4AF0B
	for <linux-security-module@vger.kernel.org>; Tue, 12 May 2026 18:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609255;
	bh=1+WG2MzbBw4FYQ+ZqlnfYUFJjE67o+yVompxx5/7iXE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q10VsoazCAWp87x2iZ0pioO0ZNp3E+RmMgpOTCJ0p4rt0r90N+62Xf/ZF+lxgVfof
	 xmqNrRW9oPV+Xye7vLbiQ7Jww7eSp61huQlu6r97VbzB+egiOt6ppCLFtSQ8jukg1u
	 pf+RfcK/k3UfKUMtoteTzpvbyhzsoV3lV/ZGRgKpZ+pJk8dQZrppIpfdDPDxfjkD0u
	 UG6N6kyn/5YcKABsCzTBLfpcNPml1jCG3g4z2ploBrZhLdOUmXi/WNv221gnxS1aEi
	 UxB6uuT9ckY8zPxswOPg2DZr1AhWdze6MxGoZNm2W/pQj8A4hmw9Upbr0imWx1BG1H
	 G9vART2Y8sV5g==
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso76676456d6.0
        for <linux-security-module@vger.kernel.org>; Tue, 12 May 2026 11:07:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/EkZ35bH5BR50NKFRB6P3gSJIK/iLqLePtKdxayVHCz+/eDUMplnFqXyHvq6VdkDZn5Ovb5GZ5OQxWePcFxJLGZvU7vFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwujlE9LQn0/FeyHlkiK9vSCF1YpHdSDkXgg7ueFbaC+X1X+pIR
	nWOJ0GxVg5PKjsTU5n7fGCkdqdMRIr8jnCO9UYdKvuqE4dmXM4kyP12seJZxgFAArGVbXo6eqqo
	gAEnp1MHseqdsBCPhj1PLM2um9g1Kx4g=
X-Received: by 2002:a05:6214:5981:b0:8c6:2245:3f49 with SMTP id
 6a1803df08f44-8c6632d9dd5mr59505866d6.32.1778609254036; Tue, 12 May 2026
 11:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509015208.3853132-1-song@kernel.org> <20260509015208.3853132-7-song@kernel.org>
 <42a9075e-a4b4-4eb7-b96e-48e5c0cd2f3a@I-love.SAKURA.ne.jp> <CAHC9VhT9vvaoYpRX4fPZ_H13+PaqG72CpRbS+d=9xgMBaKHo8w@mail.gmail.com>
In-Reply-To: <CAHC9VhT9vvaoYpRX4fPZ_H13+PaqG72CpRbS+d=9xgMBaKHo8w@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 12 May 2026 11:07:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6c4kbVmBJ+4=J2WgD8JKv7q_cZqXSE3+EPkWKro0dh1g@mail.gmail.com>
X-Gm-Features: AVHnY4LZp5deom77-xEaW01b2jRxtdWLWeWdvcHJesrle08Ns_ME_r63-071_KQ
Message-ID: <CAPhsuW6c4kbVmBJ+4=J2WgD8JKv7q_cZqXSE3+EPkWKro0dh1g@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] tomoyo: Convert from sb_mount to granular mount hooks
To: Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, john.johansen@canonical.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
	gnoack@google.com, takedakn@nttdata.co.jp, herton@canonical.com, 
	kernel-team@meta.com, selinux@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 6:32=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, May 12, 2026 at 7:03=E2=80=AFAM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > On 2026/05/09 10:52, Song Liu wrote:
> > > Replace tomoyo_sb_mount() with granular mount hooks. Each hook
> > > reconstructs the MS_* flags expected by tomoyo_mount_permission()
> > > using the original flags parameter where available.
> >
> > Please fold below diff into this patch. Then,
> >
> > Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > ---
> >  security/tomoyo/tomoyo.c | 60 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 58 insertions(+), 2 deletions(-)
>
> Thanks Tetsuo.
>
> Song, assuming you have no objections to the comment blocks, please
> fold in Tetsuo's additions in your next version and add his ACK to
> this patch.

Updated 6/7 with these changes. Thanks to both of you!

Song
