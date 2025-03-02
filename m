Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5C192B84;
	Sun,  2 Mar 2025 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740940570; cv=none; b=tF26zfjt2M61uJtKNIHeIreOfuyfh93sGXoSw4CvTpmdW+iwYy2z1xz3e736A0EmWDEf+MdGM0HkuqKxmHrvjnjlk5buB5HU3AkTW+L02Ws3vhQdeEbo5fXHEKykHVX6h6O+XwevzbadKmHv6xTN7XVxcZAlXu47M3qidouYFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740940570; c=relaxed/simple;
	bh=ZbM4vpB908yU5sbm23oOuSYF8bAoGUH22z66+pCWk8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbvjCdFyQmHicYsAoQTHChlSh4k3IdpCmJNgNT5HuG1rWgUnsx1BIVjn1d8IU7BL1/Z0VcQ9KkQzQmI1t9xWn1uwq0OcwxBqtSkq/bq2pzVF9kR7WG4YUm+BzX8dzJnlfKFSMViz4aKgcvce7Kk74Z7beQSHJKxGA0CzC5CJnH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PvBIRL06; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PvBIRL06"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fd65f1d262so6630587b3.0;
        Sun, 02 Mar 2025 10:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1740940566; x=1741545366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w78AW+JcdaAE6GRO3Ac/koXaEdMi8GHrKoemWbN/WZQ=;
        b=PvBIRL06NYocuTDvWiM4gqxkIjyhhM9MifKVa0tjwF40SQT2SVvr3fo+JjLpkCI91l
         y3Eu5yH15jdzTl7BdTZtjQiA+BKDNM5Vnv83NCBgjMbnunga6jhERX5ZX8gJon2qOfIN
         4ckdVglSOcXbhTw3aqxgyMivkJyn5KiM7J5mnUmyWl2PJN2USsddzT+5528Iu/CT1TGi
         3M2HI7nxYkHuSks14em9OQr8dIed/oQ/T7mnLOPPOTolIiVC+qo+fTqYN6BV7bBEAUV9
         BACRFSAeZa/XIO4tWVDDtAcfobZ6QNGnOsHG/jjOo3WpAruAE5nmeIFes/VbX2ZeELGQ
         qnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740940566; x=1741545366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w78AW+JcdaAE6GRO3Ac/koXaEdMi8GHrKoemWbN/WZQ=;
        b=vOxcw2pyujZF7r3ujkD/x/dOzB4ODRSpbTH4PDca/Vc6rStJVbPlXJ7kHeYuTuUlfk
         2HWgodL9x4qxpzmg+E5rpH1u7BHkv7+DXY6JjsX41u4iij0ABlWEkWFsPKNsDSBh/wMN
         F1i2TvswaRgdGoiWLKsn6KviEv/I/LCMbX8emNdzcPvvalg4WZoUZqcgNjqiILP40/18
         sWVPd0fkU3jm95pEcQcs0znYypSiCASQo680NZWPRTI2zGJl7gBCnobjNNHRrMBJdE9g
         LqS0DFwfFVKRW7u5siJyOgD7jXpbn0okz4Rmcv9jg3KXQyozyjkEA96mxJOB06E0hnn8
         z9FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnFCDRPTOEnL0HOprvVRc3calWLPZPX6OIjCkFfo7TeqptA8EWNLza70zleuy0WBLXuusRYokLflEyIQI=@vger.kernel.org, AJvYcCXVvaSgGP2scyVbJSrd6auDQJ+KJwYxaHFjuVs9CtwzMzrz2LPSkkymVtUGlqOmieXasswu6uKjO+HAyLUldvyzCEk64IMU@vger.kernel.org
X-Gm-Message-State: AOJu0YxL9mLCVMnCEABKPsnsr+7j1sEKBRjAE3m9xSH89leZDcaVqPp6
	ZSsyNjhtoF6WFQzfHTwmsSUbrrGo0wCvQ2WtN0aAlnyGuZd5tEJLHWoZcgXtl3S2YihJfRq+GX0
	HEzIk3qHBFLEWDLhTFsYEB0pUA1s=
