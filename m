Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA825C64ED6
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Mar 2023 14:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjCAOx3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Mar 2023 09:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCAOx2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Mar 2023 09:53:28 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5579222C2
        for <linux-security-module@vger.kernel.org>; Wed,  1 Mar 2023 06:53:26 -0800 (PST)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 321ErIoU070257;
        Wed, 1 Mar 2023 23:53:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Wed, 01 Mar 2023 23:53:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 321ErAtm070230
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 1 Mar 2023 23:53:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d4a7bfda-939d-3c5f-e5f4-c38a7fbd9003@I-love.SAKURA.ne.jp>
Date:   Wed, 1 Mar 2023 23:53:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] tomoyo: replace tomoyo_round2() with
 kmalloc_size_roundup()
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-security-module@vger.kernel.org
References: <20230228093556.19027-1-vbabka@suse.cz>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230228093556.19027-1-vbabka@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/02/28 18:35, Vlastimil Babka wrote:
> It seems tomoyo has had its own implementation of what
> kmalloc_size_roundup() does today. Remove the function tomoyo_round2()
> and replace it with kmalloc_size_roundup(). It provides more accurate
> results and doesn't contain a while loop.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  security/tomoyo/audit.c  |  6 +++---
>  security/tomoyo/common.c |  2 +-
>  security/tomoyo/common.h | 44 ----------------------------------------
>  3 files changed, 4 insertions(+), 48 deletions(-)
> 

Applied as https://osdn.net/projects/tomoyo/scm/git/tomoyo-test1/commits/c120c98486c2 .

Thank you.

