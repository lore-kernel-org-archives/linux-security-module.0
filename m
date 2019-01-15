Return-Path: <SRS0=ihUA=PX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544D6C43387
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 21:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F354420866
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 21:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M74wSh0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387401AbfAOV6v (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:58:51 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33198 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733253AbfAOV6v (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Jan 2019 16:58:51 -0500
Received: by mail-yb1-f193.google.com with SMTP id o73so1713361ybc.0
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jan 2019 13:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x6hciQX0pfhOjeSy7fJ9TxOfwAFNAo2LKbBl+80ZTpI=;
        b=M74wSh0kC2dZZ5sxN+gcbredyAJaFRI7sT1NxOlgLjPVBFtFxNB2cpQHvsjqeEoUB1
         4T/cb2ykKb0NXWs259Ww25/1zAkk/rcpbGv/XnclSx/FKS6/boQqNCTi4NJ7F7sZm1Pd
         3QpDb1ltJ9Cfl2g0+uCrCWQGEyWuvZ2PkwQ24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x6hciQX0pfhOjeSy7fJ9TxOfwAFNAo2LKbBl+80ZTpI=;
        b=VzCJ8LtziLgOCFwTn4uYJCuKV1BTvxFNumVd1niC4pmumH95IeiDVDUm+qtfD7d2UC
         EMiYAQPaOf9IYVlVSsu2oY8s/oCTsE7mlqar+o+8OkN4NsYGaiAuIVd6vzAS87TNnU/A
         wJEqBx/pjaZqPejo6CKs9ErL3y18YXEfQUiNOfHUwwhXGO6I+ji0qo75y+lciCUyzZRq
         B+MMRc4aF/Oe0k0Xsd924jFW+2wGQhnu0+Sksbv55WDZ/IkBg27GUQpbuVF7NFuFMQTj
         l0VcuQTAn7MYk3NzP80oDFAV7HImCN5U9yr2ZANnUhu3BIUNJlubYA62yLPfa74voPCE
         DeJA==
X-Gm-Message-State: AJcUukdrh+7Nc4uig7arL8rslBfnM7F4FFdUbF4Pn02mY3K/92B8D+xS
        QcsG/AxfvQ4qe9ZucQAMMPgfS6Wl4pvHqF26za4jPA==
X-Google-Smtp-Source: ALg8bN63UIh6DyUM0RmCdjgEPM8OyE5NRoq1Dv7xBizjWowGRuQYyyXgDbZLzXlCFTg7nW3j8BwRzxUVcLm/cgqGTsE=
X-Received: by 2002:a25:20c6:: with SMTP id g189mr4941611ybg.303.1547589528937;
 Tue, 15 Jan 2019 13:58:48 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5jKiFDD25TUnt7s_zFv7sjrt8avjeZgBKUBVzQ-er+xdkg@mail.gmail.com>
 <20190115180436.102826-1-mortonm@chromium.org> <CAGXu5jJUb3V24Yqx4m=3u_-7qv2P0qKJqreusTmpw8BkAJWL0A@mail.gmail.com>
In-Reply-To: <CAGXu5jJUb3V24Yqx4m=3u_-7qv2P0qKJqreusTmpw8BkAJWL0A@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 15 Jan 2019 13:58:37 -0800
Message-ID: <CAJ-EccP4v6-OoOJiE7ikSrJwuX2w4Z8Phqfb33Qu3z4GBbaLeQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] LSM: add SafeSetID module that gates setid calls
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 15, 2019 at 11:44 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jan 15, 2019 at 10:04 AM <mortonm@chromium.org> wrote:
> >
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
> > ---
> > Changes since the last patch set: Pulled out the "no-op" changes that
> > mark setid call sites in kernel/sys.c into a separate patch, and made
> > other small mods proposed by Kees Cook. NOTE: this patch is still using
> > do_exit(SIGKILL) to kill the process in check_uid_transition in lsm.c.
> > This may need to change, pending further discussion.
> >  Documentation/admin-guide/LSM/SafeSetID.rst | 107 ++++++++
> >  Documentation/admin-guide/LSM/index.rst     |   1 +
> >  security/Kconfig                            |   1 +
> >  security/Makefile                           |   2 +
> >  security/safesetid/Kconfig                  |  12 +
> >  security/safesetid/Makefile                 |   7 +
> >  security/safesetid/lsm.c                    | 266 ++++++++++++++++++++
> >  security/safesetid/lsm.h                    |  30 +++
> >  security/safesetid/securityfs.c             | 185 ++++++++++++++
> >  9 files changed, 611 insertions(+)
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
> > index 78dc12b7eeb3..9efc7a5e3280 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -236,6 +236,7 @@ source "security/tomoyo/Kconfig"
> >  source "security/apparmor/Kconfig"
> >  source "security/loadpin/Kconfig"
> >  source "security/yama/Kconfig"
> > +source "security/safesetid/Kconfig"
> >
> >  source "security/integrity/Kconfig"
> >
> > diff --git a/security/Makefile b/security/Makefile
> > index 4d2d3782ddef..c598b904938f 100644
> > --- a/security/Makefile
> > +++ b/security/Makefile
> > @@ -10,6 +10,7 @@ subdir-$(CONFIG_SECURITY_TOMOYO)        +=3D tomoyo
> >  subdir-$(CONFIG_SECURITY_APPARMOR)     +=3D apparmor
> >  subdir-$(CONFIG_SECURITY_YAMA)         +=3D yama
> >  subdir-$(CONFIG_SECURITY_LOADPIN)      +=3D loadpin
> > +subdir-$(CONFIG_SECURITY_SAFESETID)    +=3D safesetid
> >
> >  # always enable default capabilities
> >  obj-y                                  +=3D commoncap.o
> > @@ -25,6 +26,7 @@ obj-$(CONFIG_SECURITY_TOMOYO)         +=3D tomoyo/
> >  obj-$(CONFIG_SECURITY_APPARMOR)                +=3D apparmor/
> >  obj-$(CONFIG_SECURITY_YAMA)            +=3D yama/
> >  obj-$(CONFIG_SECURITY_LOADPIN)         +=3D loadpin/
> > +obj-$(CONFIG_SECURITY_SAFESETID)       +=3D safesetid/
> >  obj-$(CONFIG_CGROUP_DEVICE)            +=3D device_cgroup.o
>
> Given the refactoring of the LSM enabling logic, you'll need to do
> some minor merging with the linux-next tree to get this to apply to
> security-next. That would make James's life easier, I think, though
> maybe James can speak to that, since I'm not sure how the trees are
> split right now.

These patches apply cleanly to security-next at the moment (unless I'm
doing something weird -- the last commit I see in the git log is mine
from last week: c1a85a00ea66cb6f0bd0f14e47c28c2b0999799f)

>
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
> > index 000000000000..aa7bd3323751
> > --- /dev/null
> > +++ b/security/safesetid/lsm.c
> > @@ -0,0 +1,266 @@
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
> > +       struct hlist_node next;
> > +       struct hlist_node dlist; /* for deletion cleanup */
> > +       uint64_t parent_kuid;
> > +       uint64_t child_kuid;
> > +};
> > +
> > +static DEFINE_SPINLOCK(safesetid_whitelist_hashtable_spinlock);
> > +
> > +static bool check_setuid_policy_hashtable_key(kuid_t parent)
> > +{
> > +       struct entry *entry;
> > +
> > +       rcu_read_lock();
> > +       hash_for_each_possible_rcu(safesetid_whitelist_hashtable,
> > +                                  entry, next, __kuid_val(parent)) {
> > +               if (entry->parent_kuid =3D=3D __kuid_val(parent)) {
> > +                       rcu_read_unlock();
> > +                       return true;
> > +               }
> > +       }
> > +       rcu_read_unlock();
> > +
> > +       return false;
> > +}
> > +
> > +static bool check_setuid_policy_hashtable_key_value(kuid_t parent,
> > +                                                   kuid_t child)
> > +{
> > +       struct entry *entry;
> > +
> > +       rcu_read_lock();
> > +       hash_for_each_possible_rcu(safesetid_whitelist_hashtable,
> > +                                  entry, next, __kuid_val(parent)) {
> > +               if (entry->parent_kuid =3D=3D __kuid_val(parent) &&
> > +                   entry->child_kuid =3D=3D __kuid_val(child)) {
> > +                       rcu_read_unlock();
> > +                       return true;
> > +               }
> > +       }
> > +       rcu_read_unlock();
> > +
> > +       return false;
> > +}
> > +
> > +static int safesetid_security_capable(const struct cred *cred,
> > +                                     struct user_namespace *ns,
> > +                                     int cap,
> > +                                     unsigned int opts)
> > +{
> > +       if (cap =3D=3D CAP_SETUID &&
> > +           check_setuid_policy_hashtable_key(cred->uid)) {
> > +               if (!(opts & CAP_OPT_INSETID)) {
> > +                       /*
> > +                        * Deny if we're not in a set*uid() syscall to =
avoid
> > +                        * giving powers gated by CAP_SETUID that are r=
elated
> > +                        * to functionality other than calling set*uid(=
) (e.g.
> > +                        * allowing user to set up userns uid mappings)=
.
> > +                        */
> > +                       pr_warn("Operation requires CAP_SETUID, which i=
s not available to UID %u for operations besides approved set*uid transitio=
ns",
> > +                               __kuid_val(cred->uid));
> > +                       return -1;
> > +                }
> > +       }
> > +       return 0;
> > +}
> > +
> > +static int check_uid_transition(kuid_t parent, kuid_t child)
> > +{
> > +       if (check_setuid_policy_hashtable_key_value(parent, child))
> > +               return 0;
> > +       pr_warn("UID transition (%d -> %d) blocked",
> > +               __kuid_val(parent),
> > +               __kuid_val(child));
> > +        /*
> > +         * Kill this process to avoid potential security vulnerabiliti=
es
> > +         * that could arise from a missing whitelist entry preventing =
a
> > +         * privileged process from dropping to a lesser-privileged one=
.
> > +         */
> > +        do_exit(SIGKILL);
> > +}
>
> This needs double-checking, but I think you want this, to avoid
> missing various process clean-up steps (like performing a core dump if
> desired, etc):
>
> force_sig(SIGKILL, current);
> return -EACCES;
>
> But please double-check that a rejected setuid() syscall never
> completes and the process does die with SIGKILL.

