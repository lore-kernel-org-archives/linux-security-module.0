Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6C81BB6B6
	for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614350; cv=none; b=olDtsNf/KomX5wYAO5MBDWSlEkWz/qhZ6IqepQyGXT4rivW0gCX8IYQVbjWpmThL5oLeiy5/56iEwfaaw5wYKj8B1rHNmGQkWPgejxFKCu+4wRvRPL8G3PO+F7WHYoTPkdzjSznHzDl5byGUb5UUUwHXHbSa1Qnsq70XOMDLPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614350; c=relaxed/simple;
	bh=x/EpTFWcpafdx4yQZpuOCX0QNjRr/XNDp+88mspQTb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyrCkWqMoVMwVxpAouzcx787i68J5GsFDrFl9XChscVjlTWmyXB1n82h4nrNi8yE/RuE6nHghgfoCtr2WzcuUWr5mWvBkx9+yKwg1f6OmEB/uLG6NaSAKatkMzgsY7XKxhEUKrxtJZn7uVyLUdz6YeZ/5oR9VTN3diuXoEgiPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Sm/BRd7m; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Sm/BRd7m"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso5477304276.3
        for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 09:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729614346; x=1730219146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FcFULehhwAxlgpbjAQH5GvQbdOX1Yt9+//ukehIaF4=;
        b=Sm/BRd7mkh6HX69sr8olD+37sceM+80v6PrS5EcixOUU4a2KrTmJLi8DNJWSaQbDrz
         s/qt43XcXrFCV1qws3+Me8WMWnv38bMJDU5osONzZSMte+FicqIxbDlgZuj8wG8P+ow9
         b7I3Gjg9B5548gxue+hXFQ1TE1hNJ0f3YlSKG1A/K0InLhxyJ47C3oMertlGIipoiHK0
         FB5Yqk/upwwqdyQIbYwLr/UzzzJ9f47VMYFd8PRHjqkVxzNg1/PbbILBtXNcdht7xLsO
         RX3l04zioRt8zZa4MhTRybqfw6l92WMtcvRGBFSYb3jHfTQETBw//8qDBeqv2hv6M7bZ
         c3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614346; x=1730219146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FcFULehhwAxlgpbjAQH5GvQbdOX1Yt9+//ukehIaF4=;
        b=W3u6BLjBoArhnwKThugfLtir23fV7tTtOQCr9Lbc7pA56V5iULnz8AHjYcFJ1o7qdt
         MhOGEreRLNn2jK7iCCctvuBhKca0dMN5c7CwKXI1tga7oscR7TGiAcEZfxlu7l2+04+N
         dmH+jgkWYYo3NxYnDBnGUXkWDBys4CdGDBCehua4xPJeqKwwjE3ddp03vphKM0OX7TcI
         NiVdsWp2kStMB1wCf0IUBk1P/qqgGwBTYOOj+jeEU3THmS3k5DtP4hrbKTCb0En1RsIj
         968fbCPxhyHNdLdIaSECi4Dk7KIDbRbdTTrTESsZa3ZbE47e7t/2Ksfy6XiMdWeJYLLe
         k2cg==
X-Gm-Message-State: AOJu0YzAEX6zQbutmjXjnOeYBbVd6EpkINphUb9QFb+ehJVtRHje0Xuc
	U9ayX3KvIgRqlNuzARMTsAhJxZOybLAmW7i2q6JaZHBiOLpuW9TL5jBFc1kRuAUoR+CiEAkT6gX
	BUJSX2VA6EQ7As8u9efmczqFENJ+1KYiqZOCP
X-Google-Smtp-Source: AGHT+IHmXg9dtHAkm/7oEMwvTrSAmrcx0Tkk5Vpql4w7fIuSXGrdcLHvVQoR+ZoH/iPhezQ76TFTXoN23QB1mIW32CM=
X-Received: by 2002:a05:6902:2603:b0:e29:2ab7:6c03 with SMTP id
 3f1490d57ef6-e2e271bb480mr2927136276.33.1729614346507; Tue, 22 Oct 2024
 09:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014151450.73674-2-casey@schaufler-ca.com>
 <dad74779768e7c00d2a3c9bf8c60045d@paul-moore.com> <bab1de2e-0205-40dd-af3e-5956ff349948@schaufler-ca.com>
