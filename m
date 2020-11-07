Return-Path: <SRS0=bsG4=EN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC364C388F9
	for <linux-security-module@archiver.kernel.org>; Sat,  7 Nov 2020 19:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8905220723
	for <linux-security-module@archiver.kernel.org>; Sat,  7 Nov 2020 19:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nedmNtDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgKGTRx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 7 Nov 2020 14:17:53 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5730 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKGTRx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 7 Nov 2020 14:17:53 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa6f2e50000>; Sat, 07 Nov 2020 11:17:57 -0800
Received: from [10.2.62.222] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 7 Nov
 2020 19:17:52 +0000
Subject: Re: [PATCH 1/2] tomoyo: Convert get_user_pages*() to
 pin_user_pages*()
From:   John Hubbard <jhubbard@nvidia.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>, <takedakn@nttdata.co.jp>,
        <penguin-kernel@I-love.SAKURA.ne.jp>, <jmorris@namei.org>,
        <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
References: <1604737451-19082-1-git-send-email-jrdr.linux@gmail.com>
 <e5401549-8c31-2c6d-58dd-864232de17af@nvidia.com>
Message-ID: <e6859981-bc3c-9513-99e5-a99849786156@nvidia.com>
Date:   Sat, 7 Nov 2020 11:17:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e5401549-8c31-2c6d-58dd-864232de17af@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604776677; bh=yfhdGpRJZc3CvodI5i1IHo+KRBmzHgvXgzVSoUCFcYw=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=nedmNtDmoYJfgU992ShmtCC57esM3aLP4lFDsq2VsnRlkgg0vOHucUb25U9gXt0Ui
         bb46/ufveki0qfrIbDUrdScf5MsqEn/41KZDkL8VMlaTQYixjrZvxgt1S2YBf3lLvh
         rPqMwfsyGVuVIK5pTa1yry0dJhEqS4MtlTMG2pLS2ZvMvSOkqlMZhSkP0SdnA0jAe6
         P2w7IfbrVikCQpNZmVXjazWbJnkzn9y9wrIhJ6EPe+PIa+Rec/wtXsQRKp0Vfre2Kr
         hbZsXxzeQETQO4DlWHK1dqVwxwM1l7RGyJ/wtLkBRkz1twUZCzdfsIOZOPCrU8A4GB
         jk38FeRVwJ65g==
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/7/20 1:04 AM, John Hubbard wrote:
> On 11/7/20 12:24 AM, Souptick Joarder wrote:
>> In 2019, we introduced pin_user_pages*() and now we are converting
>> get_user_pages*() to the new API as appropriate. [1] & [2] could
>> be referred for more information. This is case 5 as per document [1].
> 
> It turns out that Case 5 can be implemented via a better pattern, as long
> as we're just dealing with a page at a time, briefly:
> 
> lock_page()
> write to page's data
> unlock_page()
> 
> ...which neatly synchronizes with writeback and other fs activities.

Ahem, I left out a key step: set_page_dirty()!

lock_page()
write to page's data
set_page_dirty()
unlock_page()


thanks,
-- 
John Hubbard
NVIDIA
