Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3929BC2BB40
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Dec 2020 02:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D0DE20782
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Dec 2020 02:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgLOCTW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Dec 2020 21:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgLOCTN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Dec 2020 21:19:13 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05C2C06179C
        for <linux-security-module@vger.kernel.org>; Mon, 14 Dec 2020 18:18:32 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id b9so486514ejy.0
        for <linux-security-module@vger.kernel.org>; Mon, 14 Dec 2020 18:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=epG8wiJEk1ZMX2bNaXtx4G2PAZzvvEvXiU4VYVabbH0=;
        b=UDsWdaFAysTob03FiK+EApVxXkCX+rRhlkA9bnaihv6Y03By2IpV1OjJpvTBg6Yquf
         0CIIvtiajxrLuO776i3rhBnZfS/Pyl0TUIyNBb6hnRhaay4QoUAVhcRv5oQNVAqdZbwu
         w5eKz9fqgLvOlvBuj9r6z1lrk3m3tVC3VnpTzcIvbY8IvQzZr/S0dekG/C0TAoqpbGN3
         mV3YZBgtx54LyqOEDnO6qveWVlI8Hs40RppalkzHd17Dy2tC/EpTihEOL1efih+CirxR
         erZ09FaAxP5FhymaqG7wTZBWDzhuMmnFBjC+CpItQsieELQjFcHIfPoR9N2BFZIKuNn+
         EXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=epG8wiJEk1ZMX2bNaXtx4G2PAZzvvEvXiU4VYVabbH0=;
        b=ZpZCiWvYWmzVTKcgt6Xoky2tEDco865cao2rl8un28tI5A5Zh1QHN4WHWqy7iSdejn
         1sHX2/HFer6Rf+A3EGkCBpM/jeDu2H4YZRzaHx0wN9MzehsCE24Bpy7oFNAl3rIurZ2I
         X6sIszH2VmGmtBOMnrNsiSGUdqWSKGxvb/mXuOH+kBHYGDcIppc8SGtGcpXondLoP2qB
         aQHCZXmfeoG+HhwVRnPnFEi7vHaAOwAWG62mtHXNCg82B16Dq+HPtyqkd8TXOzy3Iqsx
         hnUtucbt6rjR1K/q2VHMDU+mR2Cb/MU0nWqS9AfWUVZ1w50H8ePhPCHDr6dkQyxoQ7xM
         veoA==
X-Gm-Message-State: AOAM5304i3oL4WGpMSd+ToIb26ARlJQeEpe1Kxtbdk42YQJ1oWgnV8aI
        y5ADkLTPY459XTHTxoFTekC0ARwZupfNP0F5/ALU
X-Google-Smtp-Source: ABdhPJx4iUs+6Y7IRmemoXw4+mMYFmBN/WiDklGS3zYLAkW2tX/fmAKWtv6YilHMABA3Ss08dKEAollknAt58WSzqpQ=
X-Received: by 2002:a17:906:aec6:: with SMTP id me6mr6267598ejb.542.1607998711594;
 Mon, 14 Dec 2020 18:18:31 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 14 Dec 2020 21:18:20 -0500
Message-ID: <CAHC9VhT85MwDwrB_pAvU+g12SnGZ1g9Tvqr4nJqBpZfEw1GAdg@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.11
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

While we have a small number of SELinux patches for v5.11, there are a
few changes worth highlighting:

- Change the LSM network hooks to pass flowi_common structs instead of
the parent flowi struct as the LSMs do not currently need the full
flowi struct and they do not have enough information to use it safely
(missing information on the address family).  This patch was discussed
both with Herbert Xu (representing team netdev) and James Morris
(representing team LSMs-other-than-SELinux).

- Fix how we handle errors in inode_doinit_with_dentry() so that we
attempt to properly label the inode on following lookups instead of
continuing to treat it as unlabeled.

- Tweak the kernel logic around allowx, auditallowx, and dontauditx
SELinux policy statements such that the auditx/dontauditx are
effective even without the allowx statement.

Everything passes our test suite and as of an hour or two ago it
applies cleanly to your tree; please merge for v5.11.

Thanks,
-Paul

--
The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

 Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20201214

for you to fetch changes up to 3df98d79215ace13d1e91ddfc5a67a0f5acbd83f:

 lsm,selinux: pass flowi_common instead of flowi to the LSM hooks
   (2020-11-23 18:36:21 -0500)

----------------------------------------------------------------
selinux/stable-5.11 PR 20201214

----------------------------------------------------------------
Gustavo A. R. Silva (1):
     selinux: Fix fall-through warnings for Clang

Ondrej Mosnacek (1):
     selinux: drop super_block backpointer from superblock_security_struct

Paul Moore (2):
     selinux: fix inode_doinit_with_dentry() LABEL_INVALID error handling
     lsm,selinux: pass flowi_common instead of flowi to the LSM hooks

Tianyue Ren (1):
     selinux: fix error initialization in inode_doinit_with_dentry()

bauen1 (1):
     selinux: allow dontauditx and auditallowx rules to take effect without
       allowx

.../chelsio/inline_crypto/chtls/chtls_cm.c         |  2 +-
drivers/net/wireguard/socket.c                     |  4 ++--
include/linux/lsm_hook_defs.h                      |  4 ++--
include/linux/lsm_hooks.h                          |  2 +-
include/linux/security.h                           | 23 +++++++++-------
include/net/flow.h                                 | 10 +++++++++
include/net/route.h                                |  6 ++---
net/dccp/ipv4.c                                    |  2 +-
net/dccp/ipv6.c                                    |  6 ++---
net/ipv4/icmp.c                                    |  4 ++--
net/ipv4/inet_connection_sock.c                    |  4 ++--
net/ipv4/ip_output.c                               |  2 +-
net/ipv4/ping.c                                    |  2 +-
net/ipv4/raw.c                                     |  2 +-
net/ipv4/syncookies.c                              |  2 +-
net/ipv4/udp.c                                     |  2 +-
net/ipv6/af_inet6.c                                |  2 +-
net/ipv6/datagram.c                                |  2 +-
net/ipv6/icmp.c                                    |  6 ++---
net/ipv6/inet6_connection_sock.c                   |  4 ++--
net/ipv6/netfilter/nf_reject_ipv6.c                |  2 +-
net/ipv6/ping.c                                    |  2 +-
net/ipv6/raw.c                                     |  2 +-
net/ipv6/syncookies.c                              |  2 +-
net/ipv6/tcp_ipv6.c                                |  4 ++--
net/ipv6/udp.c                                     |  2 +-
net/l2tp/l2tp_ip6.c                                |  2 +-
net/netfilter/nf_synproxy_core.c                   |  2 +-
net/xfrm/xfrm_state.c                              |  6 +++--
security/security.c                                | 17 +++++++-------
security/selinux/hooks.c                           | 26 ++++++++++++------
security/selinux/include/objsec.h                  |  1 -
security/selinux/include/xfrm.h                    |  2 +-
security/selinux/ss/services.c                     |  4 +---
security/selinux/xfrm.c                            | 13 ++++++-----
35 files changed, 101 insertions(+), 77 deletions(-)

-- 
paul moore
www.paul-moore.com