Yep, this looks good. I changed those lines and see the following
strace output from a process that isn't allowed to setuid to root per
the whitelist policies:

...
setgid(0)                               =3D 0
setuid(0)                               =3D ?
+++ killed by SIGKILL +++

FWIW, I checked this with the following command on a ChromeOS device
in dev mode:

localhost ~ # strace -ff -o /tmp/strace /sbin/minijail0 -u shill -g
shill -c 0xc0 -- /sbin/capsh --user=3Droot -- -c /usr/bin/whoami

>
> > +
> > +/*
> > + * Check whether there is either an exception for user under old cred =
struct to
> > + * set*uid to user under new cred struct, or the UID transition is all=
owed (by
> > + * Linux set*uid rules) even without CAP_SETUID.
> > + */
> > +static int safesetid_task_fix_setuid(struct cred *new,
> > +                                    const struct cred *old,
> > +                                    int flags)
> > +{
> > +
> > +       /* Do nothing if there are no setuid restrictions for this UID.=
 */
> > +       if (!check_setuid_policy_hashtable_key(old->uid))
> > +               return 0;
> > +
> > +       switch (flags) {
> > +       case LSM_SETID_RE:
> > +               /*
> > +                * Users for which setuid restrictions exist can only s=
et the
> > +                * real UID to the real UID or the effective UID, unles=
s an
> > +                * explicit whitelist policy allows the transition.
> > +                */
> > +               if (!uid_eq(old->uid, new->uid) &&
> > +                       !uid_eq(old->euid, new->uid)) {
> > +                       return check_uid_transition(old->uid, new->uid)=
;
> > +               }
> > +               /*
> > +                * Users for which setuid restrictions exist can only s=
et the
> > +                * effective UID to the real UID, the effective UID, or=
 the
> > +                * saved set-UID, unless an explicit whitelist policy a=
llows
> > +                * the transition.
> > +                */
> > +               if (!uid_eq(old->uid, new->euid) &&
> > +                       !uid_eq(old->euid, new->euid) &&
> > +                       !uid_eq(old->suid, new->euid)) {
> > +                       return check_uid_transition(old->euid, new->eui=
d);
> > +               }
> > +               break;
> > +       case LSM_SETID_ID:
> > +               /*
> > +                * Users for which setuid restrictions exist cannot cha=
nge the
> > +                * real UID or saved set-UID unless an explicit whiteli=
st
> > +                * policy allows the transition.
> > +                */
> > +               if (!uid_eq(old->uid, new->uid))
> > +                       return check_uid_transition(old->uid, new->uid)=
;
> > +               if (!uid_eq(old->suid, new->suid))
> > +                       return check_uid_transition(old->suid, new->sui=
d);
> > +               break;
> > +       case LSM_SETID_RES:
> > +               /*
> > +                * Users for which setuid restrictions exist cannot cha=
nge the
> > +                * real UID, effective UID, or saved set-UID to anythin=
g but
> > +                * one of: the current real UID, the current effective =
UID or
> > +                * the current saved set-user-ID unless an explicit whi=
telist
> > +                * policy allows the transition.
> > +                */
> > +               if (!uid_eq(new->uid, old->uid) &&
> > +                       !uid_eq(new->uid, old->euid) &&
> > +                       !uid_eq(new->uid, old->suid)) {
> > +                       return check_uid_transition(old->uid, new->uid)=
;
> > +               }
> > +               if (!uid_eq(new->euid, old->uid) &&
> > +                       !uid_eq(new->euid, old->euid) &&
> > +                       !uid_eq(new->euid, old->suid)) {
> > +                       return check_uid_transition(old->euid, new->eui=
d);
> > +               }
> > +               if (!uid_eq(new->suid, old->uid) &&
> > +                       !uid_eq(new->suid, old->euid) &&
> > +                       !uid_eq(new->suid, old->suid)) {
> > +                       return check_uid_transition(old->suid, new->sui=
d);
> > +               }
> > +               break;
> > +       case LSM_SETID_FS:
> > +               /*
> > +                * Users for which setuid restrictions exist cannot cha=
nge the
> > +                * filesystem UID to anything but one of: the current r=
eal UID,
> > +                * the current effective UID or the current saved set-U=
ID
> > +                * unless an explicit whitelist policy allows the trans=
ition.
> > +                */
> > +               if (!uid_eq(new->fsuid, old->uid)  &&
> > +                       !uid_eq(new->fsuid, old->euid)  &&
> > +                       !uid_eq(new->fsuid, old->suid) &&
> > +                       !uid_eq(new->fsuid, old->fsuid)) {
> > +                       return check_uid_transition(old->fsuid, new->fs=
uid);
> > +               }
> > +               break;
>
> As a robustness measure can you add a default case here that will
> "fail closed"? Something like:
>
> default:
>     WARN_ON_ONCE("Unknown setid state %d\n", flags);
>     force_sig(SIGKILL, current);
>     return -EINVAL;

Done.

>
> > +       }
> > +       return 0;
> > +}
> > +
> > +int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child)
> > +{
> > +       struct entry *new;
> > +
> > +       /* Return if entry already exists */
> > +       if (check_setuid_policy_hashtable_key_value(parent, child))
> > +               return 0;
> > +
> > +       new =3D kzalloc(sizeof(struct entry), GFP_KERNEL);
> > +       if (!new)
> > +               return -ENOMEM;
> > +       new->parent_kuid =3D __kuid_val(parent);
> > +       new->child_kuid =3D __kuid_val(child);
> > +       spin_lock(&safesetid_whitelist_hashtable_spinlock);
> > +       hash_add_rcu(safesetid_whitelist_hashtable,
> > +                    &new->next,
> > +                    __kuid_val(parent));
> > +       spin_unlock(&safesetid_whitelist_hashtable_spinlock);
> > +       return 0;
> > +}
> > +
> > +void flush_safesetid_whitelist_entries(void)
> > +{
> > +       struct entry *entry;
> > +       struct hlist_node *hlist_node;
> > +       unsigned int bkt_loop_cursor;
> > +       HLIST_HEAD(free_list);
> > +
> > +       /*
> > +        * Could probably use hash_for_each_rcu here instead, but this =
should
> > +        * be fine as well.
> > +        */
> > +       spin_lock(&safesetid_whitelist_hashtable_spinlock);
> > +       hash_for_each_safe(safesetid_whitelist_hashtable, bkt_loop_curs=
or,
> > +                          hlist_node, entry, next) {
> > +               hash_del_rcu(&entry->next);
> > +               hlist_add_head(&entry->dlist, &free_list);
> > +       }
> > +       spin_unlock(&safesetid_whitelist_hashtable_spinlock);
> > +       synchronize_rcu();
> > +       hlist_for_each_entry_safe(entry, hlist_node, &free_list, dlist)=
 {
> > +               hlist_del(&entry->dlist);
> > +               kfree(entry);
> > +       }
> > +}
> > +
> > +static struct security_hook_list safesetid_security_hooks[] =3D {
> > +       LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
> > +       LSM_HOOK_INIT(capable, safesetid_security_capable)
> > +};
> > +
> > +static int __init safesetid_security_init(void)
> > +{
> > +       security_add_hooks(safesetid_security_hooks,
> > +                          ARRAY_SIZE(safesetid_security_hooks), "safes=
etid");
> > +
> > +       return 0;
> > +}
> > +
> > +DEFINE_LSM(safesetid_security_init) =3D {
> > +       .init =3D safesetid_security_init,
> > +};
> > diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
> > new file mode 100644
> > index 000000000000..bf78af9bf314
> > --- /dev/null
> > +++ b/security/safesetid/lsm.h
> > @@ -0,0 +1,30 @@
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
> > +/* Function type. */
> > +enum safesetid_whitelist_file_write_type {
> > +       SAFESETID_WHITELIST_ADD, /* Add whitelist policy. */
> > +       SAFESETID_WHITELIST_FLUSH, /* Flush whitelist policies. */
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
> > index 000000000000..c3ce7b63b4af
> > --- /dev/null
> > +++ b/security/safesetid/securityfs.c
> > @@ -0,0 +1,185 @@
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
> > +       const char *name;
> > +       enum safesetid_whitelist_file_write_type type;
> > +       struct dentry *dentry;
> > +};
> > +
> > +static struct safesetid_file_entry safesetid_files[] =3D {
> > +       {.name =3D "add_whitelist_policy",
> > +        .type =3D SAFESETID_WHITELIST_ADD},
> > +       {.name =3D "flush_whitelist_policies",
> > +        .type =3D SAFESETID_WHITELIST_FLUSH},
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
> > +                                           size_t len,
> > +                                           kuid_t *parent,
> > +                                           kuid_t *child)
> > +{
> > +       char *kern_buf;
> > +       char *parent_buf;
> > +       char *child_buf;
> > +       const char separator[] =3D ":";
> > +       int ret;
> > +       size_t first_substring_length;
> > +       long parsed_parent;
> > +       long parsed_child;
> > +
> > +       /* Duplicate string from user memory and NULL-terminate */
> > +       kern_buf =3D memdup_user_nul(buf, len);
> > +       if (IS_ERR(kern_buf))
> > +               return PTR_ERR(kern_buf);
> > +
> > +       /*
> > +        * Format of |buf| string should be <UID>:<UID>.
> > +        * Find location of ":" in kern_buf (copied from |buf|).
> > +        */
> > +       first_substring_length =3D strcspn(kern_buf, separator);
> > +       if (first_substring_length =3D=3D 0 || first_substring_length =
=3D=3D len) {
> > +               ret =3D -EINVAL;
> > +               goto free_kern;
> > +       }
> > +
> > +       parent_buf =3D kmemdup_nul(kern_buf, first_substring_length, GF=
P_KERNEL);
> > +       if (!parent_buf) {
> > +               ret =3D -ENOMEM;
> > +               goto free_kern;
> > +       }
> > +
> > +       ret =3D kstrtol(parent_buf, 0, &parsed_parent);
> > +       if (ret)
> > +               goto free_both;
> > +
> > +       child_buf =3D kern_buf + first_substring_length + 1;
> > +       ret =3D kstrtol(child_buf, 0, &parsed_child);
> > +       if (ret)
> > +               goto free_both;
> > +
> > +       *parent =3D make_kuid(current_user_ns(), parsed_parent);
> > +       if (!uid_valid(*parent)) {
> > +               ret =3D -EINVAL;
> > +               goto free_both;
> > +       }
> > +
> > +       *child =3D make_kuid(current_user_ns(), parsed_child);
> > +       if (!uid_valid(*child)) {
> > +               ret =3D -EINVAL;
> > +               goto free_both;
> > +       }
> > +
> > +free_both:
> > +       kfree(parent_buf);
> > +free_kern:
> > +       kfree(kern_buf);
> > +       return ret;
> > +}
> > +
> > +static ssize_t safesetid_file_write(struct file *file,
> > +                                   const char __user *buf,
> > +                                   size_t len,
> > +                                   loff_t *ppos)
> > +{
> > +       struct safesetid_file_entry *file_entry =3D
> > +               file->f_inode->i_private;
> > +       kuid_t parent;
> > +       kuid_t child;
> > +       int ret;
> > +
> > +       if (!ns_capable(current_user_ns(), CAP_MAC_ADMIN))
> > +               return -EPERM;
> > +
> > +       if (*ppos !=3D 0)
> > +               return -EINVAL;
> > +
> > +        switch (file_entry->type) {
> > +        case SAFESETID_WHITELIST_FLUSH:
> > +                flush_safesetid_whitelist_entries();
>
> missing break?

Thanks.

>
> > +        case SAFESETID_WHITELIST_ADD:
> > +                ret =3D parse_safesetid_whitelist_policy(buf, len, &pa=
rent,
> > +                                                                 &chil=
d);
> > +                if (ret)
> > +                        return ret;
> > +
> > +                ret =3D add_safesetid_whitelist_entry(parent, child);
> > +                if (ret)
> > +                        return ret;
>
> And add a default here too, something like:
>
> default:
>     WARN_ON_ONCE("Unknown securityfs file %d!?\n", file_entry->type);
>     break;
>

Done.

> > +        }
> > +
> > +        /* Return len on success so caller won't keep trying to write =
*/
> > +        return len;
> > +}
> > +
> > +static const struct file_operations safesetid_file_fops =3D {
> > +       .write =3D safesetid_file_write,
> > +};
> > +
> > +static void safesetid_shutdown_securityfs(void)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(safesetid_files); ++i) {
> > +               struct safesetid_file_entry *entry =3D
> > +                       &safesetid_files[i];
> > +               securityfs_remove(entry->dentry);
> > +               entry->dentry =3D NULL;
> > +       }
> > +
> > +       securityfs_remove(safesetid_policy_dir);
> > +       safesetid_policy_dir =3D NULL;
> > +}
> > +
> > +static int __init safesetid_init_securityfs(void)
> > +{
> > +       int i;
> > +       int ret;
> > +
> > +       safesetid_policy_dir =3D securityfs_create_dir("safesetid", NUL=
L);
> > +       if (!safesetid_policy_dir) {
> > +               ret =3D PTR_ERR(safesetid_policy_dir);
> > +               goto error;
> > +       }
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(safesetid_files); ++i) {
> > +               struct safesetid_file_entry *entry =3D
> > +                       &safesetid_files[i];
> > +               entry->dentry =3D securityfs_create_file(
> > +                       entry->name, 0200, safesetid_policy_dir,
> > +                       entry, &safesetid_file_fops);
> > +               if (IS_ERR(entry->dentry)) {
> > +                       ret =3D PTR_ERR(entry->dentry);
> > +                       goto error;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +
> > +error:
> > +       safesetid_shutdown_securityfs();
> > +       return ret;
> > +}
> > +fs_initcall(safesetid_init_securityfs);
> > --
> > 2.20.1.97.g81188d93c3-goog
> >
>
> And if I didn't say it before, thank you for the docs on this too! :)
>
> --
> Kees Cook
