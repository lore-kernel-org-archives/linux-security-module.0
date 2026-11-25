Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623312;
	b=JQZyI5xHvQBJE7LK+FO3FLlJvXt89ER9ISVwOVZUBqfKnb4IY3SxNS7ReL97JH9fDABG
	 WAuoXqDJxg/q7X6oWCv6hPOVb95ImDyAf1ZwwkBdGo8GRF1elXDL4cyCvtPHk9ABjhLTK
	 RQM/29qZ52efIVQiJ1YncU5ljOZvL3BEyCuAznwgBL5unDhEGUaFdyRuzXzI1pKeMqo+F
	 XdIjoUgwGTes25cKDr8vAd75kCJYJs+Uzhrfz3XtxUMjZfPgxyF4zTfQPgZ3IL5pxUi7t
	 db0uJ2ersveInKkaA/oZ/h8Di9DgTIf6NAgwVwWgdRh75ySVW7Otbb75XtgcIlg+XmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623312;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=ikIAQDWUd4oIdUiwPTrXqLa3Yct6IL/NQnfK5N4xiCQ=;
	b=L5ZrbJkt/ZUQD/4J6UrmNI7aofYAXz2ah4nUnglvfHsINls8uHyw7GHGjfGMdIu1yc+s
	 lfOylaEsAplRS8GPopjVoBFkSEi6mEut1HK/7irOz+zigp98OiUl9EXni0BHVscyJqqoU
	 DeMBw4MDdDfmxISUeo2xeqv+w7fXSs7441hTwRlHCt2RYqdm+bg/TTPUX7EZTCsFBK39B
	 uCQvCkwRlJngRZNw4GkdS9ec4Pj/sPDvpJjbULNHnSfk6nTGDmPARkErKH6FMczkMvbh6
	 +7qoLA8HRL/dKtQe+DnIH8mBZvw9K/kdFql1i/UG2UFQCTL2wsEVEay+ZXAUi6EVWsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IdTL0HtM;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB667606A329
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 16:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB667606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IdTL0HtM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795623310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikIAQDWUd4oIdUiwPTrXqLa3Yct6IL/NQnfK5N4xiCQ=;
	b=IdTL0HtMlI+wajX32FgXTOb+xjON5XrkAujWRoeb5Lq67DamPkhlDy5WQTIm8JBsihVQgb
	AMTIhnK32ZXqcyMcdjMxwnPvE0KsfrUcEwxu7fuIndz53HnTQ/0UKu30+fJV5CfdduNxMj
	qAVrMyctzgZiuYiQtGspRhW6hnU31b4=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-FiiurI_HNaCy8EAn3GJ-4w-1; Wed, 25 Nov 2026 16:15:08 +0000
X-MC-Unique: FiiurI_HNaCy8EAn3GJ-4w-1
X-Mimecast-MFC-AGG-ID: FiiurI_HNaCy8EAn3GJ-4w_1795623308
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4e937c5bd4fso5072250b6e.2
        for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 08:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795623308; x=1796228108;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikIAQDWUd4oIdUiwPTrXqLa3Yct6IL/NQnfK5N4xiCQ=;
        b=lme1xyz6Irmv/+763BpAmB/TqE0jr2DtmgCGHshv3ccOMcEDTv68UhNy0QCv1gKscs
         xivdwGmU+jU/n/015CT1JniKVDpzww1vKWB9snI+4/sLfJivWAfTwT0IXir+kYnv8U0G
         feZwiBkD9ropXdO2GMsSY6j6EaLb54ctQLzRDIsSTAhRJXt+Hi49mxHwaKXiMARt3EiO
         hAEXptHNXGABtC+4depiNwdg37qq3KeNLhFoMq8Pw01WN4P2n9Pz1/P+K9qAl0gLItFw
         QMVCedUh/hashH6ABsUIWpjy9BkhJ1iINxnD5xCHFL3pW4F6BdFoZIAzYCwYp06GbZb+
         mgBg==
X-Forwarded-Encrypted: i=1; AL+hErE8mhUDvnhYMCsfhUA/1F8/UvtHIkFNMo+PGCVJKIlDZX75AjIFh+yIXG9d+OFnWk5zbhE9zWbjsJg2XBUVI/nPkz1zx2E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Zq9xc0bBt8GiA+KfQYCe1HHScf36yU0UTedKUw8q9f9EKjUvd
	V+gllXPqXuGATqnDVcMciT6LiED/osWw0fa22R7z+vPjceLknxFvzNZQMl36XvWxOcPY/AON2mZ
	PgGRgOckFFz7Rc25o+avQmlsztC7Y1Fv2Gr9t4ilyT2uS1ZIyy+Of6HoR/C1QB3IIj7k9E+foco
	QoJfCoZXrH2bSBQQN88WBftIMFTR4rXNun3W8QaJCsL2y3DOqQ83gQ
X-Gm-Gg: AZFdTZdvckLUgrUwj5LpOyfwk0xr1lJilAhukLA9P/f53kOBRBGZlOoJ2IRxjtS0N91
	mdfzHtMxuhCl+1Fe/OHepjY16nVVRNX3yx4VwXzxhmA/wO6fHLcFuCyqImCqbsbmM9u7Yq7YPNN
	KRIagJ1Gn6e2VCTaDZuQrx0FMfHHTLtsZRiOISfAQL631N8JGtARW1jK15
X-Received: by 2002:a05:6808:1a10:b0:564:48f3:dfa8 with SMTP id 5614622812f47-57a0a111c93mr20349851b6e.11.1795623307638;
        Wed, 25 Nov 2026 08:15:07 -0800 (PST)
