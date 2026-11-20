Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795204425;
	b=txqcHxtlU3MqSBRE+DhwHjjcCt2WOkR/xHrinDK23ooURfaPxxXT90D/x33eaP9C6sNj
	 SMGHg+cZw2kA6+Mln+BBdv/IGEVP5clQJpOgLMDL2waRli7AX1BiQ4lqxyYIXiUSPWJ0K
	 XejNHa4CJOcL4a7MEn5UicJjxj9y1wxJiVFwRa9doSbtcqCGO3o2kmZV0GwLscDiqWhCz
	 b8IJ8Dmeg7+DQc6PHsvm5Eqg53igiT5CMwthRUv6ULVBu2I8iAteHDeF8VO09FDi5zZrD
	 GmA+prNz9m2rHb2ivLJ7qLWl5RBvY/jcnAF1Akb+DM2f4xhRiCmArD8N4WFj5b560VQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Y76CwwbIFFZSLzT6VqrJeNVAmGacmUJL5O9mQNR1EcY=;
	b=D76v8yKfhcVPzT1NcCphHdn5LkOB4sQNNd2N9kT/WDeXmWwCgsFX0AmV+fCG5BQ+gCxZ
	 lrfzAM9anHCMhhwuZZi/F82k4tYhhkfJttMAqiy5m9Z6/AQxX6tHumgaklUp7FQ4mKUwU
	 T3VueY5kC2r4vS+uEIi5CRluFfu9hIc6nODKBg/BbCU6Xwgqh0b8YC6Ggu28RXe4+IKzq
	 im3NfHDYfHNtk1GESICWj/QAOw9CtyV0zJbEETrkFcDi1N/Vdm4PI5HQOqr/xHMPX0p3d
	 MQGFmzBfHdV60lC9jmQN/isAQdb0FSSQqeA1XFYdErWwY2XPB83GXS2B+DQKDm+b/Dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OIzOhE5i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B243D606A338
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 19:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B243D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OIzOhE5i
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3adfc004920so11455841fa.3
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 11:53:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795204423; cv=none;
        d=google.com; s=arc-20260327;
        b=b8UmlKU3e4mqTKXgF1F6mkDCaUDb88HEXD82SruYxM+QHP+5zrJbIqjCpZsGuRjiFw
         64Qv+UB6xJnNzUvHCJTo83Egst0riPOVNN+x1nkSjBOVifWIGRKt+qpniq+iBFC2DQxP
         L7CLNw6dOYn6jw8PFKFg69+oIte6/9RHsOT7G/Gh+HqB05MJDcxbLM3Iy+eM8Fn7DkvR
         oLlPj8voKLpTTgSPjQNFZL0Yf8j4x++XZiGwC0cGS+7197QGov0/5fc5aJaPjNxy5t4f
         ZzXz0l7ct8QvChoT5omB1N4FDktRWD8Ajl1fqf0IWz2tbomoDAZeeXTT47YIq4MD4+cZ
         pbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y76CwwbIFFZSLzT6VqrJeNVAmGacmUJL5O9mQNR1EcY=;
        fh=MBbRWEKlFwYc1tB+isV+tC1YFRV6j7i20uTcU50Jdrw=;
        b=UP0uIyHR/fmY8nIxU75iacDDsAqFqvoaudQrXGUxZD9Xry2aQnjzWY62Tx2l5/391I
         MxhPYyB+SxSbzgOSE+U/h7koAdd8K96Ms2qlBDLuD22LZkH5Kf7H74fQJOkCNBDqzR8S
         6SrdwEpMAZhPvn4CcX2Ru+r4cjRc2zmtcBMnpluXjvg0kmptx1IY8kC21JLMRk5lmXeQ
         GP62SBNI1c5IS3tVnAEfaknSft5OJTjLDofBisCzvTOii1nJnNvgawynPP3rYLH0s5ez
         bao2xB1sSRhGEpqRzllvDy8PR/ZOQijjLhP7Prf+02snVYcRm6WfSvU+Oag9IUKOvKqy
         oqMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1795204423; x=1795809223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y76CwwbIFFZSLzT6VqrJeNVAmGacmUJL5O9mQNR1EcY=;
        b=OIzOhE5iObSc8vEouH0agFHpvADyEkxMoLtQygTw3RAog7Wv+L7LAKHBfx6tywTWla
         XUmS9LeJ7PnxVQ8l/3h5q4xOUl+0sR1Yhl89cyUVCQFQ6WCNIJ01mU32NChKR7y23gEJ
         n6jCSfPaTpMmvNA7KdBLfnQPGXRT46ttzJgAvgufnJa4wXOuJ17zrS9bXry+tvzH4oPw
         y8KH2mJUm+Io56eSd80lF5wNq2JRo3v7s3MN3hIShmIFHlUZKroZclqXKbLIjGE9o4oI
         gDJi5i5Hy/If+d9CSXWm+OtWA52rz2oh8TdXKQlysnEYYdN/92oAHLZ0UJRgGJo4WwVZ
         xk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795204423; x=1795809223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y76CwwbIFFZSLzT6VqrJeNVAmGacmUJL5O9mQNR1EcY=;
        b=BQeRI/bJh8moFz4p/oCN7ZsBhOvQs5dloYfEM+spk0t/r7/+TzpK9ynt3qjkzDpn7q
         Dx8ueQeY14NKmdLB+6L7HNPUUsHuGwafI2KRX7qG6GLO0OiHmOnD2gYw85IC5olMMuFB
         Xf3CU4yzKKQiy544xoMRlRfDYQy+BMCYsKl8bIFtymu1c2lHO0geM6JFamRY4jW84XWN
         ynBxIyw0Lr/JVKtKXFPEB35X96DPxVVcBZc3Oe/KEuEWOVTjR/poGZS9KFTL3iE34QE/
         1CIfpxC2Yu/o1Libb7Cp5MlPSqQUCuTbwJZp+jkZpk7wjDvZ3j2XPSGz45LG9DuThpSF
         MEnQ==
