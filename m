Return-Path: <SRS0=SKQR=64=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B4AC433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 14 May 2020 18:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7107620671
	for <linux-security-module@archiver.kernel.org>; Thu, 14 May 2020 18:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjKhf5Pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgENSYP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 May 2020 14:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726075AbgENSYO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 May 2020 14:24:14 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A031EC061A0C;
        Thu, 14 May 2020 11:24:14 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j21so1597636pgb.7;
        Thu, 14 May 2020 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GXa6PnUFgbyMdN1EyBLqwHTz+uuzg6SBgnPWkS0r0LY=;
        b=UjKhf5Pakj1PRT2NUS7T0x8Kgcqe78a2NffVX1sDTbpyleID7QctCe0xL3M1PwYVI+
         zAtYsgoWZ+BVedXbsyLsbRowGEIlXg5ThyW9kwLH/SLYw+bk2dHUbTCPLeBNGQWBssrG
         UPjunlYTOxPrA3Cs8ADgHno5puyVV+fVJmgiIqhX4/WrQjaUPNpQG8uYaEEBFSCOiKT2
         9LsRek5xLBc5g+pxyRjj74BtsUh3d/mnqTbPj0QaxTUu6qf0pS6AMKcyeCMkOhoPB49z
         UWxYETWuYgN9157+ikH2iilGAiuZa8Kk32VM9ACbJtlqpcbXPs8NShkV+j6c4Z9t0lZx
         0C+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GXa6PnUFgbyMdN1EyBLqwHTz+uuzg6SBgnPWkS0r0LY=;
        b=DQuHjspBqXZympN6glwLBetq7jSOX+nL2e3Ag1kEB785eWMfhWzxTh4ut8RPNCSf02
         6Xq5GrrFfxj2Y3WUSUA7r+8wTeXWQBYmmdTB/o++p5QvJqkBaXBvh7tDt32dgd/K+wcA
         KBvfvOao0Ejf8Vml73dh9QUXK6ZJySNeFS1pHWTR6Bt6aNg+c54KvSX9eIgcmRfu2RBL
         UUkBX9smv4AvXwLQLas3ONU+zivl+PuDW2fQ60OUa7yUHLCorsw+Dxdus44pj6HFLYnR
         34Dishy3visfR+P/UPjolfll5fp3Jj7epO0ZMNXLkUo4+HYQN7MojburR7v2d+b6jDUt
         IM3g==
X-Gm-Message-State: AOAM5329COQmuIORebOLHnSLFADpEccIBJdFZpKJ4t8E6vXn09blsuFt
        ZOaCmMyxBX+N+nCr/bAOZOI=
X-Google-Smtp-Source: ABdhPJzPQ03vkAOu8tmw3l1XdUBZ55aD3PqOv1MJlYavj27ZNUI11YU1DU52ijPUkQMTDSd+QF5MjQ==
X-Received: by 2002:a63:3756:: with SMTP id g22mr5098342pgn.304.1589480654120;
        Thu, 14 May 2020 11:24:14 -0700 (PDT)
Received: from workstation-kernel-dev ([103.87.56.31])
        by smtp.gmail.com with ESMTPSA id x185sm2863248pfx.155.2020.05.14.11.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 11:24:12 -0700 (PDT)
Date:   Thu, 14 May 2020 23:54:06 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: WARNING: suspicious RCU usage with PROVE_RCU_LIST=y
Message-ID: <20200514182406.GA28808@workstation-kernel-dev>
References: <20200406114134.GA1010@workstation-kernel-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406114134.GA1010@workstation-kernel-dev>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 06, 2020 at 05:11:34PM +0530, Amol Grover wrote:
> Hello,
> 
> With respect to the patch https://lore.kernel.org/patchwork/patch/1202512/
> I boot tested with CONFIG_PROVE_RCU_LIST=y and encountered a susppicious RCU
> usage warning in "security/apparmor/include/lib.h". I thought of going forward
> and fix it myself, however, while going through the stack trace and the actual
> code, I found that the function (__lookupn_profile) is required to be called
> with rcu_read_locK() but the splat proves it otherwise.
> 
> [   12.727582] =============================
> [   12.727599] WARNING: suspicious RCU usage
> [   12.727601] 5.5.4-stable #17 Tainted: G            E     
> [   12.727602] -----------------------------
> [   12.727604] security/apparmor/include/lib.h:191 RCU-list traversed in non-reader section!!
> [   12.727605] 
>                other info that might help us debug this:
> 
> [   12.727606] 
>                rcu_scheduler_active = 2, debug_locks = 1 
> [   12.727608] 2 locks held by apparmor_parser/506:
> [   12.727609]  #0: ffff9f0687562490 (sb_writers#10){.+.+}, at: vfs_write+0x140/0x1a0
> [   12.727614]  #1: ffff9f0687f09ca8 (&ns->lock){+.+.}, at: aa_replace_profiles+0x17a/0xdd0
> [   12.727619] 
>                stack backtrace:
> [   12.727621] CPU: 3 PID: 506 Comm: apparmor_parser Tainted: G            E     5.5.4-stable #17 
> [   12.727622] Hardware name: Gigabyte Technology Co., Ltd. Z170-D3H/Z170-D3H-CF, BIOS F21 03/06/2017
> [   12.727623] Call Trace:
> [   12.727627]  dump_stack+0x8f/0xd0
> [   12.727630]  __lookupn_profile+0x19c/0x1a0
> [   12.727632]  ? aa_unpack+0x51b/0x580
> [   12.727636]  __lookup_replace+0x34/0xc0
> [   12.727640]  aa_replace_profiles+0x2a0/0xdd0
> [   12.727649]  policy_update+0x106/0x370
> [   12.727653]  profile_replace+0xa3/0x110
> [   12.727657]  vfs_write+0xb9/0x1a0
> [   12.727661]  ksys_write+0x68/0xe0
> [   12.727666]  do_syscall_64+0x5c/0xe0
> [   12.727669]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   12.727671] RIP: 0033:0x7ff83fec7f93
> [   12.727673] Code: 75 05 48 83 c4 58 c3 e8 eb 41 ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
> [   12.727674] RSP: 002b:00007ffcebb5c398 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [   12.727676] RAX: ffffffffffffffda RBX: 0000000000007131 RCX: 00007ff83fec7f93
> [   12.727677] RDX: 0000000000007131 RSI: 00005610fd804a40 RDI: 0000000000000006
> [   12.727678] RBP: 00005610fd804a40 R08: 0000000000007131 R09: 00005610fd802f38
> [   12.727680] R10: fffffffffffffa8a R11: 0000000000000246 R12: 0000000000000000
> [   12.727681] R13: 0000000000000006 R14: 00005610fd7dd490 R15: 0000000000007131
> 
> Thanks
> Amol

Hello,

Just a friendly request to please go through the above _bug_.

Thanks
Amol
