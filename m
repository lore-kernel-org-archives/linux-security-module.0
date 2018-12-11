Return-Path: <SRS0=nZhg=OU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F57C6783B
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Dec 2018 21:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232E820849
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Dec 2018 21:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232E820849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeLKVCf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:02:35 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:48697 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKVCf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Dec 2018 16:02:35 -0500
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBBL2QlK046261;
        Wed, 12 Dec 2018 06:02:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Wed, 12 Dec 2018 06:02:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBBL2J1R046209
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 12 Dec 2018 06:02:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v5 00/38] LSM: Module stacking for SARA and Landlock
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
 <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com>
 <alpine.LRH.2.21.1812120556040.11653@namei.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d0910aed-5e4e-201d-f452-fa61e87183c5@i-love.sakura.ne.jp>
Date:   Wed, 12 Dec 2018 06:02:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1812120556040.11653@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2018/12/12 3:57, James Morris wrote:
> On Tue, 4 Dec 2018, Kees Cook wrote:
> 
>> On Mon, Nov 26, 2018 at 3:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> v5: Include Kees Cook's rework of the lsm command
>>>     line interface. Stacking is not conditional.
>>
>> Can you resend this series with corrected "From:" lines in the body, etc?
>>
>> Beyond that, I obviously like it. James, what's needed for this to move forward?
> 
> If there are no outstanding issues, I plan to merge this for 4.21.
> 

Then, can we send it to linux-next.git shortly
so that we can have some time for testing by syzbot?
