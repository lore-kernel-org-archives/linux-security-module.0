Return-Path: <SRS0=p2Kc=SF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3902EC10F0B
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 09:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0412A206DF
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 09:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omprussia.ru header.i=@omprussia.ru header.b="Fa8NBpG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfDCJ7U (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:59:20 -0400
Received: from mail.omprussia.ru ([5.134.221.218]:52056 "EHLO
        mail.omprussia.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCJ7U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 05:59:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 947B7C64082;
        Wed,  3 Apr 2019 12:59:17 +0300 (MSK)
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id P00T2jmuwxI9; Wed,  3 Apr 2019 12:59:17 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 343BBC64088;
        Wed,  3 Apr 2019 12:59:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.omprussia.ru 343BBC64088
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omprussia.ru;
        s=EC9C64F2-3532-11E8-B653-5B7E995A80AF; t=1554285557;
        bh=zH4k75Bc1+jYzZYv4yRQ1IGyvs5LwVmP0aFcT0zWRuc=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=Fa8NBpG/cyfteDxsp3QA8WBWQTr9dSgV4zjhYwMnnOllF4JHfQ0ycQcZkCYnIW4e+
         B6Fx4oglGfNQwvlzyOLolmS691ZIcxTRMGA3bNIKZSTiGCiasJSTlBxWfEzt8UtN0R
         FA8qq6CXrjnqVQRJQcvo4On5Hr0POSfkzaTukxg5WVKO/x/xp7Avy2wHXZbQBpMVwH
         2+eSPyE2hLJgt4VUcY6Vy/3i/4qefpyg/4N1KdVGNE/9VyY6LcTR+Kp8AjZryq58ur
         C3/H9FJ8mfajZ+vrul8xENfKxCjk/7oDX6tKlOTEmhh2Z30PeQdKedk9gCCmPwjJ5h
         7sz85HL2bfa9g==
X-Virus-Scanned: amavisd-new at mail.omprussia.ru
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UM3Sw1qF7TMU; Wed,  3 Apr 2019 12:59:17 +0300 (MSK)
Received: from [10.189.20.33] (unknown [10.189.20.33])
        by mail.omprussia.ru (Postfix) with ESMTPSA id EAB5CC64082;
        Wed,  3 Apr 2019 12:59:16 +0300 (MSK)
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
 <1552945715.8658.299.camel@linux.ibm.com>
 <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
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
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
Message-ID: <11fcd3b2-afb9-74d2-100d-449df61433d1@omprussia.ru>
Date:   Wed, 3 Apr 2019 12:59:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACdnJusPpis1JJgfNOrQoqPcVk0q2OGbosrXOVtZmG0cSqkotw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 03.04.2019 1:31, Matthew Garrett wrote:
> On Fri, Mar 29, 2019 at 5:50 AM Igor Zhbanov <i.zhbanov@omprussia.ru> wrote:
>> I want to be sure that no unsigned code page could be executed. So
>> exploits could only be of ROP kind and not being able to download
>> any extra code from their servers. That's why I found that
>> disabling of anonymous executable pages could be useful for that
>> (as well as disabling of making executable pages writable to modify
>> already mapped code). In conjunction with IMA it should guarantee
>> that no untrusted code could be executed.
> 
> Remember that many interpreted languages allow execution of code
> provided to them on the command line (eg, python -c) and also grant
> access to arbitrary syscalls, so there's still no guarantee that
> you're only executing trusted code.

Yes. But in some installations you can get rid of interpreters at all or limit
the number of scripts they can open. For example you can require that all
scripts have to be signed.

And having this feature as a per-process you could still limit the attack
surface by restricting e.g. network services as they are constantly attacked.

So are you saying that this feature doesn't worth to make it?
