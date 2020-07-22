Return-Path: <SRS0=gxm9=BB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7F4C433E1
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Jul 2020 21:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E601A22B42
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Jul 2020 21:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb7YmVbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgGVVAI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVVAI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 Jul 2020 17:00:08 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3F4C0619DC
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2020 14:00:07 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a8so2753963edy.1
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2020 14:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VtXxi4J6e6brclgCXogeGcozEtoLwv/KQauxoYVY0uQ=;
        b=cb7YmVbFBp2vVfPiyJ+Xr27nhTjtkEWqunHHlqHw7Faj83NQeY7si4802h7z4T6dMa
         XqUeMEXXH1sa+SoQyA6QOvCMK2t0i0dGbLCfSrFMVObr4gueRkFkdsuPVJQJj8NVCJ2t
         LLSw8A6eoS9uK2Rcuhivs8zPuzcT4peATqeqypn/J/2+2RCu5awC71R+xuL3onNobnN6
         SFuYK2iQ8b2BajMxbDJVlFpJVLR7tl9V80HW7Ax6OgbTf2OU6c1P4hwF/BXZpS9ZNdmw
         jkER2FOfechp9aMJ7vrWy5k7L2veXrcKwgYAe+Mt0yyhBl7kP9E006/DAXYtzPoQoj6X
         oPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VtXxi4J6e6brclgCXogeGcozEtoLwv/KQauxoYVY0uQ=;
        b=V8xq2J0HV2VptMv5B/5IKdaJvG3XRzmRgAVFba57mTfFFcwgNq4TG5qWx+l34w/hUs
         S/AQDE1Xl8PkDpjg1FL5YzJe4VOLrxeVagdjKZqe9wVl7L6jLkVg3TVzlMKVPEV5/9Xy
         Les0qwwQcAIu885al6CZuRKKpcGUofZ0x09v1Rb2N8GgEHFlPu3kdSlB3m6cczu/cbcc
         knnwPKuSt87qWDigtW2CL1MLWasJodlFJh2Evrx5U+RKwtYhGo5qgNB2825yt7qUfs8Q
         KXm2cTCQ2aaHeCMu6WLDKNahmcdt+yqCM3ChZpB5b6E01z+l4Fd6+QdFQfaUb1uGPiDf
         2RAw==
X-Gm-Message-State: AOAM531zNSbP3zWjVFIIrQk7sV6x3JrnIUphXoFOJOzOy20TEIVOgRrV
        +K4UfIWz2MTgKu/2pmLsP4o=
X-Google-Smtp-Source: ABdhPJwgacycxcCqqtIDbMZmYPbsYBC/fx94S2Kw4Qj6py+T2Bqk5/Lg5DPbBv1k6GK4FcS2JrIiEA==
X-Received: by 2002:aa7:d4d2:: with SMTP id t18mr1248221edr.166.1595451606408;
        Wed, 22 Jul 2020 14:00:06 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id by20sm523132ejc.119.2020.07.22.14.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 14:00:05 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH] Manual pages: cap_from_text.3: Clarify a detail of cap_from_text() action list
Date:   Wed, 22 Jul 2020 23:00:01 +0200
Message-Id: <20200722210001.423416-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The fact that the action list of a cap_from_text() clause can include
multiple operator-flag pairs is a little hidden in this page. Make it
clearer by separating this information out into a separate paragraph and
showing an example of the equivalence to multple clauses.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/cap_from_text.3 | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/doc/cap_from_text.3 b/doc/cap_from_text.3
index e59ca59..9f4c50b 100644
--- a/doc/cap_from_text.3
+++ b/doc/cap_from_text.3
@@ -139,9 +139,16 @@ capability list and one or more explicit trailing flags.  The `+'
 operator will raise all of the listed capabilities in the flagged
 capability sets.  The `\-' operator will lower all of the listed
 capabilities in the flagged capability sets.  For example:
-"all+p" will raise all of the Permitted capabilities; "cap_fowner+p\-i"
-will raise the override-file-ownership capability in the Permitted
-capability set and lower this Inheritable capability;
+"all+p" will raise all of the Permitted capabilities and
+"cap_fowner\-i" will lower the override-file-ownership in the Inheritable set.
+.PP
+The action list can consist of multiple
+.I operator flag
+pairs; the actions are performed in left-to-right order.
+Thus, for example,
+"cap_fowner+p\-i"
+is equivalent to "cap_fowner+p cap_fowner\-i".
+As another example,
 "cap_fowner+pe\-i" and "cap_fowner=+pe" are equivalent.
 .SH "RETURN VALUE"
 .BR cap_from_text (),
-- 
2.26.2

