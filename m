Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051C0C433F5
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Oct 2022 22:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJCWiT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Oct 2022 18:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJCWiQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Oct 2022 18:38:16 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEB557894
        for <linux-security-module@vger.kernel.org>; Mon,  3 Oct 2022 15:38:10 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id d74-20020a4a524d000000b004755f8aae16so7679455oob.11
        for <linux-security-module@vger.kernel.org>; Mon, 03 Oct 2022 15:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=GpjEBgPaAZWoQzseLpY6/T5h6+VeMtQLvytGfDI7+bs=;
        b=tMYlRd1wpXXDyBgdMIV5/+IvCWdgPbfEqebBbB2LkkXheWnhF17EDXD4y+dx4BfIGG
         BBk2Y2CJGxbpmo3OY6TSoEtmx8Pt+WD0RTYTa4otdyBBayo375JiLCjm5jDXBbFowY6t
         RwqDEZDgx/DDfrU/giFdpZs14vQDhOx3XaClbBxLV0eoQfMk2R5oqSQWwHUHfczSsTcX
         VCfWTxAxA29FGoyAR2n7rySX8xtqBpogmNDYnFHkDJGhXAriyOXbUyYwaS76gfe/A0Rg
         NDP7Ym5IUT5Gv8whTxvrmWivKYqIhmXEg+ofC1hOTlCCOtHopKiWxf74Fsh0Maw39GUh
         y8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=GpjEBgPaAZWoQzseLpY6/T5h6+VeMtQLvytGfDI7+bs=;
        b=vJWpXFIce9km26cvenzpkTANnRnZrCurSf2sZegvdkeXC51vza2SGaoN1y1+uuqaAd
         172uwiy3j6Sq2J8frCBgKBpDMNh9MW465b9XI0THzb4UJCgscRo2FfpctKdTV4tGO9BP
         ct4mg5tVcLWr07YCBVj+Py6vyuM8E9vaHkDsDIHudivTtZtqx7o34Vm2KMfEBMNPWnWO
         /zuaTzx17z89LIbQbELKFhUutMq4Cg91GTAqa3wSKtCrg62KM6JSACJZGOFtUnxSNRRN
         ezyQ78PdrLqoZCBUCejvV+i4baqqM+rifHdpZIJ8ynPzuihggF15KqvYgKx4cmrz+Z8X
         rdow==
X-Gm-Message-State: ACrzQf0ef2DwfnwjMHxe1reWOlRxrZnMbb4QgFLrSIdosaYXMz1Dt+nM
        uOej1sXlo7FOAGEZ4DVNByF9oSGlu2uMFsFMxWZE
X-Google-Smtp-Source: AMsMyM54XzrneG0o6DeRaUXz6HQmUrYB5YPnMzQzIeCWcAJJhva5FlffB2hOT/H473jTbvcIGydWCo+jCKYMtyPHJnk=
X-Received: by 2002:a05:6830:114f:b0:655:bd97:7a9b with SMTP id
 x15-20020a056830114f00b00655bd977a9bmr8926564otq.287.1664836689864; Mon, 03
 Oct 2022 15:38:09 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 3 Oct 2022 18:37:59 -0400
Message-ID: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
Subject: [GIT PULL] LSM patches for v6.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ebiederm@xmission.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

Seven patches for the LSM layer and we've got a mix of trivial and
significant patches, the highlights are below.  However, before we get
to that I want to mention that you'll notice a merge conflict with
this pull request, the good news is that it is small and easily
resolved.  The conflict occurs in security/selinux/include/classmap.h
and is due to the io_uring/SELinux patch which went in during the
v6.0-rcX cycle to fix the missing LSM/SELinux access controls for the
io_uring command passthrough.  I'm sure you'll figure out the merge on
your own, but if you are unsure, check that the bottom of the
secclass_map[] array definition looks like this:

  const struct security_class_mapping secclass_map[] = {
    /* ... */
    { "anon_inode",
      { COMMON_FILE_PERMS, NULL } },
    { "io_uring",
      { "override_creds", "sqpoll", "cmd", NULL } },
    { "user_namespace",
      { "create", NULL } },
    { NULL }
 };

On to the highlights, starting with the smaller bits first so they
don't get lost in the discussion of the larger items.

- Remove some redundant NULL pointer checks in the common LSM audit code.

- Ratelimit the lockdown LSM's access denial messages.  With this
change there is a chance that the last visible lockdown message on the
console is outdated/old, but it does help preserve the initial series
of lockdown denials that started the denial message flood and my gut
feeling is that these might be the more valuable messages.

