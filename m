Return-Path: <SRS0=MEX0=A7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF36C433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C683D2080D
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDZi5aHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGTJNr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTJNr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 05:13:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E87C061794
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:13:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c80so21520972wme.0
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EEXXTFD5vyrVwWhoB3C2csFETgZXCqTr+aOCGNtLSl8=;
        b=sDZi5aHHoWQztl9FKfczlL7anX9OQY4vFxpWFPKqrbdr+lwiyfP4lxTKMnp/vm2Zta
         /v6InAetUrqdVWT8IGdGa3/JsMXcMkFZ2Cl+VEnDOqvT8PcDiIt0nDkT/MXO+YZN6vvX
         NtiT7llynZNTmPK7gSHsXklJBBWI3cPALNzIqlJVRoi/KVOP0U3fgaDTdak3yW/z6u+5
         Ct0i6xako5TDKfFXXDJy392t++CHrEMv1xxn3IS70Fck1bLcrKZ8BjMP7V1C2f/hqQkA
         N8rVx1BsTW8/HKV8aZ2V/n6PTPc1eRL0KYljux97/BpK66JIDN1AxnQd42w28hgBTRws
         Zi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EEXXTFD5vyrVwWhoB3C2csFETgZXCqTr+aOCGNtLSl8=;
        b=If4fv8E+9+n1iIV7ChLCQ+aEbQBYA018+MRYdvVoXn1UdMtKW7CiN9SQmTLAqWrEYN
         3NDBC/ZBiRXFLOUqc62iRIR79s2+/oOSfP0bcKaLlK1vvHWZwE04ZTlo5TPG5ltzb7Zm
         pVfOoSC0nobItyKDYJzQNFrknhhKBakaqHRaMDT6znp9H0RlxZuGX7vG/oTXazYd+N9k
         ItCN8pe9tOV78ud5bu2gYtf8HaX87RczmDZYSvas5t+MxX/EjuBClVnInvEzg1nsOp0L
         fn7DB8sDZKniOMabXeqR0gkLyfSkl1rXuOONycCvpaBiqiZDGBhQ/ypbVWcDxvK0HQu0
         zHdA==
X-Gm-Message-State: AOAM530gFoJ0fE6ozpT/2emhOSdD6Vkoc9bwaKsRDjoXkw2f/AVdkiWg
        G9dw44jzOyj7DgkMnDnc/Aw=
X-Google-Smtp-Source: ABdhPJz5fLZyC+0qH9JgLUnzi8I1HSZpWE2pskpLmH8DhMMjfKcK8Rncju+a3tMZ/G4xIiHWPvlacg==
X-Received: by 2002:a1c:2183:: with SMTP id h125mr21961275wmh.83.1595236425343;
        Mon, 20 Jul 2020 02:13:45 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id m9sm29806436wml.45.2020.07.20.02.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:13:44 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 00/15] [libcap] Manual pages: various fixes
Date:   Mon, 20 Jul 2020 11:13:13 +0200
Message-Id: <20200720091328.290336-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Andrew,

There's a range of changes in this series. Some are trivial
fixes, and a few are more substantial. The first 11 patches are,
I think, uncontentious.

I would be happy if you check the details in patches patches 12 and 13:

  Manual pages: cap_get_file.3: NOTES: note the effect of the Ambient set
  Manual pages: cap_get_proc.3: Update description of capsetp()

and I've placed the last two patches at the and because there's
a (hopefully small) chance that you disagree with them.

Michael Kerrisk (man-pages) (15):
  Manual pages: various pages: Use "\-" for real minus signs
  Manual pages: cap_init.3: Formatting fix
  Manual pages: capsh.1: Various minor wording and formatting fixes
  Manual pages: cap_copy_ext.3: Typo fix
  Manual pages; cap_get_file.3: Fix some clumsily worded text
  Manual pages: getcap.8: Add missing word
  Manual pages: getcap.8: Fix a clumsily worded sentence
  Manual pages: getpcaps.8: Format options as a hanging list
  Manual pages: getpcaps.8: Remove a stray .br macro
  Manual pages: getpcaps.8: SEE ALSO: fix section number for capsh
  Manual pages: setcap.8: Typo fix
  Manual pages: cap_get_file.3: NOTES: note the effect of the Ambient set
  Manual pages: cap_get_proc.3: Update description of capsetp()
  Manual pages: cap_get_proc.3, capsh.1: Use "UID" and "GID" consistently
  Manual pages: capsh.1: Change .TP indent to the default

 doc/cap_copy_ext.3 |  2 +-
 doc/cap_get_file.3 | 19 +++++++----
 doc/cap_get_proc.3 | 50 +++++++++++++++++-----------
 doc/cap_init.3     |  2 +-
 doc/capsh.1        | 81 ++++++++++++++++++++++++++++------------------
 doc/getcap.8       |  4 +--
 doc/getpcaps.8     | 17 +++++-----
 doc/libpsx.3       |  6 ++--
 doc/setcap.8       |  2 +-
 9 files changed, 111 insertions(+), 72 deletions(-)

-- 
2.26.2

