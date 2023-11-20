Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E86C2BB3F
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Nov 2023 21:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjKTV7a (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Nov 2023 16:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjKTV73 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Nov 2023 16:59:29 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFEDC3
        for <linux-security-module@vger.kernel.org>; Mon, 20 Nov 2023 13:59:26 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41cc0e9d92aso29991011cf.3
        for <linux-security-module@vger.kernel.org>; Mon, 20 Nov 2023 13:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700517565; x=1701122365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+dUw6Pw4OsFtrjJ9+WWyi3blOtiKtrzBkVhCpNGDLqc=;
        b=APYr6A4B+pEiECJEu+LbQvHpu2y4Lk+iVOVsUkD0Voe0bKuLJ2AgVFtzokL/3bkfZt
         MTxtaY2VJF1NGwiQP6mDroQ8fI9TXDTK4utFWUwpyZUNQkXABirPDEd8i9D1WDvnLU90
         1Y9bGL2n3k/4U8oDCVv5kzWRLezRIfC44swr702umHDKVLWLgUQXxwq5hqfx5zYkTFet
         rOFILIhvk+K9QBBrKI+pgwyFSPuMNrvCM/dwNVUiy+X/knZdaRpELzdLHaR9x8155reN
         UnZtsHhTZ3aPNgywoYU6H7vFlRjvpZvvPRw85qiMd2R+WXxgMDVzT9mfuUhhxf72i+yn
         CObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700517565; x=1701122365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dUw6Pw4OsFtrjJ9+WWyi3blOtiKtrzBkVhCpNGDLqc=;
        b=OwHz21H54pqbqof7JqdicipMbLbaunz/eRJEZYrdf0zmnRAA8/wLXy6JoJQ75wVPSv
         Ebf4TKznZKfzbsdzTUwfKlsWrZJSlk7W5fAAKr2VotZGMrjW1BA7Xn+3HfIYwn4GPiyN
         WqXhPlc+7ZFmLHVHgBb68c41co02m7wwBenIJ3rZXp/5CjPezdoRWHricctha24z9N8M
         AsqNOuUvHYrmnK9AahYod2y3q/LHoAQyP53BjUoInOXgPDLfppyNGRK7NfqulhKtMPe6
         uopiya+fPjSIPiH0HcLmcFrNpHbhibUmuufjvMOWHbSBI9TfcXFwOlGwhzaVcgNNZhy7
         IO8w==
X-Gm-Message-State: AOJu0YzN4jFb3Ruq7yVda/TFL6UVU8BsQTghTJ1zn3/XUcaGHToqrvdg
        zJ3l/4pe4ckCCYTSKMC3eMf1W3a5X1z8LF/dew==
X-Google-Smtp-Source: AGHT+IGQtljhmITKuuQMLL5W41zQTl4I96DouBOcO4TmGl67Og7ZGkQnJTdU1lfpteTHZ0lrdr/OrQ==
X-Received: by 2002:ac8:7f51:0:b0:421:ba87:43f9 with SMTP id g17-20020ac87f51000000b00421ba8743f9mr11068798qtk.33.1700517565018;
        Mon, 20 Nov 2023 13:59:25 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id t20-20020ac85314000000b004166ab2e509sm2948840qtn.92.2023.11.20.13.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 13:59:24 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] MAINTAINERS: add an entry for the lockdown LSM
Date:   Mon, 20 Nov 2023 16:59:18 -0500
Message-ID: <20231120215917.287595-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=869; i=paul@paul-moore.com; h=from:subject; bh=yModHhJmfEX6qbwNt/OLmTa3EyqpJPG4aM1HCk9mZes=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlW9a18DzJ3alvu0sMzl1Kpps8i0wSf2NaNsfMA IQW4c8xE9uJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZVvWtQAKCRDqIPLalzeJ c9DFD/9PZGoRzX1dhUy3fRJeVnJBXvdsgEhvG9fanDm2PlTp5XLdaplnxyK2rQNeipO76BeNVrB 0iDXfSt2h+FXR/C43xwsgQT3OBAfYVBiMI5awYcini0RB2iL8Mw9uN3RZyJpkKIGxFymtIl4sa5 FJY8aYoU1MRGLVBAZI19eB8hOVvPw4S0reYluG5BRRI7gfZ+p6sCWSP85y9qWptXe3RlnfBwWhE epMimt43vqYscdjAc3j0BoEtlfvQFyQuQO0gAo1d0R5AqxOXnN1eMDYdY/2SzDSjzkoC3O7unfZ k9qp1Wx5Ny8EYpkq/PbcQAgErsGKgDXY2afEClmG5FRKNWBNWiM/5vtJWLuvq6qeoHqAqGLmzlI VmghLa0KmcG8At2DAvgunA/lRXEPYFxAh1QyZ+Aow73jYVakhE74gLVIMPMbpXfL/U85XOOnbeM CR/ny6D74RwAP8YeCWkZpDJBRPW3GWJ5145jIx9GlYhZ4yLV6urdzuxvXyHmqZetO2IiH+G/Wjj oRxkU/R3X07CEcYcu+aVc1goRQ9e9GGIMolGsyjvYCDk96oP/eR2gNppg15SMPBkf4blk2ugrBK ah4X67Q/P6sfNkghdENP7aOLQqvP6XXbrvL5/N6nJDfhJmhSzJS3hG1TgRuBtPsDqJjJW6HB4G9 OEDud4HullFiU0g==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

While lockdown has been present in the kernel for a while, it is
missing a MAINTAINERS entry for some reason.

Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 34187ece7330..ec70e163e458 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12447,6 +12447,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/har
 F:	Documentation/admin-guide/LSM/LoadPin.rst
 F:	security/loadpin/
 
+LOCKDOWN SECURITY MODULE
+L:	linux-security-module@vger.kernel.org
+S:	Odd Fixes
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
+F:	security/lockdown/
+
 LOCKING PRIMITIVES
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Ingo Molnar <mingo@redhat.com>
-- 
2.42.1

