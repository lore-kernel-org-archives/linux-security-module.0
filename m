Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AEAC07E9D
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Sep 2022 07:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiIZHUS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 26 Sep 2022 03:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiIZHUR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Sep 2022 03:20:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4468B21E1A;
        Mon, 26 Sep 2022 00:20:16 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 78so5746913pgb.13;
        Mon, 26 Sep 2022 00:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=q/z4OGpUJMMET/OWttTP7HaK+o6nZ8v+niPLsVfiBkE=;
        b=HT8WqG2F7pZ0XFEtCG6D7krqJCgEC6ZLAu43PAiod6qShHrfHCsN8OhkpksOpFojIH
         +27eA5PNqnbGNUmtGmoRdtX+X0Ag2Pl3T7+YYiB9X7UagWcSGbAsa2LBXs7dTFDsN05w
         vyJUzApXmMsZGvJAnZ5YFtvrvZzvkd7yJnr0reLVmrCN/cYbAB4FFaV6wAYZwjxW+YEk
         YtGgx9yhwEvA3VyP+D6eu7Z8y8SJEnAw5kPq1uscL2iVy/6GtQ+fX/e6MQntKJv4nA3Q
         wJXvfhcMjddxhrz3f2Vsbi5sZtn7woCuReKkkPGag7fi7cYs5kyp+PjbOyh+0pDwYz4k
         Ci6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=q/z4OGpUJMMET/OWttTP7HaK+o6nZ8v+niPLsVfiBkE=;
        b=ezEp1gu76aJ0scSERIwg7wvyvnYtLYBFB5dK+ZhXPOCYPZ1FlEnptHjogLPZ6ldGeQ
         2wTrq+J1QqAjZvSYuIcJwHtMbJ8tFtXCmW/ahg/dOXEqIA9RVWYwnDOTP8RIJ3+3pY46
         ft/PVg36EuAhJWy6v3vvMrrhyyqt43QDvD7rhd8rhU0GMpOylk6sliN/kNdZpYUmfvKM
         VBUP4uvlUPgNJUhGcktL6Jd2Ml7xuaIl3DIOFZ4GvdTRnww4F1z5LXa8bjBJBoIA4ObI
         uRy1XkVhqUwGbWU46EwQLBTeai1Ka6eJzKjInSkhSOnQP0UCfnEmFB24BtuqRdGrKc+s
         47QA==
X-Gm-Message-State: ACrzQf2kRJvcTvm5NvU2ffmyeyYCGPJtLBI/y11/ELQqm9AMlYoK7Fnk
        m6OdpoLDH60eVpY0+C/jJSo=
X-Google-Smtp-Source: AMsMyM74uc8x/D1o9rzGQ0jemJs1nEOcsQL70+4r7DbvcA5Va0Qw9mAX3qMC6092uvOMESvt+LxIbw==
X-Received: by 2002:a05:6a00:21c8:b0:52b:ffc0:15e7 with SMTP id t8-20020a056a0021c800b0052bffc015e7mr22007555pfj.29.1664176815613;
        Mon, 26 Sep 2022 00:20:15 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-57.three.co.id. [116.206.28.57])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b001753654d9c5sm10594507plg.95.2022.09.26.00.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 00:20:14 -0700 (PDT)
Message-ID: <beecf13a-b244-fd7f-3952-74e11055f216@gmail.com>
Date:   Mon, 26 Sep 2022 14:20:06 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1 2/3] landlock: Slightly improve documentation and fix
 spelling
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     alx.manpages@gmail.com, corbet@lwn.net, gnoack3000@gmail.com,
        jmorris@namei.org, konstantin.meskhidze@huawei.com,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
        mic@digikod.net, paul@paul-moore.com, serge@hallyn.com
References: <Yy8GNAAmq6t6Kt66@debian.me>
 <9055c684-bfd0-10b2-7209-7b9898f05a88@gmail.com>
 <964ecd62-7684-6d7c-c801-25907549f0bb@gmail.com>
 <19799dac-6e16-83d8-c21e-eb0895dda108@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <19799dac-6e16-83d8-c21e-eb0895dda108@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/26/22 11:10, Akira Yokosawa wrote:
> Again, your preference is _against_ the preference mentioned in the
> cross-referencing section, quoted below:
> 
>     For most use cases, the former is preferred, as it is cleaner and more suited
>     for people reading the source files. If you come across a :doc: usage that
>     isn't adding any value, please feel free to convert it to just the document path.
> 

OK, thanks.

-- 
An old man doll... just what I always wanted! - Clara
