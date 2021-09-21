Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DEAC433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Sep 2021 21:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0439E6109E
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Sep 2021 21:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhIUVZG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Sep 2021 17:25:06 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:47244
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhIUVZG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Sep 2021 17:25:06 -0400
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 15AA0401A5;
        Tue, 21 Sep 2021 21:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632259409;
        bh=G6F86AKGq73JnF59j667fCmaxhjYnzVx/CjEQY1Jr+c=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=q/iCMNsxtzSkStRH1tkk0U6ie/EgGZzYEA+mNFjBXt0rfZu+rMHuGI59dHZA3ThZR
         KnUh0/iH91yQWY4vK3RcUaTbJBIfCp1g/TehdJofmlkYddYQemXxjsvG02ZJnt1unw
         kRQGvNyl7ZQIgnCfLEaDm+BP+INGRZdxDR3uia04vWAZCZFxzzArreVSFeMiAhO8c7
         EakNDCRyYEv7BBut2TSaAXWmYu6lNpmu/ykPxZIujgoKP4SmHfWSndoivFMYaoo2sn
         beyfP/H/KZHPRajKZTnBn0/1VuqgD6CyqWjTGTJdOMU2yqKHTfKE8F+fT9GFtdCVhe
         EPkeaYbXN0sFg==
Subject: Re: apparmor: WARNING: suspicious RCU usage
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <877dfa72hm.ffs@tglx>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <4dbd0e0d-b1a3-8a06-5f65-bdcbb76fccee@canonical.com>
Date:   Tue, 21 Sep 2021 14:23:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <877dfa72hm.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/21/21 1:32 AM, Thomas Gleixner wrote:
> 
> Running with CONFIG_PROVE_RCU_LIST triggers the following splat:
> 
> [    6.805926] =============================
> [    6.806848] WARNING: suspicious RCU usage
> [    6.807738] 5.15.0-rc2+ #24 Tainted: G            E    
> [    6.808860] -----------------------------
> [    6.809734] security/apparmor/include/lib.h:191 RCU-list traversed in non-reader section!!
> [    6.811508] 
>                other info that might help us debug this:
> 
> [    6.811516] 
>                rcu_scheduler_active = 2, debug_locks = 1
> [    6.811527] 2 locks held by apparmor_parser/1897:
> [    6.811530]  #0: ffff88885f139450 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x68/0xe0
> [    6.816110]  #1: ffff8881000578a0 (&ns->lock){+.+.}-{3:3}, at: aa_replace_profiles+0x16d/0x11e0
> [    6.817418] 
>                stack backtrace:
> [    6.818086] CPU: 38 PID: 1897 Comm: apparmor_parser Tainted: G            E     5.15.0-rc2+ #24
> [    6.819359] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> [    6.820536] Call Trace:
> [    6.820918]  dump_stack_lvl+0x57/0x72
> [    6.821499]  __lookupn_profile+0x193/0x1a0
> [    6.822461]  aa_replace_profiles+0x395/0x11e0
> [    6.823448]  policy_update+0x13f/0x240
> [    6.824326]  profile_replace+0xb1/0x120
> [    6.825213]  vfs_write+0xe4/0x3b0
> [    6.826027]  ksys_write+0x68/0xe0
> [    6.826576]  do_syscall_64+0x3b/0x90
> [    6.827099]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> which is pretty obvious because aa_replace_profile() invokes:
> 
>     __lookup_replace()
>       __lookup_profile()
>         __strn_find_child()
>           __policy_strn_find()
>             list_for_each_entry_rcu()  <- Splat
> 
> The code is "correct" as this is the writer side and holding ns->lock,
> but it's incorrect to use list_for_each_entry_rcu() without being in a
> read side critical section unless it is properly annotated.
> 
> Same problem in the same function vs. __lookup_parent() and there are
> more issues of that sort, e.g. vs. __lookup_profile() in
> aa_remove_profiles().
> 
thanks Thomas, I look into it

