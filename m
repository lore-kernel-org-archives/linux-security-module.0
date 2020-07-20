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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2A2C433E7
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DAA2080D
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZku9RrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgGTJOO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgGTJON (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 05:14:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BD6C061794
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c80so21522435wme.0
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBMMpk2qHCVqK9+G1JkJ/e3L+uEemx5nyjpX9rZHTOg=;
        b=LZku9RrTsIxxYXfkhsdY8wPu7O7BIS3Q+dBYK4z7QwhkjqzDHvUCrhvmSbMO77rgRt
         3D28Zs2n39YB+Qh/TaCsNLdgv5Jezn2PjbQjlX678wjOMl6oYHDtTmupeJ4fjxFhaJHH
         05fvzEK24yksg/IxDU3guE3nY0P9/7ONAo/3n5CUVqQTdQAxs0khSY0ur6ZneZP2uNWM
         Zs8e5xh1SpuFqol6soAg33IJyD7xt8bEnSvzf1UW7CFpYZ3HGZ/xzqKaBSlsM4rPXCiy
         qFCUh3NHDdpRjCg75aVMPOdQfwzjYZuS2tse0USjbE+FNTNc9OJnjfrNOnB7eppJaLud
         dzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBMMpk2qHCVqK9+G1JkJ/e3L+uEemx5nyjpX9rZHTOg=;
        b=j6kZKoHsV2Z5RfQyEXUU/N49NCpOfEi8HNKkJOti0HoAnBepKgI4e4zjX5Mf4d5sTR
         yCQM2WymzzJ5Xayy2Jn099RIjPyiwXMRpxrq/zUGcwAjKYjP46h1sUlMhh/2JS2JjR4x
         BM+Td0lQojmWUBvukS0pb5BEhHG6z6WTDE+NzsSDgzXN3H3seZ/tvOPVxDvfpIt0Ts9Y
         JCG+kZSqWWVoPhPGLl81lZw5vJ91H3lL4EUPD19ST+AGVxHuPSFIoSyo4V585P5j6r1B
         60bcujyfgfbpd/XjUuQAmcoM1UkzWnjAXLCcD7p8U3tMTTqw9mbVFADcYwacj0YdDlLA
         uuwQ==
X-Gm-Message-State: AOAM532otP6vabJNJeU568QDhR1ZYJTtIVNTRRFhyxdp49U0tDjGUtIm
        Z9FQrUD7LJZ9XJQx7V4U2GQ=
X-Google-Smtp-Source: ABdhPJz5d2qhGDyPah9v3gxRWYQPCU5sHxqqNiYrVDrNQ0AdKj238IkHQpla040CzSltq9AkrDyOTQ==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr19801099wml.114.1595236452458;
        Mon, 20 Jul 2020 02:14:12 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id d13sm31489032wrq.89.2020.07.20.02.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:14:12 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 06/15] Manual pages: getcap.8: Add missing word
Date:   Mon, 20 Jul 2020 11:13:19 +0200
Message-Id: <20200720091328.290336-7-mtk.manpages@gmail.com>
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
 doc/getcap.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/getcap.8 b/doc/getcap.8
index d867203..367d010 100644
--- a/doc/getcap.8
+++ b/doc/getcap.8
@@ -6,7 +6,7 @@ getcap \- examine file capabilities
 \fBgetcap\fP [\-v] [\-n] [\-r] [\-h] \fIfilename\fP [ ... ]
 .SH DESCRIPTION
 .B getcap
-displays the name and capabilities of each specified
+displays the name and capabilities of each specified file.
 .SH OPTIONS
 .TP 4
 .B \-h
-- 
2.26.2

