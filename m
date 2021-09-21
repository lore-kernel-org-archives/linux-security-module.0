Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEF8C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Sep 2021 08:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B649610E8
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Sep 2021 08:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhIUIeH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Sep 2021 04:34:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47268 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhIUIeH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Sep 2021 04:34:07 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632213157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=AaU/gPbcWTPTFafa4pRjg6uugKbP7Uqa8J30ZOGD9EU=;
        b=v5YnLc7AqnUdJz5b9XLuHIl6VO6U/PlOaQTRZ8lHWLAVHD2EDnErVtGwmwCmaaSUjfk6Wx
        agQAquqZJic3VZuQF78XWd/xE/+AzDZx3Wy4d2poc6tWyJP9BxwBabG6kWXb/s0bLGbqep
        ES87nY2cSFHi9AKOC8nMR4XVR1qrMeitRRgmxXzEaxc6yNE6NE4KZ1hZQrKpkXCPCJ8am8
        dZd6YmM/WYsGjvlMxV1tt5NzLDvRsSooO7M1mF0yRfNz3fBQllHS7dOIg8uJvFGrSLuUUV
        /Pgy7CivLwaq9lVbG6AeyzceQyulGlDEkHzYIQTr4HFnB7aG3GTnSMsHEWr7PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632213157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=AaU/gPbcWTPTFafa4pRjg6uugKbP7Uqa8J30ZOGD9EU=;
        b=Kt0f3KnieOBogln1dx3PEKUi1rciS0LweQRwFz1xEtG6mmS+Mjmh2QMpGXvyz/sQHGmN38
        JtBgxfp88nFTEUAg==
To:     John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: apparmor: WARNING: suspicious RCU usage
Date:   Tue, 21 Sep 2021 10:32:37 +0200
Message-ID: <877dfa72hm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Running with CONFIG_PROVE_RCU_LIST triggers the following splat:

[    6.805926] =============================
[    6.806848] WARNING: suspicious RCU usage
[    6.807738] 5.15.0-rc2+ #24 Tainted: G            E    
[    6.808860] -----------------------------
[    6.809734] security/apparmor/include/lib.h:191 RCU-list traversed in non-reader section!!
[    6.811508] 
               other info that might help us debug this:

[    6.811516] 
               rcu_scheduler_active = 2, debug_locks = 1
[    6.811527] 2 locks held by apparmor_parser/1897:
[    6.811530]  #0: ffff88885f139450 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x68/0xe0
[    6.816110]  #1: ffff8881000578a0 (&ns->lock){+.+.}-{3:3}, at: aa_replace_profiles+0x16d/0x11e0
[    6.817418] 
               stack backtrace:
[    6.818086] CPU: 38 PID: 1897 Comm: apparmor_parser Tainted: G            E     5.15.0-rc2+ #24
[    6.819359] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
[    6.820536] Call Trace:
[    6.820918]  dump_stack_lvl+0x57/0x72
[    6.821499]  __lookupn_profile+0x193/0x1a0
[    6.822461]  aa_replace_profiles+0x395/0x11e0
[    6.823448]  policy_update+0x13f/0x240
[    6.824326]  profile_replace+0xb1/0x120
[    6.825213]  vfs_write+0xe4/0x3b0
[    6.826027]  ksys_write+0x68/0xe0
[    6.826576]  do_syscall_64+0x3b/0x90
[    6.827099]  entry_SYSCALL_64_after_hwframe+0x44/0xae

which is pretty obvious because aa_replace_profile() invokes:

    __lookup_replace()
      __lookup_profile()
        __strn_find_child()
          __policy_strn_find()
            list_for_each_entry_rcu()  <- Splat

The code is "correct" as this is the writer side and holding ns->lock,
but it's incorrect to use list_for_each_entry_rcu() without being in a
read side critical section unless it is properly annotated.

Same problem in the same function vs. __lookup_parent() and there are
more issues of that sort, e.g. vs. __lookup_profile() in
aa_remove_profiles().

Thanks,

        tglx
