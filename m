Return-Path: <SRS0=/FKR=AT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76451C433DF
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 03:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552B720708
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 03:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FQQtzi6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgGHDjo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Jul 2020 23:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbgGHDjk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Jul 2020 23:39:40 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC23C08C5EE
        for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2020 20:39:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so1410087wmi.3
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jul 2020 20:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=b0MSJMdXbeUzupb6r6J9CAUvaKsjI0cyEb04d76sLig=;
        b=FQQtzi6pac89mpD8yPE44MbmGtJ0ORE4LYJxuPMmzpDJWXj0X8LHEiqANk+eASg7c8
         ng/jVO+ZvK3Ysf2i3PMvk1hBzAT+ZyBQ2Tqw+eVxuExQ6bmG4CMOoqzzxl2WxK8zpa1m
         es0R2Dv85+SCrQP2aHmxJKslvvxPqnvpkpuIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=b0MSJMdXbeUzupb6r6J9CAUvaKsjI0cyEb04d76sLig=;
        b=gAC58q0Ze5/Iss3pZvYwPXzhKS88c2BDXuQ8c+IzboNvOAH6hoJUDJimYLQYyBpRqO
         zfjZY6Qps3Y4RWhqDWFVTe72WOg8d93azWIelHlKropnJRk1+XZYRe1a+xkIUttVssYA
         trNuSb62B0Jvi6T2OocV2M4v1VASn8CULqwFF8U+47rrGZ9dBRxjV8zjQHIXMDh2QQ/n
         L6AT2XySCbxfSNlmyf79k4miMTOOd0KqgD5RQBz+mBimmPNXZhkqEoEseUMnaDlBB+2q
         qf1BtYzZrX0lMeUpNT3A5wSinMpiK5QiWhVoR9jz5XFBYxyfox4ZRp8KLiPY2py0Gudq
         dNkw==
X-Gm-Message-State: AOAM531nmO1rTbX2IRFKufGmu/uVVsLLG+8RDF158BL2bRLUiPdriRj7
        mfVKjWi8hMejzhvFy6ra5ojuEotjWK+jRYk0k6H3PguzZdBOAPXVQ9SM/SDLZ8+Ab1ebFFb8omb
        aMjiqtQ71m2yD/nEQNePv2P+vsD/CfIAlIHe3C1QvRuPOrXAddyC0jSBG8MyjNoHWeOrwU4KgM6
        P2OHSvbR4usVtSj1ZJeY04
X-Google-Smtp-Source: ABdhPJz2S9+QMAFIAx7Px3unr1ipJo9bqmjdbN368KnmW5gZno1/2MSNEHbx4ymeujbmKIvaZ51Mkw==
X-Received: by 2002:a7b:c38f:: with SMTP id s15mr7000017wmj.152.1594179578758;
        Tue, 07 Jul 2020 20:39:38 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 69sm189961wma.16.2020.07.07.20.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 20:39:38 -0700 (PDT)
Subject: Re: [PATCH v10 1/9] fs: move kernel_read_file* to its own include
 file
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-2-scott.branden@broadcom.com>
 <202007071637.ABF914AB@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <0a3ab4c9-ee04-1cc9-6e1b-3911d58d3787@broadcom.com>
Date:   Tue, 7 Jul 2020 20:39:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202007071637.ABF914AB@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 2020-07-07 4:40 p.m., Kees Cook wrote:
> On Mon, Jul 06, 2020 at 04:23:01PM -0700, Scott Branden wrote:
>> Move kernel_read_file* out of linux/fs.h to its own linux/kernel_read_file.h
>> include file. That header gets pulled in just about everywhere
>> and doesn't really need functions not related to the general fs interface.
>>
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>   drivers/base/firmware_loader/main.c |  1 +
>>   fs/exec.c                           |  1 +
>>   include/linux/fs.h                  | 39 ----------------------
>>   include/linux/ima.h                 |  1 +
>>   include/linux/kernel_read_file.h    | 52 +++++++++++++++++++++++++++++
>>   include/linux/security.h            |  1 +
>>   kernel/kexec_file.c                 |  1 +
>>   kernel/module.c                     |  1 +
>>   security/integrity/digsig.c         |  1 +
>>   security/integrity/ima/ima_fs.c     |  1 +
>>   security/integrity/ima/ima_main.c   |  1 +
>>   security/integrity/ima/ima_policy.c |  1 +
>>   security/loadpin/loadpin.c          |  1 +
>>   security/security.c                 |  1 +
>>   security/selinux/hooks.c            |  1 +
>>   15 files changed, 65 insertions(+), 39 deletions(-)
>>   create mode 100644 include/linux/kernel_read_file.h
> This looks like too many files are getting touched. If it got added to
> security.h, very few of the above .c files will need it explicitly
> added (maybe none).
Some people want the header file added to each file that uses it,
others want it in a common header file.  I tried to add it to each file 
that uses it.
But if the other approach is to be followed that could be done.
> You can test future versions of this change with an
> allmodconfig build and make sure you have a matching .o for each .c
> file that calls kernel_read_file(). :)
>
> But otherwise, sure, seems good.
>

