Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAC9C678D4
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Mar 2023 18:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjCBSxp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Mar 2023 13:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjCBSx2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Mar 2023 13:53:28 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA2913D75
        for <linux-security-module@vger.kernel.org>; Thu,  2 Mar 2023 10:53:27 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id s17so63863pgv.4
        for <linux-security-module@vger.kernel.org>; Thu, 02 Mar 2023 10:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677783207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=19sPNpvioqmjHXQZ8W0SFyJmIXuAcC13sOwLHHa3IcA=;
        b=ObsjiKyzXTrtjl2JEJibctf3fv5TVe68XHTmQ5MCfoHwYL/Iaq51dPKbWx4L8/yhws
         mMJPuow1YaQuaq5J3PhNoIAYGd+KDc4Tagf8G3Eo3XUm1VYTmYkou4D0UBCvin0GfgEd
         pNI2DmqF9/5QQWajVH+2NtSOnR+ZNTQjV2sOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677783207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19sPNpvioqmjHXQZ8W0SFyJmIXuAcC13sOwLHHa3IcA=;
        b=iVRwncfopf3pMqopR6vS2gsfnU+6HbkTkxXF2InA9qvxDrYCVqli53fSUNcUMEVHSO
         L3wM3qTyrzn4DNldzERmhKVdoNqiEIZOkbmjbYQSZIHNBEu52JB9NbdWxTrZ/eLs/wO+
         EaAbFX8o7387fx1oC3OBZFW3dgKuUtQPZdEU7CkvwlJi7DFW/O8i99QAI6zFZhocelyb
         NacHJAivQ38uX46nlO0tEDfP8DLfByLDd7DFTkCZpNfzUMyJA0vtOtL6GcRUFSnQ09xk
         gaVnUrRCivKm6QV/UuCuvGq1vnulKqK7Wtu8R3Bn9M9AeyjnUL3q4GIHINtXKdiuznh7
         SdRA==
X-Gm-Message-State: AO0yUKU6HmM1QMdpsD78A8ZQrr+pbPuHehVoBRHVi+QT4Q9QGH867ihF
        uBoiGPkn7YN1ka/+18ilWq3RUQ==
X-Google-Smtp-Source: AK7set+4pfKeFUKh/zbxlktuGsGPOpfJcs9R1u3y2rDpvUVQ0bGQ1po8bTqb2Bqj/2yRy7TtJ03/Ug==
X-Received: by 2002:aa7:9466:0:b0:5a8:cf20:e35f with SMTP id t6-20020aa79466000000b005a8cf20e35fmr8426363pfq.28.1677783207272;
        Thu, 02 Mar 2023 10:53:27 -0800 (PST)
Received: from enlightened2.mtv.corp.google.com ([2620:15c:9d:6:9b33:9b92:f51d:bd4])
        by smtp.gmail.com with ESMTPSA id b4-20020aa78704000000b005a8c60ce93bsm26782pfo.149.2023.03.02.10.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 10:53:26 -0800 (PST)
From:   enlightened@chromium.org
To:     mic@digikod.net
Cc:     linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jeffxu@chromium.org,
        allenwebb@chromium.org, Shervin Oloumi <enlightened@chromium.org>
Subject: [PATCH 0/1] process attribute support for Landlock
Date:   Thu,  2 Mar 2023 10:52:56 -0800
Message-Id: <20230302185257.850681-1-enlightened@chromium.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Shervin Oloumi <enlightened@chromium.org>

Hi Mickaël,

I'm looking into adding a simple process attribute getter to Landlock so
we can determine the sand-boxing state of each process based on
/proc/[PID]/attr/current. As ChromeOS is expanding Landlock support,
this would help us paint a clear picture of Landlock coverage in the
fleet. I prepared a patch as a starting point, and would love to get
your feedback.

One area I am not very sure of is the case where more than one LSM is in
use. In such cases each LSM could have its own process attribute
getters and setters. What I learned is that when this is the case, the
kernel only calls the hook function for the LSM that is loaded first in
the CONFIG_LSM option. For example if landlock comes first
(CONFIG_LSM=landlock,...), then the kernel only calls the hook function
for Landlock, when the userspace interacts with process attribute files.
This is not a blocker for us, as we only currently care about reading
the Landlock related attributes, and my understanding is that this is
working as intended, but wanted to get your input.

Shervin Oloumi (1):
  lsm: adds process attribute getter for Landlock

 fs/proc/base.c         | 11 +++++++++++
 security/landlock/fs.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)


base-commit: e2ca6ba6ba0152361aa4fcbf6067db71b2c7a770
-- 
2.39.2.722.g9855ee24e9-goog