In-Reply-To: <bab1de2e-0205-40dd-af3e-5956ff349948@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Oct 2024 12:25:35 -0400
Message-ID: <CAHC9VhQ0mBKz-y33+xV-de+hjA-wMbcv9+VmBXWiPjk5Ygz2eQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] LSM: Ensure the correct LSM context releaser
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	linux-integrity@vger.kernel.org, netdev@vger.kernel.org, 
	audit@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 7:58=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 10/21/2024 4:39 PM, Paul Moore wrote:
> > On Oct 14, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Add a new lsm_context data structure to hold all the information about=
 a
> >> "security context", including the string, its size and which LSM alloc=
ated
> >> the string. The allocation information is necessary because LSMs have
> >> different policies regarding the lifecycle of these strings. SELinux
> >> allocates and destroys them on each use, whereas Smack provides a poin=
ter
> >> to an entry in a list that never goes away.
> >>
> >> Update security_release_secctx() to use the lsm_context instead of a
> >> (char *, len) pair. Change its callers to do likewise.  The LSMs
> >> supporting this hook have had comments added to remind the developer
> >> that there is more work to be done.
> >>
> >> The BPF security module provides all LSM hooks. While there has yet to
> >> be a known instance of a BPF configuration that uses security contexts=
,
> >> the possibility is real. In the existing implementation there is
> >> potential for multiple frees in that case.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> Cc: linux-integrity@vger.kernel.org
> >> Cc: netdev@vger.kernel.org
> >> Cc: audit@vger.kernel.org
> >> Cc: netfilter-devel@vger.kernel.org
> >> To: Pablo Neira Ayuso <pablo@netfilter.org>
> >> Cc: linux-nfs@vger.kernel.org
> >> Cc: Todd Kjos <tkjos@google.com>
> >> Reviewed-by: Serge Hallyn <sergeh@kernel.org>
> >> ---
> >>  drivers/android/binder.c                | 24 ++++++-------
> >>  fs/ceph/xattr.c                         |  6 +++-
> >>  fs/nfs/nfs4proc.c                       |  8 +++--
> >>  fs/nfsd/nfs4xdr.c                       |  8 +++--
> >>  include/linux/lsm_hook_defs.h           |  2 +-
> >>  include/linux/security.h                | 35 +++++++++++++++++--
> >>  include/net/scm.h                       | 11 +++---
> >>  kernel/audit.c                          | 30 ++++++++---------
> >>  kernel/auditsc.c                        | 23 +++++++------
> >>  net/ipv4/ip_sockglue.c                  | 10 +++---
> >>  net/netfilter/nf_conntrack_netlink.c    | 10 +++---
> >>  net/netfilter/nf_conntrack_standalone.c |  9 +++--
> >>  net/netfilter/nfnetlink_queue.c         | 13 ++++---
> >>  net/netlabel/netlabel_unlabeled.c       | 45 +++++++++++-------------=
-
> >>  net/netlabel/netlabel_user.c            | 11 +++---
> >>  security/apparmor/include/secid.h       |  2 +-
> >>  security/apparmor/secid.c               | 11 ++++--
> >>  security/security.c                     |  8 ++---
> >>  security/selinux/hooks.c                | 11 ++++--
> >>  19 files changed, 167 insertions(+), 110 deletions(-)
> > ..
> >
> >> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel=
_unlabeled.c
> >> index 1bc2d0890a9f..8303bbcfc543 100644
> >> --- a/net/netlabel/netlabel_unlabeled.c
> >> +++ b/net/netlabel/netlabel_unlabeled.c
> >> @@ -1127,14 +1122,14 @@ static int netlbl_unlabel_staticlist_gen(u32 c=
md,
> >>              secid =3D addr6->secid;
> >>      }
> >>
> >> -    ret_val =3D security_secid_to_secctx(secid, &secctx, &secctx_len)=
;
> >> +    ret_val =3D security_secid_to_secctx(secid, &ctx.context, &ctx.le=
n);
> >>      if (ret_val !=3D 0)
> >>              goto list_cb_failure;
> >>      ret_val =3D nla_put(cb_arg->skb,
> >>                        NLBL_UNLABEL_A_SECCTX,
> >> -                      secctx_len,
> >> -                      secctx);
> >> -    security_release_secctx(secctx, secctx_len);
> >> +                      ctx.len,
> >> +                      ctx.context);
> > Nitpicky alignment issue; please keep the arguments aligned as they
> > are currently.
>
> Not a problem, although it looks like it's correct to me. I'll check to m=
ake sure.

Thanks.  It's likely just an oddity due to tabs rendering a bit odd in
the diff, I usually check that but maybe I didn't/forgot here.  Not a
major problem either way, I only mentioned it because I was commenting
on other patches in the series.

--=20
paul-moore.com
