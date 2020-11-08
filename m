Return-Path: <SRS0=H0OP=EO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E847C388F9
	for <linux-security-module@archiver.kernel.org>; Sun,  8 Nov 2020 04:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1F3207C3
	for <linux-security-module@archiver.kernel.org>; Sun,  8 Nov 2020 04:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgKHEMm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 7 Nov 2020 23:12:42 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:63424 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgKHEMm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 7 Nov 2020 23:12:42 -0500
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0A84CDPO039523;
        Sun, 8 Nov 2020 13:12:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp);
 Sun, 08 Nov 2020 13:12:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0A84CDQ5039516
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 8 Nov 2020 13:12:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 1/2] tomoyo: Convert get_user_pages*() to
 pin_user_pages*()
To:     John Hubbard <jhubbard@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <1604737451-19082-1-git-send-email-jrdr.linux@gmail.com>
 <e5401549-8c31-2c6d-58dd-864232de17af@nvidia.com>
 <e6859981-bc3c-9513-99e5-a99849786156@nvidia.com>
 <5efeb909-3e02-ba14-7a86-f18562a2fe69@i-love.sakura.ne.jp>
 <8590eb4c-256b-9ab0-5291-de8ec8d75276@nvidia.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <40bd424d-6c4d-8b03-5d97-c572ca777b77@i-love.sakura.ne.jp>
Date:   Sun, 8 Nov 2020 13:12:09 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <8590eb4c-256b-9ab0-5291-de8ec8d75276@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020/11/08 11:17, John Hubbard wrote:
>> Excuse me, but Documentation/core-api/pin_user_pages.rst says
>> "CASE 5: Pinning in order to _write_ to the data within the page"
>> while tomoyo_dump_page() is for "_read_ the data within the page".
>> Do we want to convert to pin_user_pages_remote() or lock_page() ?
>>
> 
> Sorry, I missed the direction here, was too focused on the Case 5
> aspect. Yes. Case 5 (which, again, I think we're about to re-document)
> is only about *writing* to data within the page.
> 
> So in this case, where it is just reading from the page, I think it's
> already from a gup vs pup point of view.
> 
> btw, it's not clear to me whether the current code is susceptible to any
> sort of problem involving something writing to the page while it
> is being dumped (I am curious). But changing from gup to pup wouldn't
> fix that, if it were a problem. It a separate question from this patch.

The "struct page" tomoyo_dump_page() accesses is argv/envp arguments passed
to execve() syscall. Therefore, these pages are not visible from threads
except current thread, and thus there is no possibility that these pages
are modified by other threads while current thread is reading.
