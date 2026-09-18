Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F46627B343
	for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2026 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736114; cv=pass; b=iCZWRr+P2Jhfjtkv6YurHRADmOufco6CWMnSTDopGP6ELWbTALdxYO+rNZNMn/wVzWBTcfbfZdLhFqUPZRyrZtKXDZGIszwPoEFz/+DbBWd7guVjwcMOx0IlzusMOdr2P4xKReeRK5XbFiesNli6xNJydM5Aq4LH/Z3zPcHxvLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736114; c=relaxed/simple;
	bh=70naieZ3UsrNuhQQREPLWPaGB9WxsbhUKdI7BXo5+wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4lEVWK1qehlLCiIS5Kbrn3AWAcLw2BVFtxPA2TvYCjIk9xe8UgiL5Qc4zRpP7j2GPOVZg04itexMm8+8M9OdHJ6Ky5TeV/NMquTeiJ8v44WrMKwRbdpyiORLRjqYhWRkvUyzIFz/KxlKRBQ8cPRt5m63UR9HL361mj+75ciPBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSm0ElPl; arc=pass smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSm0ElPl"
Received: by mail-oo2-f38.google.com with SMTP id 006d021491bc7-6b1ae736c63so404154eaf.1
        for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2026 05:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789736111; cv=none;
        d=google.com; s=arc-20260327;
        b=h8au7uoq0+AtbO/nhH4TjrMc+8YquogiIXQqnYsBTDrGXE1NwF1oGhq5MGbbM+p/SN
         PnSwPRJzVD8+pSR8Il9oyXMHUiuEUtWvUM3gMHCjS84EpuungVclgLu36OLC0g0UjHqg
         uIloYSxqDq7s2k+TpDUdWZHwdTk3tK8j6nTF5mSsmOYMmuMmS/disVnoM+D1vXedJgP2
         Qr3Ztob41uEQjgMuTVRa/RQ7llnsboUcSrTgL5wgpQA/0jpLTOCS8h8HbNjnR1UwQ5jY
         1YewthT6EQrshyAfno1cBOV/pnvBsFowx4ETEW1ECn41HTDPWc0OyWVZFUXFaoh3UmRC
         vc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fznDqvZ8t6eixLAtS8PczvzvzI12PcGWxlPk+YO8Zrw=;
        fh=R8gukQ+Xd5UyJ0dFyJYTVHMuVBH/icbJGxLsdYHpxOk=;
        b=DlOyygbxq+qiPuL9UWm5UGi96w3GhQ2SoTKt5jDfDs0+Wd7l5niewfV/1y3XLIqTVN
         x1Dzza6PTYVXNTsqOoaQ6jji2DvZaT+emnWb6cNycSZHW7AMVnnHEdaV7PHVMoUZvM+T
         llN6+ntF29dckJ7gk/AQNZrv5fYTDbrKRrns0py7fkogj9DQjm3EzGfBmQvpuCWgU/y0
         pouvIjIxfEp8ZcaE5o+lng3R/KLx4v6XD229PsDPQJmoqiRrdaJr3O/ZwQjwRVTdwOZN
         MDwSO2gtuM0Vzv4bs8vlj4Pr3aT9AZokywdvW4jqATBk5gpEAcS9KD+r2FEEZopVBi4E
         Vfvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789736111; x=1790340911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fznDqvZ8t6eixLAtS8PczvzvzI12PcGWxlPk+YO8Zrw=;
        b=NSm0ElPlInhxG6Pxo95JhcxY8060Tic1braxVPvq06Gz7R4EgcPZV78ldtU42ToBcr
         E1afl9Zm4e5wkbuAJkBHnKZ8cm6nJFPdeebctEHEhfMAgwoCJVqgo1ITPIfZvaXcI+TF
         lmYzPVO2Zhe5wYodrTw2EqMmhEsxa9KBYUVZ9fsLy7r1TvlMQsT77UCnAyHOOW4/pl9x
         4ZO3cW9JyVe93jdWwS4bnFp9cJ4s1OIDpMkcxJc4D/gdbkq1sSUIINtLtfo9sxm8eaFq
         eOY2iIxwyr3hXZsN+IWxWyb8q9I9mZIaKEWBeZzJLqauCILVbt3lnc3vsSTtgXM56CfS
         fjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789736111; x=1790340911;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fznDqvZ8t6eixLAtS8PczvzvzI12PcGWxlPk+YO8Zrw=;
        b=QdVPrEMd/rcvrncxvWPLlXaxTXHry/R/+xsFb2q5TZ9lR4iiZcRlDGrqiPpZOo61QV
         L3kVD+hekKq609XqSKrfete1NG83xuBsGtygw481V7vETS7wNafagbZdahRlMK8x8pkw
         HVcJo6yCtaN/gLznh2Jg4QiA0srG1Mx399isszvc3fVJcnHFNHUrHfbMP88Lvoqyl7sH
         M9vcXbVyFoGucpMjDBSCzzCU9MV69N5+ihvpTc6z2gV6GXXBEfU8UxpZFDXYIEs8xsy1
         +cZSSGZAjLCwTtUmgEEpAdQXEhI7TzdBe1m8l1Rl/72T1DPAnXWL4trLmpL2NYSZKA7Z
         LuMA==
