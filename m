Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3ECCA0FF6
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Sep 2023 00:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351447AbjIBAtA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 Sep 2023 20:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240699AbjIBAtA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Sep 2023 20:49:00 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED1EE7E
        for <linux-security-module@vger.kernel.org>; Fri,  1 Sep 2023 17:48:57 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68bee12e842so2158794b3a.3
        for <linux-security-module@vger.kernel.org>; Fri, 01 Sep 2023 17:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693615736; x=1694220536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylIMM6O8H66mX5wEUzm+jJ9Dx/8lS9WU/xj1ockT74I=;
        b=FRyQraa/n3/pc6/pD9s70+nS3mdzfKnMpEUmT19KKJwbm9Xc5QwkIFfW5I6sldl9aT
         aU4KtJRvOS/Nnt7K/K4TGT/ZS3XIUUyndHrqTE4vjX6LmIuq9d7Mn61XuCTUB3i58qTK
         QUbb4/WstZduVc5qSOgIa7enLyzAwvXWNSCmlLcTYwi1IT35+UYTdeHQjCu5FC9+mNPY
         Yq7X6nHmUXiK2OvWVkIqgbiVD5IVfZb8b1FVroPEkdEvcpVFzyDVr7qFCD4/IWdP87aC
         HgqUm7MBdsB82ilhEMRgZEPeQFXiRpzFrmKTsW+HWgouz4hGeFDwPhgpce7wLZmpWd/F
         K+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693615736; x=1694220536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylIMM6O8H66mX5wEUzm+jJ9Dx/8lS9WU/xj1ockT74I=;
        b=VFA0WBRKlYHSo6NbnRg4llyuGFQ+iWO4gEqMcd+2D6jScNfa3sKe+RN6XkPyipvMhz
         rJh3AQ5aHGsg5O7MSxSxOY31YxnGsYuC0m0qRA8tMOrizvmUdEjCbFouS+Pg6lONV4Pl
         5axSI+DOUW6w6D7sFpEXUPEP6kqvqfEPflaTxqG9tOrnurRLhwiZ14xQgWjjLxO+sv28
         qgYOG5o9hEgchrVH9JvFFPrlY2UKVbZBteX55w9P6BnTyCmqV4fKOztGu+7XLPqO1iM3
         mFrbvS/Wn/pSStt8j36eSYRIvIvXD61hNYyBIq5eLtaYP2C5uxQMEGrzknfj0xf8dLfQ
         BbSA==
X-Gm-Message-State: AOJu0YwE9tYo19hoPMhe0D81aGD7Jvr0ZDs8es/vP5XgvctygWAj5s+1
        sfyJ37hn46zfMD1SoYos7WKlKteWYISi8A==
X-Google-Smtp-Source: AGHT+IGwfgkjwdVjFrI6ycJe+rkV6NFEqoOfjMR1W/MtOaDc4kPKbK7aa4oxTVDwBayQRTvJVDRWLQ==
X-Received: by 2002:a05:6a20:7f9a:b0:141:d54e:a907 with SMTP id d26-20020a056a207f9a00b00141d54ea907mr5911133pzj.19.1693615736314;
        Fri, 01 Sep 2023 17:48:56 -0700 (PDT)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902c1c100b001b83dc8649dsm3543356plc.250.2023.09.01.17.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 17:48:56 -0700 (PDT)
