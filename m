Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AA7EB64D9
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Jun 2023 21:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjFZV2a (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 26 Jun 2023 17:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjFZV23 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Jun 2023 17:28:29 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8A61702
        for <linux-security-module@vger.kernel.org>; Mon, 26 Jun 2023 14:28:26 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bd0a359ca35so2425539276.3
        for <linux-security-module@vger.kernel.org>; Mon, 26 Jun 2023 14:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687814906; x=1690406906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7CQ4hwJhKjIW7SikA2WYgmCLn8qhE0eQEFFM44s3DEg=;
        b=P1/AFGL4fwDDqWVyfiMDCTW9OrnM409YOha4aAGa5T3/plje1K9hsiYLKew+GyCKoV
         WIYo+x9YoXM1j0A7CaRqgC1qTMLj7Ef3IeG/OAOKGN2EQvv7RHtSHEIRPYfFOKBFUg7V
         TzEDVQmrkExxM8eCa33xtXUtSzQ8R76qwDl9OL6C6cG0m1ltQNG91CBTeIfnudi7WPlU
         rPA0AZIa4tByoT0X+Edze4AhDE6g/Krso7Nean85RFzp3k70AUOKjiONHcUvSmBzz//x
         gw3biuPP0HVXovg92jtKt41l/JZuWhkXqGej3UR65+OqJNeDej/il93teRH5p2a/6lRt
         MUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687814906; x=1690406906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CQ4hwJhKjIW7SikA2WYgmCLn8qhE0eQEFFM44s3DEg=;
        b=iAnVc8ArZFmLpOWWqMRt38XQMbDd4+ZJ7zzL4s3Xd07Fi9SAQ3TBkqNLbDLEukdk+O
         PIFE4KicB+dHOIRPOlvqXqj92QTHsU7uSTcYD3QXNz7BIWNCdOrRrO+0saueYk0EmR+s
         pWqvefkKYA0bemNtuhy4HWOJD+lwkBxypusx3oOSbHOOuP53q+BGu5AKwwdN3qPaz1R6
         jxc0en7ll1Rq2COgdi8OtoAMxJqfyvu+aDM9UZlt26B7odMCPCubVS7BY3/VJ59V4lpV
         OlRSvI5j/ZGfl8EGNhk2TKrcTnuFD+2/tSoq27dX4KTqNHkP29L+AO+A2dOj4WynIJgD
         lXIQ==
X-Gm-Message-State: AC+VfDzY34ZFHdxE1LBfTgPnlR/LokTfkV/Qp0GJIqU5B48XqwDz4wVp
        fj98pbaHBv47G7oz3cYIYhhBrn+z2X/wZB+/iCKV
X-Google-Smtp-Source: ACHHUZ59NsGIZ72LMPz3WNouR7OuGKAeY+Y9Bdjq1aCqzuo2wZQkHLVBJhWx7cTs99zy2+JYhDEZYq7slZwLlWfYEzc=
X-Received: by 2002:a0d:df4a:0:b0:570:7b4d:f694 with SMTP id
 i71-20020a0ddf4a000000b005707b4df694mr22567386ywe.3.1687814906155; Mon, 26
 Jun 2023 14:28:26 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Jun 2023 17:28:15 -0400
Message-ID: <CAHC9VhTC6s-_Q+5+evrgHHdE=wHLP0VXACzfsWSTLQ1ipyFRaw@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v6.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

We've got a number of SELinux patches for v6.5, but nothing too scary.
It is worth mentioning that there is a minor merge conflict in
security/selinux/Makefile (due to the quick fix sent during the
v6.4-rcX cycle); the proper way to resolve the conflict is to simply
take the version in this pull request.

Here is a quick summary of the changes:

- Thanks to help from the MPTCP folks, it looks like we have finally
sorted out a proper solution to the MPTCP socket labeling issue, see
the new security_mptcp_add_subflow() LSM hook.

- Fix the labeled NFS handling such that a labeled NFS share mounted
prior to the initial SELinux policy load is properly labeled once a
policy is loaded; more information in the commit description.

- Two patches to security/selinux/Makefile, the first took the
cleanups in v6.4 a bit further and the second removed the grouped
targets support as that functionality doesn't appear to be properly
supported prior to make v4.3.

- Deprecate the "fs" object context type in SELinux policies.  The fs
object context type was an old vestige that was introduced back in
v2.6.12-rc2 but never really used.

- A number of small changes that remove dead code, clean up some
awkward bits, and generally improve the quality of the code.  See the
individual commit descriptions for more information.

Thanks,
-Paul

--
The following changes since commit ac9a78681b921877518763ba0e89202254349d1b=
:

 Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20230626

for you to fetch changes up to 447a5688005e5b789633bd080016517a08f9fd8d:

 selinux: avoid bool as identifier name (2023-06-05 17:04:01 -0400)

----------------------------------------------------------------
selinux/stable-6.5 PR 20230626

----------------------------------------------------------------
Christian G=C3=B6ttsche (10):
     selinux: do not leave dangling pointer behind
     selinux: adjust typos in comments
     selinux: avc: drop unused function avc_disable()
     selinux: drop return at end of void function avc_insert()
     selinux: retain const qualifier on string literal in avtab_hash_eval()
     selinux: declare read-only data arrays const
     selinux: keep context struct members in sync
     selinux: make header files self-including
     selinux: deprecated fs ocon
     selinux: avoid bool as identifier name

Ondrej Mosnacek (1):
     selinux: make labeled NFS work when mounted before policy load

Paolo Abeni (2):
     security, lsm: Introduce security_mptcp_add_subflow()
     selinux: Implement mptcp_add_subflow hook

Paul Moore (3):
     selinux: more Makefile tweaks
     selinux: small cleanups in selinux_audit_rule_init()
     selinux: fix Makefile for versions of make < v4.3

Xiu Jianfeng (1):
     selinux: cleanup exit_sel_fs() declaration

include/linux/lsm_hook_defs.h                    |  1 +
include/linux/security.h                         |  6 ++
net/mptcp/subflow.c                              |  6 ++
security/security.c                              | 17 ++++++
security/selinux/Makefile                        | 28 ++++++---
security/selinux/avc.c                           | 20 ------
security/selinux/hooks.c                         | 78 +++++++++++++++-----
security/selinux/ima.c                           |  2 +-
security/selinux/include/audit.h                 |  2 +-
security/selinux/include/avc.h                   |  3 -
security/selinux/include/ibpkey.h                |  1 +
security/selinux/include/ima.h                   |  2 +-
security/selinux/include/initial_sid_to_string.h |  3 +
security/selinux/include/security.h              |  2 +-
security/selinux/netlabel.c                      |  8 ++-
security/selinux/selinuxfs.c                     |  4 +-
security/selinux/ss/avtab.c                      |  2 +-
security/selinux/ss/avtab.h                      |  2 +-
security/selinux/ss/conditional.c                |  8 +--
security/selinux/ss/conditional.h                |  2 +-
security/selinux/ss/context.h                    |  2 +
security/selinux/ss/policydb.c                   |  6 +-
security/selinux/ss/policydb.h                   |  2 +-
security/selinux/ss/services.c                   | 40 ++++++------
24 files changed, 158 insertions(+), 89 deletions(-)

--=20
paul-moore.com
