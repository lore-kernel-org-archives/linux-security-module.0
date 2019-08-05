Return-Path: <SRS0=x/8A=WB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2775C0650F
	for <linux-security-module@archiver.kernel.org>; Mon,  5 Aug 2019 10:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC842075B
	for <linux-security-module@archiver.kernel.org>; Mon,  5 Aug 2019 10:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfHEKCL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:02:11 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55954 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfHEKCK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 5 Aug 2019 06:02:10 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x75A22au079400;
        Mon, 5 Aug 2019 19:02:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Mon, 05 Aug 2019 19:02:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x75A1vXj079327
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 5 Aug 2019 19:02:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] security/tomoyo: convert put_page() to put_user_page*()
To:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        linux-security-module@vger.kernel.org
References: <20190805022626.13291-1-jhubbard@nvidia.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <346e5a8e-57fe-b2ac-4069-50a8a83048b5@i-love.sakura.ne.jp>
Date:   Mon, 5 Aug 2019 19:01:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805022626.13291-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/08/05 11:26, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page() or
> release_pages().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
> 
> Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Sending to Andrew Morton means you expect this patch to go via -mm tree, don't you?
Andrew, please take this patch. Thank you.
