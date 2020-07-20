Return-Path: <SRS0=MEX0=A7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DD4C433E2
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58C02080D
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRkBtTnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgGTJOF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbgGTJOF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 05:14:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C87C061794
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q5so17045656wru.6
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJ3Uay5d4eTa1DbxGGqauoSNym5hcuAwJGYEpSnyrMw=;
        b=iRkBtTnImHWRevfyfJbyJQ4w4MCag8YjkJXOH/IDEiWvKhsOiXJo2p1qoDA8EvDPRW
         a8FCPJMKZ7GmVlNBNzdtjBOMhbRlW46OjxVeQgvZQVahG3dVYbN4z6cyDZI3C/KKQgnA
         YO8JBJimGfjTNyPavEZVUyl8lQtsro6GOLcr1PQJjZege9cID9N+Wf6UXqUA+PaJ5wmm
         HzB4eghk7O95a893RJB7KogX/Pfm9WWc5pSCauEKLJZvD3/bHM5ONZ2yjBbDKiPEOBAG
         VvsZw6hKVdxFR4X/2FmkelLcBvengRRIETp48ccz+aOPTjmfiFhMwFOe8b/OwvpD2kOA
         inxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJ3Uay5d4eTa1DbxGGqauoSNym5hcuAwJGYEpSnyrMw=;
        b=U1bg/4gfCFT3cqhzfw1mymg835tJUsnczw6syIZmFZEA+XFI40Haa3LMi+hkQnv77R
         LhIa2Jbaj5inVmlTQsskDrmwi6phFAp3kkMqNuW+S2UTcQVap9rvwuCUvrcmd2AFiwdz
         RkAznOJ4Gy8AxqdDwammZUb56DuX00PR/FHUZCQkzg6q0IGnB9ErG+MT0yzG21b4jHR7
         ki1wEwTBKXU7A5RxvrV2i6LgoUD4CsYko/o0U8r44Vpca+Hv9MYOGffgBxYwdycO62RS
         xexAtBfSF/9rZlfltjUAG4G4Ukz//dFWquNULCopalKiiPKKPlXCKWIFMTWsXT2rrkDT
         soKg==
X-Gm-Message-State: AOAM530d5QR6mhJPJaYQ84kHuoGT7CoV3QR7AXIM36EQqYjwsqnVkmmb
        gwH69KMUlOWcKgw4IJKwwgzsI22c
X-Google-Smtp-Source: ABdhPJx1GNySsH6mpmvWdgo41xyZ/HBTYGqtOgknlYtGvNtZhRBJEP6eVnHStqosoyAjzCPlJVVxMQ==
X-Received: by 2002:a5d:4b4f:: with SMTP id w15mr20833907wrs.84.1595236443510;
        Mon, 20 Jul 2020 02:14:03 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id v15sm11779143wrm.23.2020.07.20.02.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:14:03 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 04/15] Manual pages: cap_copy_ext.3: Typo fix
Date:   Mon, 20 Jul 2020 11:13:17 +0200
Message-Id: <20200720091328.290336-5-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720091328.290336-1-mtk.manpages@gmail.com>
References: <20200720091328.290336-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/cap_copy_ext.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/cap_copy_ext.3 b/doc/cap_copy_ext.3
index 18c2fe6..acbb487 100644
--- a/doc/cap_copy_ext.3
+++ b/doc/cap_copy_ext.3
@@ -34,7 +34,7 @@ function in order to hold the capability data record created from
 .BR cap_copy_ext ()
 copies a capability state in working storage, identified by
 .IR cap_p ,
-from system managed space to user-managed space (pointed to by
+from system-managed space to user-managed space (pointed to by
 .IR ext_p )
 and returns the length of the resulting data record.  The size parameter
 represents the maximum size, in bytes, of the resulting data record.  The
-- 
2.26.2