X-Forwarded-Encrypted: i=1; AKwUvByV6QMV6VAUTpUL9Kn2QIiePFEELAokf8qsJjZfD07ZofA7P4PmlI+XQgqPB34wYPWV2p6ed350WfFfxYqS/Y5Zonu7TYM=@vger.kernel.org
X-Gm-Message-State: AFuF++nnyWWGmkUSHn7rzkEf53NvWrpCH73XJ4KWBa1yuItKIEKqhXhM
	xj3O8SIDOb22bBsR07tbVqs0aLiRg/yW2qk8N0jAVqDYiyamA+Ae5QYsoSAa6JPm6fFfuDXaevJ
	Tk1rt4WAjxniuxpQ6VWmYTCL2U8sHwsg=
X-Gm-Gg: AYBFou3e4fVc/vb2P4Q7zYdNPoU+ODOYaVyx6gEWQQPOhyLLhzGkw1FWygkDU/d7qMl
	vaN4kz+jKRnjjtcSmQZzTBwJ+bERwJ2HKFsbw+Ya1mQ4crUH7zdkCCysqm2dNgulArsyLJsIGVX
	TxkrEgp6+cqSMdIIkXVRY0pkEtvRfZm/m2WYtv+cLazCPWKDG5A4BfPUYDtKnGuCBHgHRWvRCD6
	/GehXm72uW+0hHSWIDrsHv6kLRto/lxl0JNvivncMADaQJZPdHV/9fXo0EiOCp38jmoslaMrN49
	p3MgLjSYech4D+WfbX952+SmA/6JIdzbpS3gY9PV6IGNhhWVJTNw0g8=
X-Received: by 2002:a05:6820:1c9c:b0:6c0:c954:e534 with SMTP id
 006d021491bc7-6ca9c0597e2mr2266667eaf.38.1789736111293; Fri, 18 Sep 2026
 05:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916194824.37332-1-stephen.smalley.work@gmail.com> <20260918-kernbereich-altkleider-gespuckt-3b9488e49810@brauner>
In-Reply-To: <20260918-kernbereich-altkleider-gespuckt-3b9488e49810@brauner>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 18 Sep 2026 08:55:00 -0400
X-Gm-Features: AcwNN1UhxtwoSIE8m7i0Ih2QsSeuF7_CCE4neiBP84u9kEww775wYy8_yIPLYNs
Message-ID: <CAEjxPJ5dQ1khsycqtuFw_3DH=VMjnpxGgcqBs8gr1B_9VJnHgA@mail.gmail.com>
Subject: Re: [PATCH] lsm: initialize the security blob for the initial namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnacek@gmail.com, 
	linux-security-module@vger.kernel.org, mic@digikod.net, serge@hallyn.com, 
	jack@suse.cz, jmorris@namei.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 3:28=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Sep 16, 2026 at 03:48:24PM -0400, Stephen Smalley wrote:
