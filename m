Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59BCC432BE
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Aug 2021 00:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6CC960FD9
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Aug 2021 00:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhHaAKL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 30 Aug 2021 20:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhHaAKL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 30 Aug 2021 20:10:11 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4704EC061575;
        Mon, 30 Aug 2021 17:09:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n4so2437771plh.9;
        Mon, 30 Aug 2021 17:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rye1Edc0SeIqUbpKucA7grOHx1pZJ4Tkel88f4v1GRM=;
        b=Fbr7W6eTdgdklCQCEFXMe/jCqXWM6sbLFZIHKAeMmJC2SdnHwsBjOw/yFLAD9fvH64
         Bc3FkhLVOU5xCZMu4CnLpl9X/5hUS6JEDFxsx7IPPVKsgEyPg2NC9yE8nrcK46MmMcOX
         JA9wH8z4KgI+U8wq0xvetFpXuDps2TcnVyPFs5v3RgX0hfTz4fzW/N/Xwy3KygxwbuOH
         k8GvkitkrgxR38qbX3el54JTlS58ns4B9+byqK40g5qYXcGmewtUhLm3ya0G0zMglrOw
         4xUCcOdThkzIl4Xk0K47carW5R2tALnySHPYfG/FaxxjZlg8AGFMjTG+HQ4S72b63ECo
         V9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rye1Edc0SeIqUbpKucA7grOHx1pZJ4Tkel88f4v1GRM=;
        b=NvmQM5bCPQjW/sPpZC/MR+OJDOhe2IoznIwfTpLOLL8DrU+bTsafJ83J47pxvv8q95
         rplW/cqSCJpTMAmiaSPiU/g4yNgyhGA5bPgvCn6rKRdjkmCyVz4WZ1YnIvfEhnoCiwDE
         lLpo5uMA/WYTzavOixTr6cmFGZ1NR8yeW7CDpD27LAPB/sDeAIN1QxzMTfT2kM1xt0Un
         bR3rUnk5ADpU2kS04ym2jet4VTZEdLcf02XpMSyh4rgmabtZxZB4Dskz6Acf1LuzZzpq
         Ztc8wwyu3zeIg8qB0RIOH4NhX1vNrP6EWcVXTdrs0JfIKqNOPTtuArhbsIlBId9XfltP
         8oIg==
X-Gm-Message-State: AOAM532Fj7pv01EBeBimBtXRCUp5prmoISwl4Uz1mmJEKYI8/yZuh0lH
        GMWtn3heVu0KBnQsDpMTKlw9n9gWkiQACzLH
X-Google-Smtp-Source: ABdhPJzWquIZ/pMVTygtstZuAxLRY2nee23NR8S92B3M4iXBBfKBubiL1WBOX3l2FVWRrVm2h2LJQg==
X-Received: by 2002:a17:902:aa02:b0:134:b387:facc with SMTP id be2-20020a170902aa0200b00134b387faccmr1987824plb.22.1630368556768;
        Mon, 30 Aug 2021 17:09:16 -0700 (PDT)
Received: from raspberrypi ([210.183.35.240])
        by smtp.gmail.com with ESMTPSA id 15sm15355062pfl.186.2021.08.30.17.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 17:09:16 -0700 (PDT)
Date:   Tue, 31 Aug 2021 01:09:12 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, austindh.kim@gmail.com
Subject: [PATCH] apparmor: remove unused argument of aa_umount()
Message-ID: <20210831000912.GA4588@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The 'flags' argument in aa_umount() is not used,
so it had better remove unused argument.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 security/apparmor/include/mount.h | 2 +-
 security/apparmor/lsm.c           | 2 +-
 security/apparmor/mount.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/include/mount.h b/security/apparmor/include/mount.h
index a710683b2496..9327456cda09 100644
--- a/security/apparmor/include/mount.h
+++ b/security/apparmor/include/mount.h
@@ -42,7 +42,7 @@ int aa_new_mount(struct aa_label *label, const char *dev_name,
 		 const struct path *path, const char *type, unsigned long flags,
 		 void *data);
 
-int aa_umount(struct aa_label *label, struct vfsmount *mnt, int flags);
+int aa_umount(struct aa_label *label, struct vfsmount *mnt);
 
 int aa_pivotroot(struct aa_label *label, const struct path *old_path,
 		 const struct path *new_path);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
Index 0834ba6a8a2e..58ba3f0605d2 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -574,7 +574,7 @@ static int apparmor_sb_umount(struct vfsmount *mnt, int flags)
 
 	label = __begin_current_label_crit_section();
 	if (!unconfined(label))
-		error = aa_umount(label, mnt, flags);
+		error = aa_umount(label, mnt);
 	__end_current_label_crit_section(label);
 
 	return error;
diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index aa6fcfde3051..e33de97839ec 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -610,7 +610,7 @@ static int profile_umount(struct aa_profile *profile, const struct path *path,
 			   AA_MAY_UMOUNT, &perms, info, error);
 }
 
-int aa_umount(struct aa_label *label, struct vfsmount *mnt, int flags)
+int aa_umount(struct aa_label *label, struct vfsmount *mnt)
 {
 	struct aa_profile *profile;
 	char *buffer = NULL;
-- 
2.20.1

