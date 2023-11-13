Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C021C4332F
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Nov 2023 19:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjKMTVj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Nov 2023 14:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMTVj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Nov 2023 14:21:39 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603D218A
        for <linux-security-module@vger.kernel.org>; Mon, 13 Nov 2023 11:21:33 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7789577b53fso301166085a.3
        for <linux-security-module@vger.kernel.org>; Mon, 13 Nov 2023 11:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699903292; x=1700508092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ysGG/eyxGfq1VjeHYgkgoERVT+mdN3DzJsMgOceUTLg=;
        b=DuHfGp0vFk69+y8N0uxqOflI57Q7ReIcaG0DV+8HyOExZnUihrD0/vBKUPL0sNa1Vt
         Yrw4EB8AZ0uz5ZbTZ7UGTVuwZrWeSCw7l4P/WypZji4yd1RPBdxBuc1SbBX3Ptz4qqdL
         y8ijieLWptuDMP/3xDsl4zGL8hAlUU8q09A4cAsul2zF33bOnHvFQ+vKwPA+u6XjPPTF
         /JQhFJiIhRKAn+QKnQOi+Kd4yGsvGGi3kElhVRgI4xoiUDYleY8iMhJ4bxTtcPKwqZJs
         e+EdeXX315Fd/qBN/sWlMWlGWmhd8Z4wjHDxtylMOhf8WhQbGOxsmS15xNyqzcJlzAyD
         i99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699903292; x=1700508092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysGG/eyxGfq1VjeHYgkgoERVT+mdN3DzJsMgOceUTLg=;
        b=fSQ2yt4PrAwe33A9K3Y/gwNnJpPvsaigNmGImdeJ0tMxPdMVZ+VLWqvvidOdAmOxOp
         7AmouGt4oR8u8/8ib2B7IWksBax1s9KgTXO1vLmY4eo5O7xLOqV2q9dNOclQTiMJ8VXQ
         Rz5JvVTlMI2v2HMqTqiHIzC4uux+5cwciZzihhqy3dNF1gGEXGNeQCEoGZ+/LSIsXvkj
         bSF/+v7tPu/jbPPFR9s1S3UyeTmgfW3wRaZRtwh/seAVPaF0CQO+pGqdNbb4VonbWpNA
         QFT+zNlrlbse1jifs+y4ooD8Ru1Mhop8MUcWEGTieanDIJkYkRGdKjZu7rY9d5zSNL6a
         bugA==
X-Gm-Message-State: AOJu0YzGTvxQg1qMpsRnh3XlOy+foVp4XesHTe2FxWU8VDOui7aVytyI
        JiQlURYZfGLluv6JdMZ4+U0Q5q8j7nELQxVt5Q==
X-Google-Smtp-Source: AGHT+IE+xDCabEZIBme6qijAagEPvrd6/dae68al9hZIUdw5DJTmArw94v4+PetvS8lj1X0hj/SqwA==
X-Received: by 2002:a05:620a:258b:b0:77a:2520:2793 with SMTP id x11-20020a05620a258b00b0077a25202793mr131237qko.2.1699903291859;
        Mon, 13 Nov 2023 11:21:31 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ts5-20020a05620a3d8500b00767e98535b7sm2081404qkn.67.2023.11.13.11.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 11:21:31 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>
Subject: [PATCH] mailmap: add entries for Serge Hallyn's dead accounts
Date:   Mon, 13 Nov 2023 14:21:26 -0500
Message-ID: <20231113192125.57117-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=876; i=paul@paul-moore.com; h=from:subject; bh=7HqdIb07BkOGgY1pXu4j16ad2zOnNbTzxT+tc/NoVMw=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlUnc18DnHA+psGmFBQfIRBTShBO0A+5pRVCBzY zT+6mzFqyKJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZVJ3NQAKCRDqIPLalzeJ cwToEACFuZ5NOnOaBcuNuP8cLNu9dgTPE7jx4KXuFbrFRbWapQ9ncWc76mxHl++EUJJUL2mtIuA a5K6CXctGB4tbCtHki1iTIGw3aZlM+zD8JE0NLvYjKYG5y+OIG3Gwa9gldhkzMBcenFLbK3JmMo ecWxtLmeloSVJDCX7drYq25TPPVBbzoH/rHwQolvGMZEm4APRCvRAOYlY3jhkUN4bQ01Mv6IsPo Rb2wis46DJv82HX1B3+UIr0sAskS8OWrXyXLRIQ45VN6JF/xcuXnK6/vK9JhZzRI0a1NFFEjDsz OyIw7V7atLgsNggmtunKNZn5/xaK/E5YRYG2tE1MtCNr32qdQYlN7EAF7bu+TwvU5tca/AWLXJJ vV3qIM7q7nZ5ZFFcAEZJCPeFXr3X+B2NdNe9rzlarWKsuho6iDfXyDbmv31fFxl+kMu9MDUQM9w 8k4KadXKw3voHyyKP6wdtD3l9Tk9/uD8LA/f0tcJLZ209CBBXZxPgdRCuxzSCM7C+fJuhWHWRVW 3u1B1eFj3+i+BTemKioYyoDM3b5OpmKhFKUsqj+qtAw25nMMcYFqpDxMB9NQl9ll0unClUQNG78 BGtaSuWwxzeLMW1VFBvEAIIoYDhpH3vGKvZ9/6hkk34bJ0i/GRLlpPBJ9ttO518fCQOtQ+HvLdx 5Au+IdsF9Ir0Tpw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Serge Hallyn <serge@hallyn.com>

Signed-off-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 2ba581ebb2cf..35086f4a7961 100644
--- a/.mailmap
+++ b/.mailmap
@@ -535,6 +535,8 @@ Sebastian Reichel <sre@kernel.org> <sebastian.reichel@collabora.co.uk>
 Sebastian Reichel <sre@kernel.org> <sre@debian.org>
 Sedat Dilek <sedat.dilek@gmail.com> <sedat.dilek@credativ.de>
 Senthilkumar N L <quic_snlakshm@quicinc.com> <snlakshm@codeaurora.org>
+Serge Hallyn <sergeh@kernel.org> <serge.hallyn@canonical.com>
+Serge Hallyn <sergeh@kernel.org> <serue@us.ibm.com>
 Seth Forshee <sforshee@kernel.org> <seth.forshee@canonical.com>
 Shannon Nelson <shannon.nelson@amd.com> <snelson@pensando.io>
 Shannon Nelson <shannon.nelson@amd.com> <shannon.nelson@intel.com>
-- 
2.42.1

