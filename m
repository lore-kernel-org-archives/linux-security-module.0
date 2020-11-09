Return-Path: <SRS0=3Yzx=EP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BE7C2D0A3
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Nov 2020 04:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2552220897
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Nov 2020 04:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NcFwCzlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgKIERK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 8 Nov 2020 23:17:10 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4001 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIERK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 8 Nov 2020 23:17:10 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa8c2c90001>; Sun, 08 Nov 2020 20:17:13 -0800
Received: from [10.2.49.75] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Nov
 2020 04:17:09 +0000
Subject: Re: [PATCH 2/2] tomoyo: Fixed typo in documentation
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1604737451-19082-1-git-send-email-jrdr.linux@gmail.com>
 <1604737451-19082-2-git-send-email-jrdr.linux@gmail.com>
 <f5ed0413-315c-d5d0-e33f-c2b247a28da2@nvidia.com>
 <CAFqt6zaRP56DPRHTGMNiY3KpdOKPB_SeeuFagUbkmQKQ6mKD2A@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <7c60a6f5-414f-99e8-68c3-ca3b60fe89e9@nvidia.com>
Date:   Sun, 8 Nov 2020 20:17:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zaRP56DPRHTGMNiY3KpdOKPB_SeeuFagUbkmQKQ6mKD2A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604895433; bh=GyczsSIPQ2H7XyF7aw5OG6GSzZRXZ+iyOimEZqVpguI=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=NcFwCzlIIkdM2jCJN3EMJWiVtpT610ymFCkhLJzj2vxhiHAT5isr8uX3wzPA862Fp
         U7IFUbiMUdJxAIDzWbW677vYiaQgtcAp3ByBOrxcF31UrwGHXFqoYZXdDIxE1MvfM9
         rWd99Y2W71EkELaRi50GU1Ns38LsaW4EykWseuyMsI4uffl2yVfzroHJXTXoMA3hMR
         pZ28L1Ar6lGSwBcyNCCdVhyLBOSfn9iiJ7noJBz9SzWS/V7s5ce4Z0FpLDZd9C8SiQ
         y3Qf6EzYP1APkfnN1nmBSehFD5/ElNK8Y1rcXNX/JqafBuhkEkzOr1htFIzu0VhO4G
         h1w3idpkvjhsQ==
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/8/20 7:41 PM, Souptick Joarder wrote:
> On Sat, Nov 7, 2020 at 2:27 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 11/7/20 12:24 AM, Souptick Joarder wrote:
>>> Fixed typo s/Poiner/Pointer
>>>
>>> Fixes: 5b636857fee6 ("TOMOYO: Allow using argv[]/envp[] of execve() as conditions.")
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>> ---
>>>    security/tomoyo/domain.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
>>> index bd748be..7b2babe 100644
>>> --- a/security/tomoyo/domain.c
>>> +++ b/security/tomoyo/domain.c
>>> @@ -891,7 +891,7 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
>>>     *
>>>     * @bprm: Pointer to "struct linux_binprm".
>>>     * @pos:  Location to dump.
>>> - * @dump: Poiner to "struct tomoyo_page_dump".
>>> + * @dump: Pointer to "struct tomoyo_page_dump".
>>
>> Not worth a separate patch, especially since the original comment is merely
>> copying the C sources, and as such, does not add any value.
>>
>> I'd either a) craft a new documentation line that adds some value, or b) just
>> merge this patch into the previous one, and make a note in the commit
>> description to the effect that you've included a trivial typo fix as long
>> as you're there.
>>
> 
> John, as patch[1/2] is dropped, can we take this patch forward with some more
> updates in documentations ?
> 

That's really up to the folks who work on this code. Personally I would rarely
post a patch *just* for this, but on the other hand it is a correction. Either
way is fine with me of course.


thanks,
-- 
John Hubbard
NVIDIA
