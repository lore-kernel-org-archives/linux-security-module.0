Return-Path: <SRS0=H0OP=EO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F181FC55ABD
	for <linux-security-module@archiver.kernel.org>; Sun,  8 Nov 2020 05:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A129D20760
	for <linux-security-module@archiver.kernel.org>; Sun,  8 Nov 2020 05:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="guvtqofO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgKHFA1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 8 Nov 2020 00:00:27 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9187 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgKHFA1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 8 Nov 2020 00:00:27 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa77b6e0000>; Sat, 07 Nov 2020 21:00:30 -0800
Received: from [10.2.62.222] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 8 Nov
 2020 05:00:26 +0000
Subject: Re: [PATCH 1/2] tomoyo: Convert get_user_pages*() to
 pin_user_pages*()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Souptick Joarder <jrdr.linux@gmail.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <1604737451-19082-1-git-send-email-jrdr.linux@gmail.com>
 <e5401549-8c31-2c6d-58dd-864232de17af@nvidia.com>
 <e6859981-bc3c-9513-99e5-a99849786156@nvidia.com>
 <5efeb909-3e02-ba14-7a86-f18562a2fe69@i-love.sakura.ne.jp>
 <8590eb4c-256b-9ab0-5291-de8ec8d75276@nvidia.com>
 <40bd424d-6c4d-8b03-5d97-c572ca777b77@i-love.sakura.ne.jp>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <1174ed3e-d33c-6de9-3873-b122013b295a@nvidia.com>
Date:   Sat, 7 Nov 2020 21:00:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <40bd424d-6c4d-8b03-5d97-c572ca777b77@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604811630; bh=0F6FyPkKxLlO1J2Iwb+PkNH/lUr59fnpYgGGqGjgy9s=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=guvtqofOgQi9R86WymuUok80xhTaRW7Ydwf2bzPE7ZlgTFvHZztcJn+uTj9QO4BLF
         FVi8q2YXZ1wk9KHvnu2QyDtNFM7RXARHcy2oJaUiMthsvwIWx6khreikAVIwciH4gp
         tNgaUfiAKzRTQn53dtPM/bNCqTkEWS2WLCNXvFRuBUEO0T/LLRMapBerGC/uuy5mFu
         leFuUbf8jTdR43PTybiEgbfUdd3AaqUPZK31V34Yf1y52DVl9cI6QiThcjGrG4yU10
         +xNIvr2Wa2OiPvV57W8nJMWm2I3Qo87x+KbFYjhzNoGkT5nVW15OTpPPWLiHZ+pyBy
         aB7xU0mlXA4Dg==
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/7/20 8:12 PM, Tetsuo Handa wrote:
> On 2020/11/08 11:17, John Hubbard wrote:
>>> Excuse me, but Documentation/core-api/pin_user_pages.rst says
>>> "CASE 5: Pinning in order to _write_ to the data within the page"
>>> while tomoyo_dump_page() is for "_read_ the data within the page".
>>> Do we want to convert to pin_user_pages_remote() or lock_page() ?
>>>
>>
>> Sorry, I missed the direction here, was too focused on the Case 5
>> aspect. Yes. Case 5 (which, again, I think we're about to re-document)
>> is only about *writing* to data within the page.
>>
>> So in this case, where it is just reading from the page, I think it's
>> already from a gup vs pup point of view.
>>
>> btw, it's not clear to me whether the current code is susceptible to any
>> sort of problem involving something writing to the page while it
>> is being dumped (I am curious). But changing from gup to pup wouldn't
>> fix that, if it were a problem. It a separate question from this patch.
> 
> The "struct page" tomoyo_dump_page() accesses is argv/envp arguments passed
> to execve() syscall. Therefore, these pages are not visible from threads
> except current thread, and thus there is no possibility that these pages
> are modified by other threads while current thread is reading.
> 

Perfect. So since I accidentally left out the word "correct" above (I meant
to write, "it's already correct"), let me be extra clear: Souptick, we
should just drop this patch.

thanks,
-- 
John Hubbard
NVIDIA
