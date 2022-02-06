Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E0EC433F5
	for <linux-security-module@archiver.kernel.org>; Sun,  6 Feb 2022 08:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiBFIDL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 6 Feb 2022 03:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiBFH5j (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 6 Feb 2022 02:57:39 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A56CC06173B
        for <linux-security-module@vger.kernel.org>; Sat,  5 Feb 2022 23:57:38 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id bx31so15183936ljb.0
        for <linux-security-module@vger.kernel.org>; Sat, 05 Feb 2022 23:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=rXdUI7og1j2yAdA0JspQf7wirmwD/uaHgVNhJfxJE5Y=;
        b=pCY+Ays5EULZNpKWcXEfSWWj4XTiLgEZ8BXJEPg9CQ8rG++4ExxS2vnx8rFUEWWs5r
         fkuy6g4SKn7VgEsGW/FJYNHCuoLufiEhXbzgxlZe0VR0NzgiHR7Xe0YpRp9xQWQzCzPx
         mj0kyvM7cKHvzgtr38sE9jnY4jg2QlKEE4Q1bQ1numb578kAXkO39NiIS+fUvctnpwrN
         B6ht8K5CkE5m7YhXdqbz6iK4l7UsG3b5Io/K3n7GDn/IsBQUldekaM9U3Z1U4YOiUV74
         77qaXH87a01AhkNzYJETmrrPq8aKTNtspqAz2y5KNL0Cftw0tO3zYpZF5kkjWXA4eKPE
         4xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=rXdUI7og1j2yAdA0JspQf7wirmwD/uaHgVNhJfxJE5Y=;
        b=i8tkQsFjaDuPyC+mo8/RGu4np/w/Wh/fvj7WzW402jsPbFYsBSDz/J1HLlwOYr1XcH
         q+F0b/B8VLkZGIu6eVnmooWyCnRBN26ba2qevTCmr97mBh/WqLpB8b0SglFOHf0NtEUn
         dpZ2xzIC2oEqryZo1ghhNvonwEYy5x27b054qQA8XRPYtonJEyPi8UzjrFrm/FIqCaOY
         sLjpQB2YFksjnkeW1RUJHwx7FkzHdjLuXUD3PssxUfv2H0TKbThNNH6qb5jCvxJ0As9i
         BjbnjXm1Jy8qFmZQyLU0Uo0zllwaAnw2t2bQS6mltPq46GS26axifqenL+KdY9q9T0mR
         bSFA==
X-Gm-Message-State: AOAM5328q6v5AHH+BiTAxXs2LJl+NnRrAEyFiMGKaAmkPNawssG79MEo
        xp8/3GPQU772GHl+hvrI7cAuAtEvJHU=
X-Google-Smtp-Source: ABdhPJy21GAs7EeOxR1l2OsI/w+0+DHmsXVoBTIiyOHE7KUDSDhlM0CxLv4pwCdJigq4XxepMBAHug==
X-Received: by 2002:a05:651c:1249:: with SMTP id h9mr5075529ljh.127.1644134256252;
        Sat, 05 Feb 2022 23:57:36 -0800 (PST)
Received: from [10.20.3.220] ([188.35.189.39])
        by smtp.gmail.com with ESMTPSA id f9sm1087289ljm.15.2022.02.05.23.57.35
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 23:57:35 -0800 (PST)
Message-ID: <2d6d1d14-8653-3a02-911d-eadb96fed640@gmail.com>
Date:   Sun, 6 Feb 2022 10:57:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     linux-security-module <linux-security-module@vger.kernel.org>
From:   Igor Zhbanov <izh1979@gmail.com>
Subject: TOMOYO can't be enabled with other major LSM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

According to commit a5e2fe7ede1268d2f80fe49ca1f717d0e3750995, TOMOYO
could be able to work together with other major LSM:
    TOMOYO: Update LSM flags to no longer be exclusive
    With blob sharing in place, TOMOYO is no longer an exclusive LSM,
    so it can operate separately now. Mark it as such.

However, current security/Kconfig doesn't allow to select TOMOYO and
some other major LSM because of using exclusive "choice" of one of them.

I suppose, if TOMOYO is ready to work alongside with other major LSM,
we need adjust security/Kconfig accordingly.

Thank you.
