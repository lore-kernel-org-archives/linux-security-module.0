Return-Path: <SRS0=lFQA=SA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD92EC4360F
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Mar 2019 13:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF5F217F5
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Mar 2019 13:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omprussia.ru header.i=@omprussia.ru header.b="lDptJ954"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfC2NBu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:01:50 -0400
Received: from mail.omprussia.ru ([5.134.221.218]:47134 "EHLO
        mail.omprussia.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbfC2NBt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Mar 2019 09:01:49 -0400
X-Greylist: delayed 670 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Mar 2019 09:01:49 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id B197CEE34C2;
        Fri, 29 Mar 2019 15:50:38 +0300 (MSK)
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MJ2cbbumYqYv; Fri, 29 Mar 2019 15:50:38 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 535F4EE34CA;
        Fri, 29 Mar 2019 15:50:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.omprussia.ru 535F4EE34CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omprussia.ru;
        s=EC9C64F2-3532-11E8-B653-5B7E995A80AF; t=1553863838;
        bh=+aKHkF8vOhW+ix4NP69Z42AVfmham5u8ISf+ZFDUtOg=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=lDptJ954tZ1sBq5HDy9pZH7Sx2VPx3wffFcIGn+VBzD8HWQm4ffpMFNNZomz0fRI0
         whNPetN8IUcuX/BbcuSPdlw8W/c2IhWyxsT3en00qKxBybNn47YtBBehCjqexKN/Qc
         M+v+pIyZ76nEK7ZrtROUsC8rbO1u+IhbTzOP7kEBnPA0CZCwN8NDC9hO5TRiPQLXtm
         +xcZfpIPvO55B4ob0nOmlvDFqoaUqBFGMMHg9uBwqLABmM56C3Ur8Iia+Tvs/XdhQb
         JcKWY0pzOdDiJqRTMyNlunR1R5deS5kwui2t7skwe5KgNSlQjv8IxNJWHt6hEUTWwS
         MakPy+L9DIlMA==
X-Virus-Scanned: amavisd-new at mail.omprussia.ru
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4pdZRqaXijyM; Fri, 29 Mar 2019 15:50:38 +0300 (MSK)
Received: from [10.189.20.33] (unknown [10.189.20.33])
        by mail.omprussia.ru (Postfix) with ESMTPSA id 34ABEEE34C2;
        Fri, 29 Mar 2019 15:50:38 +0300 (MSK)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
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
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
Message-ID: <cb46d5ba-30de-664f-67d4-646da4592a6f@omprussia.ru>
Date:   Fri, 29 Mar 2019 15:50:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b5a89692-4c93-80b3-37e5-41265765cdc3@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 29.03.2019 15:28, Stephen Smalley wrote:
> On 3/29/19 6:59 AM, Mimi Zohar wrote:
>> [Cc'ing the LSM mailing list and others]
>>
>> On Fri, 2019-03-29 at 13:00 +0300, Igor Zhbanov wrote:
>>> Hi Mimi,On 28.03.2019 20:17, Mimi Zohar wrote:
>>
>>>> I just came across the grsecurity article on mprotect.[1]
>>>> =C2=A0 Has anyone looked at it? Would it make sense to make it a min=
or LSM?
>>>>
>>>> [1]https://pax.grsecurity.net/docs/mprotect.txt
>>>
>>> Interesting article. It is almost exactly of what I wanted to be
>>> implemented.
>>>
>>> If this minor LSM would be stackable to allow combining with e.g. SEL=
inux
>>> then why not.
>>
>> Stacking shouldn't be a problem. =C2=A0Other LSMs are already on the
>> mprotect hook. =C2=A0Let's hear what others think.
>=20
> SELinux already provides a set of controls over executable mappings;
> see selinux_mmap_file and selinux_file_mprotect. Other major security
> modules may do likewise but I can't speak to that. Is there some gap
> you are trying to address that isn't already covered, or are you just
> trying to provide such restrictions without requiring one of the
> major modules?

I want to be sure that no unsigned code page could be executed. So exploi=
ts
could only be of ROP kind and not being able to download any extra code
from their servers. That's why I found that disabling of anonymous execut=
able
pages could be useful for that (as well as disabling of making executable
pages writable to modify already mapped code). In conjunction with IMA it
should guarantee that no untrusted code could be executed.

As for SELinux abilities I need to check what can it do and what can't. D=
on't
ready to comment on that now. Will check.

As for modular approach I think that having this feature separately is
beneficial for distros do not using SELinux.