X-Received: by 2002:a05:6808:1a10:b0:564:48f3:dfa8 with SMTP id
 5614622812f47-57a0a111c93mr20349798b6e.11.1795623307221; Wed, 25 Nov 2026
 08:15:07 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
 <20261124-v2_20230123_tjmercier_google_com-v6-6-dce12fa03ad6@redhat.com> <CAJ2a_DeDF+9pbLKS9pcX4Tot4xZZ-K7HydKnDjW6TWC5bvREzQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DeDF+9pbLKS9pcX4Tot4xZZ-K7HydKnDjW6TWC5bvREzQ@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 25 Nov 2026 17:14:55 +0100
X-Gm-Features: Aa3M54qg8B1tVY9MI_hj21-3fP47U-BOsj1Lrj8qIxJDIaifgpgCHqLTs9bOP0k
Message-ID: <CADSE00JMSXm4Vi5aH=k3VgLL__EsdEZgg_PqkSkK0LQumj1SUQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] selinux: Restrict cross-cgroup memcg charging
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
	Philipp Stanner <phasta@kernel.org>, airlied@gmail.com, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	echanude@redhat.com, mripard@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KBugIBW1lITk294WTCJghipDada8DysDAEdSqnVC_AE_1795623308
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 2:50=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Tue, 24 Nov 2026 at 14:05, Albert Esteve <aesteve@redhat.com> wrote:
> >
> > The security_current_memcg_charge_task() and
> > security_current_memcg_charge_cgroup() hooks allow security modules to
> > control which processes may charge or transfer memcg memory to another
> > process's cgroup, named by a pidfd, or to an arbitrary cgroup named by
> > a cgroupfd, both passed in charge_fd. Without a policy implementation,
> > either hook is a no-op and the restriction is not enforced.
> >
> > On SELinux-managed systems the only limit is CAP_SYS_RESOURCE. A
> > domain that holds both dma-heap access (today's only exporter that
> > opts-in) and that capability, can charge memory to any cgroup outside
> > its own subtree. Since the capability is all-or-nothing, SELinux
> > policy cannot express which targets such a domain may charge to.
> >
> > Implement both selinux_memcg_charge_task() and
> > selinux_memcg_charge_cgroup() using avc_has_perm() with a new cgroup
> > object class and a new charge_to permission. Both charge_fd flavours
> > ultimately charge a cgroup, so one permission covers them and the
> > target type keeps the distinction: for the pidfd path the target is
> > the referred task's SID, as there is no cgroup object to take a label
> > from; for the cgroupfd path it is the cgroup directory's inode SID,
> > which comes from the genfscon entry for cgroupfs unless the directory
> > is relabeled.
> >
> > The checks run when the charge target is resolved, before the
> > CAP_SYS_RESOURCE baseline is evaluated, and apply to every explicit
> > charge_fd target, including the caller's own subtree, so policy needs
> > a rule even for self-charging. Policy authors can then grant
> > cross-cgroup charging selectively, for example:
> >
> >   allow allocator_app_t client_app_t:cgroup charge_to;
> >   allow allocator_app_t cgroup_t:cgroup charge_to;
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  security/selinux/hooks.c            | 19 +++++++++++++++++++
> >  security/selinux/include/classmap.h |  1 +
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 6c4c64d6e904..76a714107ae4 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2204,6 +2204,23 @@ static int selinux_capable(const struct cred *cr=
ed, struct user_namespace *ns,
> >         return cred_has_capability(cred, cap, opts, ns =3D=3D &init_use=
r_ns);
> >  }
> >
> > +static int selinux_memcg_charge_task(const struct cred *to)
> > +{
> > +       const struct cred *cred =3D current_cred();
> > +
> > +       return avc_has_perm(cred_sid(cred), cred_sid(to),
>
> Small nit:
> `cred_sid(current_cred())` could be simplified using `current_sid()`

Nice, thanks! I will apply that for the next version.

>
> > +                           SECCLASS_CGROUP, CGROUP__CHARGE_TO, NULL);
> > +}
> > +
> > +static int selinux_memcg_charge_cgroup(const struct file *file)
> > +{
> > +       const struct cred *cred =3D current_cred();
> > +       struct inode_security_struct *isec =3D inode_security(file_inod=
e(file));
> > +
> > +       return avc_has_perm(cred_sid(cred), isec->sid, SECCLASS_CGROUP,
> > +                           CGROUP__CHARGE_TO, NULL);
> > +}
> > +
> >  static int selinux_quotactl(int cmds, int type, int id, const struct s=
uper_block *sb)
> >  {
> >         const struct cred *cred =3D current_cred();
> > @@ -7683,6 +7700,8 @@ static struct security_hook_list selinux_hooks[] =
__ro_after_init =3D {
> >         LSM_HOOK_INIT(capget, selinux_capget),
> >         LSM_HOOK_INIT(capset, selinux_capset),
> >         LSM_HOOK_INIT(capable, selinux_capable),
> > +       LSM_HOOK_INIT(memcg_charge_task, selinux_memcg_charge_task),
> > +       LSM_HOOK_INIT(memcg_charge_cgroup, selinux_memcg_charge_cgroup)=
,
> >         LSM_HOOK_INIT(quotactl, selinux_quotactl),
> >         LSM_HOOK_INIT(quota_on, selinux_quota_on),
> >         LSM_HOOK_INIT(syslog, selinux_syslog),
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/inc=
lude/classmap.h
> > index 90cb61b16425..1f1f2fc4d35d 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -181,6 +181,7 @@ const struct security_class_mapping secclass_map[] =
=3D {
> >         { "user_namespace", { "create", NULL } },
> >         { "memfd_file",
> >           { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL }=
 },
> > +       { "cgroup", { "charge_to", NULL } },
> >         /* last one */ { NULL, {} }
> >  };
> >
> >
> > --
> > 2.55.0
> >
> >
>

