Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975B3C4332F
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Dec 2022 18:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbiLMS62 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Dec 2022 13:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiLMS6Z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Dec 2022 13:58:25 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7011BE9F
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 10:58:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p24so822116plw.1
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 10:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKl1wcPWQc3lV7wabM4Kjj2ksPRKT8Mh/REGb3spmwo=;
        b=kisO4BnNgk20qy6vPkSBK0Qzlr4fjOV5ID3Ja1+U8wZm9CuduaBDrXzMgn7x9IvPWW
         zNHIavdeQiAUxV46HCYK7mptwp4tjt3DG4JcCAIZKC8q69tsOR8gvgEMV/2N6PW4yh2B
         wEmxYwsx5J1DzK5hhP91xQLrNZCT+n+rDPrT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKl1wcPWQc3lV7wabM4Kjj2ksPRKT8Mh/REGb3spmwo=;
        b=DmsrOKt+uPb76ol/04acNEJZSBu/huPs7mpu7cBgu9hi0Fg9sP/9e5vYjd3HmY7pzZ
         GjdcRE3IS/bFQuYqQx2vew4LhC7J8YuMn/pBRv5TLxmq5XWzNIPnaBUK0xOR3p2RmZbZ
         7vhpiV5dlNG1G45MYwcz2jLp6UEIEFDrnS8li63rhutROeluFR9LXnWz5mnk0xN+Vvho
         +QG+puD766JdOzA/z9CCbGHr3S7SISeB5LB+tHA3fXKCZMv5g6GqbsevsJDAXqTU/Q1H
         NcDGpZ1GWXK213isYsu+wuJXYlkWy6C/18C5R3njdJItlam+xN8vEIgE4CJa/0MkkpOU
         0Khg==
X-Gm-Message-State: ANoB5pl89qmkqB4fZTL6YN/vrjTpRcMiL76jkllXiObg3xFcFjtqCkD6
        T90os5h6eVa4reoG7jPQLNkasyWuHb2vuVYf
X-Google-Smtp-Source: AA0mqf5H+f0ZVagL6c3TVSaf9bQExR+ENfObeUt9VJVDuC0eNpHgVHtrIpsgo3JAyyPVK1i7OM5Fnw==
X-Received: by 2002:a17:902:e011:b0:189:8062:d8e with SMTP id o17-20020a170902e01100b0018980620d8emr19884080plo.7.1670957904490;
        Tue, 13 Dec 2022 10:58:24 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001869ba04c83sm199970plf.245.2022.12.13.10.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 10:58:23 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        Jeff Xu <jeffxu@google.com>
Subject: [PATCH v2 0/1] selftests/landlock: Fix selftest ptrace_test run fail
Date:   Tue, 13 Dec 2022 18:58:15 +0000
Message-Id: <20221213185816.3942853-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Landlock ptrace failed because YAMA is enabled. 
This patch check YAMA value and skip related tests.

V1:
- skip specific testcase according to YAMA value

V0: https://lore.kernel.org/r/20220628222941.2642917-1-jeffxu@google.com
- skip entire ptrace when YAMA is not 0.

Jeff Xu (1):
  selftests/landlock: skip ptrace_test according to YAMA

 .../testing/selftests/landlock/ptrace_test.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)


base-commit: 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a
-- 
2.39.0.rc1.256.g54fd8350bd-goog

