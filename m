Return-Path: <SRS0=6WpB=QM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263BDC282CB
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 11:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B722175B
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 11:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfBELGs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:06:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37063 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBELGs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Feb 2019 06:06:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so3134907wrt.4
        for <linux-security-module@vger.kernel.org>; Tue, 05 Feb 2019 03:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G4tr0VYwJCG41RI3WYyCA9ntkgW7df/WWDw87a8ZHmU=;
        b=n1sFAQ2mF+AymSEs2Kx3e5yizLxO9m36+vhurGEA63rqI+CSi37awbH+XQkRh1iJ13
         SiFObJ0um2I1huOmlt2qCe9yQ4ExkbCEW4F43lK/azfkr3cCcF4/PbY2dGt6Be718/XB
         0bNLWM0OylXpEQGwmJSxaK62uGZIkXt9JHkmMz9IMSI1ec8LWlO2Lq0HmVz5SBi+SI4i
         fcfrHsWS54sOjAekGD7r8I0pRIuiIrsDA6fYrjSA2OW8jdSUnrQpPQTyK/0ojCS4OXox
         wFcX0I5vx1bqeqkv+RI/Y1owBet9OKoCzQSvOWMLR1skuitLAJcLpcynft6gxM6Guoa0
         JTgg==
X-Gm-Message-State: AHQUAuam/fJv3fY2iqgxJu4OX9kpdRZN2ZHb5D7jjoiYJSdBbeCVOmqU
        lXqPgXnCJ72Yy47EFW5OB3hobg==
X-Google-Smtp-Source: AHgI3Ia/onMA1PpBn4OtwOQAsfNNjisKMAlQaBRaPWEUxupi1JnL2u/otIL9bc7nK8vDg4U2JDW9Tw==
X-Received: by 2002:a5d:4486:: with SMTP id j6mr3046973wrq.41.1549364805560;
        Tue, 05 Feb 2019 03:06:45 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x186sm26067070wmg.41.2019.02.05.03.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 03:06:44 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v5 0/5] Allow initializing the kernfs node's secctx based on its parent
Date:   Tue,  5 Feb 2019 12:06:33 +0100
Message-Id: <20190205110638.30782-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Changes in v5:
- fix misplaced semicolon detected by 0day robot

v4: https://lore.kernel.org/selinux/20190205085915.5183-1-omosnace@redhat.com/T/
Changes in v4:
- reorder and rename hook arguments
- avoid allocating kernfs_iattrs unless needed

v3: https://lore.kernel.org/selinux/20190130114150.27807-1-omosnace@redhat.com/T/
Changes in v3:
- rename the hook to "kernfs_init_security"
- change the hook interface to simply pass pointers to struct iattr and
  struct simple_xattrs of both the new node and its parent
- add full security xattr support to kernfs (and fixup SELinux behavior
  to handle it properly)

v2: https://lore.kernel.org/selinux/20190109162830.8309-1-omosnace@redhat.com/T/
Changes in v2:
- add docstring for the new hook in union security_list_options
- initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
  implemented

v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/

TL;DR:
This series adds a new security hook that allows to initialize the security
context of kernfs properly, taking into account the parent context (and
possibly other attributes). Kernfs nodes require special handling here, since
they are not bound to specific inodes/superblocks, but instead represent the
backing tree structure that is used to build the VFS tree when the kernfs
tree is mounted.

The kernfs nodes initially do not store any security context and rely on
the LSM to assign some default context to inodes created over them. Kernfs
inodes, however, allow setting an explicit context via the *setxattr(2)
syscalls, in which case the context is stored inside the kernfs node's
internal structure.

SELinux (and possibly other LSMs) initialize the context of newly created
FS objects based on the parent object's context (usually the child inherits
the parent's context, unless the policy dictates otherwise). This is done
by hooking the creation of the new inode corresponding to the newly created
file/directory via security_inode_init_security() (most filesystems always
create a fresh inode when a new FS object is created). However, kernfs nodes
can be created "behind the scenes" while the filesystem is not mounted
anywhere and thus no inodes can exist for them yet.

Therefore, to allow maintaining similar behavior for kernfs nodes, a new
LSM hook is needed, which will allow initializing the kernfs node's
security context based on its own attributes and those of the parent's
node.

The main motivation for this change is that the userspace users of cgroupfs
(which is built on kernfs) expect the usual security context inheritance
to work under SELinux (see [1] and [2]). This functionality is required for
better confinement of containers under SELinux.

Patch 1/5 changes SELinux to fetch security context from extended
attributes on kernfs filesystems, falling back to genfs-defined context
if that fails. Without this patch the 2/5 would be a regression for
SELinux (due to the removal of ...notifysecctx() call.

Patch 2/5 implements full security xattr support in kernfs using
simple_xattrs; patch 3/5 adds the new LSM hook; patch 4/5 implements the
new hook in SELinux; and patch 5/5 modifies kernfs to call the new hook
on new node creation.

Testing:
- passed the reproducer from the commit message of the last patch
- passed SELinux testsuite on Fedora 29 (x86_64) when applied on top of
  current Rawhide kernel (5.0.0-0.rc5.git0.1) [3]
  - including the new proposed selinux-testsuite subtest [4] (adapted
    from the reproducer)

[1] https://github.com/SELinuxProject/selinux-kernel/issues/39
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1553803
[3] https://copr.fedorainfracloud.org/coprs/omos/kernel-testing/build/854148/
[4] https://github.com/SELinuxProject/selinux-testsuite/pull/48

Ondrej Mosnacek (5):
  selinux: try security xattr after genfs for kernfs filesystems
  kernfs: use simple_xattrs for security attributes
  LSM: add new hook for kernfs node initialization
  selinux: implement the kernfs_init_security hook
  kernfs: initialize security of newly created nodes

 fs/kernfs/dir.c                     |  64 +++++++-
 fs/kernfs/inode.c                   | 125 +++++++---------
 fs/kernfs/kernfs-internal.h         |   7 +-
 include/linux/lsm_hooks.h           |  22 +++
 include/linux/security.h            |  14 ++
 include/linux/xattr.h               |  15 ++
 security/security.c                 |  10 ++
 security/selinux/hooks.c            | 221 +++++++++++++++++++---------
 security/selinux/include/security.h |   1 +
 9 files changed, 328 insertions(+), 151 deletions(-)

-- 
2.20.1

