Return-Path: <SRS0=ir4w=SG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323EFC10F0C
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 11:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40F520855
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 11:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omprussia.ru header.i=@omprussia.ru header.b="HunUP2Vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfDDLot (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:44:49 -0400
Received: from mail.omprussia.ru ([5.134.221.218]:47958 "EHLO
        mail.omprussia.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDLos (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Apr 2019 07:44:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 4C0EBC6552B;
        Thu,  4 Apr 2019 14:44:46 +0300 (MSK)
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id huhXaTgq-f2s; Thu,  4 Apr 2019 14:44:46 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id DB3F6C6552C;
        Thu,  4 Apr 2019 14:44:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.omprussia.ru DB3F6C6552C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omprussia.ru;
        s=EC9C64F2-3532-11E8-B653-5B7E995A80AF; t=1554378285;
        bh=iiiMUQJeOqzq3LiQQJ5DfsP3zRxzXY31WTM2WChBXhA=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=HunUP2VgRKaK8M9zPJR1891LjrCigEtqjPpjY/G3ra25nBQNZSL9QFymoOM0TfUqO
         aSw1+XVxTZbNpHnvTJ1ZkXONDJSzvmLrVUZI/lOb7G/cu89GsixmaKjm3BxADN+YyN
         e/+Y3DWwohEO1DP+Gc56mVO/+OROWiE4iOEkjfiaZ/Q5yKNNufcf4AhSi1Cw8GEMrF
         YTAwDbKUpDRXJJhSHR5ozNaIzbURtucZ+n9CZkQk515rgaDnvH7r7uf04dEeEk2OoS
         IfQvVlUWJEyZjzZu/QENiyn4Z4YwZbd8mR9xfJ+AclzDeTKccWLRqarq6mytry1iyg
         A9Pu1DxwPU2Cw==
X-Virus-Scanned: amavisd-new at mail.omprussia.ru
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NFeR5KEXfGo7; Thu,  4 Apr 2019 14:44:45 +0300 (MSK)
Received: from [10.189.20.33] (unknown [10.189.20.33])
        by mail.omprussia.ru (Postfix) with ESMTPSA id A4445C6552B;
        Thu,  4 Apr 2019 14:44:45 +0300 (MSK)
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
 <bca4eb5b-2d76-5df8-6e63-573b3a057985@omprussia.ru>
 <CACdnJutv4O9bPwvddrasz2up06P6OtBbHjsr6JGSOwAtryMTpg@mail.gmail.com>
 <3ebff410-f1bd-654e-7cd0-486ea4768ebe@omprussia.ru>
 <CACdnJutN3415jtt+kaz-zxyAw0V9-0x0_YGWpxBXWYseD5Z7uA@mail.gmail.com>
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
Message-ID: <925634dc-7983-9da9-6d25-d9e0e052e4b7@omprussia.ru>
Date:   Thu, 4 Apr 2019 14:44:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACdnJutN3415jtt+kaz-zxyAw0V9-0x0_YGWpxBXWYseD5Z7uA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 03.04.2019 22:25, Matthew Garrett wrote:
> On Wed, Apr 3, 2019 at 11:47 AM Igor Zhbanov <i.zhbanov@omprussia.ru> wrote:
>> On 03.04.2019 21:19, Matthew Garrett wrote:
>>> There's two possible cases here:
>>>
>>> 1) The application is legitimate but can be convinced to open and
>>> execute malicious code. There should be no such applications that
>>> download code from the internet and execute it directly, so this can
>>> be prevented by requiring that files be signed (which has to be done
>>> to protect against attackers just using an interpreted language
>>> instead)
>>> 2) The application is actively malicious. In this case this approach
>>> is insufficient - an actively malicious application can interpret code
>>> rather than executing it directly. This can only be prevented by not
>>> signing malicious applications.
>>>
>>> When you talk about "staying below the radar" it implies that you're
>>> talking about case 2, but the proposed solution is only a speed bump
>>> rather than a blocker.
>>
>> But what about buffer/stack overflow? The application doesn't need to be
>> malicious. It could be just a web-browser or e-mail client processing
>> some evil file.
> 
> Executable pages shouldn't be writable?

Shouldn't. But I think about following:

1) Small ROP part downloads bigger portion of code to RW page.
2) Then it switches it to RX page with mprotect.

And this bigger downloaded code could try to steal data or to probe for
another holes. I believe that it's very hard to implement big ROP exploit.
It's easier to implement it in parts: smaller one takes control and downloads
the bigger one.
