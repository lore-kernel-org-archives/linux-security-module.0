Return-Path: <SRS0=fFag=3V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8DCC33C9E
	for <linux-security-module@archiver.kernel.org>; Sat,  1 Feb 2020 07:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AC620679
	for <linux-security-module@archiver.kernel.org>; Sat,  1 Feb 2020 07:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgBAHy0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 1 Feb 2020 02:54:26 -0500
Received: from relay.sw.ru ([185.231.240.75]:55366 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgBAHy0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 1 Feb 2020 02:54:26 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1ixnbU-00067o-2C; Sat, 01 Feb 2020 10:54:08 +0300
Subject: Re: [PATCH v2] keys: proc_keys_next should increase position index
To:     David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <22307ecd-3254-6077-8bc7-02693338b586@virtuozzo.com>
 <eaacb0b2-fd0d-480e-1868-0a1284c20185@virtuozzo.com>
 <265151.1580491178@warthog.procyon.org.uk>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <bb473a18-3241-9377-3bee-33d4e9381f3d@virtuozzo.com>
Date:   Sat, 1 Feb 2020 10:54:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <265151.1580491178@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/31/20 8:19 PM, David Howells wrote:
> Vasily Averin <vvs@virtuozzo.com> wrote:
>> If seq_file .next fuction does not change position index,
> "function"
>>    <<<< and whole last lien again
> "line"
> 
> I can fix these up for you.

thank you!

>> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> 
> I wonder if this should have a tag - it looks kind of out of place without
> one, but I can't find one suggested.

Some maintainers of another subsystems asked me to add 
Cc: stable@vger.kernel.org
Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code ...")
however frankly speaking I do not think it is required in this case.

Thank you,
	Vasily Averin
