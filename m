Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E74C001E0
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Aug 2023 10:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243732AbjHPKKd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Aug 2023 06:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243774AbjHPKKc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Aug 2023 06:10:32 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D0DC1;
        Wed, 16 Aug 2023 03:10:30 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 37GAAHQ1055223;
        Wed, 16 Aug 2023 19:10:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Wed, 16 Aug 2023 19:10:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 37GAAG7i055218
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 16 Aug 2023 19:10:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b06dbdd8-d2f6-b190-5635-948c0a966103@I-love.SAKURA.ne.jp>
Date:   Wed, 16 Aug 2023 19:10:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] audit: add task history record
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, audit@vger.kernel.org,
        Steve Grubb <sgrubb@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
 <CAHC9VhTLQjjQ0QMfBDHYCz9LOAuO=rJWSDEUqPsFE+dowFbN=Q@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhTLQjjQ0QMfBDHYCz9LOAuO=rJWSDEUqPsFE+dowFbN=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2023/08/16 3:44, Paul Moore wrote:
> On Fri, Aug 11, 2023 at 6:58 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> When an unexpected system event occurs, the administrator may want to
>> identify which application triggered the event. For example, unexpected
>> process termination is still a real concern enough to write articles
>> like https://access.redhat.com/solutions/165993 .
>>
>> This patch adds a record which emits TOMOYO-like task history information
>> into the audit logs for better understanding of unexpected system events.
>>
>>   type=UNKNOWN[1340] msg=audit(1691750738.271:108): history="name=swapper/0;pid=1;start=20230811194329=>name=init;pid=1;start=20230811194343=>name=systemd;pid=1;start=20230811194439=>name=sshd;pid=3660;start=20230811104504=>name=sshd;pid=3767;start=20230811104535"
> 
> While I respect your persistence, we've talked about this quite a bit
> already in other threads.  What you are trying to do is already
> possible with audit

How?

>                     and/or TOMOYO enabled and configured

Wrong. Since not all LSM hooks allow sleeping, TOMOYO is unable to
check sending signals. Also, TOMOYO is not using audit interface.

>                                                          so I see no
> reason why we want to merge this.

This code makes it possible to record sending signals with TOMOYO-like context,
and we can avoid assigning LSM ID for this code if we can merge this code as
a part of audit.

>                                    I understand your frustration that
> TOMOYO is not enabled by your prefered distribution, but adding
> additional (and arguably redundant code) code to the upstream kernel
> is not a solution I am willing to support and maintain long term.

Never a redundant code. Absolutely no reason we don't want to merge.

The only choice is which approach (a standalone LSM module or a part of audit)
to go. Casey suggests this code as a part of audit. You must persuade Casey
if you don't want this code as a part of audit.

