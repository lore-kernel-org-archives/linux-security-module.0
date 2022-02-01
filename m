Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B0BC433EF
	for <linux-security-module@archiver.kernel.org>; Tue,  1 Feb 2022 16:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbiBAQuz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 1 Feb 2022 11:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbiBAQuz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 1 Feb 2022 11:50:55 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA49C061714
        for <linux-security-module@vger.kernel.org>; Tue,  1 Feb 2022 08:50:54 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o12so35086392lfg.12
        for <linux-security-module@vger.kernel.org>; Tue, 01 Feb 2022 08:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=CxVhdDEi1feGSQPX1jzE3EyU+xyIWaxy8YqHVrpPCGg=;
        b=feHqXZIuOK608lBk72XiN119KjVaPk9r6KgaaqU/+nukDwrZKgH1EBAxQKzGlX1MIB
         Uca1AhnZ2veQWA9+9kxYZRk5CuuMfQZs+kB6fdYqmJjLvXoLhMrlYmGwjk5igimRAORT
         7U+XZWqHEw61KerDv7+IGusR0QX8QrkHWU2Q/KRxiV5xIqv3hh6RgLI9Ue7dY4efmeEi
         aYhCnZ5JIRT0gFRdP01UD1Psyp3k3gg42yIU5wIS9ZTtQv77Gay9UzMwIPX8aZP1GkDC
         gw6uyj/HneuhSJo+NEX7xkwAqNxdPiYAJujlLfEXOxXGtRX43Fox8jKI8nPp/7FJRbAl
         vqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CxVhdDEi1feGSQPX1jzE3EyU+xyIWaxy8YqHVrpPCGg=;
        b=5JjnqF1hSzyVEWFZv0F5cvupAWwyPvdwepHRDUrKAAVhapnGXmEzpcUkKFpYqJkBC8
         jtkWYAWI5lI+1wVXHkoQJsI3+GKMLAWuFFmPhnEd3jbSja+Ia2HUO8mpe3GPCdLJq7vR
         UReTTdsGETwh+CnzqQtg1BfN72grqFn063ub+k4BNVfL2MUgdCPwTA4jTOxH/h4vHMSB
         Gaf6ITVSwTUm6SS9CDf9pARFcn+wL2szWiUp4FFpvv8Ki279FUtFg/EJioCXro2A8Ctu
         33+o0ntfMcbJKDQcn+wh4cN/8+8bE57m1nc0LCA915SR03+RUrjPkLpi5QoDEUXvSHIk
         sFsg==
X-Gm-Message-State: AOAM5315VXA4k/buWzikYMfuSI2mMHTnbBLLWEKOMitRsXQwn8tA/QNw
        WSAWoud2dZRxBWjg41xhhDf0FL50iIc=
X-Google-Smtp-Source: ABdhPJziuqcYUWcW5U3WALYiAdcELYL7+x+MmkpbGv2KFWCtO7IhBJ3c4RCnBSih6wogMB09By+D8w==
X-Received: by 2002:a05:6512:39c2:: with SMTP id k2mr19087290lfu.586.1643734253294;
        Tue, 01 Feb 2022 08:50:53 -0800 (PST)
Received: from [192.168.0.150] (0855025014.static.corbina.ru. [89.179.245.198])
        by smtp.gmail.com with ESMTPSA id cf32sm2692649lfb.133.2022.02.01.08.50.52
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 08:50:52 -0800 (PST)
To:     linux-security-module <linux-security-module@vger.kernel.org>
From:   Igor Zhbanov <izh1979@gmail.com>
Subject: Leftover info for sb_copy_data and sb_parse_opts_str in
 include/linux/lsm_hooks.h
Message-ID: <b81ca774-d45d-6b85-fb74-ffa72223b35a@gmail.com>
Date:   Tue, 1 Feb 2022 19:50:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi!

There are no more sb_copy_data and sb_parse_opts_str LSM hooks,
but there is still documentation comments in include/linux/lsm_hooks.h.
