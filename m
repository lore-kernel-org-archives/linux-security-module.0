Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E81C4338F
	for <linux-security-module@archiver.kernel.org>; Sun, 15 Aug 2021 09:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E35461038
	for <linux-security-module@archiver.kernel.org>; Sun, 15 Aug 2021 09:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhHOJsT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 15 Aug 2021 05:48:19 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:58790
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232507AbhHOJsT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 15 Aug 2021 05:48:19 -0400
Received: from [192.168.192.153] (unknown [50.45.173.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D9C833F0AB;
        Sun, 15 Aug 2021 09:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629020867;
        bh=qwyay/dEQEEK6waiS0XNV4Vw4UtAbQ2ptEmOpQd9FII=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=EVNtqTvJvPfxiARjevKAO52t9iDlan3/hRGljK0qOOyLh7lB6PE6U02wvHcFmu/UX
         y5HLKeRHg8LHcMzgE6h5xwVJCDtt0DcyvYV8I+M4g7IQkkQsvgUmJHOMiYIxsbASKQ
         DHvm2VIQPRW00EX4R1AkQADqcn6b0pMsYWyZh1g2UPrieXufBnba9Gc2OXGLnhPGN+
         HZFpM3r6sGeFcEJtZn2QFPQei8e5ckam80fP4WWGcHPNbWp2m8Zpo6kf1mGV7J1G2R
         tFXM/MpHrJnao5arvYF8AjuLEuKd5kpxoLVLk1R8EoMAHfE2FsB2spucfTMyNZ4Lsu
         2vrwMXqHow3xw==
Subject: Re: apparmor: global buffers spin lock may get contended
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <YO2S+C7Cw7AS7bsg@google.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <fbf051ea-5a6b-37d0-e7b7-6513e4da9273@canonical.com>
Date:   Sun, 15 Aug 2021 02:47:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YO2S+C7Cw7AS7bsg@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/13/21 6:19 AM, Sergey Senozhatsky wrote:
> Hi,
> 
> We've notices that apparmor has switched from using per-CPU buffer pool
> and per-CPU spin_lock to a global spin_lock in df323337e507a0009d3db1ea.
> 
> This seems to be causing some contention on our build machines (with
> quite a bit of cores). Because that global spin lock is a part of the
> stat() sys call (and perhaps some other)
> 
> E.g.
> 
> -    9.29%     0.00%  clang++          [kernel.vmlinux]                        
>    - 9.28% entry_SYSCALL_64_after_hwframe                                      
>       - 8.98% do_syscall_64                                                    
>          - 7.43% __do_sys_newlstat                                            
>             - 7.43% vfs_statx                                                  
>                - 7.18% security_inode_getattr                                  
>                   - 7.15% apparmor_inode_getattr                              
>                      - aa_path_perm                                            
>                         - 3.53% aa_get_buffer                                  
>                            - 3.47% _raw_spin_lock                              
>                                 3.44% native_queued_spin_lock_slowpath        
>                         - 3.49% aa_put_buffer.part.0                          
>                            - 3.45% _raw_spin_lock                              
>                                 3.43% native_queued_spin_lock_slowpath   
> 
> Can we fix this contention?
> 

sorry this got filtered to a wrong mailbox. Yes this is something that can
be improved, and was a concern when the switch was made from per-CPU buffers
to the global pool.

We can look into doing a hybrid approach where we can per cpu cache a buffer
from the global pool. The trick will be coming up with when the cached buffer
can be returned so we don't run into the problems that lead to
df323337e507a0009d3db1ea
