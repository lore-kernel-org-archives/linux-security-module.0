Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA5D4437A
	for <linux-security-module@vger.kernel.org>; Thu,  7 Aug 2025 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754527233; cv=none; b=SF0NTXDZNL6qwiftXU6d2SML6Io8/O7hUYWOHMh9yyJ0yBWzYW3fD3jlOTxYRFopxI153WCPs3jwp7D5WMnt+pl/CLko1yGiQFFQtFtKCIlKB4+bxOfyzN12HEjN8lSquej8wj6I3sWT1vBGR5QB2Svvv2Zjx32Ycflc2FbpyIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754527233; c=relaxed/simple;
	bh=4ROGn0oDBTpKlpqUDQ7SoxAMekMiIPw98eYIg1yddKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L22iJyby5W0HS2O+YV32/mP2txCsngLHCsQKNGI+pQGZYyAxmSAkO/WIRnjAg8KIunZ/bTzPvHDW7+4naxPFseWbYkptXGEHR0wiB4vGX38d/nc+zbyF5VEZSDrGBrCGzpbrEo15vAPaAWEXVFW0hgp/Ne3tV9u//mHHtv4tnK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XTvr/1Nf; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XTvr/1Nf"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31f017262d9so469066a91.1
        for <linux-security-module@vger.kernel.org>; Wed, 06 Aug 2025 17:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754527230; x=1755132030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIDyGCS8xHCqOVsUnrlcD2L9UqKff5ovQLVxd1rVf3o=;
        b=XTvr/1NfCqxCMX2tnzmrsliBg1YYfwSu0OFXOvaa1bL/MNLp7DfJkGLcPzsCeSwvdh
         sBxcDprCAO0KpmOzLs8W6VDElDESKQGx5GDroGKMmMwfizNpmppzYZGSWSo6Wik6c3Do
         j5UhJxYPjzeMs8Ceu5mJ6Cs0OSpCG028I6eLNDBm3pJMDUyATykNHEr4WrL9vqfYZaCm
         XCfV4wZYnI/j/4WWq255W4xU713AZShI7ksvzjBgk9zHnkWuu0M/7WgrBZXtazVoyUGm
         0HTbWV2wpFuQ4Syy1dagVi9Oex+YoNc38V8sWycmw5N2MPhWe6wmM9g3tEEwAyCbhqfJ
         bMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754527230; x=1755132030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIDyGCS8xHCqOVsUnrlcD2L9UqKff5ovQLVxd1rVf3o=;
        b=JofyIp+QmtP5nPvpPHQHEgsG/Woi/YONNqqeTHVOuca0Vny9iMp4N/cQ1P0XNhIBe1
         B1nupO48alANQnE7jnCJaFMrH4x4YeNzp9fesTNcAweqX1FDz8kILc89nfqPXdGw6cIU
         ZmRq91qIDOdhdNZ7rgDcpoy+LElROA9WC6lYdJ8HeKOiz5lSziv4nVnCJsleWTHQ4OTR
         MpW06JiKmJENuCtsJleY/hLphR5qFtnYoCqWTLHi+0uPCsRN+JS7qR8shu7iZodfuEkq
         McuUc4e2NsTrmsfkRTkF/oPdZnEXv0gp/qI2WRFb2DIeKh40KR8BYbD/oC8irdWxsDpk
         WWYw==
X-Forwarded-Encrypted: i=1; AJvYcCWVeBVYv4yLsIt+xlwdJ4xAAB3IhoheYtIc0BdSPQ/7t+xdWohHtOjaiHQWhqkrWGt1VnBQNvJhCYjU06vH8FbE9k9xvKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2RRRmDsqKAUs23wgL1kYnubDBGZOWQJrWXZcdgs0AibhIKlC
	55ru4O4tTgfdcB3wN/qwTYtETqRcw4ee63VGDKcrL5FOw7l/dCa97K2XYxK/s93F8rMxeuHdmmA
	dX+4h4P3gDA3wM3tDEoPzGVWWQt3WnaJJ8PvG2FqL
