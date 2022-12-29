Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2238DC3DA7A
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Dec 2022 21:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiL2VFw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Dec 2022 16:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiL2VFt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Dec 2022 16:05:49 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F57B1CE
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 13:05:48 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v23so20410717pju.3
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 13:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dCaO9/WtALgdTe0NS6YOvFELXlseKC/rnA/3CkUWgNw=;
        b=dggPnbyKe1jwSSW2WnEDlssVj8Fe+Bv39BrtK+eUNtnI6z/X1CDdT9joBakIQlq5FL
         /7WgfqPoREPXO6IeDwWEdO1SoMMiDjAEsVkpuaPIbcMdRLQPzvmX8JW1z0h+GwWclMJg
         y7N1AECTN7prsKV9IlGn0gOq2UHpm1uIOGHdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCaO9/WtALgdTe0NS6YOvFELXlseKC/rnA/3CkUWgNw=;
        b=wT08qRmbcJ6owh+6FnqRHHcOCpebshucMmyqjYZF4F7v+/XpzjBTW7woVeZNeDWzJM
         ColQDVoECEXlKWRv++YPgEobG3JqaMD65ZU2XC8msMMVAT6+lBXo27LBRMjvBIk++EIr
         VZySib1yp1W8KdFxYKla20mrHZOKTF2jWKi5CofXfZhAk97v6dOpnVIQxwcJO09aXj74
         UbgeoI3/vKpbFOPGRNLfdK4OEX4DVUt3dapuP20UDV0oUGWGZD/yv4CcLuSeh5S4ENk0
         JxAzdlhK3cvJ7Ni3jc5ex0nBTG1Jex4/WgLUeSS5FsdNlj0+7oqlTLsD+6bpayfJlmxu
         4a6g==
X-Gm-Message-State: AFqh2kqKS3RSCLXZFNxUmgpHVnO4PT+c889clBpjKd1TRotny+WAYdJD
        jQVDDSJaNC9s2qDeSEVaRZEo6g==
X-Google-Smtp-Source: AMrXdXs746oYW+xcvVE//yYW8d1Mho2HVCWVxonjXLENZ1nFaRYnbX5mN7Rlg03W71VIEavdb3kTeg==
X-Received: by 2002:a05:6a20:3c8f:b0:ac:5bc1:cca6 with SMTP id b15-20020a056a203c8f00b000ac5bc1cca6mr46600226pzj.8.1672347947870;
        Thu, 29 Dec 2022 13:05:47 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id g75-20020a62524e000000b005817fa83bcesm4256884pfb.76.2022.12.29.13.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 13:05:47 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Subject: [PATCH v7 0/1] selftests/landlock: fix test when overlayfs is
Date:   Thu, 29 Dec 2022 21:05:42 +0000
Message-Id: <20221229210542.3153375-1-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Overlayfs can be disabled in kernel config, causing related tests to
fail. Adding a check for overlayfs’s supportability at runtime,
so we can call SKIP() when needed.

v7:
Fix bug in supports_overlayfs().
Manual test with kernel with and without overlayfs.

v6: https://lore.kernel.org/all/20221229201215.3006512-1-jeffxu@google.com/
In v4, the SKIP() was applied at FIXTURE_SETUP() after mount() fail,
however, FIXTURE_TEARDOWN() will fail. It might be complicated 
for test infra or testcase itself to have cleanup code handing the
success/failure of steps in SETUP().

This patch changes the approach, it calls supports_overlay() and SKIP()
at the beginning of FIXTURE_SETUP(), FIX_TEARDOWN(), TEST_F_FORK().
Because no modification of system is done by the test, cleanup is not 
needed.

v4:
https://lore.kernel.org/all/20220823010216.2653012-1-jeffxu@google.com/

Jeff Xu (1):
  selftests/landlock: skip overlayfs test when kernel not support it

 tools/testing/selftests/landlock/fs_test.c | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)


base-commit: 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a
-- 
2.39.0.314.g84b9a713c41-goog

