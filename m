Return-Path: <SRS0=H0OP=EO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CEAC388F7
	for <linux-security-module@archiver.kernel.org>; Sun,  8 Nov 2020 02:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1660320719
	for <linux-security-module@archiver.kernel.org>; Sun,  8 Nov 2020 02:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KwQOvJlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgKHCRX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 7 Nov 2020 21:17:23 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4294 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbgKHCRX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 7 Nov 2020 21:17:23 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa755360000>; Sat, 07 Nov 2020 18:17:26 -0800
Received: from [10.2.62.222] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 8 Nov
 2020 02:17:22 +0000
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
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <8590eb4c-256b-9ab0-5291-de8ec8d75276@nvidia.com>
Date:   Sat, 7 Nov 2020 18:17:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5efeb909-3e02-ba14-7a86-f18562a2fe69@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604801846; bh=bZw7mGT3w9m9Y7Dcs1zQ8kMzt3zbk0xOy0bnGCS8rTo=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=KwQOvJlPbMb8l1LvLiXBuWlemKRJklt034S8TtxjqEZihTCiD8g5QN0t6wKKQvaHz
         +z976OMLMd1KuEPS0ePWMLkrj3uloIX+iq0Illa97fG+TlNx7rwVF48wLJFouyb6ii
         xynhFkFd3FCzClfGE5fSbeYcYSX+myRwpxMK8Hm6IrvA97g1UvojqfkF74l31PJIlW
         uVNdlnucxfihmp6tGOpfQo8jf2Xj6JugueL7ZgPPXfVG2D9rUXTbY5lon1CCjavKc+
         ngaO0ffk2mpxhMomkPXaQny4xj1znfBzODXVuFVRv1IbiNLwDh9taMExkRCtsuUz1P
         ErPRefHfMICVg==
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/7/20 5:13 PM, Tetsuo Handa wrote:
> On 2020/11/08 4:17, John Hubbard wrote:
>> On 11/7/20 1:04 AM, John Hubbard wrote:
>>> On 11/7/20 12:24 AM, Souptick Joarder wrote:
>>>> In 2019, we introduced pin_user_pages*() and now we are converting
>>>> get_user_pages*() to the new API as appropriate. [1] & [2] could
>>>> be referred for more information. This is case 5 as per document [1].
>>>
>>> It turns out that Case 5 can be implemented via a better pattern, as long
>>> as we're just dealing with a page at a time, briefly:
>>>
>>> lock_page()
>>> write to page's data
>>> unlock_page()
>>>
>>> ...which neatly synchronizes with writeback and other fs activities.
>>
>> Ahem, I left out a key step: set_page_dirty()!
>>
>> lock_page()
>> write to page's data
>> set_page_dirty()
>> unlock_page()
>>
> 
> Excuse me, but Documentation/core-api/pin_user_pages.rst says
> "CASE 5: Pinning in order to _write_ to the data within the page"
> while tomoyo_dump_page() is for "_read_ the data within the page".
> Do we want to convert to pin_user_pages_remote() or lock_page() ?
> 

Sorry, I missed the direction here, was too focused on the Case 5
aspect. Yes. Case 5 (which, again, I think we're about to re-document)
is only about *writing* to data within the page.

So in this case, where it is just reading from the page, I think it's
already from a gup vs pup point of view.

btw, it's not clear to me whether the current code is susceptible to any
sort of problem involving something writing to the page while it
is being dumped (I am curious). But changing from gup to pup wouldn't
fix that, if it were a problem. It a separate question from this patch.

(Souptick, if you're interested, the Case 5 documentation change and
callsite retrofit is all yours if you want it. Otherwise it's on
my list.)

thanks,
-- 
John Hubbard
NVIDIA