X-Gm-Gg: ASbGncvH9liUBdHsyc5bevkqrr0rgJFRej9FpwnNTQ639ClP3Yj8ahHDFH/IO0b9HYi
	J1giaGa9QK9T1fkKtwGEJJnLYw1EwsQuHBNEcYNywxtOqsO4hvQrEPzBuolTpFMLB1+8hU/Fj+F
	OxprnC9sL7NCNVm0WNyCQxrW5F
X-Google-Smtp-Source: AGHT+IFEDFRSLDqxeBHjrQywmijhQmz1FQW1pOjODzRPNakiH9IUDfoup1MSTpVVFPDPENluYnSs00bxRiHrQPHXl9k=
X-Received: by 2002:a05:690c:3686:b0:6ef:57ad:9d6e with SMTP id
 00721157ae682-6fd4a0f7944mr148229247b3.15.1740940566042; Sun, 02 Mar 2025
 10:36:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
 <20250302160657.127253-11-cgoettsche@seltendoof.de> <6f74f18f-ba64-4372-8307-efba97c03bf2@schaufler-ca.com>
In-Reply-To: <6f74f18f-ba64-4372-8307-efba97c03bf2@schaufler-ca.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Sun, 2 Mar 2025 19:35:55 +0100
X-Gm-Features: AQ5f1JpZICwtQ4pPwJ_9PnfHMp-YThZWlCGoAujw1thoqgj05siVdgKD2fL2hJM
Message-ID: <CAJ2a_DdrhV0pGj1WQ9N201KCY3bp_70zd1eSZ2PD1VOOd6SBrg@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] coccinelle: Add script to reorder capable() calls
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Serge Hallyn <serge@hallyn.com>, Jan Kara <jack@suse.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2 Mar 2025 at 17:53, Casey Schaufler <casey@schaufler-ca.com> wrote=
:
>
> On 3/2/2025 8:06 AM, Christian G=C3=B6ttsche wrote:
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > capable() calls refer to enabled LSMs whether to permit or deny the
> > request.  This is relevant in connection with SELinux, where a
> > capability check results in a policy decision and by default a denial
> > message on insufficient permission is issued.
> > It can lead to three undesired cases:
> >   1. A denial message is generated, even in case the operation was an
> >      unprivileged one and thus the syscall succeeded, creating noise.
> >   2. To avoid the noise from 1. the policy writer adds a rule to ignore
> >      those denial messages, hiding future syscalls, where the task
> >      performs an actual privileged operation, leading to hidden limited
> >      functionality of that task.
> >   3. To avoid the noise from 1. the policy writer adds a rule to permit
> >      the task the requested capability, while it does not need it,
> >      violating the principle of least privilege.
>
> What steps are you taking to ensure that these changes do not
> negatively impact LSMs other than SELinux? At a glance, I don't
> see that there is likely to be a problem. I do see a possibility
> that changes in error returns could break test suites and, more
> importantly, applications that are careful about using privileged
> operations.

Checks are only reordered where the current right-hand side is
side-effect free, e.g. a comparison.
Whether a branch is taken or not (and thus possible return values)
should not be affected.

Here is the current output of the script with the false-positives not conve=
rted:


