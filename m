Return-Path: <SRS0=peEt=DO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B57C41604
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Oct 2020 10:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759EA20872
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Oct 2020 10:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjRB37NL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgJGKIR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Oct 2020 06:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgJGKIR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Oct 2020 06:08:17 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A298C0613D2
        for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2020 03:08:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x22so1041453pfo.12
        for <linux-security-module@vger.kernel.org>; Wed, 07 Oct 2020 03:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0QkHBy45JfxZtUUWeVh+Xo9BADxCzwJcCK5i5tE7/VU=;
        b=mjRB37NLj5SNoTE8pv7ujwZNmYXQSd/3yMHce8LtH63xvt4j7v4GQn5Vfx2QX1f6xJ
         fznOlC0w4fVcF4jdN4xKUqJsiN5dyj64LIV4fbdoj6fO8eO2umNLNNFwkovMWiMXwltK
         b0X3YB+JTIobDlZU6zCI5EQGkM36JsQfFxn3oYRIGXR7ZRlHCIWoKlqhoN9VAeC6gKwI
         uk1OKtT9vgtJ5zmTo/Qp/RO/swoOZlgKmUGyKymHLhZDNVptK2IMXpAQEEC/AoqySwpf
         nKouZsF6xRnLkoT+LckkTn/WcT3OQED6Rs1Wrr9DlJkM/Etba+XzIDydYmaVd6wukM7T
         tBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0QkHBy45JfxZtUUWeVh+Xo9BADxCzwJcCK5i5tE7/VU=;
        b=FGeXwEaaceRR6qAMh+pHfPLaxk68Q2gkGYGg/MyhtXFIVa3ksZWDbmK72V1FnBeOCc
         mIwhthoIQs/g/+bJSfeNvQOjcKELqk7SyYsUPKVABn8+sHyVBCI6kVi6KriGsbnYMSS/
         clQWWhhdVvk4+UqLW6+DtML1aZ+DuDpzdY3AvUiOUOE14Xq7TPK4+Qee+/yjca2Kc6ht
         LPmjB3NbJbQxqi6V8SlIFw9M/d6oxD6nYmoQ8dY4ox7/IN6xD5O1r4Lq0tZr7FYNCWhD
         cUxaeodUtPMRyjWNuMqODO2LNH0fQN+5sYCQrUDsXykDPhGc4AmDHkZOHdiA/v6SVI+W
         hAww==
X-Gm-Message-State: AOAM531Uxm1SI3e02e7JtTofW9mWhwxfs2OFuOOgN2NSfgHbSZJPQfXl
        7Kli/n6S9edGDWUv/6iPKZAYMA==
X-Google-Smtp-Source: ABdhPJylY343ok9cAC6Btln4FsnUmJ5S0BSBvwLDpHlJJvlvFlZ64WTgUaTu8PpnloGMXk0GhMRqqw==
X-Received: by 2002:aa7:910c:0:b029:13e:d13d:a07b with SMTP id 12-20020aa7910c0000b029013ed13da07bmr2262427pfh.18.1602065295978;
        Wed, 07 Oct 2020 03:08:15 -0700 (PDT)
Received: from localhost.localdomain ([117.252.65.235])
        by smtp.gmail.com with ESMTPSA id m4sm2322174pgv.87.2020.10.07.03.08.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 03:08:15 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v7 0/4] Introduce TEE based Trusted Keys support
Date:   Wed,  7 Oct 2020 15:37:44 +0530
Message-Id: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add support for TEE based trusted keys where TEE provides the functionality
to seal and unseal trusted keys using hardware unique key. Also, this is
an alternative in case platform doesn't possess a TPM device.

This patch-set has been tested with OP-TEE based early TA which is already
merged in upstream [1].

[1] https://github.com/OP-TEE/optee_os/commit/f86ab8e7e0de869dfa25ca05a37ee070d7e5b86b

Changes in v7:
1. Added a trusted.source module parameter in order to enforce user's
   choice in case a particular platform posses both TPM and TEE.
2. Refine commit description for patch #1.

Changes in v6:
1. Revert back to dynamic detection of trust source.
2. Drop author mention from trusted_core.c and trusted_tpm1.c files.
3. Rebased to latest tpmdd/master.

Changes in v5:
1. Drop dynamic detection of trust source and use compile time flags
   instead.
2. Rename trusted_common.c -> trusted_core.c.
3. Rename callback: cleanup() -> exit().
4. Drop "tk" acronym.
5. Other misc. comments.
6. Added review tags for patch #3 and #4.

Changes in v4:
1. Pushed independent TEE features separately:
  - Part of recent TEE PR: https://lkml.org/lkml/2020/5/4/1062
2. Updated trusted-encrypted doc with TEE as a new trust source.
3. Rebased onto latest tpmdd/master.

Changes in v3:
1. Update patch #2 to support registration of multiple kernel pages.
2. Incoporate dependency patch #4 in this patch-set:
   https://patchwork.kernel.org/patch/11091435/

Changes in v2:
1. Add reviewed-by tags for patch #1 and #2.
2. Incorporate comments from Jens for patch #3.
3. Switch to use generic trusted keys framework.

Sumit Garg (4):
  KEYS: trusted: Add generic trusted keys framework
  KEYS: trusted: Introduce TEE based Trusted Keys
  doc: trusted-encrypted: updates with TEE as a new trust source
  MAINTAINERS: Add entry for TEE based Trusted Keys

 Documentation/security/keys/trusted-encrypted.rst | 203 ++++++++++---
 MAINTAINERS                                       |   8 +
 include/keys/trusted-type.h                       |  47 +++
 include/keys/trusted_tee.h                        |  55 ++++
 include/keys/trusted_tpm.h                        |  17 +-
 security/keys/trusted-keys/Makefile               |   2 +
 security/keys/trusted-keys/trusted_core.c         | 334 +++++++++++++++++++++
 security/keys/trusted-keys/trusted_tee.c          | 278 ++++++++++++++++++
 security/keys/trusted-keys/trusted_tpm1.c         | 336 ++++------------------
 9 files changed, 953 insertions(+), 327 deletions(-)
 create mode 100644 include/keys/trusted_tee.h
 create mode 100644 security/keys/trusted-keys/trusted_core.c
 create mode 100644 security/keys/trusted-keys/trusted_tee.c

-- 
2.7.4

