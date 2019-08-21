Return-Path: <SRS0=EETi=WR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630B9C3A59E
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Aug 2019 12:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387A5233A0
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Aug 2019 12:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvlhXifz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfHUM7l (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:59:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41080 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbfHUM7k (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Aug 2019 08:59:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so1278558pgg.8
        for <linux-security-module@vger.kernel.org>; Wed, 21 Aug 2019 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NgcFw3hVKox4ZMncTJsF8I7dcCJPrgxZ4MMUUDjG2jI=;
        b=gvlhXifzulVxBA1k+iRoWru29nBEQt3aVFtsBJEr1ClYybOdXRI/bo+8zYaZE9BEuM
         z+L+v7mf0GNn2Kz5oicvcwk2GISMV6F6Rh5Y/R+PQ650EzYRIC0tpGQTcjnHk6bHWN0R
         QBd7eZkj98cTywlpukDtDqV/IOiu3Rfzwjm4Jx8kv7YefXkgv6kmVt8m4x4TQhNVORrN
         lYp6zAlnZUr1b0UX0npHdX4WvheApvkmyE0/IX9OZZ7vG1mG/2KjGBH7wf7DgG4kvA2N
         5zm0d9sKc4suFgABlyE45VliP3u/X+tX9FOiq9XTs55KAcqi13zbk48ZTCHuRHPtym3e
         LTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NgcFw3hVKox4ZMncTJsF8I7dcCJPrgxZ4MMUUDjG2jI=;
        b=RvpUBL/rseXPyPS6E/OlLsixmBsyjMA4/DA3lEcET4rwA5ywZ8CRO7PWL05FU9eLVq
         hFwScOUPGNrQUHdX9eqtWX3n7jw/rj8uZy9UnLcVQnhTqxIsrdV9Mx692G/ApwQIMlfF
         O93DXlUb2PK23iAQx2MwDCucbNtYbtCgMk0S+2EOEILWBSuJFr0HfWtYd51wTfINhB+Q
         Ssxsjn1Bll62Li/NFjsqyJePCX1mn0p6LzeI27uA1xg4EACURMA0c/NhU9v2Qa5m7qkK
         McFlhvXsUa5YEqIy5dsD3k574WI0BnU6NGstY+NpSfxbrKaXk4WT0DlEAExxFg62zMgJ
         EMuA==
X-Gm-Message-State: APjAAAWebX0RpXE/bLUiDf53R4b5/0+53dddD7pQHpXHYG11w/YxgFv5
        KaOU6Vmz0Afm0apnkxFi4bK5FA==
X-Google-Smtp-Source: APXvYqyOqIQGBjM7cgB9Ls3JuPghOspsk2eAlS2J0JiABhuavH0Gfjs6KSkNWBW0wNpi1dWFpP/kFQ==
X-Received: by 2002:a17:90a:94c3:: with SMTP id j3mr5011299pjw.10.1566392380046;
        Wed, 21 Aug 2019 05:59:40 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.28])
        by smtp.gmail.com with ESMTPSA id o24sm47377476pfp.135.2019.08.21.05.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Aug 2019 05:59:39 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 0/4] Create and consolidate trusted keys subsystem
Date:   Wed, 21 Aug 2019 18:29:01 +0530
Message-Id: <1566392345-15419-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch-set does restructuring of trusted keys code to create and
consolidate trusted keys subsystem.

Changes in v5:
1. Drop 5/5 patch as its more relavant along with TEE patch-set.
2. Add Reviewed-by tag for patch #2.
3. Fix build failure when "CONFIG_HEADER_TEST" and
   "CONFIG_KERNEL_HEADER_TEST" config options are enabled.
4. Misc changes to rename files.

Changes in v4:
1. Separate patch for export of tpm_buf code to include/linux/tpm.h
2. Change TPM1.x trusted keys code to use common tpm_buf
3. Keep module name as trusted.ko only

Changes in v3:

Move TPM2 trusted keys code to trusted keys subsystem.

Changes in v2:

Split trusted keys abstraction patch for ease of review.

Sumit Garg (4):
  tpm: move tpm_buf code to include/linux/
  KEYS: trusted: use common tpm_buf for TPM1.x code
  KEYS: trusted: create trusted keys subsystem
  KEYS: trusted: move tpm2 trusted keys code

 crypto/asymmetric_keys/asym_tpm.c                  |   2 +-
 drivers/char/tpm/tpm-chip.c                        |   1 +
 drivers/char/tpm/tpm-interface.c                   |  56 ---
 drivers/char/tpm/tpm.h                             | 230 -------------
 drivers/char/tpm/tpm2-cmd.c                        | 308 +----------------
 include/Kbuild                                     |   1 -
 include/keys/{trusted.h => trusted_tpm.h}          |  49 +--
 include/linux/tpm.h                                | 270 ++++++++++++++-
 security/keys/Makefile                             |   2 +-
 security/keys/trusted-keys/Makefile                |   8 +
 .../{trusted.c => trusted-keys/trusted_tpm1.c}     |  92 +++--
 security/keys/trusted-keys/trusted_tpm2.c          | 378 +++++++++++++++++++++
 12 files changed, 697 insertions(+), 700 deletions(-)
 rename include/keys/{trusted.h => trusted_tpm.h} (77%)
 create mode 100644 security/keys/trusted-keys/Makefile
 rename security/keys/{trusted.c => trusted-keys/trusted_tpm1.c} (94%)
 create mode 100644 security/keys/trusted-keys/trusted_tpm2.c

-- 
2.7.4

