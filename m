Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4BDC001DE
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Aug 2023 17:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjHHR0v (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjHHR0W (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Aug 2023 13:26:22 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1D785287;
        Tue,  8 Aug 2023 09:11:18 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 378APexv059107;
        Tue, 8 Aug 2023 19:25:40 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Tue, 08 Aug 2023 19:25:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 378APdoI059104
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Aug 2023 19:25:40 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <025aa551-7ed7-d413-26e3-222ac12e9345@I-love.SAKURA.ne.jp>
Date:   Tue, 8 Aug 2023 19:25:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] TaskTracker : Simplified thread information tracker.
Content-Language: en-US
To:     Steve Grubb <sgrubb@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        audit@vger.kernel.org, linux-audit@redhat.com
References: <41d03271-ff8a-9888-11de-a7f53da47328@I-love.SAKURA.ne.jp>
 <2029076.tdWV9SEqCh@x2>
 <ab7b4099-d238-e791-6dc2-25be5952798c@I-love.SAKURA.ne.jp>
 <2294714.ElGaqSPkdT@x2>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2294714.ElGaqSPkdT@x2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/08/08 3:54, Steve Grubb wrote:
>>> What I would suggest is to make a separate record: AUDIT_PROC_TREE that
>>> describes process tree from the one killed up to the last known parent.
>>> This way you can define your own format and SYSCALL can stay as everyone
>>> expects it to look. In the EXECVE audit record, there is a precedent of
>>> using agv[0]=xx argv[1]=xx argv[2]=yy  and so on. If you want to make
>>> these generally parsable without special knowledge of the record format,
>>> I'd suggest something like it.
>>
>> Yes,
>> https://lkml.kernel.org/r/201501202220.DJJ34834.OLJOHFMQOFtSVF@I-love.SAKU
>> RA.ne.jp used AUDIT_PROCHISTORY instead of LSM hooks, but that thread died
>> there.
> 
> I do not read that mail list. AUDIT_PROC_HIST or AUDIT_PROC_CHAIN or some 
> thing like that would be the better way to go. If someone wanted to see if 
> they have process history for a segfault, how would they do it with the 
> proposed record?

Avoid bloating of audit log files could be done when saving into audit log
files, but avoiding overhead of tracking/recording this history information
would need to be done using kernel command line options.

Is there a kernel command line option that can configure whether to include
(and what to be included into) this history information or not?

If an LSM is used, a kernel command line option like lsm=tt can be used for
telling the kernel to include this history information and kernel command
line options like tt.size=512 tt.fields=name,stamp for telling the kernel
max history length and fields to include.

