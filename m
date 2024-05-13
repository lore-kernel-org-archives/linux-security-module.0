Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B234C74
	for <linux-security-module@vger.kernel.org>; Mon, 13 May 2024 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612292; cv=none; b=vF48Bj0O5/nWFMD55miw1MsVsTxOb8XyXnHQpSUs+I4pRlpdS6T3nzh2jyCwbizr/I6MHwfJS3DKRm/PrhzG2tDj1WzF2JjiAIdZEtt3ggo+JgJ/TvmZhloYwS+vDvayaObBeUNCTgyuLV9nhPH6aZc8PtA0UhstBUKgw6EjGyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612292; c=relaxed/simple;
	bh=j9bZZti+9FQ+7r5shz9bNfaDhSYxfYzTp3+5PA+YT2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhXqnRa6Q49+xy3qpyG7+BzYsXFBvcHRs6laTuvnb4xzTfi4BI51mH0aBfy5YpAThd/ckGq5VKWT0tlRoFz1mmsqCM0EXm+H0UFYoti0h77jvIZZpO/v11hyu0tqbTP1ZXKDyEji1UzbV5fzha1meteE+yBS3ULAZ+8TbqUAtr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MlxoQiCX; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MlxoQiCX"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbed0710c74so3747776276.1
        for <linux-security-module@vger.kernel.org>; Mon, 13 May 2024 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715612288; x=1716217088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M0SyizaRAHUtRPojEicOMbmKA68tXqqO+2+to/w/2k=;
        b=MlxoQiCXSbrfMPXkGp2CySc5KaQkGq4Lb35ptU6hanGbEN0eefxIMEFmO8kqSY/z31
         1hZSAoZtQLSjl+3E4S3icY0v9aT++r/mSboTlo537FdpEFrEXAuCkI7fYDMwptNvwT8m
         XcI7BmZHgPJAdZQWN0xpyRG6Yae44SqlOS1OhzXaO/vZ/XYjQ83q7fmCfowOP4TwC2EN
         38aCZX2r1aAwtdqGpUWpqu3fPBUWxku4JHE2zoIyCb4Mrn04fVauh8/OOoflfoOEkrwS
         VO+KKuN+QhvyJgAb5E5e1ki7klFsPz3CE2rs6b+i3hvQCZ8McPk1UgJtWIrniTkBicDv
         7J1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612288; x=1716217088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7M0SyizaRAHUtRPojEicOMbmKA68tXqqO+2+to/w/2k=;
        b=EGf6+e+kmRsgHRjLvC+nE9ziePAh7QXoK3uY4l0j9irsMbMvECrGnHarx+anxn1+Px
         +cVWm8RuWOEJmtEo9RANdLRn99qyWA6TU2M+muzgeHGY2VrUumKJBObOcRholJeYK5ZA
         nV16AkPpu67FjJpe71g/osGjQJmeBE6pcgzMR3miavamCDdkpXj2RUSqhR4NPzOxuZnt
         7+IBkM/wqR/P+ccJp5JMCpdDOP8hRPSBcw4L1s7sdcxiqEkf0PbvS7bw7TNKogAKLvZt
         bZiW/SD8hB0B6yN4AVMUnFhjom0HXgNebUr785HO8V6vcoepXCtz8tBd9F6aFonyRaas
         Bwkw==
X-Forwarded-Encrypted: i=1; AJvYcCWgRRwtfjMHbvoglZukMPaulFIvFLwltNyTFtxdGUZdCr0GsoU2AIiqD2g64iJDu+lnmkd72O6LgvqwehPSArYC77ZppjhyfptHrAWrj+s28BI5a91H
X-Gm-Message-State: AOJu0YxhkUk0g5BKJLg2IMW5ow0PV4of4oawTUjSKU6qksFNRSQqP/Xm
	M8qQXOSedG1RgakZyGAVOp0eCzO/+cM4zUdEEqVbIOqk3VlkbdYYQBGU53MgWQHR2sVju/g2ELX
	W80aNEd1tsEbTc9azkhooZoJCxlVk3X6g/OeLzoeOpFchU70=
X-Google-Smtp-Source: AGHT+IHDwN+8pFFHqgzAJfSHa/ND4FCnNNX1ClwsHGCc0PzWIetjNmGPFOImdjRGWe9tJ4iyY/v+WvT8iIXTHbiGQJ4=
X-Received: by 2002:a25:53c7:0:b0:de5:5b9c:4452 with SMTP id
 3f1490d57ef6-dee4f319277mr8718086276.21.1715612288420; Mon, 13 May 2024
 07:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223190546.3329966-2-mic@digikod.net>
 <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com>
 <CAHC9VhTUux1j9awg8pBhHv_4-ZZH0_txnEp5jQuiRpAcZy79uQ@mail.gmail.com>
 <CAHC9VhQHpZZDOoPcCqRQJeDc_DOh8XGvhFF3M2wZse4ygCXZJA@mail.gmail.com> <147b0637-7423-4abc-b7fe-3d8da2c1e57c@canonical.com>
In-Reply-To: <147b0637-7423-4abc-b7fe-3d8da2c1e57c@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 May 2024 10:57:57 -0400
Message-ID: <CAHC9VhRbHKkdtAC4JWFbWpj=T3MG7wPhH1EHhJomKu+pU6oCQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
To: John Johansen <john.johansen@canonical.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:10=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
> On 2/27/24 08:01, Paul Moore wrote:
> > On Mon, Feb 26, 2024 at 2:59=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >> On Fri, Feb 23, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>> On Fri, Feb 23, 2024 at 2:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic=
@digikod.net> wrote:
> >>>>
> >>>> aa_getprocattr() may not initialize the value's pointer in some case=
.
> >>>> As for proc_pid_attr_read(), initialize this pointer to NULL in
> >>>> apparmor_getselfattr() to avoid an UAF in the kfree() call.
> >>>>
> >>>> Cc: Casey Schaufler <casey@schaufler-ca.com>
> >>>> Cc: John Johansen <john.johansen@canonical.com>
> >>>> Cc: Paul Moore <paul@paul-moore.com>
> >>>> Cc: stable@vger.kernel.org
> >>>> Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
> >>>> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> >>>> ---
> >>>>   security/apparmor/lsm.c | 2 +-
> >>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> If you like John, I can send this up to Linus with the related SELinu=
x
> >>> fix, I would just need an ACK from you.
> >>
> >> Reviewed-by: Paul Moore <paul@paul-moore.com>
> >>
> >> This patch looks good to me, and while we've still got at least two
> >> (maybe three?) more weeks before v6.8 is tagged, I think it would be
> >> good to get this up to Linus ASAP.  I'll hold off for another day, but
> >> if we don't see any comment from John I'll go ahead and merge this and
> >> send it up to Linus with the SELinux fix; I'm sure John wouldn't be
> >> happy if v6.8 went out the door without this fix.
> >
> > I just merged this into lsm/stable-6.8 and once the automated
> > build/test has done it's thing and come back clean I'll send this,
> > along with the associated SELinux fix, up to Linus.  Thanks all.
> >
> > John, if this commit is problematic please let me know and I'll send a
> > fix or a revert.
>
> sorry, I am still trying to dig out of my backlog. This is good, you can
> certainly have my ACK, I know its already in tree so no point in adding
> it there but wanted to just make sure its on list

No worries, reviews are still appreciated; just because a patch has
made its way up to Linus is no guarantee there isn't something wrong
with it ;)

--=20
paul-moore.com
