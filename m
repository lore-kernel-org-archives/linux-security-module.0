Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54986C43460
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Apr 2021 18:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0576145D
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Apr 2021 18:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhD3S7J (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 30 Apr 2021 14:59:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231140AbhD3S7I (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Apr 2021 14:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619809099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=k42L3xryaez+oSKmSu1QdAMryLEAIpMx64ypVwr/urA=;
        b=MU39/HEVKQLQb1IWlaB3zSFAUW1R4OXhTxnAp9eFH8IxyzLMvoACIAB4Dfs6XWSrqdf31A
        M+NsqhskT567PRvrxXA25ple3FmTdXx/NPfrE5JXrtm5Y/pkIT92Yyy7rSTN8hswYCj3Ir
        gxjbbxK18Ka6Tt7rLazslwF9ApJKP/4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-9WDLbnEhMlunEP8W0ZQ8Yw-1; Fri, 30 Apr 2021 14:58:15 -0400
X-MC-Unique: 9WDLbnEhMlunEP8W0ZQ8Yw-1
Received: by mail-qt1-f199.google.com with SMTP id d10-20020a05622a100ab02901b8224bae03so24401216qte.2
        for <linux-security-module@vger.kernel.org>; Fri, 30 Apr 2021 11:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k42L3xryaez+oSKmSu1QdAMryLEAIpMx64ypVwr/urA=;
        b=R8hwPxWeaie5j/CIpcUnD9r4HQEqZynMCgqjOJ5HUJSpcNDKUFC+P0VwlcHIsbdZgi
         fdZD4CTBNDdjJDj5PFXcWNlroN+Nt6yA2zUDuvexAl1+PxCy4Iw0u9AEBJsSE+BLeOOo
         plQ9qYVh8Y7TjoJhv9SUqmnMYytIKOG/U3S7tHyRiAF3ojbM/6XwopNPRUeSmnbbYMu5
         OhNUvgaLcTorVyEqHkch8UhRO9/wwO7nzIz48PKYtUKGEW0pqhyL/nnrc8r3e2thmNbK
         epPo9RaDFW+Nfq7K+kPmtCwHnJ3eFYmhpo1rnjK64Bwtz53cTNr1g4Y/LNSXANyJkgq2
         mojg==
X-Gm-Message-State: AOAM532umtX3QSrsmorUrCEbQskSwHEvYoynI4yErZsR78yzhrBZMzDc
        MQv9rOX5Q9dIpW/5Z0iSW2UB4v+zy/3lPDG+t6a33Fl/Xqs1eA5okfbP8fxOtzMn8yJs46tQOMY
        ev5/PtifdhCJmPfck43v8dLv/UjLn4HlQBBOo
X-Received: by 2002:ae9:f205:: with SMTP id m5mr6950986qkg.101.1619809095102;
        Fri, 30 Apr 2021 11:58:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR2o64jnSyLn3IiYpCSQfqm0Tweb+Lrh1Ejl4G4c7Bimvr+FTabvOuLg5CiYAx+Ty5nMnEEg==
X-Received: by 2002:ae9:f205:: with SMTP id m5mr6950963qkg.101.1619809094911;
        Fri, 30 Apr 2021 11:58:14 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b17sm2802557qto.88.2021.04.30.11.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 11:58:14 -0700 (PDT)
From:   trix@redhat.com
To:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] KEYS: trusted: fix memory leak
Date:   Fri, 30 Apr 2021 11:58:10 -0700
Message-Id: <20210430185810.3331311-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem
trusted-keys/trusted_tpm1.c:496:10: warning: Potential memory leak
  return ret;
         ^~~

In tpm_seal() some failure handling returns directly, without
freeing memory.

Fixes: 5df16caada3f ("KEYS: trusted: Fix incorrect handling of tpm_get_random()")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 469394550801..aa108bea6739 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -493,10 +493,12 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 
 	ret = tpm_get_random(chip, td->nonceodd, TPM_NONCE_SIZE);
 	if (ret < 0)
-		return ret;
+		goto out;
 
-	if (ret != TPM_NONCE_SIZE)
-		return -EIO;
+	if (ret != TPM_NONCE_SIZE) {
+		ret = -EIO;
+		goto out;
+	}
 
 	ordinal = htonl(TPM_ORD_SEAL);
 	datsize = htonl(datalen);
-- 
2.26.3

