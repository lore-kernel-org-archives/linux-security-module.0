Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822226FA7B
	for <linux-security-module@vger.kernel.org>; Fri, 11 Apr 2025 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334520; cv=none; b=PHVL5QkHFXHxK6uvdRObg/BwsIRv+UI60054b12JNokvQpBIhpEdk2s4XHoKobrKYuUdJN747war2cnAkvVdvS8lDdMQ+b1cyCODGgs+tsaR8gp1gURSK/9C+rx+VhFRNNXJ3LOndMovqpkTvaFyK9lxxafAGCRYjl/9SdkpPnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334520; c=relaxed/simple;
	bh=0W34x8Ck2m4q/Qa+lzOYSRJAJBcw975BtQwXfNHZXj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xmwe/eZOmfVxfAhYXySKPapsAvpjy7qybxCVIABBb/Z0nfnGKocDUE/XdXNxSE4pN87r+CX42iaiWPT5m65iETIps1ALeetpHiMxK7Bv7UNnuvtmRkENM/oGWD4qFod9RvVr1QL2rShCi6YLVJxPVlgMvltXzNh5GcQe0T1PNf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ShCFN5lc; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ShCFN5lc"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e637edaa652so1128269276.1
        for <linux-security-module@vger.kernel.org>; Thu, 10 Apr 2025 18:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744334517; x=1744939317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDZj3yQ14A5xcIpe7c0DSs5qSG0Hnq5KDdt6cHHAOgY=;
        b=ShCFN5lcBIMD2qx87n80CsrOt1TElZUZ/3xNWFNSnMM5cqtnoJe077KRiCZb52IrlK
         zJi9mQToaJa6+MV1qUj9XtDfrv2wYtKWjgj3DPUmOalhR6t+On0UG9dL+rKLx5unhpLI
         6HPvtfdmARbLxfdux3fGN50TB2+w1T8TvggoVzcadtAkk1UvpqMQkKTeiHsW/vrbu9Pi
         IyKM165CYs2uku3Arc9FJSNJqLVeSHOPra+JgSmziW6UG7M2ZpgfIv37Pcgf04uMVbb0
         9qxHDz0/jaoZqz1fbxNH8TKC88iZwyBYCr4X8/q8uDmEZQm/HsnQXACGVIU+NOm3mG6d
         zufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744334517; x=1744939317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDZj3yQ14A5xcIpe7c0DSs5qSG0Hnq5KDdt6cHHAOgY=;
        b=H3GJrN1uf5GmbhVZAsOizAfE13LBS43CeuIJugqC4ZjoIwh57E9j886y6a3/68nrbw
         G/Y7YBSEihkbZ2P0seToHU04xUQd3ijk5MK+yY62fEiurkoIb/xUQ+9UIGxGLYxnKxxx
         uWcIqTqn4EB/nXlal+tbvpJhJIn4vzUAB77OXl8qjb019+iuScZQllifTLswHHlOLt3E
         ZWrRzo68zp83lbNnndr0aUHAQQV4/lQhRa6pzXITpVqsVLyX8IkhAt8cM1K8U5cNuRJ7
         krH8boz0yw5wVhPxoWT6oE8AFX8F3qvB0DcnZLFt4l/gsK7jq2515NL68UXwjGlMJ7aX
         F0pw==
X-Gm-Message-State: AOJu0YxhSbZSp0EYiKgFCF/8MyCXZTOMN1za3p+kilKzkiqnqdvXzx/X
	jQJcGNyEwgAEcbwgZzBGyzQTNgW6aviq2xFCam1EKM+AtNKScJNe5Beqocpkq0UVEvKnXy2Bb/J
	CQk2wdkfcja9Vft0oM/dp7z7jnN8/f/8yFKWu
X-Gm-Gg: ASbGncvsmG2DcJ9+qrt9ryQLJqcQCc7RzITWY7mul9jsh4s3cQRzUfxtqGxAiDGMeFt
	ltZnjXhF7gzTrFzHWsar2L4flnA1q8txwZTBD8GingdmUWO7QqI5ZDOwmdtXEN0bxD83aIdqbpx
	RlO2uI3mvf/jBlfDg9UOMcDw==
X-Google-Smtp-Source: AGHT+IG7WXGp7fnjjFYKUmfliUjJExX03/TYU/y9D8duxhk/OQGZU8sKLSMddfn2XvWf/re46nHpnP9HIJ7dpJxGopo=
X-Received: by 2002:a05:6902:91a:b0:e5a:b05e:4da8 with SMTP id
 3f1490d57ef6-e704e025162mr1839801276.42.1744334517198; Thu, 10 Apr 2025
 18:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-58-paul@paul-moore.com>
 <202504091649.E30A1670@keescook>
In-Reply-To: <202504091649.E30A1670@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 21:21:46 -0400
X-Gm-Features: ATxdqUFV6nml9Pgs1tXUY-RKXULr_XkSZF2rF4yd2I4HaYI1g1tN1bIqwvmlvGI
Message-ID: <CAHC9VhSFGfEJ1-f48hdBMgrXwCMcqxi22ze5WZz1N_yPuFdriQ@mail.gmail.com>
Subject: Re: [RFC PATCH 27/29] lsm: consolidate all of the LSM framework initcalls
To: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 7:52=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Apr 09, 2025 at 02:50:12PM -0400, Paul Moore wrote:
> > The LSM framework itself registers a small number of initcalls, this
> > patch converts these initcalls into the new initcall mechanism.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/inode.c    |  3 +--
> >  security/lsm.h      |  4 ++++
> >  security/lsm_init.c | 14 ++++++++++++--
> >  security/min_addr.c |  5 +++--
> >  4 files changed, 20 insertions(+), 6 deletions(-)

...

> > @@ -503,7 +508,12 @@ early_initcall(security_initcall_early);
> >   */
> >  static int __init security_initcall_core(void)
> >  {
> > -     return lsm_initcall(core);
> > +     int rc_sfs, rc_lsm;
> > +
> > +     rc_sfs =3D securityfs_init();
> > +     rc_lsm =3D lsm_initcall(core);
> > +
> > +     return (rc_sfs ? rc_sfs : rc_lsm);
> >  }
> >  core_initcall(security_initcall_core);
>
> Hrm. Given these aren't really _lsm_ hooks, maybe just leave this out. I
> worry about confusing the lsm inits with the lsm subsystem's core inits.

I'm not too concerned about that, and I do prefer it this way.

> Or we need a new stacking type for "required"? But that seems ... heavy.

So I understand the motivation behind that, but that's a big hard "no"
from me at this point in time ;)

--=20
paul-moore.com
