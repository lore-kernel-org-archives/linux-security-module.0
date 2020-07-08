Return-Path: <SRS0=/FKR=AT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65956C433E0
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 11:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42CD620739
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 11:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZ9C/f2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgGHLCF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:02:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26696 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728633AbgGHLB7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Jul 2020 07:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594206117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R5NESMLlssU1+fU+MzHpdMP4ATVfk6Mh7mmKV6aiRHE=;
        b=ZZ9C/f2i2Fk62BYSwegaJTHQMsqj+SscleRbHgsup1BJCc09TwDH64R4PWyB2l5y4hmG1U
        hbb7kScH12OrTyIGIqMNm7Jt1Gd1lrzvasxrGJcFoU+rNNcpQtsuFqHfU+h9JwDuALw3DO
        XXBA4wvXKkkUUF9WFJWjDjy9qxIY2lQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-_ZDPvxgqO7GnTQArYlfV_g-1; Wed, 08 Jul 2020 07:01:54 -0400
X-MC-Unique: _ZDPvxgqO7GnTQArYlfV_g-1
Received: by mail-ed1-f71.google.com with SMTP id m12so57397012edv.3
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2020 04:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R5NESMLlssU1+fU+MzHpdMP4ATVfk6Mh7mmKV6aiRHE=;
        b=PHC94jj2wB3chIX0S9H7lOPf7M2ck270K5aLAQGH4Xqa3iobKuOQWeDR2fszh8mvIr
         hRR2hRKevAHmyNk40KJgGNK1aI/otEMIt9ZzKpFTaVA5xEhx6od4t2ba+DWcjFQ9JhoX
         nMkAXUeFO57A+JJEfhEYkPqJ+SUtMiW2rbOozwL454K9xGLOOrSwiOg3M6fKGV3vXhVC
         Qald+BEms//PhKkwjz3kKA0C9xpma3V8hsEtQK6hndwJBsQcaw1xBpk0JsEdFBHarz32
         20C3AxONJMr1Z+E1NO5HrU5lJHH7obnz1k/KjwH04tdEf0ZIUuhQbnjbTyEAMMH+YAwq
         KzNw==
X-Gm-Message-State: AOAM532In43kkxNZraeXtE6Onx8Q+fjVzH9eZF+7XhuTS/975NmxM/iH
        OlBCqOgbed9AqVkpjsqWxQQwg+JKRFvgB+8I5l/uGQYWjrsGBQQA39nI9hmkua22MtbI5XZQU3h
        e3N2ZluDqvlv0NasAajsDrXuaJjreocB7dFBQ
X-Received: by 2002:aa7:d297:: with SMTP id w23mr63681848edq.49.1594206112970;
        Wed, 08 Jul 2020 04:01:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu3h7uw896uTUPxnA3LkPYXdQN/SwlS39PF0fY2ZywJDOPl8R3ZF8j4DbvajdrArtX/ozobQ==
X-Received: by 2002:aa7:d297:: with SMTP id w23mr63681803edq.49.1594206112726;
        Wed, 08 Jul 2020 04:01:52 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id p4sm1776088eja.9.2020.07.08.04.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 04:01:52 -0700 (PDT)
Subject: Re: [PATCH 0/4] Fix misused kernel_read_file() enums
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3c01073b-c422-dd97-0677-c16fe1158907@redhat.com>
Date:   Wed, 8 Jul 2020 13:01:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707081926.3688096-1-keescook@chromium.org>
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

On 7/7/20 10:19 AM, Kees Cook wrote:
> Hi,
> 
> In looking for closely at the additions that got made to the
> kernel_read_file() enums, I noticed that FIRMWARE_PREALLOC_BUFFER
> and FIRMWARE_EFI_EMBEDDED were added, but they are not appropriate
> *kinds* of files for the LSM to reason about. They are a "how" and
> "where", respectively. Remove these improper aliases and refactor the
> code to adapt to the changes.
> 
> Additionally adds in missing calls to security_kernel_post_read_file()
> in the platform firmware fallback path (to match the sysfs firmware
> fallback path) and in module loading. I considered entirely removing
> security_kernel_post_read_file() hook since it is technically unused,
> but IMA probably wants to be able to measure EFI-stored firmware images,
> so I wired it up and matched it for modules, in case anyone wants to
> move the module signature checks out of the module core and into an LSM
> to avoid the current layering violations.
> 
> This touches several trees, and I suspect it would be best to go through
> James's LSM tree.
> 
> Thanks!


I've done some quick tests on this series to make sure that
the efi embedded-firmware support did not regress.
That still works fine, so this series is;

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> 
> -Kees
> 
> Kees Cook (4):
>    firmware_loader: EFI firmware loader must handle pre-allocated buffer
>    fs: Remove FIRMWARE_PREALLOC_BUFFER from kernel_read_file() enums
>    fs: Remove FIRMWARE_EFI_EMBEDDED from kernel_read_file() enums
>    module: Add hook for security_kernel_post_read_file()
> 
>   drivers/base/firmware_loader/fallback_platform.c | 12 ++++++++++--
>   drivers/base/firmware_loader/main.c              |  5 ++---
>   fs/exec.c                                        |  7 ++++---
>   include/linux/fs.h                               |  3 +--
>   include/linux/lsm_hooks.h                        |  6 +++++-
>   kernel/module.c                                  |  7 ++++++-
>   security/integrity/ima/ima_main.c                |  6 ++----
>   7 files changed, 30 insertions(+), 16 deletions(-)
> 