X-Forwarded-Encrypted: i=1; AL+hErH+Lwva4h9oaLWSgdWCshKDU0iLMcDe1dBHJlQrZddWra9GFHyNr6e4sVMlUGxLnnS26wIdaP4r9vXwlsWdbyWPKQOlSvg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FgEPGw5cs8zrJAW0YqmNpO4gvW5R5DI3FudXe7pEPPvurj53r
	uL6PlcqEL0PGwseqBM3SHhPVIgFqsdklvDreo7E9eypZptzR5WPZUP1BkRqjmfBkUesbKt1k4QT
	QCdLwzCHpKUBSEtwL5zU5RF4k3K92hFAJo8PWln70
X-Gm-Gg: AZFdTZfkX5EkeTA3N0boY9q5DB5r+H/THaFk9L/joizhVrXswqxCgzV/pyX099MpTmP
	IpGnFbI28vNnmwjJPLnzoOqCi6HhbKCfLOBi6FmnuNXYjkI1D0sc3a296mny4Rv7f2xGlb5mmXs
	ZvxJt5YEYEP5H+Xy1WZFeSLsOBxlFu4vNZOJf+bkKUtcsGuL1Y15eNKuy9N9pAQMk5iwI5o4FxG
	P9eAO0TjwufiG0vDTQCTKqjJtPgwoKNO5oe2tJx9BsqKE4M6JS2h+J7wV7EgwXxRBIkXz3l5pgl
	7wNwOtnU3l/C1qx8p0To4rl7aXAKNVaMLfNdrd1A7t58GX3h/a5PJ6bvGHwfL+lFM5NpOJWR5n2
	EUcnyIYRoFVDE+GA8qfJtmkEyfJ0tyC0dfg==
X-Received: by 2002:a05:6512:1046:b0:5c1:acec:260e with SMTP id
 2adb3069b0e04-5c1bc8432bamr1303866e87.55.1795204422738; Fri, 20 Nov 2026
 11:53:42 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <av3bkDnwmjunTleX@kernel.org> <CALCETrXPLeUgxyhjP4XuWS46FKB0TUHF5PcMkdMf+qeEXbyXRA@mail.gmail.com>
 <9463a969d35a7d5ec5a56aeb67644b94.josef@toxicpanda.com> <CALCETrXt-Do28BHDpbrA98kEy-tQuorxD8c2XsW24Tt8Vspdtg@mail.gmail.com>
 <CALCETrUbe8rBoxrC+Q66AMsrJ8Fow7xt5KJKRAmobtXBvHWdqg@mail.gmail.com>
 <c301fff20a4920fcd3baa31dda2e31ad99c93436.camel@amutable.com>
 <awBHZO2VwWyJzvBN@kernel.org> <1f12636403bb7af3759cd933b2612d8a5d7317a2.camel@amutable.com>
 <awBRyKgOQlaEqpWX@kernel.org> <awCg5VYXKJvex9vy@kernel.org> <awCkANwNDox_99SR@kernel.org>
