Return-Path: <SRS0=3Yzx=EP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9EAC2D0A3
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Nov 2020 04:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75355206A5
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Nov 2020 04:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgKIEpL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 8 Nov 2020 23:45:11 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:60534 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgKIEpK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 8 Nov 2020 23:45:10 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0A94j4oG094502;
        Mon, 9 Nov 2020 13:45:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp);
 Mon, 09 Nov 2020 13:45:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0A94j4WX094484
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 9 Nov 2020 13:45:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 2/2] tomoyo: Fixed typo in documentation
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>
References: <1604737451-19082-1-git-send-email-jrdr.linux@gmail.com>
 <1604737451-19082-2-git-send-email-jrdr.linux@gmail.com>
 <f5ed0413-315c-d5d0-e33f-c2b247a28da2@nvidia.com>
 <CAFqt6zaRP56DPRHTGMNiY3KpdOKPB_SeeuFagUbkmQKQ6mKD2A@mail.gmail.com>
 <7c60a6f5-414f-99e8-68c3-ca3b60fe89e9@nvidia.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <7d214f98-90bb-563e-fbc1-e812e31f3b71@i-love.sakura.ne.jp>
Date:   Mon, 9 Nov 2020 13:45:05 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <7c60a6f5-414f-99e8-68c3-ca3b60fe89e9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020/11/09 13:17, John Hubbard wrote:
> On 11/8/20 7:41 PM, Souptick Joarder wrote:
>> John, as patch[1/2] is dropped, can we take this patch forward with some more
>> updates in documentations ?
>>
> 
> That's really up to the folks who work on this code. Personally I would rarely
> post a patch *just* for this, but on the other hand it is a correction. Either
> way is fine with me of course.

Xiaoming Ni has posted a patch for fixing spelling errors in security/ directory
at https://lkml.kernel.org/r/20200822030534.2577-1-nixiaoming@huawei.com .

James, can we apply that patch? Or, should we split that patch into each subsystem?
