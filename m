Return-Path: <SRS0=/FKR=AT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1831AC433E0
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 11:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E21A02065C
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 11:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hc/oiexZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgGHL6y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:58:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30060 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728637AbgGHL6y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Jul 2020 07:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594209532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QkevNhBGyNEaCjar4U2+U0onC84LFT4MZtwJK+TdKxE=;
        b=hc/oiexZ9wvLLn9/+IX22A+iVwsLJjfD+Usu6Pc2RLctUx5T9STVJhzettkDB9Xe88k0XW
        eoCBMsI6EFedwjLE8/DXTq5XPQbWusTjoZy2RJH9ts5otgLIWaYEndGASChObGStyJUR8h
        1wf/sC8XdXrhOP1bC3oFLqfYzeflYNw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-Ys3UOU2BOPCoM5WvrJN2kQ-1; Wed, 08 Jul 2020 07:58:51 -0400
X-MC-Unique: Ys3UOU2BOPCoM5WvrJN2kQ-1
Received: by mail-ed1-f70.google.com with SMTP id u59so58724322edc.16
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2020 04:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QkevNhBGyNEaCjar4U2+U0onC84LFT4MZtwJK+TdKxE=;
        b=T0Q1v6dvcAldgK8HUAMuWVR0gCKnZd60kqw9uyq66cTGl++Ko+4deXB/zhKMyd/HtO
         e322h2XzkEH2BoNuaZEqKzz2yl+1O3Kc6ZDioHamdJgzCSs4/4+JscQj8v+yhu4TYtb2
         jcH15ZFIXy41L+13WiSsQjQW5pnsVc2P7GX8aY7qcrfmqkcjCFis9xezco8R8NE02jIw
         y4DR6i8cf9ZOEV0osx3FxS1ByUQnBq7FDR5W0cIuA7UOFv90/HSNXkkNaXday6MBfp7V
         IvhbT2S+lbcLcbe9otq0z+DR3lI/XNqS80yKO0xQI+dQxilRKNeFTlZHdxRB6KmJwR+g
         93fQ==
X-Gm-Message-State: AOAM5327g8dPVQkEqE0uFLvMNLTTvVpkayGQBWKdTrB5MwXdRmJFXsqX
        ppitwReskjFtfPqLvAkmSXOhD83kyVyYgnMil1KIY3LX/WYSnfpzO6Bkcl3JXE8nOXjm7f37MVH
        NZXQs33UQbURVvCx5p/DbcTXk5gNzJxkiYHYB
X-Received: by 2002:a17:906:12cd:: with SMTP id l13mr52498676ejb.96.1594209529422;
        Wed, 08 Jul 2020 04:58:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOaKMnLhyOtq9Iubps/WQ3eLjQjfBe1IKlNFBH5VgFaQrN+6p11ckWrUzF75y/UxOFmva1gw==
X-Received: by 2002:a17:906:12cd:: with SMTP id l13mr52498652ejb.96.1594209529173;
        Wed, 08 Jul 2020 04:58:49 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id u2sm28953481edq.29.2020.07.08.04.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 04:58:48 -0700 (PDT)
Subject: Re: [PATCH 0/4] Fix misused kernel_read_file() enums
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200707081926.3688096-1-keescook@chromium.org>
 <3c01073b-c422-dd97-0677-c16fe1158907@redhat.com>
 <f5e65f73-2c94-3614-2479-69b2bfda9775@redhat.com>
 <20200708115517.GF4332@42.do-not-panic.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8766279d-0ebe-1f64-c590-4a71a733609b@redhat.com>
Date:   Wed, 8 Jul 2020 13:58:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200708115517.GF4332@42.do-not-panic.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

On 7/8/20 1:55 PM, Luis Chamberlain wrote:
> On Wed, Jul 08, 2020 at 01:37:41PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 7/8/20 1:01 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 7/7/20 10:19 AM, Kees Cook wrote:
>>>> Hi,
>>>>
>>>> In looking for closely at the additions that got made to the
>>>> kernel_read_file() enums, I noticed that FIRMWARE_PREALLOC_BUFFER
>>>> and FIRMWARE_EFI_EMBEDDED were added, but they are not appropriate
>>>> *kinds* of files for the LSM to reason about. They are a "how" and
>>>> "where", respectively. Remove these improper aliases and refactor the
>>>> code to adapt to the changes.
>>>>
>>>> Additionally adds in missing calls to security_kernel_post_read_file()
>>>> in the platform firmware fallback path (to match the sysfs firmware
>>>> fallback path) and in module loading. I considered entirely removing
>>>> security_kernel_post_read_file() hook since it is technically unused,
>>>> but IMA probably wants to be able to measure EFI-stored firmware images,
>>>> so I wired it up and matched it for modules, in case anyone wants to
>>>> move the module signature checks out of the module core and into an LSM
>>>> to avoid the current layering violations.
>>>>
>>>> This touches several trees, and I suspect it would be best to go through
>>>> James's LSM tree.
>>>>
>>>> Thanks!
>>>
>>>
>>> I've done some quick tests on this series to make sure that
>>> the efi embedded-firmware support did not regress.
>>> That still works fine, so this series is;
>>>
>>> Tested-by: Hans de Goede <hdegoede@redhat.com>
>>
>> I made a mistake during testing I was not actually running the
>> kernel with the patches added.
>>
>> After fixing that I did find a problem, patch 4/4:
>> "module: Add hook for security_kernel_post_read_file()"
>>
>> Breaks module-loading for me. This is with the 4 patches
>> on top of 5.8.0-rc4, so this might just be because I'm
>> not using the right base.
>>
>> With patch 4/4 reverted things work fine for me.
>>
>> So, please only add my Tested-by to patches 1-3.
> 
> BTW is there any testing covered by the selftests for the firmware
> laoder which would have caputured this? If not can you extend
> it with something to capture this case you ran into?

This was not a firmware-loading issue. For me in my tests,
which were limited to 1 device, patch 4/4, which only touches
the module-loading code, stopped module loading from working.

Since my test device has / on an eMMC and the kernel config
I'm using has mmc-block as a module, things just hung in the
initrd since no modules could be loaded, so I did not debug
this any further. Dropping  patch 4/4 from my local tree
solved this.

Regards,

Hans

