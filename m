Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C735C433DB
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Mar 2021 20:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E2B364F2B
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Mar 2021 20:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhCRUmh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Mar 2021 16:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbhCRUmT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Mar 2021 16:42:19 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1261C06175F
        for <linux-security-module@vger.kernel.org>; Thu, 18 Mar 2021 13:42:19 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id x2so664309qkd.9
        for <linux-security-module@vger.kernel.org>; Thu, 18 Mar 2021 13:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=hVRkW0Gn2RwcsEdRmxlDCP7u6XEAIJBBsmJA2mDGmoA=;
        b=eUvgs5edB+Sb7qUz3Ih5ve0g2Gyj2+3dG5KVDCftQJ+WrzuZ5p5Hb3q8jiZR31y8Nb
         5xxFj8mCst906Fd052MojHC1OyOKjeCI+v0nei2JXR5BQf6PzKQoqm725GrFXGg3++QZ
         MOjmGbbDnmLTZX3q0c/nuhNa2/6VzOD3xnk3s9CWNK9BGHpbHQK2iHyAqV2NrzQKO8Dz
         CAAYcPvkKtWEqja0XKpFlO1P1a5FHNCrFv1VNezRUpdAzQ5mRWgMYXBPfCSCuE2ob51d
         gAEj4BODP/LEnQbIWvGsceXLQnn3B8DaRgEHcKNWKZuXgF/+K7zm8E81/53j3q520nJX
         GW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=hVRkW0Gn2RwcsEdRmxlDCP7u6XEAIJBBsmJA2mDGmoA=;
        b=BdLyfBLK57uv1Yg8Cj2hzrwtRyZ0j+Fxaff+doGppbrMPr9/m8tGccsJ3cMRGlqNxx
         1u0vQw+BFa4uisvQ0qYfebqe4GYrZ5MfNTpbEEHWOZeABsYDzf2Y0ZqltqsPh75RU8SX
         t8FsUxrsWLv8/ukcpB5t3SGWK+WStMcvr++uO/qaIZuDDXU6f4Y5iUizNHabIofxoHpe
         Rj+0/F/zy1jYbtpq3L4H/fOWbyyYFkamM8s9PXW/5mGVRbkaH5Evujo1EX5Vlgm8L2LG
         eUG8qkDlfvUABjYD6HDEbSTzXuU/MTT37U/cAB3j199MSUiST0if6QitaWY1G8hz8o2u
         SURw==
X-Gm-Message-State: AOAM5331y1l33nqxG0yWat94fDiWFiuVVSj41NifX4W6Wj3s8Rj6fqJB
        zvyv18OBTgCcZRP8lwS5g0T/gy8HFKFd9qE=
X-Google-Smtp-Source: ABdhPJwenk7fJBQr5Nfw7WoERzjivuHjcoFuJIlXZqBlELE/wGdGBJFSzAg/xmJov59TJPkAhbtQKQ==
X-Received: by 2002:a37:83c6:: with SMTP id f189mr6307118qkd.260.1616100138461;
        Thu, 18 Mar 2021 13:42:18 -0700 (PDT)
Received: from localhost (pool-72-74-249-41.bstnma.fios.verizon.net. [72.74.249.41])
        by smtp.gmail.com with ESMTPSA id r133sm2722067qke.20.2021.03.18.13.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:42:18 -0700 (PDT)
Subject: [PATCH v2 0/3] Split security_task_getsecid() into subj and obj
 variants
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        selinux@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Richard Guy Briggs <rgb@redhat.com>
Date:   Thu, 18 Mar 2021 16:42:17 -0400
Message-ID: <161609713992.55424.6906498317563652734.stgit@olly>
User-Agent: StGit/1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

An update on the previous RFC patchset found here:

https://lore.kernel.org/linux-security-module/161377712068.87807.12246856567527156637.stgit@sifl/

Aside from being rebased to the current SELinux next branch (which
in turn is based on v5.12-rc2), this revision changes the binder
related code to always use the objective credentials as discussed
in the thread above.  I've also dropped the AppArmor patch as John
has a better version in progress; in the meantime AppArmor should
continue to work exactly as it did before this patchset so there
is no harm in merging this without the AppArmor patch.

Casey, John, and Richard; I dropped your ACKs, Reviewed-by, etc.
tags as the binder changes seemed substantial enough to not
carryover your tags.  I would appreciate it if you could re-review
this revision; the changes should be minimal.  I did leave Mimi's
tag on this revision as she qualified it for IMA and that code
didn't change.

---

Paul Moore (3):
      lsm: separate security_task_getsecid() into subjective and objective variants
      selinux: clarify task subjective and objective credentials
      smack: differentiate between subjective and objective task credentials


 security/selinux/hooks.c   | 112 ++++++++++++++++++++++++-------------
 security/smack/smack.h     |  18 +++++-
 security/smack/smack_lsm.c |  40 ++++++++-----
 3 files changed, 117 insertions(+), 53 deletions(-)
