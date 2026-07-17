Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C373A75A7
	for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784332375; cv=pass; b=bFCUgEiL2dE5tb6ifBQEGcBBjqGbEFBe/HMWg0DNdcsFLqVoNSSqjGv8gcpPC3cIVptfOR8piJzvPX0LJepqR/BJBBCvNl6Y6BH7CuajdJgnI/ROf1I7belGHqxLXbEIEGb04RhJqxYysT/oo1tYEQGkkxJGiXYBfjR+faNDH0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784332375; c=relaxed/simple;
	bh=fhNycunKakejbYvgMWcv2sbRp6+FJWb96YEmNcHIZ+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNkAHJHXEmX4VYKV9qqDjqxV7Ppiuj61zP0N2ufvkjs7tGrkFrZB2lxu/M6OtZcFfpVZao2+wdQMKRVH09PIazWeTHjVRBQgIqDiH4ZZWERCtfYUxw9xk7Vo9H/M79I0BeTQkE6J7d0PcahaRcltehD4LcBZHWGMy/0TwKo4PyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=dnNuS/TM; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="dnNuS/TM"
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 920013F845
	for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 23:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784332364;
	bh=dAA4vimtJ4swx7QMOmJPxI4fZFO19KBHay6EGhYXgpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=dnNuS/TMZjhyE+H79q4YKXFpR8qPyzYyAYtZQDS82N1ubdjH1i3hCp5jnsVC68CyZ
	 fVsSH3MUhXRbpHmZO79tZatbk6zgsZBYzVUczI6WjA+PIMqrjV816DqQcrfaYoxqD0
	 AFAZ/VbwikTEVIQTxpSIFu3JBdYNOsfCsr1dlBWjJDVhek3Cys98RnHJQWMVIzPbxG
	 wXibRX4+m/anWXCM1uz603/x3Ti8UmUtJL1n/W7d5+hs5g6Obp48mPBjeLvyb/h7AX
	 QyVxUWTDWYrS2NGiTGXCWFoYClCvzdm2JDRMGRFl3XiA8jfOZNWx+TYc6Z11WWsN3h
	 n+c41A2n73klqcITPAN40ukMVgOm2q9d+M/9dqJ6wR+X97QLTj6l7iswyznLAVt/hq
	 ae4poZo1rVxXzahakWWfQ0xBsJkn5ElPp/5eJdLhXzeG9nU2jW/OoV9xBNYbmYISyO
	 3PrexqWYu0DpmdsZ6Da0bsbjcopFuMi544qcjag8/3Gd7/6tYwzNrejh1Z0W7wNRcK
	 u51g72+7SoxlJOUqAN6xpp7HKdln+3nWVJTDgbMZIGjsSi+n7Qsim/Wu1DVu9omcNr
	 xkYDKHC1XLNqJMuyyIlRzGxGNEGnaDmAi41MLqf82lYgiwX0jvNCDwoMreXUUFG9Pq
	 4rY4eZnWuAWvaZc+Pmn0kdrA=
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81e8a76a273so63442197b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 16:52:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784332363; cv=none;
        d=google.com; s=arc-20260327;
        b=k8gCmLztfD/CZAY6ymcT6H9enV7jIE7SBdDWZFmWY5xykUu7lru5zb03HjhybJH0u+
         PxletgSoKFn+8p0w9ifNCp8gMnEn43Lc8nRbx7XddD6l4UfKzjUE12tcZmhUqKPj8BRa
         +u0oCoMQ17SdLQ0Gt5/6bZbCvaNq0HiL3Io+onV5Qru8Yf5eXbxQtuc7vGGWndTxzJ10
         omFdv7O7Is/21OPHBjTowhLkPFc/g2ykWhatimm85IL5jnBry2J1c9HryzK3faQQ9nlp
         nWb+Bi6YZdM716fE5muPYx7DItLDkXAkwRlT5B2KIVeLnpjr7WsvcmGnptu6KGpgf3pA
         yLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=dAA4vimtJ4swx7QMOmJPxI4fZFO19KBHay6EGhYXgpU=;
        fh=Xa4OztFbSVzZHf54EzC6iUHbTS6KIKZfKVKngA2EXeo=;
        b=lo6oXmuLN3jGLzN6YLaJCsXkwD3qkBTBfKcHeF9ibC0PQmjyA8R55jl0Png3lkdFoq
         /QuXdfc/3VVFvfp504PxGkZawt0R3V+OwP9/jjatSPpuM2GxHWzQrDtG+oeMuI4nuC1f
         Der778Tbc7mLlkx3vfIKAoUvT1mlygkV6xKJWarwu1wSXcRCHe8S+c7ajV+d+HyePVJs
         B3ss2vVa2SRwg6URMPD9HENybgagSgPZ018EENgD+DKV4c3+SMyOdOmDR+Lyiji/IgcW
         VbHCRQL5Na0tnswD4I4gV/1aKLuE7gB95kUVYco+AWUk3pS8zC+vTpcEO8ypStyjuyqH
         iaUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784332363; x=1784937163;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dAA4vimtJ4swx7QMOmJPxI4fZFO19KBHay6EGhYXgpU=;
        b=JY9cbmO4i7wJiqPxbLxYRO7p0bsEcHvjo4Dq5RQZh7T1KhxK+yfDokMH1nK9362Gbx
         +l0PcNz51YUMtOLNKdrgz2FHslco+yHaeSNeFmkdTKvuAxH1lgB7aTdXAkprnHo1jvMV
         pHlG1Uuzifmudvur1AGjOKc7egMYNhSgzkb4/lT+OgGTdKz9QKH1z2ITiEUL26Kt5rgx
         noKuR+IEfl3AsPtttZcazPGkKieee5JUbfAJjyNNMXmGlV8a2X1FY3AqkwToPKJs71/o
         SbuTQ1ssAa2VTsov8swBSVTEReeFV2lS40JiAtEv7d93Mzf1BSIxRwszTu1GUGNFDh3c
         xzuw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4Xt8VC9PTysFp+ieLiL+yXtTAGMZDYg3G26m/Hjj2JXfR8eNLDBcjLpzYK9kAdvRbDnL+Orl3rcFsCFU27IT2L1T0IHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHS8yySD3M0zzJgB54te1QP5q/+hH1zJbmwmZng7ViYZkJ4VoX
	AOfPGbK5AEkYIDKx+Tv7+3gRwyHWE9r4Uo/+0SieSwYjqro+OEVZBYhRxwJp+CkXH/hoHUStIcO
	vx5CQDzgYo2knZcpzdNSSghOsS6f/cJvLzbQB2VxcFhgFAtytwh291E74bH/kjmGaOueeMHBHnj
	RqyGfCRlE4N+IOKEcQZubs8X6Ha8vTy2NlyUvirR/g0sTCgt0uXmWmjLVp4iEAN5FlQtKkdP+HB
	Y+7
