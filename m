Return-Path: <SRS0=cbB2=A4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963C1C433E0
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Jul 2020 19:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68671208DB
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Jul 2020 19:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dcvrHKCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgGQTI0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgGQTI0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Jul 2020 15:08:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B497CC0619D5
        for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2020 12:08:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so7742703wmc.1
        for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2020 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Vo1PWad/RfqR/fd/AxYuedHKeK/43VW6RrtpDOaz9v8=;
        b=dcvrHKCi7EdXkVVflvWIzJMBuN+o9keHjn/eQMQl9puSF5R7O7DfHZLCUxp+w3PrWg
         RRv4HZwam1InZBLTuOrqNRz7hhCb/mni2bgXb63cAv3msuRhOVpvy4cEjaPX/8j3HViS
         qsgnJAxeGvco2ycqJryemyRflNwJm5df8VHLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Vo1PWad/RfqR/fd/AxYuedHKeK/43VW6RrtpDOaz9v8=;
        b=KPkd3CGeGtFQWA7cpP7jiYWtViRw58xLqEmEuS0syhPj3RAttDVIWSVoT8sLGmRTvd
         l4BF/Ws/vzuaxSK9aWfobPo/AISe32U/GTTg8ySwNKkb+PHq+/8hkC5nKSNU2Zg/fO8Q
         v/EIYwRKcIUnGcyBYLRwHtd/0W5+p5Cm1iZao48/TrtZsY75FUYSUY50cc1SHl165f5/
         usNM8W+Kr6IShx8kifM/9g3ejV/p3bogw74cnjbbtdauH15sjAk//9BMZ4EZbdz04W15
         J0ZDSq5TU88BLNQ8zsgfTsPhwf5g3B6hIaukRlPAgUyN4A/q2UFFJBmCsjeXUExPKJDa
         XKMw==
X-Gm-Message-State: AOAM531d+6hSZQBxcLuFiSt0fgXYBansga+A7sVF2YtpKS3+guphEeyb
        vroVMyUXUmpNKucBnUBQBVXZnQ==
X-Google-Smtp-Source: ABdhPJzhdwmEm/2PwY3ttPxyPeh/Z71MNC7/SFg7UbZCAs8kktCvaWRYquORL/03TJsnWTyEaFX32Q==
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr11044183wmn.6.1595012904136;
        Fri, 17 Jul 2020 12:08:24 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d132sm15237532wmd.35.2020.07.17.12.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 12:08:23 -0700 (PDT)
Subject: Re: [PATCH 01/13] firmware_loader: EFI firmware loader must handle
 pre-allocated buffer
To:     Kees Cook <keescook@chromium.org>
Cc:     stable@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
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
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-2-keescook@chromium.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <d8aa2da5-d678-811a-9c28-b372b5491d4b@broadcom.com>
Date:   Fri, 17 Jul 2020 12:08:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717174309.1164575-2-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 2020-07-17 10:42 a.m., Kees Cook wrote:
> The EFI platform firmware fallback would clobber any pre-allocated
> buffers. Instead, correctly refuse to reallocate when too small (as
> already done in the sysfs fallback), or perform allocation normally
> when needed.
>
> Fixes: e4c2c0ff00ec ("firmware: Add new platform fallback mechanism and firm ware_request_platform()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
> To aid in backporting, this change is made before moving
> kernel_read_file() to separate header/source files.
> ---
>   drivers/base/firmware_loader/fallback_platform.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
> index cdd2c9a9f38a..685edb7dd05a 100644
> --- a/drivers/base/firmware_loader/fallback_platform.c
> +++ b/drivers/base/firmware_loader/fallback_platform.c
> @@ -25,7 +25,10 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
>   	if (rc)
>   		return rc; /* rc == -ENOENT when the fw was not found */
>   
> -	fw_priv->data = vmalloc(size);
> +	if (fw_priv->data && size > fw_priv->allocated_size)
> +		return -ENOMEM;
> +	if (!fw_priv->data)
> +		fw_priv->data = vmalloc(size);
>   	if (!fw_priv->data)
>   		return -ENOMEM;
>   