> > Commit f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > added a security blob to struct ns_common and allocates it from
> > __ns_common_init(). Most initial namespaces (init_user_ns,
> > init_uts_ns, init_pid_ns, init_mnt_ns, and, depending on
> > configuration, init_ipc_ns, init_cgroup_ns and init_time_ns) are
> > however set up statically via NS_COMMON_INIT() and never pass through
> > __ns_common_init(), so their ns_security pointer is left NULL for the
> > lifetime of the system. Any LSM that registers an lbs_ns blob and
> > dereferences its slice on one of those namespaces (for example from
> > the namespace_install hook when a task setns()'s back into an initial
> > namespace) will fault.
> >
> > Allocate the blob and run the namespace_init hook for each of these
> > namespaces at the end of security_init(), after all ordered LSMs have
> > registered their hooks, so every LSM sees the initial namespaces the
> > same way it sees init_net (which is initialized at runtime via
> > ns_common_init(&init_net) from net_ns_init() immediately after
> > security_init()) and does not need to special-case them in its own
> > ->init() callback.
> >
> > Provide an init_ns_common_for_each() iterator in kernel/nscommon.c so
> > the list of statically-defined initial namespaces and their Kconfig
> > guards live next to the rest of the ns_common infrastructure. init_net
> > is intentionally excluded: pre-initializing it here would leak once
> > __ns_common_init() clears ns_security and re-allocates.
> >
> > Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  include/linux/ns_common.h |  1 +
> >  kernel/nscommon.c         | 45 +++++++++++++++++++++++++++++++++++++++
> >  security/lsm_init.c       | 11 ++++++++++
> >  3 files changed, 57 insertions(+)
> >
> > diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> > index c8e227a3f9e2..742627000453 100644
> > --- a/include/linux/ns_common.h
> > +++ b/include/linux/ns_common.h
> > @@ -11,6 +11,7 @@
> >  bool is_current_namespace(struct ns_common *ns);
> >  int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct p=
roc_ns_operations *ops, int inum);
> >  void __ns_common_free(struct ns_common *ns);
> > +int init_ns_common_for_each(int (*fn)(struct ns_common *ns));
> >  struct ns_common *__must_check ns_owner(struct ns_common *ns);
> >
> >  static __always_inline bool is_ns_init_inum(const struct ns_common *ns=
)
> > diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> > index e72426bba29a..4f3cba5518d7 100644
> > --- a/kernel/nscommon.c
> > +++ b/kernel/nscommon.c
> > @@ -1,11 +1,17 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
> >
> > +#include <linux/cgroup.h>
> > +#include <linux/ipc_namespace.h>
> > +#include <linux/mnt_namespace.h>
> >  #include <linux/ns_common.h>
> >  #include <linux/nstree.h>
> > +#include <linux/pid_namespace.h>
> >  #include <linux/proc_ns.h>
> >  #include <linux/security.h>
> > +#include <linux/time_namespace.h>
> >  #include <linux/user_namespace.h>
> > +#include <linux/uts_namespace.h>
> >  #include <linux/vfsdebug.h>
> >
> >  #ifdef CONFIG_DEBUG_VFS
> > @@ -101,6 +107,45 @@ int __ns_common_init(struct ns_common *ns, u32 ns_=
type, const struct proc_ns_ope
> >       return 0;
> >  }
> >
> > +/**
> > + * init_ns_common_for_each - iterate the statically-defined initial na=
mespaces
> > + * @fn: callback invoked with each initial ns_common
> > + *
> > + * Walk the initial namespaces that are set up via NS_COMMON_INIT() at=
 compile
> > + * time and therefore never pass through __ns_common_init(). The initi=
al
> > + * network namespace is intentionally excluded: it is initialized at r=
untime
> > + * via ns_common_init(&init_net) from net_ns_init().
> > + *
> > + * Return: the first non-zero return from @fn, or 0.
> > + */
> > +int __init init_ns_common_for_each(int (*fn)(struct ns_common *ns))
> > +{
> > +     struct ns_common *set[] =3D {
> > +             to_ns_common(&init_user_ns),
> > +             to_ns_common(&init_uts_ns),
> > +             to_ns_common(&init_pid_ns),
> > +             from_mnt_ns(&init_mnt_ns),
> > +#if defined(CONFIG_POSIX_MQUEUE) || defined(CONFIG_SYSVIPC)
> > +             to_ns_common(&init_ipc_ns),
> > +#endif
> > +#ifdef CONFIG_CGROUPS
> > +             to_ns_common(&init_cgroup_ns),
> > +#endif
> > +#ifdef CONFIG_TIME_NS
> > +             to_ns_common(&init_time_ns),
> > +#endif
> > +     };
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(set); i++) {
> > +             ret =3D fn(set[i]);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     return 0;
> > +}
> > +
> >  void __ns_common_free(struct ns_common *ns)
> >  {
> >       security_namespace_free(ns);
> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index dbda7771013b..60e15215f6bd 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -7,6 +7,7 @@
> >
> >  #include <linux/init.h>
> >  #include <linux/lsm_hooks.h>
> > +#include <linux/ns_common.h>
> >
> >  #include "lsm.h"
> >
> > @@ -490,6 +491,16 @@ int __init security_init(void)
> >               lsm_init_single(*lsm);
> >       }
> >
> > +     /*
> > +      * The initial namespaces are set up statically via NS_COMMON_INI=
T()
> > +      * and never pass through __ns_common_init(), so allocate their
> > +      * security blobs and run the namespace_init hooks now that all L=
SMs
> > +      * are registered. init_net is not covered here; it is initialize=
d
> > +      * at runtime from net_ns_init() shortly after security_init().
> > +      */
> > +     if (init_ns_common_for_each(security_namespace_init))
> > +             panic("initial LSM ns alloc failed\n");
>
> Wouldn't it be nicer to turn this around and call
> security_namespace_init from the ns common code and avoid the callback?
> Especially since there's only one.

Good idea. I'll send a v2 that does this.
