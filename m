Return-Path: <SRS0=9r3I=P6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A09C282C3
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Jan 2019 20:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D9B20870
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Jan 2019 20:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A9c33biM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfAVUkV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:40:21 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40437 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfAVUkU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Jan 2019 15:40:20 -0500
Received: by mail-yb1-f194.google.com with SMTP id i6so9146111ybo.7
        for <linux-security-module@vger.kernel.org>; Tue, 22 Jan 2019 12:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=36raJAgeVGX8vKHpQcT6OUhttY3zOsbPdQ5ajTaz0YA=;
        b=A9c33biMtzhCDhyMW5d4pB0/ewtz2gJ3OdoF6P2/nxu9W4PtVHtFAf7GhPODZJuNch
         7+LmuQuO7RCn4X4YoULio3jlG/w0m3RFAPydphGETDYDDGSU+e34sHbgk6hnk5lgdUIC
         k1rTs/Lgdwt5AEzzIoqkAFX37FKaQAs5pMM2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=36raJAgeVGX8vKHpQcT6OUhttY3zOsbPdQ5ajTaz0YA=;
        b=hD1J8lrgWbeL8lAB/axQADkp8YC3AN7XqrG4c3pghqPjOFiMvr9zZAAFXYD0vuMP3M
         gldLWlJJuqRX40qcBTF7gJcxNqFtF+tVOUEQmpilGUdhIH6I+PPcl0E550FDvDLw7td7
         kKLccQGMExHKjx3ikAH+Hqbie6nVRiIK1JVTBfEQdGYRbQkyFMqkMFfKogIovHrxbiZd
         0iAXbZ1JxHlaqUDAaI0NniVJbi5LNrhdCS6SD03hZoTzrvH+lCDi3YcmC4eYXgsuO9ZA
         z+Scg9mmmX8mQYI8Ell5HJVqt8CJZzFvrFuQk3JpKmbyzCaqfafRVD422ZwLliTKmqVP
         r42Q==
X-Gm-Message-State: AJcUukcUHAP6Te1pwEf/inwlrQeLJU7DQFtvMaI/qouN140OaQHmqbFo
        e5FaF7VlZNBpdtaNxY+ZUetbFjPhs/WQ4cL/ne6lvg==
X-Google-Smtp-Source: ALg8bN4NGB2TP1qyS7yYQLsQNTpj5hb8OOPl3jnHVOlFuhTBCPWadBH3w8kJxSp8t9yYs8L/E9raAk+Dr2vC/Gy+Pj0=
X-Received: by 2002:a25:d7c5:: with SMTP id o188mr22660754ybg.464.1548189618148;
 Tue, 22 Jan 2019 12:40:18 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5j+V61YOk7oAEw3Fm5rOxQAmy2-3QqOZaOP_FROLBUk2Qg@mail.gmail.com>
 <20190116154606.92331-1-mortonm@chromium.org> <59075206-784c-3225-4150-0c6e2c319083@schaufler-ca.com>
In-Reply-To: <59075206-784c-3225-4150-0c6e2c319083@schaufler-ca.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 22 Jan 2019 12:40:07 -0800
Message-ID: <CAJ-EccOyOEYiCgBhVDCEdpAawWBFXx=Hczdk7tKNDR0Y8p8Y=Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] LSM: add SafeSetID module that gates setid calls
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This has been Acked by Kees and Casey so far. Any further comments on
this? If not, should be ready to merge?


