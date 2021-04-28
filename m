Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1117C433B4
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Apr 2021 09:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F454613E8
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Apr 2021 09:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbhD1J7T (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 28 Apr 2021 05:59:19 -0400
Received: from smtp-190c.mail.infomaniak.ch ([185.125.25.12]:41011 "EHLO
        smtp-190c.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238809AbhD1J7S (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 28 Apr 2021 05:59:18 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4FVYx4442NzMq3YP;
        Wed, 28 Apr 2021 11:58:32 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4FVYx344c0zlmrrs;
        Wed, 28 Apr 2021 11:58:31 +0200 (CEST)
Subject: Re: [PATCH] samples/landlock: fix path_list memory leak
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210427183755.2790654-1-trix@redhat.com>
 <CAKwvOdmj5YvWZZWwcq1G7JgRALwPbqwiROiedMeEbBst2sGeiQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <6108e69b-0470-cd71-e477-ba64641cbf58@digikod.net>
Date:   Wed, 28 Apr 2021 11:58:59 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmj5YvWZZWwcq1G7JgRALwPbqwiROiedMeEbBst2sGeiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 27/04/2021 21:13, Nick Desaulniers wrote:
> On Tue, Apr 27, 2021 at 11:38 AM <trix@redhat.com> wrote:
>>
>> From: Tom Rix <trix@redhat.com>
>>
>> Clang static analysis reports this error
>>
>> sandboxer.c:134:8: warning: Potential leak of memory
>>   pointed to by 'path_list'
>>         ret = 0;
>>               ^
>> path_list is allocated in parse_path() but never freed.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  samples/landlock/sandboxer.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
>> index 7a15910d2171..4629d011ed61 100644
>> --- a/samples/landlock/sandboxer.c
>> +++ b/samples/landlock/sandboxer.c
>> @@ -134,6 +134,8 @@ static int populate_ruleset(
>>         ret = 0;
>>
>>  out_free_name:
>> +       if (path_list)
>> +               free(path_list);
> 
> I don't think the conditional is even necessary? By our first `goto
> out_free_name;`, `parse_path` has already been called/memory for
> `path_list` has already been allocated. `parse_path` doesn't check
> whether `malloc` has failed.

Indeed, no need for the path_list check. In practice, this memory leak
doesn't stay long because of the execve, but I missed this free anyway.
Thanks!

Reviewed-by: Mickaël Salaün <mic@linux.microsoft.com>

> 
>>         free(env_path_name);
>>         return ret;
>>  }
>> --
>> 2.26.3
>>
> 
> 
