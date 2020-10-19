Return-Path: <SRS0=+Ebz=D2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5672C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Oct 2020 17:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E2C222EA
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Oct 2020 17:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeJyWmqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgJSRhC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Oct 2020 13:37:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbgJSRhC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Oct 2020 13:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603129021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type;
        bh=lYvd6Kc5MQZgVAzrvYKcsZrecx2ck/hDIb16nUNa8SU=;
        b=aeJyWmqEbs4Cr/DoR5Q0kYaTGdPVeQLvZ9wn+rR3VRj9lF2OqNqPoXnd/Lw7vDSOT3er3b
        wAvlJJ3Zr4XJIqKz1Dz6k4G0YUc6IFdOEPRQUcyB6mOVIfsqj/hXD0jLN40vJWamj+HqX+
        BLdtdhlIMFvqxjMpLUirO6QFDOFNK+g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-EktnL2V3O0SoM-apcdrc2Q-1; Mon, 19 Oct 2020 13:36:59 -0400
X-MC-Unique: EktnL2V3O0SoM-apcdrc2Q-1
Received: by mail-qk1-f197.google.com with SMTP id q15so134146qkq.23
        for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2020 10:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lYvd6Kc5MQZgVAzrvYKcsZrecx2ck/hDIb16nUNa8SU=;
        b=dt61uoh0Wck4yF+iVJoyigc29Bwyj9KhCI8W1525ujJHJ9FJ30hVEgTKnnFdyeay9W
         b02Vs21uUOprXEySldfpKH0a1h2UxTBpY6bHCC5T5lgK/AWYM6im2nTWVwmfJKZ1cGvY
         jS/t1vebKyRqZC23F54pepwjNqrztAGKVEYDFGCOtuEK8oLHpUtTlEpDpPnTqF0wmBVK
         3mvxNKlximJD1oIQgM5AWLgVCiO06+hKV+N5/og9d//1uPA59CYxDGn9C983drIsgcVU
         5HNNtIjvqPyT6I5Vvl9xx4mVIDBh2+zJs0M1VVVLHhyi1pRmU27Qjbyo85uk3y4UC/Ga
         5jGw==
X-Gm-Message-State: AOAM531WX3AJ5gd18UHPjWPe3fAOKfE57C4YSxKYabkbkvXP+Ar270OV
        mctaRNts0Ty4shVfcLM3zdp6/9b7B2+cIpVrK4+/gm68g/KCKYRv5PLGQ29jCW/k6L0f+E3sRO5
        7F7FLZiGLYZabzuAxP99NTexOc6vC2Fhdplca
X-Received: by 2002:ac8:5389:: with SMTP id x9mr575077qtp.106.1603129019008;
        Mon, 19 Oct 2020 10:36:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3+ziEhGgg3i43z5XMnTEnwSx2vwI9vWybcMni3mq3qdw3hxI6nEAg4xK1Cv/MhfSLFqhHkg==
X-Received: by 2002:ac8:5389:: with SMTP id x9mr575060qtp.106.1603129018778;
        Mon, 19 Oct 2020 10:36:58 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b8sm271101qkn.133.2020.10.19.10.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:36:58 -0700 (PDT)
From:   trix@redhat.com
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, jejb@linux.ibm.com,
        jarkko.sakkinen@linux.intel.com, dhowells@redhat.com,
        mortonm@chromium.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] security: remove unneeded break
Date:   Mon, 19 Oct 2020 10:36:53 -0700
Message-Id: <20201019173653.527-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/integrity/ima/ima_appraise.c     | 1 -
 security/keys/trusted-keys/trusted_tpm1.c | 1 -
 security/safesetid/lsm.c                  | 3 ---
 3 files changed, 5 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 3dd8c2e4314e..f400a6122b3c 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -181,7 +181,6 @@ enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
 		if (sig->version != 2 || xattr_len <= sizeof(*sig))
 			return ima_hash_algo;
 		return sig->hash_algo;
-		break;
 	case IMA_XATTR_DIGEST_NG:
 		/* first byte contains algorithm id */
 		ret = xattr_value->data[0];
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index b9fe02e5f84f..eddc9477d42a 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -901,7 +901,6 @@ static int datablob_parse(char *datablob, struct trusted_key_payload *p,
 		break;
 	case Opt_err:
 		return -EINVAL;
-		break;
 	}
 	return ret;
 }
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 8a176b6adbe5..1079c6d54784 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -125,7 +125,6 @@ static int safesetid_security_capable(const struct cred *cred,
 		pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
 			__kuid_val(cred->uid));
 		return -EPERM;
-		break;
 	case CAP_SETGID:
 		/*
 		* If no policy applies to this task, allow the use of CAP_SETGID for
@@ -140,11 +139,9 @@ static int safesetid_security_capable(const struct cred *cred,
 		pr_warn("Operation requires CAP_SETGID, which is not available to GID %u for operations besides approved set*gid transitions\n",
 			__kuid_val(cred->uid));
 		return -EPERM;
-		break;
 	default:
 		/* Error, the only capabilities were checking for is CAP_SETUID/GID */
 		return 0;
-		break;
 	}
 	return 0;
 }
-- 
2.18.1

