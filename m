Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2CF3DB62A
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845080; cv=pass; b=EeaiV1J6BHM6ZMGFZuPI5Or9xubSwSAFA9LzVNI7PzDJ7ihQvXNJ+x2BFjOSSvmfigZgIePtPE/JYD7irwGI0SC9BY2j2kHdvuIrLUnebTXg7SeOs7b5TqhpiKnBLp3/XAHDGDyAUtDJYYRLhkl2sYOCuUeTde10mKFjzMvn+nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845080; c=relaxed/simple;
	bh=Z4wqF9sWI9YJ+rS20uembpUi4U7sFpRC+JVMwf92TZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOts++pC42HbsGjjDcb0MKfqJ7cDCsAAf07mhaxHkzcOTCVQ0Ti8TSJ1x6NtFgXDygvhqXnRA//eUU31xV0dxrZoE/78PtcPyvex1i3dPCsiXhhgE4/YhlpQ5LllDeVJzuFAXLBUJ0G4Q5d3mXuSv31mXsQvVs3SNVuM2HrThG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LtfJ50+v; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LtfJ50+v"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35a04d6aeb0so11283a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 07:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773845079; cv=none;
        d=google.com; s=arc-20240605;
        b=gJYRLbgXV2lshlC1hZx4RHCIPDC+ElsJiELvCY1syml3aUr81XhbTITNG+tAq9vkn9
         2H+PTRi5k8By/++1wrdadBaS6HppVbOh56vjZLLrmAeoRQJxg/XqIIqg3oJEknoQGjlx
         TlcSXXZYQvVJttK3Wm25jnSx4PocKOXCHr0ja0xuZJy9gjAZAFQf6LsVK2fkECbVnCjr
         9YdJe3X+9DsiRhJ/0MVmed5HWFTinbhdp+gOGS0JqcerpzCQWNWqOhSrWERuLv2S1Drb
         sAGmACDtTDwKn/OZD2DYhbrI9HfP07ZVMSpb1UOn2b443QeIZVDhud4WNtmxDVzQmHl6
         tP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HkavQrv5cWvoxe4AZ9l+fP74uR/q1B9HToUrpGg2U84=;
        fh=zfHb5dvfLBUh9UATIg2bQSrHC1OnR6nbCftqMNRrnKc=;
        b=V3wRphxzdl1jqMS9H5UCrFnAQENikW6qClhTMzLV8Uk2ngqtEZ9mKWhY6izmt1ikFc
         Js8f/PwnstgD+yb1PNWf0h2ZfFi62iyo5T39uSGnHoij6pPPrTjDNeBZQX1YjLurhvXO
         FvIvRIkpxWyjEnDcnI+LTM+SVaiFRSX4Jr4aS3VFH+/Cx7GybssiHQku3BMTb05belAz
         xebkfMqISnjZw6eR0ax1g7/69yaAgnmXZk3kvzvDUTTAnZs7ke1BCS9VlQBY4qJvtQrT
         yHwru/XtYjzbdTqYry4nbjKuj+DxYNY/BR0XDtKNDZOCIOwr0Jde0uqFhzOfBtW5ZoWA
         kiyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773845079; x=1774449879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkavQrv5cWvoxe4AZ9l+fP74uR/q1B9HToUrpGg2U84=;
        b=LtfJ50+vGOl5L+bLvcSZCj3PDRDRMn4P2P805uqGLqb3Spy++kIYGQorAT8N4DmFVe
         UuJdxNW9Tb7v8CffysJ824Sznzz0ceAdnMwBAsJO62MKMMr1tYiHxqxTI9ONL1Vdw4cP
         4ORFohxU9AXlL12y+vbHOn+JT6LkQ6oAg/ZkAvufUZ4JPdRHrhkIX/oakvTQQUZ/P5Nh
         nc59iJYCzh0yuMs/puSSEPaTAHqTLuEYkpVNtHF07PFTJgtsaWdKUYrXCIgTC5rRL5IO
         bEoP0EWhpKXO4FnTPdxcXmuZTk4bhDjZal3uFYibnFOKUIQ0DZSFaU/p5/C3htEx6SVt
         brqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845079; x=1774449879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkavQrv5cWvoxe4AZ9l+fP74uR/q1B9HToUrpGg2U84=;
        b=saX3VEbT5FnphN1Kc8i5rgprEX1HtcxlUKCvWhA2lPOxBaKa2YCUNHIBDl/du0b37+
         0Uv2ki5wk7tuZ0eHmGJaWutRuFQ1OiRg7Icro9E9Ke6YUWnin4pT86n3G0ahfjxPwcsc
         o+9pB/pNA+RHd2qoBpCsIYyO7VRINuRPllEro3NgiJlAL7uiH4qhyNUmqg5ZlGv+DYfP
         jTy3Ccf8/YqLKU1GPbYUzwB4Jx7WVf7KndFqChjqeC/MxVisK2LvXTaDXp6xPmb1s2o1
         ENtO63xGymmypCpzmZricsRGoUyFgvbqVtxUQIUD6tDgNE0dCmFQIr89PKhgCh/mDndl
         J0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKzNOZq0/E8D+tUWF8i5tSaqt4U6RK2yGDGHffIrtDfvnU6wEt6S3j+BiNDptGoPszCKSQSPcXB3fwwVEqdUTR6kcaCis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQbM21VhML7k5a/KZkZer+GRdRcsmxhL3sRJdm9zVWctCZWk7
	uyvLH1BBYD36RVp1alVBCRTe8UlalpkJGXQNoIpArXZJ05gQZielfgVqTo9NhVCtd3e2a0W+0Hk
	NF5tFxXrTktHIliP6XqjTzE+L/4LcKcXrLuiPcqhQ