On Wed, Jan 16, 2019 at 8:10 AM Casey Schaufler <casey@schaufler-ca.com> wr=
ote:
>
> On 1/16/2019 7:46 AM, mortonm@chromium.org wrote:
> > From: Micah Morton <mortonm@chromium.org>
> >
> > SafeSetID gates the setid family of syscalls to restrict UID/GID
> > transitions from a given UID/GID to only those approved by a
> > system-wide whitelist. These restrictions also prohibit the given
> > UIDs/GIDs from obtaining auxiliary privileges associated with
> > CAP_SET{U/G}ID, such as allowing a user to set up user namespace UID
> > mappings. For now, only gating the set*uid family of syscalls is
> > supported, with support for set*gid coming in a future patch set.
> >
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
> > Acked-by: Kees Cook <keescook@chromium.org>
>
> While I have some lesser reservations philosophically, all
> direct technical objections have been addressed.
>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
>
> > ---
> > Changes since last patch:
> >   - added 'safesetid' to the ordered list of enabled LSMs in
> >     security/Kconfig.
> >   - added a "did I get initialized?" variable for the securityfs init t=
o
> >     check and check that variable in securityfs.c to skip tree creation
> >     if safesetid isn't running
> >  Documentation/admin-guide/LSM/SafeSetID.rst | 107 ++++++++
> >  Documentation/admin-guide/LSM/index.rst     |   1 +
> >  security/Kconfig                            |   3 +-
> >  security/Makefile                           |   2 +
> >  security/safesetid/Kconfig                  |  12 +
> >  security/safesetid/Makefile                 |   7 +
> >  security/safesetid/lsm.c                    | 277 ++++++++++++++++++++
> >  security/safesetid/lsm.h                    |  33 +++
> >  security/safesetid/securityfs.c             | 193 ++++++++++++++
> >  9 files changed, 634 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/admin-guide/LSM/SafeSetID.rst
> >  create mode 100644 security/safesetid/Kconfig
> >  create mode 100644 security/safesetid/Makefile
> >  create mode 100644 security/safesetid/lsm.c
> >  create mode 100644 security/safesetid/lsm.h
> >  create mode 100644 security/safesetid/securityfs.c
> >
> > diff --git a/Documentation/admin-guide/LSM/SafeSetID.rst b/Documentatio=
n/admin-guide/LSM/SafeSetID.rst
> > new file mode 100644
> > index 000000000000..ffb64be67f7a
> > --- /dev/null
> > +++ b/Documentation/admin-guide/LSM/SafeSetID.rst
> > @@ -0,0 +1,107 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +SafeSetID
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +SafeSetID is an LSM module that gates the setid family of syscalls to =
restrict
> > +UID/GID transitions from a given UID/GID to only those approved by a
> > +system-wide whitelist. These restrictions also prohibit the given UIDs=
/GIDs
> > +from obtaining auxiliary privileges associated with CAP_SET{U/G}ID, su=
ch as
> > +allowing a user to set up user namespace UID mappings.
> > +
> > +
> > +Background
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +In absence of file capabilities, processes spawned on a Linux system t=
hat need
> > +to switch to a different user must be spawned with CAP_SETUID privileg=
es.
> > +CAP_SETUID is granted to programs running as root or those running as =
a non-root
> > +user that have been explicitly given the CAP_SETUID runtime capability=
. It is
> > +often preferable to use Linux runtime capabilities rather than file
> > +capabilities, since using file capabilities to run a program with elev=
ated
> > +privileges opens up possible security holes since any user with access=
 to the
> > +file can exec() that program to gain the elevated privileges.
> > +
> > +While it is possible to implement a tree of processes by giving full
> > +CAP_SET{U/G}ID capabilities, this is often at odds with the goals of r=
unning a
> > +tree of processes under non-root user(s) in the first place. Specifica=
lly,
> > +since CAP_SETUID allows changing to any user on the system, including =
the root
> > +user, it is an overpowered capability for what is needed in this scena=
rio,
> > +especially since programs often only call setuid() to drop privileges =
to a
> > +lesser-privileged user -- not elevate privileges. Unfortunately, there=
 is no
> > +generally feasible way in Linux to restrict the potential UIDs that a =
user can
> > +switch to through setuid() beyond allowing a switch to any user on the=
 system.
> > +This SafeSetID LSM seeks to provide a solution for restricting setid
> > +capabilities in such a way.
> > +
> > +The main use case for this LSM is to allow a non-root program to trans=
ition to
> > +other untrusted uids without full blown CAP_SETUID capabilities. The n=
on-root
> > +program would still need CAP_SETUID to do any kind of transition, but =
the
> > +additional restrictions imposed by this LSM would mean it is a "safer"=
 version
> > +of CAP_SETUID since the non-root program cannot take advantage of CAP_=
SETUID to
> > +do any unapproved actions (e.g. setuid to uid 0 or create/enter new us=
er
> > +namespace). The higher level goal is to allow for uid-based sandboxing=
 of system
> > +services without having to give out CAP_SETUID all over the place just=
 so that
