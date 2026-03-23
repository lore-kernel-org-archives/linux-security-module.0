Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9CC3D891D
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297584; cv=pass; b=FDy+AJtDEh6XUtwx2wC2uvc1Ky25UeJa13DsokVtiy7+Mzg/DI0Wf76nzSqf1TMj1nAHTo5yFWm23rcX4lSOwjomLzFW/FfNq7VG0YFwMM+Naf+ZYkerKqwf0nDb6xgb6x2ULGxO5vJIp9N8sHaD7a0g+QIz6XySp/vT+sja8Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297584; c=relaxed/simple;
	bh=DUq8LGPBqt8SdNVFvCb35XbDHvQhmyVsE12hf8eYvpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdr07sJC0q1T/Hyj35UkEc/3NteYF1kEfQ6ZA9aVrDtXFqj0s13cmsIEty6gQRNX75QkbArrehA15uR9n0ZJlvUxldWHC6AzAuls4/iwOo7G8ANpHLNm5Os7kssmFlqUnF+47bpB1+24X+j2Fy624newftkL+aMJy+VEB9MVr8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PqAmuXLB; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PqAmuXLB"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829afe24fb5so2375726b3a.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 13:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774297583; cv=none;
        d=google.com; s=arc-20240605;
        b=ZHQ4ORAhcS4rBqLcHa6RSEx+EkEsMW1xOiTlFwgQaw7bpAeqta3RgdAHxSyqGgt9P7
         H//Xw91CbAOijDTFrkGz693VeBymAcUDxd2xopNGpndVY5v13KDzgkk7eKFCppV+gm4g
         vF51Obco5/Kyz+9ZkqMJGIl/NpHfSVEH88oGJTa098wHSmk0s5da1a1pwE5WXHkY+I5z
         PMi1Ws783lzR4h6GgK33rLcoILkKf+GgZ5j5ohNJAf2TQ6qVuK40G1KPI1st+NXg3gWX
         sjocgqexVLPQ0nBk8I9b+QfD5E5Comuq1s2puE9gznjR2XkTDC+VSm/BpZQCcY5V7wWI
         OaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZXWUtkYT4FoBAzKXThRQRMQz4bR8XCJn8//fdEKHV5A=;
        fh=xdAwvQxpRIkCom9nVH9m7cN8amXgDDvcCIEXQmp49Xc=;
        b=IuUY/+xPzIN0qy/fsX7Mi/lShtNb+1t0VsT8gZrgFcet5lfBVccvt7kCM/GsSXfZjR
         AWA+ri44FLrKgp6dkMtPPgaRulaQt8WL/WcYCAyzufCwwn6ISo1jyehEpmILgRA1pG/T
         jdWwOWGOxTNDRvfRG5/Nj7nOvdemirWBW5GveQvEBRASAy4MxNIWLNtM0ZKkYOVhDfcv
         +tBiywOhnUFUkOBBjrW/P/U9hP3Re+Ue2oTrlzCE8kZWAjl14J5ovZT0BFhKFRR7Ub78
         Ks+lSHUpyosJWV2o9P6lwAj28B1cI10Iz41jGaMM9rZ+nDzaUE9wKLLwuj42xWb6FMza
         lq1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774297583; x=1774902383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXWUtkYT4FoBAzKXThRQRMQz4bR8XCJn8//fdEKHV5A=;
        b=PqAmuXLBZA1LYezZ7lrRes2HbpYxY4jjn65QEuVBJ8ja2pPAasryoSsimHY0NNXU+S
         9i/Qby1RnHuNbbTvJEGIJjYCHVTlMdFWTUK7UvSENXrH2rJzXoQDXOi7eqMeJ1q/aJdv
         gnvOpYVLex2FvPwHGfsZmiydjIIh2PpoGSwfkjDgs/rHwE4d9ucq/Q8FZaiQgruz2WRh
         fcwGvSZgi4lRcJQvW0HyHx+bDiqMwKoOmZ0IYlDTf6xl9x/xjkWGdWIr2dkW/JDLwUYo
         +RojfSpc6sXPletFPPWSR9u9xuHdgIy9BQ+9Y4k9E36UCwLiEYCara3xiD12ZgNRLzAW
         WgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297583; x=1774902383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZXWUtkYT4FoBAzKXThRQRMQz4bR8XCJn8//fdEKHV5A=;
        b=nS90Lqcfocbpo5ITt8P/Zi5u1GPUkGhUfXnJlOlTaR2JRKYUf3lM92dSaVgAATtpwV
         GPImFtmE3RIamqKNzuS1WES6rScjDdFyRUba5kdRsLQWw7hyPl1EfeeCnOudDHOQEKSj
         gW9MT8eaxenW+/Ev8hBvPNkKa9nGl08RSwpB9dh8cIhOiHhOAJyyFuyzrZHsc6FCfGOX
         ruKpqcOe3eToshOyVuXAgwJ2jqD0gdRo+fnmYTNi4vtxpoY/CGjxOKJfmF/TvSih0ufU
         7+w2MgfN0KA2vG+8PHWVj9ijWRfvdw7s56fvaiLOv38xpyPTxAZ/AETFFDLhdIAE1VLV
         HIQA==