X-Gm-Gg: ATEYQzxepyN1LOSs4wK9ZQ3JT8edh5IqVnk0F5KAWsOhnzt4HgmvsfT/Keo+IobJWX2
	aRc2kmYaV/w2p2/cPYxYUCOJqZHTZH+gA3WfGgInqeXEuqMoOT9Teu6NkJiLLNF6mqnZafFOjFf
	AW2P2zI/GEKNzqf6wW+Q9WuRqf/66RIHztF98mA7ttJ8CNN3K+wEgYZurRJzdVfH50ckqao/89/
	ZhtCCTQ1DXL9I5YbFxO2V+JkkLDYuY9GZ1yFhTQvPhgNW809oNaMeXhj4M+xXLyBWAILUgyGHWr
	pFouvRQ=
X-Received: by 2002:a17:90b:35cb:b0:35b:a44f:b82 with SMTP id
 98e67ed59e1d1-35bb9e51084mr3564914a91.11.1773845078585; Wed, 18 Mar 2026
 07:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315222150.121952-2-gnoack3000@gmail.com> <2697b9f672967b1318630f2ffa21914f@paul-moore.com>
 <20260318.In1aekohyivu@digikod.net>
In-Reply-To: <20260318.In1aekohyivu@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Mar 2026 10:44:26 -0400
X-Gm-Features: AaiRm53K5dsL5XuuN56xBEWUroqIt1ab6AzZo4hfS_0P9wo1tK90pKj6Bu_pEyY
Message-ID: <CAHC9VhRy2j3nYHHnyjsDf9Rk6=5DAzCSrmXgHCpo4arVnfBjRw@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 4:48=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Tue, Mar 17, 2026 at 05:34:57PM -0400, Paul Moore wrote:
> > On Mar 15, 2026 =3D?UTF-8?q?G=3DC3=3DBCnther=3D20Noack?=3D <gnoack3000@=
gmail.com> wrote:
> > >
> > > Add a LSM hook security_unix_find.
> > >
> > > This hook is called to check the path of a named unix socket before a
> > > connection is initiated. The peer socket may be inspected as well.
> > >
> > > Why existing hooks are unsuitable:
> > >
> > > Existing socket hooks, security_unix_stream_connect(),
> > > security_unix_may_send(), and security_socket_connect() don't provide
> > > TOCTOU-free / namespace independent access to the paths of sockets.
> > >
> > > (1) We cannot resolve the path from the struct sockaddr in existing h=
ooks.
> > > This requires another path lookup. A change in the path between the
> > > two lookups will cause a TOCTOU bug.
> > >
> > > (2) We cannot use the struct path from the listening socket, because =
it
> > > may be bound to a path in a different namespace than the caller,
> > > resulting in a path that cannot be referenced at policy creation time=
.
> > >
> > > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > > Cc: Tingmao Wang <m@maowtm.org>
> > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h |  5 +++++
> > >  include/linux/security.h      | 11 +++++++++++
> > >  net/unix/af_unix.c            | 13 ++++++++++---
> > >  security/security.c           | 20 ++++++++++++++++++++
> > >  4 files changed, 46 insertions(+), 3 deletions(-)
> >
> > Some really minor nitpicky things (below), but nothing critical.
> > However, as we discussed, I would like to see the AppArmor folks commen=
t
> > on the new hook before we merge anything as I know they have an interes=
t
> > here.
>
> John, Georgia, we've been discussing this new hook for a few months now
> but didn't hear from you yet.  We plan to merge this patch series with
> the 7.1 merge window (in a few weeks), so before that I'd like to merge
> it in -next in a few days to get a broader coverage.  I'm pretty sure
> this hook will work well with AppArmor too, but could you please take
> look to confirm?

I probably wasn't as clear as I should have been, my apologies.  The
major reason I held back my ACK on this patch was that I wanted to
hear from the AA folks regarding the hook's suitability for their
needs.  While I don't expect they will have an issue with this hook
as-is, they have expressed interest in the hook, and I would just
assume make sure it is okay for everyone before we send it to Linus.

Since this is a feature addition and not a critical bug fix, I will be
quite upset if this is sent to Linus without review by the AA
developers and my ACK.

--=20
paul-moore.com