### begin ###
diff -u -p a/kernel/capability.c b/kernel/capability.c
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -491,8 +491,8 @@ bool capable_wrt_inode_uidgid(struct mnt
{
       struct user_namespace *ns =3D current_user_ns();

-       return ns_capable(ns, cap) &&
-              privileged_wrt_inode_uidgid(ns, idmap, inode);
+       return privileged_wrt_inode_uidgid(ns, idmap, inode) && ns_capable(=
ns,
+                                              cap);
}
EXPORT_SYMBOL(capable_wrt_inode_uidgid);

diff -u -p a/kernel/pid.c b/kernel/pid.c
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -662,8 +662,7 @@ static int pid_table_root_permissions(st
               container_of(head->set, struct pid_namespace, set);
       int mode =3D table->mode;

-       if (ns_capable(pidns->user_ns, CAP_SYS_ADMIN) ||
-           uid_eq(current_euid(), make_kuid(pidns->user_ns, 0)))
+       if (uid_eq(current_euid(), make_kuid(pidns->user_ns, 0)) ||
ns_capable(pidns->user_ns, CAP_SYS_ADMIN))
               mode =3D (mode & S_IRWXU) >> 6;
       else if (in_egroup_p(make_kgid(pidns->user_ns, 0)))
               mode =3D (mode & S_IRWXG) >> 3;
diff -u -p a/kernel/bpf/token.c b/kernel/bpf/token.c
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -10,7 +10,8 @@

static bool bpf_ns_capable(struct user_namespace *ns, int cap)
{
-       return ns_capable(ns, cap) || (cap !=3D CAP_SYS_ADMIN &&
ns_capable(ns, CAP_SYS_ADMIN));
+       return (cap !=3D CAP_SYS_ADMIN && ns_capable(ns, CAP_SYS_ADMIN))
|| ns_capable(ns,
+
              cap);
}

bool bpf_token_capable(const struct bpf_token *token, int cap)
diff -u -p a/debian/linux-headers-6.9.0-rc2+/usr/src/linux-headers-6.9.0-rc=
2+/include/linux/bpf.h
b/debian/linux-headers-6.9.0-rc2+/usr/src/linux-headers-6.9.0-rc2+/include/=
linux/bpf.h
--- a/debian/linux-headers-6.9.0-rc2+/usr/src/linux-headers-6.9.0-rc2+/incl=
ude/linux/bpf.h
+++ b/debian/linux-headers-6.9.0-rc2+/usr/src/linux-headers-6.9.0-rc2+/incl=
ude/linux/bpf.h
@@ -2715,7 +2715,7 @@ static inline int bpf_obj_get_user(const

static inline bool bpf_token_capable(const struct bpf_token *token, int cap=
)
{
-       return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_A=
DMIN));
+       return (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN)) || capabl=
e(cap);
}

static inline void bpf_token_inc(struct bpf_token *token)
diff -u -p a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1285,8 +1285,7 @@ static ssize_t scrub_show(struct device
               && !test_bit(ARS_CANCEL, &acpi_desc->scrub_flags);
       rc =3D sysfs_emit(buf, "%d%s", acpi_desc->scrub_count, busy ?
"+\n" : "\n");
       /* Allow an admin to poll the busy state at a higher rate */
-       if (busy && capable(CAP_SYS_RAWIO) && !test_and_set_bit(ARS_POLL,
-                               &acpi_desc->scrub_flags)) {
+       if (busy && !test_and_set_bit(ARS_POLL,
&acpi_desc->scrub_flags) && capable(CAP_SYS_RAWIO)) {
               acpi_desc->scrub_tmo =3D 1;
               mod_delayed_work(nfit_wq, &acpi_desc->dwork, HZ);
       }
diff -u -p a/include/linux/bpf.h b/include/linux/bpf.h
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2830,7 +2830,7 @@ static inline int bpf_obj_get_user(const

static inline bool bpf_token_capable(const struct bpf_token *token, int cap=
)
{
-       return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_A=
DMIN));
+       return (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN)) || capabl=
e(cap);
}