> > +non-root programs can drop to even-lesser-privileged uids. This is esp=
ecially
> > +relevant when one non-root daemon on the system should be allowed to s=
pawn other
> > +processes as different uids, but its undesirable to give the daemon a
> > +basically-root-equivalent CAP_SETUID.
> > +
> > +
> > +Other Approaches Considered
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +
> > +Solve this problem in userspace
> > +-------------------------------
> > +For candidate applications that would like to have restricted setid ca=
pabilities
> > +as implemented in this LSM, an alternative option would be to simply t=
ake away
> > +setid capabilities from the application completely and refactor the pr=
ocess
> > +spawning semantics in the application (e.g. by using a privileged help=
er program
> > +to do process spawning and UID/GID transitions). Unfortunately, there =
are a
> > +number of semantics around process spawning that would be affected by =
this, such
> > +as fork() calls where the program doesn=E2=80=99t immediately call exe=
c() after the
> > +fork(), parent processes specifying custom environment variables or co=
mmand line
> > +args for spawned child processes, or inheritance of file handles acros=
s a
> > +fork()/exec(). Because of this, as solution that uses a privileged hel=
per in
> > +userspace would likely be less appealing to incorporate into existing =
projects
> > +that rely on certain process-spawning semantics in Linux.
> > +
> > +Use user namespaces
> > +-------------------
> > +Another possible approach would be to run a given process tree in its =
own user
> > +namespace and give programs in the tree setid capabilities. In this wa=
y,
> > +programs in the tree could change to any desired UID/GID in the contex=
t of their
> > +own user namespace, and only approved UIDs/GIDs could be mapped back t=
o the
> > +initial system user namespace, affectively preventing privilege escala=
tion.
> > +Unfortunately, it is not generally feasible to use user namespaces in =
isolation,
> > +without pairing them with other namespace types, which is not always a=
n option.
> > +Linux checks for capabilities based off of the user namespace that =E2=
=80=9Cowns=E2=80=9D some
> > +entity. For example, Linux has the notion that network namespaces are =
owned by
> > +the user namespace in which they were created. A consequence of this i=
s that
> > +capability checks for access to a given network namespace are done by =
checking
> > +whether a task has the given capability in the context of the user nam=
espace
> > +that owns the network namespace -- not necessarily the user namespace =
under
> > +which the given task runs. Therefore spawning a process in a new user =
namespace
> > +effectively prevents it from accessing the network namespace owned by =
the
> > +initial namespace. This is a deal-breaker for any application that exp=
ects to
> > +retain the CAP_NET_ADMIN capability for the purpose of adjusting netwo=
rk
> > +configurations. Using user namespaces in isolation causes problems reg=
arding
> > +other system interactions, including use of pid namespaces and device =
creation.
> > +
> > +Use an existing LSM
> > +-------------------
> > +None of the other in-tree LSMs have the capability to gate setid trans=
itions, or
> > +even employ the security_task_fix_setuid hook at all. SELinux says of =
that hook:
> > +"Since setuid only affects the current process, and since the SELinux =
controls
> > +are not based on the Linux identity attributes, SELinux does not need =
to control
> > +this operation."
> > +
> > +
> > +Directions for use
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +This LSM hooks the setid syscalls to make sure transitions are allowed=
 if an