- Open userfaultfds as readonly instead of read/write.  While this
code obviously lives outside the LSM, it does have a noticeable impact
on the LSMs with Ondrej explaining the situation in the commit
description.  It is worth noting that this patch languished on the VFS
list for over a year without any comments (objections or otherwise) so
I took the liberty of pulling it into the LSM tree after giving fair
notice.  It has been in linux-next since the end of August without any
noticeable problems.

- Add a LSM hook for user namespace creation, with implementations for
both the BPF LSM and SELinux.  Even though the changes are fairly
small, this is the bulk of the diffstat as we are also including BPF
LSM selftests for the new hook.  It's also the most contentious of the
changes in this pull request with Eric Biederman NACK'ing the LSM hook
multiple times during its development and discussion upstream.  While
I've never taken NACK's lightly, I'm sending these patches to you
because it is my belief that they are of good quality, satisfy a
long-standing need of users and distros, and are in keeping with the
existing nature of the LSM layer and the Linux Kernel as a whole.  The
patches in this pull request implement a LSM hook for user namespace
creation that allows for a granular approach, configurable at runtime,
which enables both monitoring and control of user namespaces.  The
general consensus has been that this is far preferable to the other
solutions that have been adopted downstream including outright removal
from the kernel, disabling via system wide sysctls, or various other
out-of-tree mechanisms that users have been forced to adopt since we
haven't been able to provide them an upstream solution for their
requests.  Eric has been steadfast in his objections to this LSM hook,
explaining that any restrictions on the user namespace could have
significant impact on userspace.  While there is the possibility of
impacting userspace, it is important to note that this solution only
impacts userspace when it is requested based on the runtime
configuration supplied by the distro/admin/user.  Frederick (the
pathset author), the LSM/security community, and myself have tried to
work with Eric during development of this patchset to find a mutually
acceptable solution, but Eric's approach and unwillingness to engage
in a meaningful way have made this impossible.  I have CC'd Eric
directly on this pull request so he has a chance to provide his side
of the story; there have been no objections outside of Eric's.

For reference, I'm providing links to the last five patchset
iterations in case you want to read the discussions in more detail.  I
suspect you can look just at the v5 discussion to get a sense of the
discussion and the arguments involved.

* v5
https://lore.kernel.org/linux-security-module/20220815162028.926858-1-fred@cloudflare.com

* v4
https://lore.kernel.org/linux-security-module/20220801180146.1157914-1-fred@cloudflare.com

* v3
https://lore.kernel.org/linux-security-module/20220721172808.585539-1-fred@cloudflare.com

* v2
https://lore.kernel.org/linux-security-module/20220707223228.1940249-1-fred@cloudflare.com

* v1
https://lore.kernel.org/linux-security-module/20220621233939.993579-1-fred@cloudflare.com

My hope is that you agree with the opinion that the LSM hook for user
namespace creation is something we should have upstream, but if you
agree with Eric Biederman and think this would be a mistake, let me
know and I'll respin this pull request without the LSM hook.

-Paul

--
The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

 Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
   tags/lsm-pr-20221003

for you to fetch changes up to 1e7d8bcbe37d3c63babe628443f13f77970dd06b:

 lockdown: ratelimit denial messages (2022-09-14 07:37:50 -0400)

----------------------------------------------------------------
lsm/stable-6.1 PR 20221003

----------------------------------------------------------------
Frederick Lawler (4):
     security, lsm: Introduce security_create_user_ns()
     bpf-lsm: Make bpf_lsm_userns_create() sleepable
     selftests/bpf: Add tests verifying bpf lsm userns_create hook
     selinux: Implement userns_create hook

Nathan Lynch (1):
     lockdown: ratelimit denial messages

Ondrej Mosnacek (1):
     userfaultfd: open userfaultfds with O_RDONLY

Xiu Jianfeng (1):
     lsm: clean up redundant NULL pointer check

fs/userfaultfd.c                                   |   4 +-
include/linux/lsm_hook_defs.h                      |   1 +
include/linux/lsm_hooks.h                          |   4 +
include/linux/security.h                           |   6 ++
kernel/bpf/bpf_lsm.c                               |   1 +
kernel/user_namespace.c                            |   5 +
security/lockdown/lockdown.c                       |   2 +-
security/lsm_audit.c                               |  14 +--
security/security.c                                |   5 +
security/selinux/hooks.c                           |   9 ++
security/selinux/include/classmap.h                |   2 +
.../selftests/bpf/prog_tests/deny_namespace.c      | 102 +++++++++++++++++
.../selftests/bpf/progs/test_deny_namespace.c      |  33 +++++++
13 files changed, 172 insertions(+), 16 deletions(-)
create mode 100644 tools/testing/selftests/bpf/prog_tests/deny_namespace.c
create mode 100644 tools/testing/selftests/bpf/progs/test_deny_namespace.c

-- 
paul-moore.com
