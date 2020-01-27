Return-Path: <SRS0=BnuI=3Q=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0B3C2D0DB
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jan 2020 22:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFE222527
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jan 2020 22:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Lgl9X7Kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgA0W0e (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Jan 2020 17:26:34 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35715 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgA0W0e (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jan 2020 17:26:34 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so12537087edv.2
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jan 2020 14:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ImJurKyjDdBFqXnGp8NsllsDY2CX8cUxhNCfpbNIn+A=;
        b=Lgl9X7KhlV051rZwpS9tg/Oe1lRzwP4rip1ENWeFFsgeVPdRRDLrJVgmIdPE1Aeteu
         AE+2iy/3mNv9pePcXK7NySRC4llED37VmpRAtqzB5K8vNNWAnHcek0A9SmQYGumAyWEc
         XaVB7uBJMwrDtP8C/HfHRveeguPFjuKCudWzjd6XxWWHGmnZeTW3h9fy8MPCxLPz5LFN
         BuPCfXF7My2mQTiTJ/kGqAnrr/idPyYzWngwl2EY0RpV/aHJBiJAMewP44mLEHa2fC/B
         we468W/esPC/FWkvJ5m47GCNqQ29vl4ILakKge/2WaLKX3mbFjphlFQ9fsd0XIHzIvSs
         wB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ImJurKyjDdBFqXnGp8NsllsDY2CX8cUxhNCfpbNIn+A=;
        b=VfPh4nn9PrKh6XnO7DY/RJX+fDHTjiLfu+vbo0wBK5JPt0brcJeaqgCrvrLJ+vk1T6
         Svt8gqPVWrTBCyTmnSf173XLWTk7aIGNWE26v4nCfFdQ2WJU1y6o0E+5IqRi5FV0qUTr
         Hf7QXTh73sN6I3vMgCE9mF0VrC4QKzZbTXYPcMjUfkLvSYdhsq8CTR6LfdBe6501mur0
         qnKBUvUnIXfmvjXR7MqrbK4rkl8zERvlY+sCU4spE12qoEntOooeQIPGYvHcnrV4sYSL
         1lIqd5e4GFCSvKbqm4amekRGqczkLKMI2+CJIg9DQHQxJhbBqRRnkP3Ec0DXugwQnfsf
         Bzeg==
X-Gm-Message-State: APjAAAUlWSvTqrEAMxiuo4LOoxBYJ+PDtpepTHrMYEmymD/pc5oIKxpH
        YvF8+70qZeohwwYswvnjNoJIBAn+wWCfAouTPbtR
X-Google-Smtp-Source: APXvYqwRgMacKHVgEJejATnw9fXYyY2GDwe9WDz8PNsuWYZaE/MUvELQwyVKYMZaGgjusDPbsnKlOLRDu0Az2bjH4DQ=
X-Received: by 2002:a17:906:7c47:: with SMTP id g7mr662588ejp.281.1580163989574;
 Mon, 27 Jan 2020 14:26:29 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Jan 2020 17:26:18 -0500
Message-ID: <CAHC9VhR_5564up7u1V-PRXOz_RRfTLj16m508qgNvdWC8gcRTA@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

This is one of the bigger SELinux pull requests in recent years with
28 patches.  Everything is passing our test suite and the highlights
are listed below, please merge them for v5.6.

- Mark CONFIG_SECURITY_SELINUX_DISABLE as deprecated.  We're some time
away from actually attempting to remove this in the kernel, but the
only distro we know that still uses it (Fedora) is working on moving
away from this so we want to at least let people know we are planning
to remove it.

- Reorder the SELinux hooks to help prevent bad things when SELinux is
disabled at runtime.  The proper fix is to remove the
CONFIG_SECURITY_SELINUX_DISABLE functionality (see above) and just
take care of it at boot time (e.g. "selinux=0").

- Add SELinux controls for the kernel lockdown functionality,
introducing a new SELinux class/permissions: "lockdown { integrity
confidentiality }".

- Add a SELinux control for move_mount(2) that reuses the "file {
mounton }" permission.

- Improvements to the SELinux security label data store lookup
functions to speed up translations between our internal label
representations and the visible string labels (both directions).

- Revisit a previous fix related to SELinux inode auditing and
permission caching and do it correctly this time.

- Fix the SELinux access decision cache to cleanup properly on error.
In some extreme cases this could limit the cache size and result in a
decrease in performance.

- Enable SELinux per-file labeling for binderfs.

- The SELinux initialized and disabled flags were wrapped with
accessors to ensure they are accessed correctly.

- Mark several key SELinux structures with __randomize_layout.