> > +applicable restriction policy is in place. Policies are configured thr=
ough
> > +securityfs by writing to the safesetid/add_whitelist_policy and
> > +safesetid/flush_whitelist_policies files at the location where securit=
yfs is
> > +mounted. The format for adding a policy is '<UID>:<UID>', using litera=
l
> > +numbers, such as '123:456'. To flush the policies, any write to the fi=
le is
> > +sufficient. Again, configuring a policy for a UID will prevent that UI=
D from
> > +obtaining auxiliary setid privileges, such as allowing a user to set u=
p user
> > +namespace UID mappings.
> > diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/ad=
min-guide/LSM/index.rst
> > index 9842e21afd4a..a6ba95fbaa9f 100644
> > --- a/Documentation/admin-guide/LSM/index.rst
> > +++ b/Documentation/admin-guide/LSM/index.rst
> > @@ -46,3 +46,4 @@ subdirectories.
> >     Smack
> >     tomoyo
> >     Yama
> > +   SafeSetID
> > diff --git a/security/Kconfig b/security/Kconfig
> > index 78dc12b7eeb3..9555f4914492 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -236,12 +236,13 @@ source "security/tomoyo/Kconfig"
> >  source "security/apparmor/Kconfig"
> >  source "security/loadpin/Kconfig"
> >  source "security/yama/Kconfig"
> > +source "security/safesetid/Kconfig"
> >
> >  source "security/integrity/Kconfig"
> >
> >  config LSM
> >       string "Ordered list of enabled LSMs"
> > -     default "yama,loadpin,integrity,selinux,smack,tomoyo,apparmor"
> > +     default "yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,ap=
parmor"
> >       help
> >         A comma-separated list of LSMs, in initialization order.
> >         Any LSMs left off this list will be ignored. This can be
> > diff --git a/security/Makefile b/security/Makefile
> > index 4d2d3782ddef..c598b904938f 100644
> > --- a/security/Makefile
> > +++ b/security/Makefile
> > @@ -10,6 +10,7 @@ subdir-$(CONFIG_SECURITY_TOMOYO)        +=3D tomoyo
> >  subdir-$(CONFIG_SECURITY_APPARMOR)   +=3D apparmor
> >  subdir-$(CONFIG_SECURITY_YAMA)               +=3D yama
> >  subdir-$(CONFIG_SECURITY_LOADPIN)    +=3D loadpin
> > +subdir-$(CONFIG_SECURITY_SAFESETID)    +=3D safesetid
> >
> >  # always enable default capabilities
> >  obj-y                                        +=3D commoncap.o
> > @@ -25,6 +26,7 @@ obj-$(CONFIG_SECURITY_TOMOYO)               +=3D tomo=
yo/
> >  obj-$(CONFIG_SECURITY_APPARMOR)              +=3D apparmor/
> >  obj-$(CONFIG_SECURITY_YAMA)          +=3D yama/
> >  obj-$(CONFIG_SECURITY_LOADPIN)               +=3D loadpin/
> > +obj-$(CONFIG_SECURITY_SAFESETID)       +=3D safesetid/
> >  obj-$(CONFIG_CGROUP_DEVICE)          +=3D device_cgroup.o
> >
> >  # Object integrity file lists
> > diff --git a/security/safesetid/Kconfig b/security/safesetid/Kconfig
> > new file mode 100644
> > index 000000000000..bf89a47ffcc8
> > --- /dev/null
> > +++ b/security/safesetid/Kconfig
> > @@ -0,0 +1,12 @@
> > +config SECURITY_SAFESETID
> > +        bool "Gate setid transitions to limit CAP_SET{U/G}ID capabilit=
ies"
> > +        default n
> > +        help
> > +          SafeSetID is an LSM module that gates the setid family of sy=
scalls to
> > +          restrict UID/GID transitions from a given UID/GID to only th=
ose
> > +          approved by a system-wide whitelist. These restrictions also=
 prohibit
