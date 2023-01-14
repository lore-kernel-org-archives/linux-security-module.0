Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5F1C3DA78
	for <linux-security-module@archiver.kernel.org>; Sat, 14 Jan 2023 02:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjANCDP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Jan 2023 21:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjANCDO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Jan 2023 21:03:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13778B510
        for <linux-security-module@vger.kernel.org>; Fri, 13 Jan 2023 18:03:13 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso28754642pjt.0
        for <linux-security-module@vger.kernel.org>; Fri, 13 Jan 2023 18:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4IyBXTT4pN6EnZTfEuVmltXizjWAjD3Yj4Hx2AMkZZo=;
        b=ansz0uonRDw27qN4pQOLKMEZ3B+O7Q+Xm28HAisB7Qds8g1z9NMEpEuMX0l/2DW8xr
         t9BOd4+THrS408DAWPOx7D9VMVzaSE993miExPHfE2ltqrOEIA6hwujceZ+pKbMIIhbu
         qkWktJidfCdDziW8SUzjfw4Lo99vK7zpEOhV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IyBXTT4pN6EnZTfEuVmltXizjWAjD3Yj4Hx2AMkZZo=;
        b=avI9CUFxrWqj9enzozljjktaCREnoWaOz42sT/uwFmC1bT69OluEGLvsHt2wwjeO/d
         qVlR5mMCP2wA5YUs4O3rady/q12zMICbZG6K8oBFguwJDJJRX9P0lQFZEVEjqD5h2Ut0
         SMVrvFys4wHWk9g9oIDEVYbO6REMRTf9Wwy7d7VXLv7Z2g82+DpctMrMpcQIMekdNjpF
         5pZFpkCpL4ht6M0gJDUn2d/rt1Cznm2VpQP5PO3+gcvl8hZ2LVYY+dhimYK9ykIpyIqU
         qxq4h9zL9SX71VA+E6X401cHy569grFocu84toisgm6xAuZE8VmEVObE9WtVTiZG+UjM
         8N+g==
X-Gm-Message-State: AFqh2krnY/7t++HepYY+rYnE68ujwT+9ySOQXLS7MZcudVYUQED35M5W
        Y95Cn6Ke3ZQnpdzIT9vU/A41IA==
X-Google-Smtp-Source: AMrXdXtBxhgbLgVpyzeN+QE1hD1nhl+q0yavKomAIVpFUJrf1ILaN5UuxX3NbD+rWmCgp9U7Xx26EA==
X-Received: by 2002:a17:902:cac9:b0:189:e3d0:2682 with SMTP id y9-20020a170902cac900b00189e3d02682mr11010714pld.30.1673661793155;
        Fri, 13 Jan 2023 18:03:13 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id l33-20020a635721000000b0047702d44861sm11882491pgb.18.2023.01.13.18.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 18:03:12 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Subject: [PATCH v6 0/1] selftests/landlock: fix ptrace_test
Date:   Sat, 14 Jan 2023 02:03:05 +0000
Message-Id: <20230114020306.1407195-1-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Landlock ptrace failed because YAMA is enabled.
This patch check YAMA value and skip related tests.

V6:
- Squash change from Mickaël Salaün 
- Link: https://lore.kernel.org/r/20230113175308.50900-1-mic@digikod.net
- Add can_read_child and can_read_parent
- Remove SKIP(), add log for incomplete test.

V5:
- https://lore.kernel.org/all/20230113050755.1277736-1-jeffxu@google.com/
- address comments from groeck@google.com

V4: 
- https://lore.kernel.org/all/20230103190314.3882177-1-jeffxu@google.com
- apply can_trace_parent and can_trace_child to smaller scope.

V3:
https://lore.kernel.org/all/20221227140244.1041292-1-jeffxu@google.com
- add can_trace_parent and can_trace_child to handle yama value.

V2:
https://lore.kernel.org/all/20221213185816.3942853-1-jeffxu@chromium.org
- update from code review comments.

V1:
https://lore.kernel.org/all/20221213185816.3942853-1-jeffxu@chromium.org
- skip specific testcase according to YAMA value

V0: 
https://lore.kernel.org/r/20220628222941.2642917-1-jeffxu@google.com
- skip entire ptrace when YAMA is not 0.

Jeff Xu (1):
  selftests/landlock: skip ptrace_test according to YAMA

 .../testing/selftests/landlock/ptrace_test.c  | 112 +++++++++++++++---
 1 file changed, 94 insertions(+), 18 deletions(-)


base-commit: 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a
-- 
2.39.0.314.g84b9a713c41-goog