- Changes to the LSM build configuration to only build
security/lsm_audit.c when needed.

- Changes to the SELinux build configuration to only build the IB
object cache when CONFIG_SECURITY_INFINIBAND is enabled.

- Move a number of single-caller functions into their callers.

- Documentation fixes (/selinux -> /sys/fs/selinux).

- A handful of cleanup patches that aren't worth mentioning on their
own, the individual descriptions have plenty of detail.

Thanks,
-Paul

--
The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

 Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20200127

for you to fetch changes up to 98aa00345de54b8340dc2ddcd87f446d33387b5e:

 selinux: fix regression introduced by move_mount(2) syscall
   (2020-01-20 07:42:37 -0500)

----------------------------------------------------------------
selinux/stable-5.6 PR 20200127

----------------------------------------------------------------
Hridya Valsaraju (1):
     selinux: allow per-file labelling for binderfs

Huaisheng Ye (2):
     selinux: remove redundant msg_msg_alloc_security
     selinux: remove redundant selinux_nlmsg_perm

Jaihind Yadav (1):
     selinux: ensure we cleanup the internal AVC counters on error in
              avc_update()

Jeff Vander Stoep (1):
     selinux: sidtab reverse lookup hash table

Ondrej Mosnacek (5):
     selinux: cache the SID -> context string translation
     selinux: treat atomic flags more carefully
     selinux: reorder hooks to make runtime disable less broken
     selinux: fix wrong buffer types in policydb.c
     selinux: do not allocate ancillary buffer on first load

Paul Moore (4):
     selinux: ensure we cleanup the internal AVC counters on error in
              avc_insert()
     selinux: ensure the policy has been loaded before reading the sidtab stats
     selinux: deprecate disabling SELinux and runtime
     selinux: remove redundant allocation and helper functions

Ravi Kumar Siddojigari (1):
     selinux: move ibpkeys code under CONFIG_SECURITY_INFINIBAND.

Stephen Smalley (10):
     security,lockdown,selinux: implement SELinux lockdown
     selinux: revert "stop passing MAY_NOT_BLOCK to the AVC upon follow_link"
     selinux: fall back to ref-walk if audit is required
     selinux: clean up selinux_inode_permission MAY_NOT_BLOCK tests
     security: only build lsm_audit if CONFIG_SECURITY=y
     selinux: clean up selinux_enabled/disabled/enforcing_boot
     selinux: randomize layout of key structures
     Documentation,selinux: fix references to old selinuxfs mount point
     selinux: make default_noexec read-only after init
     selinux: fix regression introduced by move_mount(2) syscall

Yang Guo (1):
     selinux: remove unnecessary selinux cred request

YueHaibing (1):
     selinux: remove set but not used variable 'sidtab'

liuyang34 (1):
     selinuxfs: use scnprintf to get real length for inode

Documentation/ABI/obsolete/sysfs-selinux-disable |  26 ++
Documentation/admin-guide/kernel-parameters.txt  |   9 +-
MAINTAINERS                                      |   1 +
include/linux/lsm_audit.h                        |   2 +
include/linux/security.h                         |   2 +
security/Makefile                                |   2 +-
security/lockdown/lockdown.c                     |  27 --
security/lsm_audit.c                             |   5 +
security/security.c                              |  33 ++
security/selinux/Kconfig                         |  33 +-
security/selinux/Makefile                        |   4 +-
security/selinux/avc.c                           |  95 +++---
security/selinux/hooks.c                         | 388 ++++++++++--------
security/selinux/ibpkey.c                        |   2 +-
security/selinux/include/avc.h                   |  13 +-
security/selinux/include/classmap.h              |   2 +
security/selinux/include/ibpkey.h                |  13 +-
security/selinux/include/objsec.h                |   2 +-
security/selinux/include/security.h              |  40 ++-
security/selinux/netif.c                         |   2 +-
security/selinux/netnode.c                       |   2 +-
security/selinux/netport.c                       |   2 +-
security/selinux/selinuxfs.c                     |  87 ++++-
security/selinux/ss/context.h                    |  11 +-
security/selinux/ss/policydb.c                   |   9 +-
security/selinux/ss/policydb.h                   |   2 +-
security/selinux/ss/services.c                   | 312 +++++++++++-------
security/selinux/ss/services.h                   |   6 +-
security/selinux/ss/sidtab.c                     | 402 ++++++++++++-------
security/selinux/ss/sidtab.h                     |  70 +++-
30 files changed, 1045 insertions(+), 559 deletions(-)
create mode 100644 Documentation/ABI/obsolete/sysfs-selinux-disable

-- 
paul moore
www.paul-moore.com