X-Forwarded-Encrypted: i=1; AJvYcCXfHleJspuA+JFlJLDI7gOKfeOVBEtQU3o7xcCH+75g4repNlKKcJupIXTAFWTHAPtgFf8d7AWD9cjC/0znyzNa7jQDLlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYgY+69/pz2W9Rz0Bp6njpLLB77ibqbpNx89qazzqhcPGE1vBo
	F+HBuIZKfGwpiPJTzYUGfGfjonbarUmeOVaoylZVJ0o4HVtPH/uKGAs+gTOokGksP06hGxE20Vu
	CSrdoHO0haLrxXO6XbLI1KwoT0XEc/Qe+RfduDuuw
X-Gm-Gg: ATEYQzz7q2evxb6YGtk+I6LBzQEXzRlUh98FSWHY3T/fVdFqJG4rM47Gt/8ZjTbvs6I
	Xi5bVH0otVKjabbGxqhRMgqKEgiOUwuJtljJxBiCiffEu62p6kpLo4MAmaCF1Pq6Lqwo0Qy5r6t
	mwzKEPkYkt6D0qISjhUdkfLDyvdbKyT4p0a7x+APVL8dx+Ptn3S9OJo7Q9RxNsL9b7AXlcmZxeJ
	ggYWlfPCNXmGjwFwbZgYJJXqCqo7WhLJcd5FOQnPKi+QxkVOLhSP86dA2uYV7BT3MNMes9AzPtx
	GgxsaFDNCOWNcAoS7g==
X-Received: by 2002:a05:6a20:3d21:b0:398:bcee:4506 with SMTP id
 adf61e73a8af0-39bceb6a713mr12969400637.38.1774297582653; Mon, 23 Mar 2026
 13:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315222150.121952-2-gnoack3000@gmail.com> <2697b9f672967b1318630f2ffa21914f@paul-moore.com>
 <20260318.In1aekohyivu@digikod.net> <c3fccd822db5fc76b7fab00a9515eb276a71b421.camel@canonical.com>
In-Reply-To: <c3fccd822db5fc76b7fab00a9515eb276a71b421.camel@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Mar 2026 16:26:11 -0400
X-Gm-Features: AaiRm51FuUBzeGG69rPX77Gd8XhRpL659WyssRMUKEJbgtgMD3UG1iYgVDMDkg4
Message-ID: <CAHC9VhS-pygOtPHM1c5TYHCJehGtWY7x92Jmjbb599PRmPLXgA@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
To: Georgia Garcia <georgia.garcia@canonical.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	John Johansen <john.johansen@canonical.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
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

On Mon, Mar 23, 2026 at 10:37=E2=80=AFAM Georgia Garcia
<georgia.garcia@canonical.com> wrote:
> On Wed, 2026-03-18 at 09:48 +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Tue, Mar 17, 2026 at 05:34:57PM -0400, Paul Moore wrote:
> > > On Mar 15, 2026 =3D?UTF-8?q?G=3DC3=3DBCnther=3D20Noack?=3D <gnoack300=
0@gmail.com> wrote:
> > > >
> > > > Add a LSM hook security_unix_find.
> > > >
> > > > This hook is called to check the path of a named unix socket before=
 a
> > > > connection is initiated. The peer socket may be inspected as well.
> > > >
> > > > Why existing hooks are unsuitable:
> > > >
> > > > Existing socket hooks, security_unix_stream_connect(),
> > > > security_unix_may_send(), and security_socket_connect() don't provi=
de
> > > > TOCTOU-free / namespace independent access to the paths of sockets.
> > > >
> > > > (1) We cannot resolve the path from the struct sockaddr in existing=
 hooks.
> > > > This requires another path lookup. A change in the path between the
> > > > two lookups will cause a TOCTOU bug.
> > > >
> > > > (2) We cannot use the struct path from the listening socket, becaus=
e it
> > > > may be bound to a path in a different namespace than the caller,
> > > > resulting in a path that cannot be referenced at policy creation ti=
me.
> > > >
> > > > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > > > Cc: Tingmao Wang <m@maowtm.org>
> > > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > > ---
> > > >  include/linux/lsm_hook_defs.h |  5 +++++
> > > >  include/linux/security.h      | 11 +++++++++++
> > > >  net/unix/af_unix.c            | 13 ++++++++++---
> > > >  security/security.c           | 20 ++++++++++++++++++++
> > > >  4 files changed, 46 insertions(+), 3 deletions(-)
> > >
> > > Some really minor nitpicky things (below), but nothing critical.
> > > However, as we discussed, I would like to see the AppArmor folks comm=
ent
> > > on the new hook before we merge anything as I know they have an inter=
est
> > > here.
> >
> > John, Georgia, we've been discussing this new hook for a few months now
> > but didn't hear from you yet.  We plan to merge this patch series with
> > the 7.1 merge window (in a few weeks), so before that I'd like to merge
> > it in -next in a few days to get a broader coverage.  I'm pretty sure
> > this hook will work well with AppArmor too, but could you please take
> > look to confirm?
>
> Apologies for the long delay replying. I have looked it over and I have
> no objections on the hook, it looks good to me. I would prefer if we
> got a reply from John as well since I'm not 100% confident but he
> should be out this week. In any case,
>
> Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>

Thanks!  I can understand wanting to wait for John, and if I'm
understanding the other aspects of the discussion (unrelated to this)
I think there still might be some additional discussions or revisions
before this goes anywhere.

--=20
paul-moore.com