In-Reply-To: <awCkANwNDox_99SR@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 20 Nov 2026 11:53:30 -0800
X-Gm-Features: Aa3M54pKxDm6eU_2Sjm44hIEowicdxL9W6xw2PHKnbweFLV6y91fuj5aPjITmFQ
Message-ID: <CALCETrUnQjrWmSzL-FOqFF+_enxVsEM0On7orydXLCO-L2f23w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Alexander Mikhalitsyn <alex@amutable.com>, Josef Bacik <josef@toxicpanda.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Serge Hallyn <sergeh@kernel.org>, 
	Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 11:48=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> On Fri, Nov 20, 2026 at 09:35:06PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Nov 20, 2026 at 03:57:32PM +0200, Jarkko Sakkinen wrote:
> > > On Fri, Nov 20, 2026 at 02:24:57PM +0100, Alexander Mikhalitsyn wrote=
:
> > > > Yeah, detached mounts API solves a security issue here, but it does=
 not
> > > > fully enable the use-case Andy describes (if I understood it
> > > > correctly). My interpretation here is that to fully cover it we nee=
d
> > > > some well-isolated communication channel between container and
> > > > container manager (vsock for containers? :-D). And some well-define=
d
> > > > agreement of how PID 1 inside the container can get an information
> > > > about a hotplugg-ed stuff. [ But it could be that I completely
> > > > misunderstood and Andy meant something much more simple here. ]
> >
> > The sequence for hotplug (Andy's use case) breaks down like this and is
> > doable:
> >
> > 1. Host creates rootns(ROOTNS_SEAL_MNTNS).
> > 2. Host sets uid/gid maps with NS_USERNS_SET_IDMAP.
> > 3. Host populates "/" with MOVE_MOUNT_T_MNTNS, optionally combined with
> >    MOVE_MOUNT_CLONE for bind mounts.
> > 4. Host spawns PID 1 with clone3(CLONE_INTO_ROOTNS) (optionally passing
> >    an AF_UNIX socketpair fd for communication).
> > 5. PID 1 watches /proc/self/ns/mnt via fanotify(FAN_REPORT_MNT |
> >    FAN_MARK_MNTNS, FAN_MNT_ATTACH) or polls /proc/self/mountinfo.
> > 6. On hotplug, host mounts the filesystem via fsopen()/fsmount() (plus
> >    optional MOUNT_ATTR_IDMAP).
> > 7. Host creates the mountpoint with openat2(RESOLVE_IN_ROOT) + mkdirat(=
)
> >    and attaches the mount with MOVE_MOUNT_T_MNTNS.
> > 8. PID 1 receives FAN_MNT_ATTACH and queries the new mount via
> >    statmount().
> >
> > ROOTNS_SEAL_MNTS, NS_USERNS_SET_IDMAP and MOVE_MOUNT_CLONE new features
> > that are yet to be submitted but they were not tedious to ramp up.
> >
> > I'll include them to v5 of the patch set. Thanks for underlining this
> > part because that led to having those.
> >
> > Architecture scales to this even if my choices to address these details
> > would need some adjustment.
> >
> > The clear two-phase (build/live) progress with rootns sort of just give=
s
> > room to address stuff like this, and I have hard time to believe that i=
t
> > would get much better than this.
>
> A completely new feature is NS_USERNS_SET_IDMAP:
>
>     nsfs: Support NS_USERNS_SET_IDMAP ioctl
>
>     Configuring UID, GID, and project ID mappings or disabling setgroups(=
2)
>     for a user namespace currently requires writing to /proc/<pid>/uid_ma=
p,
>     gid_map, projid_map, and setgroups, forcing container managers to spa=
wn a
>     live process before populating a filesystem owned by that user namesp=
ace.
>
>     Add the extensible NS_USERNS_SET_IDMAP ioctl on CLONE_NEWUSER nsfs fi=
le
>     descriptors to atomically configure setgroups policy and UID, GID, an=
d
>     project ID mappings before any process enters the namespace. Enforce =
the
>     same single-write and capability invariants against both current_cred=
()
>     and filp->f_cred under userns_state_mutex.
>
>     Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>

I'm highly in favor of this.  But maybe not as an ioctl.

If you have an nsfd for a userns and that nsfd is the "control" fd
(however anyone decides this is formulated), why does f_cred matter?
It should be possible to create a userns without privilege and
SCM_RIGHTS the fd to a privileged uidmapd.  (I fixed the rather
screwed up workflow for this in newuidmap/newgidmap a few weeks ago --
this is remarkably easy to screw up.  It'll make it to a distro near
you some day.  It's supposed to *work* even without CAP_SYS_ADMIN in
the picture, and it did not.)

--Andy



--=20
Andy Lutomirski
AMA Capital Management, LLC
