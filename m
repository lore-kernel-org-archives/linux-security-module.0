Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB13AC001DB
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Jun 2023 03:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjF3DZl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Jun 2023 23:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjF3DZk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Jun 2023 23:25:40 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B4B1BD3
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 20:25:38 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b7f9d66812so11384135ad.0
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 20:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688095538; x=1690687538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qGZNY/d45qcsqv/6dK9Kz1D5j5tQyoBwHqcnw/3xWks=;
        b=ClO4Qqdk//HiL4nAnF+jD3EXrUP0WC/6JqzrvFwxUaQAnuTb8GhL6XjHKC0M5ZnWer
         q/QyM079DUjYyDDb55dxU0VEZkgtgl707aXs/D3aUAnFICB1gvftBkzo+qbnZ+XHv7Xg
         dpb6aAnBl6WZhLhF8JseLS8FEa3OkLY5IW4HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095538; x=1690687538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGZNY/d45qcsqv/6dK9Kz1D5j5tQyoBwHqcnw/3xWks=;
        b=aLND3A4KIuxZBaL1jxF2I99soPg8kF/S7XBzwic/w2jk0HGSNioQlrUBnklstA+RUa
         OGKq4pLIdqJV8mpeC3LevtUIabaBndOouS1rh2xEP7skZ6/g792BLQg9rOMwVXWSGxQT
         gyU1E1ceWw8oZ7EgwDyu4tZpC3L0x8/WjynFf0Px8x2cHdsHpM/FvoaVHw4IqyeVS/us
         pUnCGZr/46M7uyNnM3ez95KmoLXF1k0xs/bOhQis2SxgJNW0uTV8jA47vm0Evmsbt2DW
         jq+z/MqblgbL7DvEF8xatiHyaL8k7pOmj5UOzA5oSZye5lHqn1AVN7/iWbhH/GLOKFfE
         wWIw==
X-Gm-Message-State: ABy/qLZr/27yIZe+JgMWsupTLm6OAHA6eUGTVnUSDOE0vtnhST3QyLXs
        kAsdyOkbJKi6hS/XxLpxNb9AH8FOYLiPxj/vM1I=
X-Google-Smtp-Source: APBJJlE7RIil3rQSgYWENbH10+1mHtgxaRDkTD8nyfCULDKfglAL51FCHofXxyxl+cjgtq0ZR5dd4Q==
X-Received: by 2002:a17:902:d2cd:b0:1b8:16c7:a786 with SMTP id n13-20020a170902d2cd00b001b816c7a786mr1379879plc.4.1688095537808;
        Thu, 29 Jun 2023 20:25:37 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id x3-20020a1709027c0300b001ae5d21f760sm9728322pll.146.2023.06.29.20.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 20:25:37 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 0/1]  Add documentation for sysctl vm.memfd_noexec
Date:   Fri, 30 Jun 2023 03:25:34 +0000
Message-ID: <20230630032535.625390-1-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Add documentation for sysctl vm.memfd_noexec

Thanks to Dominique Martinet <asmadeus@codewreck.org> who reported this.
see [1] for context.

[1] https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/

V3: resend V2 with cover letter.
V2: revise.
V1: initial version.

Jeff Xu (1):
  Documentation: mm/memfd: vm.memfd_noexec

 Documentation/admin-guide/sysctl/vm.rst | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

-- 
2.41.0.255.g8b1d071c50-goog