X-Gm-Gg: AfdE7ckEtf/xzZS2EfTvwKahYxYi8YME2O+67tZyqfDjczxCYX/teRFTYVX6NxatlvS
	Pqnllz/fXeUYqO8BTxt1YSXH0tUTii5fXdGWl3suvG43FUdntdvkjZL6aqAItwQ/ZLEwaq9cRik
	3f+TIdHZOlnJFkdmJ6/T+eDUluRkaQqMdjnFdxnYGoZiBlKNkXBx6HIi7/HUj2ux/JQqEGYNqDU
	3ruwvtVDq/d/9+Gas12o9a9EwDHzByf3EJxiqEux/ds
X-Received: by 2002:a05:690c:62c7:b0:81c:eca8:b31f with SMTP id 00721157ae682-81ef2671c5bmr14806837b3.39.1784332363305;
        Fri, 17 Jul 2026 16:52:43 -0700 (PDT)
X-Received: by 2002:a05:690c:62c7:b0:81c:eca8:b31f with SMTP id
 00721157ae682-81ef2671c5bmr14806707b3.39.1784332362948; Fri, 17 Jul 2026
 16:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717215254.383183-2-paul@paul-moore.com> <CAHC9VhRcJGj3Pnrpmpi0uRi3ndcMVGGQorsU4dJ-vA_uQmRuQA@mail.gmail.com>
 <CAHC9VhQNthghRo8S-w8BQhe46ur8vhUyzW+xkOngAJQUb6O-Ug@mail.gmail.com>
In-Reply-To: <CAHC9VhQNthghRo8S-w8BQhe46ur8vhUyzW+xkOngAJQUb6O-Ug@mail.gmail.com>
From: Ryan Lee <ryan.lee@canonical.com>
Date: Fri, 17 Jul 2026 16:52:31 -0700
X-Gm-Features: AUfX_mxqZ2iCa17NgmOjYK5lufA2OKZq_-sPnDXPRFpzv9PWUrlaHjWDkTIt3hg
Message-ID: <CAKCV-6u-jAoQgghXrp828JLRLvoSyTp_OcPyGQNDHM6FYn8DOA@mail.gmail.com>
Subject: Re: [PATCH] apparmor: leverage audit_log_n_untrustedstring() when possible
To: Paul Moore <paul@paul-moore.com>
Cc: Georgia Garcia <georgia.garcia@canonical.com>, 
	John Johansen <john.johansen@canonical.com>, linux-security-module@vger.kernel.org, 
	apparmor <apparmor@lists.ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 2:58=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Jul 17, 2026 at 5:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Jul 17, 2026 at 5:52=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > Make use of the audit_log_n_untrustedstring() function to simplify th=
e
> > > code in aa_label_xaudit().
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  security/apparmor/label.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > Untested beyond a basic compile, but I noticed this while looking at
> > something else (unrelated) and wanted to send it to the list before I
> > forgot about it ...
>
> My apologies Georgia, I thought I had copied your email into the
> original posting but it appears I copied John's email twice into my
> posting script (which helpfully de-duped it).
>
> Sorry about that.
>
> > > diff --git a/security/apparmor/label.c b/security/apparmor/label.c
> > > index 3fd384d8c41a..a165cadf8249 100644
> > > --- a/security/apparmor/label.c
> > > +++ b/security/apparmor/label.c
> > > @@ -1743,10 +1743,7 @@ void aa_label_xaudit(struct audit_buffer *ab, =
struct aa_ns *ns,
> > >                 str =3D (char *) label->hname;
> > >                 len =3D strlen(str);
> > >         }
> > > -       if (audit_string_contains_control(str, len))
> > > -               audit_log_n_hex(ab, str, len);
> > > -       else
> > > -               audit_log_n_string(ab, str, len);
> > > +       audit_log_n_untrustedstring(ab, str, len);
> > >
> > >         kfree(name);
> > >  }
> > > --
> > > 2.55.0
>
> --
> paul-moore.com
>

Reviewed-By: Ryan Lee <ryan.lee@canonical.com>
