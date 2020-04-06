Return-Path: <SRS0=ULH2=5W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A03C2BA19
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Apr 2020 11:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728ED206C3
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Apr 2020 11:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7uNUv3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgDFLln (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:41:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37156 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgDFLlm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Apr 2020 07:41:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id u65so7398358pfb.4;
        Mon, 06 Apr 2020 04:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=khaADiBEnPr/yBlje3uAgQCwft8k315e7ByTRXW7oXU=;
        b=Y7uNUv3efSr2xz7wgzuH02VmrQdMTpdIi9Lki3b4EulZLOaXcq6zPV9xdxNsmy2zoA
         +Fg3q9rbxLEDeHa3zHL4erFLTaIo3sgqAlXMrAxD60xNz4R5XskHZ3fsKd0uFt4HnDL6
         nQh7weza2AFRwS02mIS73DxOnZSltucTfbgrKTXQbjT2ayU7ZIh11jEUEvtjh8W35AED
         Ss79dyu6WHDwKqzTWivLmUKRisan2bpjqKjGZOugHLv7NaInxYyho23+yZuelPD7RGhc
         gAe6mxV+1CpDji5bdZvh+7RxZ1btvvvmVStc/aB937wYJ8OzjELd9aQhujdLjU/z5rlf
         2hkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=khaADiBEnPr/yBlje3uAgQCwft8k315e7ByTRXW7oXU=;
        b=aW1rF75rH9UZyri0DM5AbmM5hQFmzHBaV0LV3GHIoUw7nlIGbaEa8HHxwT89Tuv5FK
         nTe6m8M+hIxTOGXRVF07bmu4zEHrq5T5xehx9RHMQCHlIt4q6Z3Bndsdg9OhT9NtgjPT
         W/C/XZoENQyvWyBvIIfUrBZ4Q2idf1OEhDhRS9fWeOgg7djcQt0sRsAo5C16guMgei4B
         k+QobEJlnuXOWxyunow+t1D0qHcWv99iplmSW4KwUd8vVGWPE2P4Z3T6SvLtFHWJeInp
         5OFPD7xRz5li5nfU4Zby0H6Euu4MtIv8cLN1VEsJgElVcN0rNkLmXWunx9BYqBCjmY6y
         WNOw==
X-Gm-Message-State: AGi0PubsqKD1kOXtxBEVvrAbpWbbnZ+X00tQ0xUWCdpgORSsvWAjrrfm
        ZyMW8k7AkwnCX4CWoua82wE=
X-Google-Smtp-Source: APiQypIeFR+QhiRl1WvO/7FmfVE+EkA6IKJb7Ao1Jqu4ourF3I44qDqx0e/vuZeG6WrKcI8ZLWGWVA==
X-Received: by 2002:a63:fe44:: with SMTP id x4mr19228097pgj.95.1586173300169;
        Mon, 06 Apr 2020 04:41:40 -0700 (PDT)
Received: from workstation-kernel-dev ([103.87.57.178])
        by smtp.gmail.com with ESMTPSA id r64sm11919208pjb.15.2020.04.06.04.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 04:41:39 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:11:34 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: WARNING: suspicious RCU usage with PROVE_RCU_LIST=y
Message-ID: <20200406114134.GA1010@workstation-kernel-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

With respect to the patch https://lore.kernel.org/patchwork/patch/1202512/
I boot tested with CONFIG_PROVE_RCU_LIST=y and encountered a susppicious RCU
usage warning in "security/apparmor/include/lib.h". I thought of going forward
and fix it myself, however, while going through the stack trace and the actual
code, I found that the function (__lookupn_profile) is required to be called
with rcu_read_locK() but the splat proves it otherwise.

[   12.727582] =============================
[   12.727599] WARNING: suspicious RCU usage
[   12.727601] 5.5.4-stable #17 Tainted: G            E     
[   12.727602] -----------------------------
[   12.727604] security/apparmor/include/lib.h:191 RCU-list traversed in non-reader section!!
[   12.727605] 
               other info that might help us debug this:

[   12.727606] 
               rcu_scheduler_active = 2, debug_locks = 1 
[   12.727608] 2 locks held by apparmor_parser/506:
[   12.727609]  #0: ffff9f0687562490 (sb_writers#10){.+.+}, at: vfs_write+0x140/0x1a0
[   12.727614]  #1: ffff9f0687f09ca8 (&ns->lock){+.+.}, at: aa_replace_profiles+0x17a/0xdd0
[   12.727619] 
               stack backtrace:
[   12.727621] CPU: 3 PID: 506 Comm: apparmor_parser Tainted: G            E     5.5.4-stable #17 
[   12.727622] Hardware name: Gigabyte Technology Co., Ltd. Z170-D3H/Z170-D3H-CF, BIOS F21 03/06/2017
[   12.727623] Call Trace:
[   12.727627]  dump_stack+0x8f/0xd0
[   12.727630]  __lookupn_profile+0x19c/0x1a0
[   12.727632]  ? aa_unpack+0x51b/0x580
[   12.727636]  __lookup_replace+0x34/0xc0
[   12.727640]  aa_replace_profiles+0x2a0/0xdd0
[   12.727649]  policy_update+0x106/0x370
[   12.727653]  profile_replace+0xa3/0x110
[   12.727657]  vfs_write+0xb9/0x1a0
[   12.727661]  ksys_write+0x68/0xe0
[   12.727666]  do_syscall_64+0x5c/0xe0
[   12.727669]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   12.727671] RIP: 0033:0x7ff83fec7f93
[   12.727673] Code: 75 05 48 83 c4 58 c3 e8 eb 41 ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[   12.727674] RSP: 002b:00007ffcebb5c398 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   12.727676] RAX: ffffffffffffffda RBX: 0000000000007131 RCX: 00007ff83fec7f93
[   12.727677] RDX: 0000000000007131 RSI: 00005610fd804a40 RDI: 0000000000000006
[   12.727678] RBP: 00005610fd804a40 R08: 0000000000007131 R09: 00005610fd802f38
[   12.727680] R10: fffffffffffffa8a R11: 0000000000000246 R12: 0000000000000000
[   12.727681] R13: 0000000000000006 R14: 00005610fd7dd490 R15: 0000000000007131

Thanks
Amol