From:   Xiao Liang <shaw.leon@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH] apparmor: Fix null pointer deref when receiving skb during sock creation
Date:   Sat,  2 Sep 2023 08:48:38 +0800
Message-ID: <20230902004841.614102-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The panic below is observed when receiving ICMP packets with secmark set
while an ICMP raw socket is being created. SK_CTX(sk)->label is updated
in apparmor_socket_post_create(), but the packet is delivered to the
socket before that, causing the null pointer dereference.
Drop the packet if label context is not set.

    BUG: kernel NULL pointer dereference, address: 000000000000004c
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 0 P4D 0
    Oops: 0000 [#1] PREEMPT SMP NOPTI
    CPU: 0 PID: 407 Comm: a.out Not tainted 6.4.12-arch1-1 #1 3e6fa2753a2d75925c34ecb78e22e85a65d083df
    Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/28/2020
    RIP: 0010:aa_label_next_confined+0xb/0x40
    Code: 00 00 48 89 ef e8 d5 25 0c 00 e9 66 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 89 f0 <8b> 77 4c 39 c6 7e 1f 48 63 d0 48 8d 14 d7 eb 0b 83 c0 01 48 83 c2
    RSP: 0018:ffffa92940003b08 EFLAGS: 00010246
    RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000000e
    RDX: ffffa92940003be8 RSI: 0000000000000000 RDI: 0000000000000000
    RBP: ffff8b57471e7800 R08: ffff8b574c642400 R09: 0000000000000002
    R10: ffffffffbd820eeb R11: ffffffffbeb7ff00 R12: ffff8b574c642400
    R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000000
    FS:  00007fb092ea7640(0000) GS:ffff8b577bc00000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 000000000000004c CR3: 00000001020f2005 CR4: 00000000007706f0
    PKRU: 55555554
    Call Trace:
     <IRQ>
     ? __die+0x23/0x70
     ? page_fault_oops+0x171/0x4e0
     ? exc_page_fault+0x7f/0x180
     ? asm_exc_page_fault+0x26/0x30
     ? aa_label_next_confined+0xb/0x40
     apparmor_secmark_check+0xec/0x330
     security_sock_rcv_skb+0x35/0x50
     sk_filter_trim_cap+0x47/0x250
     sock_queue_rcv_skb_reason+0x20/0x60
     raw_rcv+0x13c/0x210
     raw_local_deliver+0x1f3/0x250
     ip_protocol_deliver_rcu+0x4f/0x2f0
     ip_local_deliver_finish+0x76/0xa0
     __netif_receive_skb_one_core+0x89/0xa0
     netif_receive_skb+0x119/0x170
     ? __netdev_alloc_skb+0x3d/0x140
     vmxnet3_rq_rx_complete+0xb23/0x1010 [vmxnet3 56a84f9c97178c57a43a24ec073b45a9d6f01f3a]
     vmxnet3_poll_rx_only+0x36/0xb0 [vmxnet3 56a84f9c97178c57a43a24ec073b45a9d6f01f3a]
     __napi_poll+0x28/0x1b0
     net_rx_action+0x2a4/0x380
     __do_softirq+0xd1/0x2c8
     __irq_exit_rcu+0xbb/0xf0
     common_interrupt+0x86/0xa0
     </IRQ>
     <TASK>
     asm_common_interrupt+0x26/0x40
    RIP: 0010:apparmor_socket_post_create+0xb/0x200
    Code: 08 48 85 ff 75 a1 eb b1 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 54 <55> 48 89 fd 53 45 85 c0 0f 84 b2 00 00 00 48 8b 1d 80 56 3f 02 48
    RSP: 0018:ffffa92940ce7e50 EFLAGS: 00000286
    RAX: ffffffffbc756440 RBX: 0000000000000000 RCX: 0000000000000001
    RDX: 0000000000000003 RSI: 0000000000000002 RDI: ffff8b574eaab740
    RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
    R10: ffff8b57444cec70 R11: 0000000000000000 R12: 0000000000000003
    R13: 0000000000000002 R14: ffff8b574eaab740 R15: ffffffffbd8e4748
     ? __pfx_apparmor_socket_post_create+0x10/0x10
     security_socket_post_create+0x4b/0x80
     __sock_create+0x176/0x1f0
     __sys_socket+0x89/0x100
     __x64_sys_socket+0x17/0x20
     do_syscall_64+0x5d/0x90
     ? do_syscall_64+0x6c/0x90
     ? do_syscall_64+0x6c/0x90
     ? do_syscall_64+0x6c/0x90
     entry_SYSCALL_64_after_hwframe+0x72/0xdc

Fixes: ab9f2115081a ("apparmor: Allow filtering based on secmark policy")
Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 security/apparmor/lsm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 108eccc5ada5..0dbff677ac2e 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1097,6 +1097,13 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	if (!skb->secmark)
 		return 0;
 
+	/*
+	 * If reach here before socket_post_create hook is called, in which
+	 * case label is null, drop the packet.
+	 */
+	if (!ctx->label)
+		return -EACCES;
+
 	return apparmor_secmark_check(ctx->label, OP_RECVMSG, AA_MAY_RECEIVE,
 				      skb->secmark, sk);
 }
-- 
2.42.0