static inline void bpf_token_inc(struct bpf_token *token)
diff -u -p a/kernel/user_namespace.c b/kernel/user_namespace.c
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1194,8 +1194,7 @@ static bool new_idmap_permitted(const st
        * (CAP_SETUID or CAP_SETGID) over the parent user namespace.
        * And the opener of the id file also has the appropriate capability=
.
        */
-       if (ns_capable(ns->parent, cap_setid) &&
-           file_ns_capable(file, ns->parent, cap_setid))
+       if (file_ns_capable(file, ns->parent, cap_setid) &&
ns_capable(ns->parent, cap_setid))
               return true;

       return false;
### end ###

>
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > ---
> >  MAINTAINERS                                |  1 +
> >  scripts/coccinelle/api/capable_order.cocci | 98 ++++++++++++++++++++++
> >  2 files changed, 99 insertions(+)
> >  create mode 100644 scripts/coccinelle/api/capable_order.cocci
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8e0736dc2ee0..b1d1c801765b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5196,6 +5196,7 @@ F:      include/linux/capability.h
> >  F:   include/trace/events/capability.h
> >  F:   include/uapi/linux/capability.h
> >  F:   kernel/capability.c
> > +F:   scripts/coccinelle/api/capable_order.cocci
> >  F:   security/commoncap.c
> >
> >  CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
> > diff --git a/scripts/coccinelle/api/capable_order.cocci b/scripts/cocci=
nelle/api/capable_order.cocci
> > new file mode 100644
> > index 000000000000..4150d91b0f33
> > --- /dev/null
> > +++ b/scripts/coccinelle/api/capable_order.cocci
> > @@ -0,0 +1,98 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +///
> > +/// Checks for capable() calls of the left side of a binary expression=
.
> > +/// Reordering might avoid needless checks, LSM log messages, and more
> > +/// restrictive LSM security policies (e.g. SELinux).
> > +/// Can report false positives if the righthand side contains a nested
> > +/// capability check or has side effects.
> > +///
> > +// Confidence: Moderate
> > +// Copyright: (C) 2024 Christian G=C3=B6ttsche.
> > +// Options: --no-includes --include-headers
> > +// Keywords: capable, ns_capable, sockopt_ns_capable
> > +//
> > +
> > +virtual patch
> > +virtual context
> > +virtual org
> > +virtual report
> > +
> > +//----------------------------------------------------------
> > +//  Pattern to ignore
> > +//----------------------------------------------------------
> > +
> > +@ignore@
> > +identifier F1 =3D { capable, ns_capable, sockopt_ns_capable };
> > +identifier F2 =3D { capable, ns_capable, sockopt_ns_capable };
> > +binary operator op,op1,op2;
> > +expression E;
> > +position p;
> > +@@
> > +
> > +(
> > +F1@p(...) op F2(...)
> > +|
> > +E op1 F1@p(...) op2 F2(...)
> > +)
> > +
> > +
> > +//----------------------------------------------------------
> > +//  For patch mode
> > +//----------------------------------------------------------
> > +
> > +@ depends on patch@
> > +identifier F =3D { capable, ns_capable, sockopt_ns_capable };
> > +binary operator op,op1,op2;
> > +expression E,E1,E2;
> > +expression list EL;
> > +position p !=3D ignore.p;
> > +@@
> > +
> > +(
> > +-  F@p(EL) op E
> > ++  E op F(EL)
> > +|
> > +-  E1 op1 F@p(EL) op2 E2
> > ++  E1 op1 E2 op2 F(EL)
> > +)
> > +
> > +
> > +//----------------------------------------------------------
> > +//  For context mode
> > +//----------------------------------------------------------
> > +
> > +@r1 depends on !patch exists@
> > +identifier F =3D { capable, ns_capable, sockopt_ns_capable };
> > +binary operator op,op1,op2;
> > +expression E, E1, E2;
> > +position p !=3D ignore.p;
> > +@@
> > +
> > +(
> > +*  F@p(...) op E
> > +|
> > +*  E1 op1 F@p(...) op2 E2
> > +)
> > +
> > +
> > +//----------------------------------------------------------
> > +//  For org mode
> > +//----------------------------------------------------------
> > +
> > +@script:python depends on org@
> > +p << r1.p;
> > +@@
> > +
> > +cocci.print_main("WARNING opportunity for capable reordering",p)
> > +
> > +
> > +//----------------------------------------------------------
> > +//  For report mode
> > +//----------------------------------------------------------
> > +
> > +@script:python depends on report@
> > +p << r1.p;
> > +@@
> > +
> > +msg =3D "WARNING opportunity for capable reordering"
> > +coccilib.report.print_report(p[0], msg)
