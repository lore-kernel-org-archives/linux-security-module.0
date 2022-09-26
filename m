Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0FBC6FA83
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Sep 2022 01:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiIZBqh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 25 Sep 2022 21:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiIZBqg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 25 Sep 2022 21:46:36 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C053D26ACC;
        Sun, 25 Sep 2022 18:46:35 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id u69so5289827pgd.2;
        Sun, 25 Sep 2022 18:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8Pu2dG5AQiZFeVxvGchYNFKn/yZot3+pG/Dl9rmPkXo=;
        b=cl4R5rbE3dqIlZ43E74GpQnW8xRxzWZ3SdBKlsHo/7dHZI+3zj/Z9KDCYdO8WaTclw
         Qe/N/J6sr2txtEkM0SQlgizFyMVd5UIoU7it7ZwDR5NxPxUUlKI2Y/dsF6TF48ahBghm
         Ajo6MJmtis/8G3j+hzlG8tBrYaPOtfpzkWzpxbbZb0aE9biA3d9Q7kJFbhQVRtYLoT5G
         fAnxdQWk4sq0muj9xU9rLX8CLQaAAoafeNDSXd3n6LitBvhS1FTTSDa4kCSEqQJzsyV2
         8P6qsWAUeT3hCAfh5aWZsoHWRre4oKWRjCVogGaosDykkrORg5dzDn6yroJW8DoiWmD5
         ep+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8Pu2dG5AQiZFeVxvGchYNFKn/yZot3+pG/Dl9rmPkXo=;
        b=Up+v3KMNnIEPh5sXJwCEJVfC9lWqcH7QzOg+k0Xe8sAgkWVl+7pUnjng2bIsGZtieY
         sI9qNZtZV2l7eSadUYvLqxxkoLPloL7ACoHIqEq76ixexsd5x12hE3cygSvnBcdtTHBW
         danhDukpWGtpKjvokopklcdikQbmqYCEI7NUJjEPIMYeNiUKuRjLbD3WtEBJ0k3aY5uf
         is15yoKjNH95xFSP3Kd2+IV+Bm1sMZpQ7WqLJFQ2C1+9JTXzRO1TftYZ2PBgqc5zlpws
         opOet/5zKTpRVYXkTXi1n1LIt2AJKaJ7bj1rM/NWUFX1395bvXggTMDsPl6tSH+8ev5U
         SEOg==
X-Gm-Message-State: ACrzQf2KJKqsna82GRWlFZ8b7L3hPyJGXh3Gb4zsqyXb0VeOZ3pj5s3G
        J7XBq+fpJW2xweG/R1t8D8Y=
X-Google-Smtp-Source: AMsMyM7SuDxhhMQ46oKmYsrKHSb2HomRQRPSW/JntXpekvSxfFu2HDE2K8829l2k+oG+AGqVPmanlA==
X-Received: by 2002:a65:68c8:0:b0:438:744d:b340 with SMTP id k8-20020a6568c8000000b00438744db340mr17486787pgt.142.1664156795199;
        Sun, 25 Sep 2022 18:46:35 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-77.three.co.id. [180.214.232.77])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a31c600b001fabcd994c1sm5482756pjf.9.2022.09.25.18.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 18:46:34 -0700 (PDT)
Message-ID: <964ecd62-7684-6d7c-c801-25907549f0bb@gmail.com>
Date:   Mon, 26 Sep 2022 08:46:18 +0700
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
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <9055c684-bfd0-10b2-7209-7b9898f05a88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/26/22 08:09, Akira Yokosawa wrote:
> Wait!
> Bagas, your suggestion is _against_ the preference of kernel documentation.
> See https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#cross-referencing
> 
> Or do you have some good reason to add labels at the beginning of
> rst docs?
> 

Ah, I don't see that :doc: directive is possible in that case, thanks.

BTW, I prefer the link text be not full path to document (like
Documentation/path/to/foo.rst), but rather either the linked doc's title
or custom text.

-- 
An old man doll... just what I always wanted! - Clara
