Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208C8C4332F
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Dec 2022 14:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiL0OC7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Dec 2022 09:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiL0OC6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Dec 2022 09:02:58 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D4A5FE2
        for <linux-security-module@vger.kernel.org>; Tue, 27 Dec 2022 06:02:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so13348559pjd.0
        for <linux-security-module@vger.kernel.org>; Tue, 27 Dec 2022 06:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lLuO2ebmBElZWmYpU+bLPLdrdeQVy3PrXD4ReH/BND8=;
        b=I4Bh6UWPiuURiYpAsRPXndunv8kEgp+HAHtWQSZ6WzD+BxymQmNRxGszTQ3gwkrGvU
         cYZzBbRPe9LVcrS+Hbil1Na5bYex/bViTYaaIXm9qBup8x2rIsiEkQvYOWh3u3zxd/cH
         2XYIS2oyRUuAdmQX5aCB0xqOUW+VxftRSo7Fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLuO2ebmBElZWmYpU+bLPLdrdeQVy3PrXD4ReH/BND8=;
        b=G46iBYwT64e49TPBPpIDOEQlimB+Bxi+NXv+9ZEXcthP2CxkQn+Sd3F0QXnKBOlZUV
         8LafV2U7QstMCio+60IneHRmW6ERkbwEELX+NmUQdyrv1rsb9oCm7FemcAFmwJeYL4nZ
         A6pf2EBBvbsqOdFfSgvO+CSbLX37LTaeQTiiDrv8q6SzQY6xD8JpsKzOUiU93jhFmgmp
         UGuljHpBS01D5EJf7s+DCSj+OGJXBx1E7CsNNX8NldgwS/aj2v5xSLb5rXVwXcqIWU6V
         QC7by+9hNBviJv+8BQ+NrAG79B1HzlNSEafRZQIxchO3tKxmIw93PZbaRrZ55oeNxCAl
         0U2g==
X-Gm-Message-State: AFqh2kobGAw0BzWsqCBjVCARzt4L+XDR9sj488Eeo9a7uNfYeWUUi4i8
        Wjo/ZgJtqLwXjcxBz/EORhiC0A==
X-Google-Smtp-Source: AMrXdXtXzU3WKFpwmPf2CJgefoNCeRermTMmji5fVHqFreGX9tHT+p5eJ3d3nGbw9wTKJqK2fnPPBA==
X-Received: by 2002:a05:6a20:3c93:b0:9d:efbe:a113 with SMTP id b19-20020a056a203c9300b0009defbea113mr29830724pzj.35.1672149777200;
        Tue, 27 Dec 2022 06:02:57 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id y17-20020a626411000000b00575b6d7c458sm8674530pfb.21.2022.12.27.06.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:02:56 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Subject: [PATCH v3 0/1] selftests/landlock: Fix selftest ptrace_test run fail
Date:   Tue, 27 Dec 2022 14:02:43 +0000
Message-Id: <20221227140244.1041292-1-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Landlock ptrace failed because YAMA is enabled.
This patch check YAMA value and skip related tests.

V2:
- update from code review comments.

V1:
https://lore.kernel.org/all/20221213185816.3942853-1-jeffxu@chromium.org
- skip specific testcase according to YAMA value

V0: https://lore.kernel.org/r/20220628222941.2642917-1-jeffxu@google.com
- skip entire ptrace when YAMA is not 0.


Jeff Xu (1):
  selftests/landlock: skip ptrace_test according to YAMA

 .../testing/selftests/landlock/ptrace_test.c  | 173 ++++++++++++------
 1 file changed, 112 insertions(+), 61 deletions(-)


base-commit: 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a
-- 
2.39.0.314.g84b9a713c41-goog