> > +          the given UIDs/GIDs from obtaining auxiliary privileges asso=
ciated
> > +          with CAP_SET{U/G}ID, such as allowing a user to set up user =
namespace
> > +          UID mappings.
> > +
> > +          If you are unsure how to answer this question, answer N.
> > diff --git a/security/safesetid/Makefile b/security/safesetid/Makefile
> > new file mode 100644
> > index 000000000000..6b0660321164
> > --- /dev/null
> > +++ b/security/safesetid/Makefile
> > @@ -0,0 +1,7 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for the safesetid LSM.
> > +#
> > +
> > +obj-$(CONFIG_SECURITY_SAFESETID) :=3D safesetid.o
> > +safesetid-y :=3D lsm.o securityfs.o
> > diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> > new file mode 100644
> > index 000000000000..3a2c75ac810c
> > --- /dev/null
> > +++ b/security/safesetid/lsm.c
> > @@ -0,0 +1,277 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * SafeSetID Linux Security Module
> > + *
> > + * Author: Micah Morton <mortonm@chromium.org>
> > + *
> > + * Copyright (C) 2018 The Chromium OS Authors.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License version 2, as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#define pr_fmt(fmt) "SafeSetID: " fmt
> > +
> > +#include <asm/syscall.h>
> > +#include <linux/hashtable.h>
> > +#include <linux/lsm_hooks.h>
> > +#include <linux/module.h>
> > +#include <linux/ptrace.h>
> > +#include <linux/sched/task_stack.h>
> > +#include <linux/security.h>
> > +
> > +/* Flag indicating whether initialization completed */
> > +int safesetid_initialized;
> > +
> > +#define NUM_BITS 8 /* 128 buckets in hash table */
> > +
> > +static DEFINE_HASHTABLE(safesetid_whitelist_hashtable, NUM_BITS);
> > +
> > +/*
> > + * Hash table entry to store safesetid policy signifying that 'parent'=
 user
> > + * can setid to 'child' user.
> > + */
> > +struct entry {
> > +     struct hlist_node next;
> > +     struct hlist_node dlist; /* for deletion cleanup */
> > +     uint64_t parent_kuid;
> > +     uint64_t child_kuid;
> > +};
> > +
> > +static DEFINE_SPINLOCK(safesetid_whitelist_hashtable_spinlock);
> > +
> > +static bool check_setuid_policy_hashtable_key(kuid_t parent)
> > +{
> > +     struct entry *entry;
> > +
> > +     rcu_read_lock();
> > +     hash_for_each_possible_rcu(safesetid_whitelist_hashtable,
> > +                                entry, next, __kuid_val(parent)) {
> > +             if (entry->parent_kuid =3D=3D __kuid_val(parent)) {
> > +                     rcu_read_unlock();
> > +                     return true;
> > +             }
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     return false;
> > +}
> > +
> > +static bool check_setuid_policy_hashtable_key_value(kuid_t parent,
> > +                                                 kuid_t child)
> > +{
> > +     struct entry *entry;
> > +
> > +     rcu_read_lock();
> > +     hash_for_each_possible_rcu(safesetid_whitelist_hashtable,
> > +                                entry, next, __kuid_val(parent)) {
> > +             if (entry->parent_kuid =3D=3D __kuid_val(parent) &&
> > +                 entry->child_kuid =3D=3D __kuid_val(child)) {
> > +                     rcu_read_unlock();
> > +                     return true;
> > +             }
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     return false;
> > +}
> > +
> > +static int safesetid_security_capable(const struct cred *cred,
> > +                                   struct user_namespace *ns,
> > +                                   int cap,
> > +                                   unsigned int opts)
> > +{
> > +     if (cap =3D=3D CAP_SETUID &&
> > +         check_setuid_policy_hashtable_key(cred->uid)) {
> > +             if (!(opts & CAP_OPT_INSETID)) {
> > +                     /*
> > +                      * Deny if we're not in a set*uid() syscall to av=
oid
> > +                      * giving powers gated by CAP_SETUID that are rel=
ated
> > +                      * to functionality other than calling set*uid() =
(e.g.
> > +                      * allowing user to set up userns uid mappings).
> > +                      */
> > +                     pr_warn("Operation requires CAP_SETUID, which is =
not available to UID %u for operations besides approved set*uid transitions=
",
> > +                             __kuid_val(cred->uid));
> > +                     return -1;
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int check_uid_transition(kuid_t parent, kuid_t child)
> > +{
> > +     if (check_setuid_policy_hashtable_key_value(parent, child))
> > +             return 0;
> > +     pr_warn("UID transition (%d -> %d) blocked",
> > +             __kuid_val(parent),
> > +             __kuid_val(child));
> > +     /*
> > +      * Kill this process to avoid potential security vulnerabilities
> > +      * that could arise from a missing whitelist entry preventing a
> > +      * privileged process from dropping to a lesser-privileged one.
> > +      */
> > +     force_sig(SIGKILL, current);
> > +     return -EACCES;
> > +}
> > +
> > +/*
> > + * Check whether there is either an exception for user under old cred =
struct to
> > + * set*uid to user under new cred struct, or the UID transition is all=
owed (by
> > + * Linux set*uid rules) even without CAP_SETUID.
> > + */
> > +static int safesetid_task_fix_setuid(struct cred *new,
> > +                                  const struct cred *old,
> > +                                  int flags)
> > +{
> > +
> > +     /* Do nothing if there are no setuid restrictions for this UID. *=
/
> > +     if (!check_setuid_policy_hashtable_key(old->uid))
> > +             return 0;
> > +
> > +     switch (flags) {
> > +     case LSM_SETID_RE:
> > +             /*
> > +              * Users for which setuid restrictions exist can only set=
 the
> > +              * real UID to the real UID or the effective UID, unless =
an
> > +              * explicit whitelist policy allows the transition.
> > +              */
> > +             if (!uid_eq(old->uid, new->uid) &&
> > +                     !uid_eq(old->euid, new->uid)) {
> > +                     return check_uid_transition(old->uid, new->uid);
> > +             }
> > +             /*
> > +              * Users for which setuid restrictions exist can only set=
 the
> > +              * effective UID to the real UID, the effective UID, or t=
he
> > +              * saved set-UID, unless an explicit whitelist policy all=
ows
> > +              * the transition.
> > +              */
> > +             if (!uid_eq(old->uid, new->euid) &&
> > +                     !uid_eq(old->euid, new->euid) &&
> > +                     !uid_eq(old->suid, new->euid)) {
> > +                     return check_uid_transition(old->euid, new->euid)=
;
> > +             }
> > +             break;
> > +     case LSM_SETID_ID:
> > +             /*
> > +              * Users for which setuid restrictions exist cannot chang=
e the
> > +              * real UID or saved set-UID unless an explicit whitelist
> > +              * policy allows the transition.
> > +              */
> > +             if (!uid_eq(old->uid, new->uid))
> > +                     return check_uid_transition(old->uid, new->uid);
> > +             if (!uid_eq(old->suid, new->suid))
> > +                     return check_uid_transition(old->suid, new->suid)=
;
> > +             break;
> > +     case LSM_SETID_RES:
> > +             /*
> > +              * Users for which setuid restrictions exist cannot chang=
e the
> > +              * real UID, effective UID, or saved set-UID to anything =
but
> > +              * one of: the current real UID, the current effective UI=
D or
> > +              * the current saved set-user-ID unless an explicit white=
list
> > +              * policy allows the transition.
> > +              */
> > +             if (!uid_eq(new->uid, old->uid) &&
> > +                     !uid_eq(new->uid, old->euid) &&
> > +                     !uid_eq(new->uid, old->suid)) {
> > +                     return check_uid_transition(old->uid, new->uid);
> > +             }
> > +             if (!uid_eq(new->euid, old->uid) &&
> > +                     !uid_eq(new->euid, old->euid) &&
> > +                     !uid_eq(new->euid, old->suid)) {
> > +                     return check_uid_transition(old->euid, new->euid)=
;
> > +             }
> > +             if (!uid_eq(new->suid, old->uid) &&
> > +                     !uid_eq(new->suid, old->euid) &&
> > +                     !uid_eq(new->suid, old->suid)) {
> > +                     return check_uid_transition(old->suid, new->suid)=
;
> > +             }
> > +             break;
> > +     case LSM_SETID_FS:
> > +             /*
> > +              * Users for which setuid restrictions exist cannot chang=
e the
> > +              * filesystem UID to anything but one of: the current rea=
l UID,
> > +              * the current effective UID or the current saved set-UID
> > +              * unless an explicit whitelist policy allows the transit=
ion.
> > +              */
> > +             if (!uid_eq(new->fsuid, old->uid)  &&
> > +                     !uid_eq(new->fsuid, old->euid)  &&
> > +                     !uid_eq(new->fsuid, old->suid) &&
> > +                     !uid_eq(new->fsuid, old->fsuid)) {
> > +                     return check_uid_transition(old->fsuid, new->fsui=
d);
> > +             }
> > +             break;
> > +     default:
> > +             pr_warn("Unknown setid state %d\n", flags);
> > +             force_sig(SIGKILL, current);
> > +             return -EINVAL;
> > +     }
> > +     return 0;
> > +}
> > +
> > +int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child)
> > +{
> > +     struct entry *new;
> > +
> > +     /* Return if entry already exists */
> > +     if (check_setuid_policy_hashtable_key_value(parent, child))
> > +             return 0;
> > +
> > +     new =3D kzalloc(sizeof(struct entry), GFP_KERNEL);
> > +     if (!new)
> > +             return -ENOMEM;
> > +     new->parent_kuid =3D __kuid_val(parent);
> > +     new->child_kuid =3D __kuid_val(child);
> > +     spin_lock(&safesetid_whitelist_hashtable_spinlock);
> > +     hash_add_rcu(safesetid_whitelist_hashtable,
> > +                  &new->next,
> > +                  __kuid_val(parent));
> > +     spin_unlock(&safesetid_whitelist_hashtable_spinlock);
> > +     return 0;
> > +}
> > +
> > +void flush_safesetid_whitelist_entries(void)
> > +{
> > +     struct entry *entry;
> > +     struct hlist_node *hlist_node;
> > +     unsigned int bkt_loop_cursor;
> > +     HLIST_HEAD(free_list);
> > +
> > +     /*
> > +      * Could probably use hash_for_each_rcu here instead, but this sh=
ould
> > +      * be fine as well.
> > +      */
> > +     spin_lock(&safesetid_whitelist_hashtable_spinlock);
> > +     hash_for_each_safe(safesetid_whitelist_hashtable, bkt_loop_cursor=
,
> > +                        hlist_node, entry, next) {
> > +             hash_del_rcu(&entry->next);
> > +             hlist_add_head(&entry->dlist, &free_list);
> > +     }
> > +     spin_unlock(&safesetid_whitelist_hashtable_spinlock);
> > +     synchronize_rcu();
> > +     hlist_for_each_entry_safe(entry, hlist_node, &free_list, dlist) {
> > +             hlist_del(&entry->dlist);
> > +             kfree(entry);
> > +     }
> > +}
> > +
> > +static struct security_hook_list safesetid_security_hooks[] =3D {
> > +     LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
> > +     LSM_HOOK_INIT(capable, safesetid_security_capable)
> > +};
> > +
> > +static int __init safesetid_security_init(void)
> > +{
> > +     security_add_hooks(safesetid_security_hooks,
> > +                        ARRAY_SIZE(safesetid_security_hooks), "safeset=
id");
> > +
> > +     /* Report that SafeSetID successfully initialized */
> > +     safesetid_initialized =3D 1;
> > +
> > +     return 0;
> > +}
> > +
> > +DEFINE_LSM(safesetid_security_init) =3D {
> > +     .init =3D safesetid_security_init,
> > +};
> > diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
> > new file mode 100644
> > index 000000000000..c1ea3c265fcf
> > --- /dev/null
> > +++ b/security/safesetid/lsm.h
> > @@ -0,0 +1,33 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * SafeSetID Linux Security Module
> > + *
> > + * Author: Micah Morton <mortonm@chromium.org>
> > + *
> > + * Copyright (C) 2018 The Chromium OS Authors.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License version 2, as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +#ifndef _SAFESETID_H
> > +#define _SAFESETID_H
> > +
> > +#include <linux/types.h>
> > +
> > +/* Flag indicating whether initialization completed */
> > +extern int safesetid_initialized;
> > +
> > +/* Function type. */
> > +enum safesetid_whitelist_file_write_type {
> > +     SAFESETID_WHITELIST_ADD, /* Add whitelist policy. */
> > +     SAFESETID_WHITELIST_FLUSH, /* Flush whitelist policies. */
> > +};
> > +
> > +/* Add entry to safesetid whitelist to allow 'parent' to setid to 'chi=
ld'. */
> > +int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child);
> > +
> > +void flush_safesetid_whitelist_entries(void);
> > +
> > +#endif /* _SAFESETID_H */
> > diff --git a/security/safesetid/securityfs.c b/security/safesetid/secur=
ityfs.c
> > new file mode 100644
> > index 000000000000..61be4ee459cc
> > --- /dev/null
> > +++ b/security/safesetid/securityfs.c
> > @@ -0,0 +1,193 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * SafeSetID Linux Security Module
> > + *
> > + * Author: Micah Morton <mortonm@chromium.org>
> > + *
> > + * Copyright (C) 2018 The Chromium OS Authors.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License version 2, as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +#include <linux/security.h>
> > +#include <linux/cred.h>
> > +
> > +#include "lsm.h"
> > +
> > +static struct dentry *safesetid_policy_dir;
> > +
> > +struct safesetid_file_entry {
> > +     const char *name;
> > +     enum safesetid_whitelist_file_write_type type;
> > +     struct dentry *dentry;
> > +};
> > +
> > +static struct safesetid_file_entry safesetid_files[] =3D {
> > +     {.name =3D "add_whitelist_policy",
> > +      .type =3D SAFESETID_WHITELIST_ADD},
> > +     {.name =3D "flush_whitelist_policies",
> > +      .type =3D SAFESETID_WHITELIST_FLUSH},
> > +};
> > +
> > +/*
> > + * In the case the input buffer contains one or more invalid UIDs, the=
 kuid_t
> > + * variables pointed to by 'parent' and 'child' will get updated but t=
his
> > + * function will return an error.
> > + */
> > +static int parse_safesetid_whitelist_policy(const char __user *buf,
> > +                                         size_t len,
> > +                                         kuid_t *parent,
> > +                                         kuid_t *child)
> > +{
> > +     char *kern_buf;
> > +     char *parent_buf;
> > +     char *child_buf;
> > +     const char separator[] =3D ":";
> > +     int ret;
> > +     size_t first_substring_length;
> > +     long parsed_parent;
> > +     long parsed_child;
> > +
> > +     /* Duplicate string from user memory and NULL-terminate */
> > +     kern_buf =3D memdup_user_nul(buf, len);
> > +     if (IS_ERR(kern_buf))
> > +             return PTR_ERR(kern_buf);
> > +
> > +     /*
> > +      * Format of |buf| string should be <UID>:<UID>.
> > +      * Find location of ":" in kern_buf (copied from |buf|).
> > +      */
> > +     first_substring_length =3D strcspn(kern_buf, separator);
> > +     if (first_substring_length =3D=3D 0 || first_substring_length =3D=
=3D len) {
> > +             ret =3D -EINVAL;
> > +             goto free_kern;
> > +     }
> > +
> > +     parent_buf =3D kmemdup_nul(kern_buf, first_substring_length, GFP_=
KERNEL);
> > +     if (!parent_buf) {
> > +             ret =3D -ENOMEM;
> > +             goto free_kern;
> > +     }
> > +
> > +     ret =3D kstrtol(parent_buf, 0, &parsed_parent);
> > +     if (ret)
> > +             goto free_both;
> > +
> > +     child_buf =3D kern_buf + first_substring_length + 1;
> > +     ret =3D kstrtol(child_buf, 0, &parsed_child);
> > +     if (ret)
> > +             goto free_both;
> > +
> > +     *parent =3D make_kuid(current_user_ns(), parsed_parent);
> > +     if (!uid_valid(*parent)) {
> > +             ret =3D -EINVAL;
> > +             goto free_both;
> > +     }
> > +
> > +     *child =3D make_kuid(current_user_ns(), parsed_child);
> > +     if (!uid_valid(*child)) {
> > +             ret =3D -EINVAL;
> > +             goto free_both;
> > +     }
> > +
> > +free_both:
> > +     kfree(parent_buf);
> > +free_kern:
> > +     kfree(kern_buf);
> > +     return ret;
> > +}
> > +
> > +static ssize_t safesetid_file_write(struct file *file,
> > +                                 const char __user *buf,
> > +                                 size_t len,
> > +                                 loff_t *ppos)
> > +{
> > +     struct safesetid_file_entry *file_entry =3D
> > +             file->f_inode->i_private;
> > +     kuid_t parent;
> > +     kuid_t child;
> > +     int ret;
> > +
> > +     if (!ns_capable(current_user_ns(), CAP_MAC_ADMIN))
> > +             return -EPERM;
> > +
> > +     if (*ppos !=3D 0)
> > +             return -EINVAL;
> > +
> > +     switch (file_entry->type) {
> > +     case SAFESETID_WHITELIST_FLUSH:
> > +             flush_safesetid_whitelist_entries();
> > +             break;
> > +     case SAFESETID_WHITELIST_ADD:
> > +             ret =3D parse_safesetid_whitelist_policy(buf, len, &paren=
t,
> > +                                                              &child);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D add_safesetid_whitelist_entry(parent, child);
> > +             if (ret)
> > +                     return ret;
> > +             break;
> > +     default:
> > +             pr_warn("Unknown securityfs file %d\n", file_entry->type)=
;
> > +             break;
> > +     }
> > +
> > +     /* Return len on success so caller won't keep trying to write */
> > +     return len;
> > +}
> > +
> > +static const struct file_operations safesetid_file_fops =3D {
> > +     .write =3D safesetid_file_write,
> > +};
> > +
> > +static void safesetid_shutdown_securityfs(void)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(safesetid_files); ++i) {
> > +             struct safesetid_file_entry *entry =3D
> > +                     &safesetid_files[i];
> > +             securityfs_remove(entry->dentry);
> > +             entry->dentry =3D NULL;
> > +     }
> > +
> > +     securityfs_remove(safesetid_policy_dir);
> > +     safesetid_policy_dir =3D NULL;
> > +}
> > +
> > +static int __init safesetid_init_securityfs(void)
> > +{
> > +     int i;
> > +     int ret;
> > +
> > +     if (!safesetid_initialized)
> > +             return 0;
> > +
> > +     safesetid_policy_dir =3D securityfs_create_dir("safesetid", NULL)=
;
> > +     if (!safesetid_policy_dir) {
> > +             ret =3D PTR_ERR(safesetid_policy_dir);
> > +             goto error;
> > +     }
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(safesetid_files); ++i) {
> > +             struct safesetid_file_entry *entry =3D
> > +                     &safesetid_files[i];
> > +             entry->dentry =3D securityfs_create_file(
> > +                     entry->name, 0200, safesetid_policy_dir,
> > +                     entry, &safesetid_file_fops);
> > +             if (IS_ERR(entry->dentry)) {
> > +                     ret =3D PTR_ERR(entry->dentry);
> > +                     goto error;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +
> > +error:
> > +     safesetid_shutdown_securityfs();
> > +     return ret;
> > +}
> > +fs_initcall(safesetid_init_securityfs);