X-Gm-Gg: ASbGnctWeVYiMTc178DccVyVUpf2nSYem00pf2PownMg/bNO8wZhMGA0qjN/Y2q+H7R
	7PKZwh/UbJ4jy1MOg6e5GvS5Ms0zo2mpWyWYWn6YLnsTnXkwwMiy2fNH+oi28A0KKVluFJX+X+X
	FK/ta7fphzKBR9wS3YP+59bboT91hhRSYPtvmSohtssj0qAmxVKOLkqa/ByPqseqY2P6mudcW7G
	iWKn5A=
X-Google-Smtp-Source: AGHT+IGKIO52g5ER47wAOh69fA0MNDX9GHEgLcBiFV6LGJZgbd2j5ZJbEzF9aBT2bGdM7sw8tofF8xwzOBbv0tOHAaI=
X-Received: by 2002:a17:90b:1d43:b0:321:27d5:623e with SMTP id
 98e67ed59e1d1-32166cc8ff0mr5381661a91.23.1754527229849; Wed, 06 Aug 2025
 17:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617210105.17479-3-casey@schaufler-ca.com>
 <f7e03785a79a0ac8f034cd38e263b84f@paul-moore.com> <f3a8cbc4-069f-4ec2-8bb5-708b90360b05@schaufler-ca.com>
In-Reply-To: <f3a8cbc4-069f-4ec2-8bb5-708b90360b05@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 6 Aug 2025 20:40:18 -0400
X-Gm-Features: Ac12FXzzNR0g9jh2zy54Q1qrJNPEp3zGdJnwV4n4YyYgLDuSBPHMhEyzCQhOOus
Message-ID: <CAHC9VhQ29bue6V5=QE6qVUE8zpG3N8yndhtk_JUmt5htTgtQGg@mail.gmail.com>
Subject: Re: [PATCH 2/3] LSM: allocate mnt_opts blobs instead of module
 specific data
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: eparis@redhat.com, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 7:16=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 8/6/2025 3:06 PM, Paul Moore wrote:
> > On Jun 17, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Replace allocations of LSM specific mount data with the
> >> shared mnt_opts blob.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/lsm_hooks.h  |  1 +
> >>  security/security.c        | 12 ++++++++++++
> >>  security/selinux/hooks.c   | 10 +++++++---
> >>  security/smack/smack_lsm.c |  4 ++--
> >>  4 files changed, 22 insertions(+), 5 deletions(-)
> > ..
> >
> >> diff --git a/security/security.c b/security/security.c
> >> index 8a4e0f70e49d..ec61fb7e6492 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -904,6 +904,18 @@ void security_sb_free(struct super_block *sb)
> >>      sb->s_security =3D NULL;
> >>  }
> >>
> >> +/**
> >> + * lsm_mnt_opts_alloc - allocate a mnt_opts blob
> >> + * @priority: memory allocation priority
> >> + *
> >> + * Returns a newly allocated mnt_opts blob or NULL if
> >> + * memory isn't available.
> >> + */
> >> +void *lsm_mnt_opts_alloc(gfp_t priority)
> >> +{
> >> +    return kzalloc(blob_sizes.lbs_mnt_opts, priority);
> >> +}
> > It's probably better to use lsm_blob_alloc() here so we have some
> > allocator consistency.
> >
> > Also, make this private/static as we should just handle the blob
> > allocation in the LSM framework (see below) just like everything else,
> > unless you can explain why the mount options need to be handled
> > differently?
>
> The mount blob is different from the other blobs in that it is
> only used if there are LSM specific mount options. If there aren't
> LSM specific mount options there is no reason to have a blob.
> I know it's not a huge deal, but there is a performance cost in
> allocating a blob that isn't used.
>
> If you'd really rather accept the overhead, I can make the blob
> always allocated. Let me know.

Well, this is happening at mount time, which should already have a
non-trivial amount of overhead (parsing options, doing the filesystem
setup, mount tree addition, etc.) so I'm not sure this will really be
noticeable in practice.  I guess one could also make an argument about
additional memory pressure, but the mount options blob should have a
fairly short lifetime so I don't see that as a significant issue
either.  If one, or both, of these becomes an issue we can look into
ways of mitigating them, but right now I'd just assume keep with the
existing LSM blob allocation pattern to simplify the code and make
life easier.

--=20
paul-moore.com
