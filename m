Return-Path: <SRS0=p2Kc=SF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A6DC10F0B
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 17:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE55320700
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 17:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omprussia.ru header.i=@omprussia.ru header.b="zhzXMmbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfDCRbs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:31:48 -0400
Received: from mail.omprussia.ru ([5.134.221.218]:47706 "EHLO
        mail.omprussia.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCRbr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 13:31:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 2954E1000E46;
        Wed,  3 Apr 2019 20:31:45 +0300 (MSK)
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id L4FtDqCteccM; Wed,  3 Apr 2019 20:31:41 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 565131000E48;
        Wed,  3 Apr 2019 20:31:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.omprussia.ru 565131000E48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omprussia.ru;
        s=EC9C64F2-3532-11E8-B653-5B7E995A80AF; t=1554312701;
        bh=6Kgtvrgq6AlmiLDLWDERokohjwhEkCSSyph/5VyB+/Y=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=zhzXMmbwoBP7YBWMhc0ff6akKOASqNVMzZs9DHr4sKipcFcQNoL5dAGDriC1NEeWi
         csTzKC01o0hJWDXaHZMJrXOlPy+qKxuffDCHRIsenyX5FkHscLHbDwB3pLCegvgw4W
         I5EVbS4UPrN9MFecZ9VCAh5w9AAVN4hil7z+B1fpzrLdPw1epSlzfPHvo1K1IBOBIJ
         r0WT3Y+vdhCTIW+usgFneD71fG5RBT0ETb40SQl+g5aEYLziPHN2+w3rN9VgN0HQpz
         r0HN4ICSRvXv0i8Ps8ZorGlxCF6lWHmFXoriJ3WOiV9XYyRrZRR4tXXCI7AQT+sMCk
         FCW1nAb6pTWZQ==
X-Virus-Scanned: amavisd-new at mail.omprussia.ru
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EuJxcsJ8_JGp; Wed,  3 Apr 2019 20:31:41 +0300 (MSK)
Received: from [10.189.20.33] (unknown [10.189.20.33])
        by mail.omprussia.ru (Postfix) with ESMTPSA id 227FA1000E46;
        Wed,  3 Apr 2019 20:31:41 +0300 (MSK)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Matthew Garrett <mjg59@google.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1552994559.4899.26.camel@linux.ibm.com>
 <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
 <1553015134.4899.82.camel@linux.ibm.com>
 <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
 <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
 <1553167318.4899.382.camel@linux.ibm.com>
 <dab923ca-ef53-4af2-034a-bea4151a4e25@omprussia.ru>
 <CACdnJuvVqibDdd+MLKOHqEfdngTk=GSkfybj1jS3MpmC7rjyHg@mail.gmail.com>
 <07347317-ee71-83c1-384a-0c3439980af7@omprussia.ru>
 <1553793463.8711.26.camel@linux.ibm.com>
 <92718382-8669-748f-10d8-02fa21225210@omprussia.ru>
 <1553857187.9420.49.camel@linux.ibm.com>
 <b5a89692-4c93-80b3-37e5-41265765cdc3@tycho.nsa.gov>
 <cb46d5ba-30de-664f-67d4-646da4592a6f@omprussia.ru>
 <CACdnJusPpis1JJgfNOrQoqPcVk0q2OGbosrXOVtZmG0cSqkotw@mail.gmail.com>
 <11fcd3b2-afb9-74d2-100d-449df61433d1@omprussia.ru>
 <CACdnJusgwpcSxzwNEieqsa54_3cTYMEfuXpAeP0cW81TQ29E+w@mail.gmail.com>
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
Message-ID: <bca4eb5b-2d76-5df8-6e63-573b3a057985@omprussia.ru>
Date:   Wed, 3 Apr 2019 20:31:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACdnJusgwpcSxzwNEieqsa54_3cTYMEfuXpAeP0cW81TQ29E+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 03.04.2019 19:58, Matthew Garrett wrote:
> On Wed, Apr 3, 2019 at 2:59 AM Igor Zhbanov <i.zhbanov@omprussia.ru> wrote:
> No, that's my point - if you're able to pass code directly to the
> interpreter then you're not protected by file signatures. python -c
> 'print("hello")' will execute without the user-provided code touching
> IMA.
> 
>> And having this feature as a per-process you could still limit the attack
>> surface by restricting e.g. network services as they are constantly attacked.
>>
>> So are you saying that this feature doesn't worth to make it?
> 
> I'm saying that before adding more security code you should describe
> the attack that you're actually trying to prevent. What you're doing
> prevents applications from opening a file read-only and then
> mprotect()ing it to being executable without IMA noticing, but what
> attack are you actually protecting against as a result? You block one
> avenue of obtaining code execution that isn't measured by IMA, but
> there are many more. Most (but not all) are blocked by requiring that
> all files be signed, but if all files are signed we don't need to
> change the behaviour here - opening the file read-only will be enough
> to trigger an appraisal.

I'm trying to reduce attacker's possibilities to inject any new unauthorized
code. Currently it could be:
1) Downloaded binaries (on disk) which is validated by IMA,

2) Downloaded scripts (which need some combined approach like removing
    unneeded interpreters and checking the they are open and disabling passing
    the script as command line argument),

3) Return-Oriented-Programming exploits. Compiler support for validating
    return addresses is needed.

4) Anonymous executable pages (either new or existing changing to writable).
    ^ This is what I'm talking about. Because it's relatively easy to create
    anonymous executable page to stay below the radar. Because even if you
    enable signature checking for all opened files it would be possible to
    simply download the code and execute it directly from the anonymous pages.

By closing one by one these possibilities one can be (relatively) sure that
only trusted code and scripts could be executed.
