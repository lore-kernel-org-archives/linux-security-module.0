Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B448AC433F5
	for <linux-security-module@archiver.kernel.org>; Tue,  1 Feb 2022 20:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbiBAUoG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiBAUoG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 1 Feb 2022 15:44:06 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF54AC061714
        for <linux-security-module@vger.kernel.org>; Tue,  1 Feb 2022 12:44:05 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x23so36481519lfc.0
        for <linux-security-module@vger.kernel.org>; Tue, 01 Feb 2022 12:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=MBY7qkYIeruS403jGWxLc8qBC8crAwDSc2ArZKdF7cE=;
        b=ZJHXF/mgc129bb1roGPt/eKGwGbEkT5OsLglTS5x6YCuJup5X9jZri0gm8aQ9lQkoO
         ikSdDBpN8mxtjkuNUjoHIbnM+dP+JAlKKakx4saSYgVp80Wn3c3f3pMf9SjXwukSVYBA
         FIdGw3jim5kLN2xm2rKc0Tz9qrKTb1U4Ai5G3eD1CE9u3/L9VVJUvOp09RgNgxS6mvL8
         o3kcz23cxg11Qfn1k4RtDrpUd8UHZ938DmlwstTh+4zCI93s/Cvn0BavZW/BtoBR9TgS
         MTss5X8mU9XGvbf8jNDGbw9XX/hZomaPmjd1JOkdCUUpWn+jHyxTR6fHZ+MMDxU3nP8P
         PJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MBY7qkYIeruS403jGWxLc8qBC8crAwDSc2ArZKdF7cE=;
        b=qKmYav48OHsTcHbMD7ry0UXO2DDB8mVCeo7yXUQ41HYrHSyh4AkYk8Y/ew6tfmrd5k
         JdInOiuPFACto1bhzV4M4uoJsO0xywp3OSAGUWVZ0uP/XuvmmqffVqA7Js12HOI6JcuR
         YDh/hIB47YSwriNnRk3xkf/u3jbePEUYCqG6AXIztAcYbl3vww5ZApnP9EYAVIt16Tav
         MhuoIyC7N1JjWE5QH9xzcgj8inqtjGG8CGUvU3MMhK3pGdYYMzVPvMFXgGs3EIdDF5nd
         eyux8mCb1KwpKs5mV9wxz/8jl5VEpT8sF3KfpHJyXQyP6T0eU4ZprLi7ssRQPm35+/Pa
         FqxQ==
X-Gm-Message-State: AOAM532FsdCyn8MFCYaE2xS5ZIw4DwbWnfmRpBuKSmee3YMr2y25G2Te
        y8Cku5pLBYCnIufgqQRtHf19grsNLOw=
X-Google-Smtp-Source: ABdhPJx13ynyknwQHDAVWhWQTICmHAxB4SHtRAUaxuaacyxxY23sxQH3g8EaVIJMBHvcFm61vWbTVQ==
X-Received: by 2002:ac2:51db:: with SMTP id u27mr21325820lfm.442.1643748244046;
        Tue, 01 Feb 2022 12:44:04 -0800 (PST)
Received: from [192.168.0.150] (0855025014.static.corbina.ru. [89.179.245.198])
        by smtp.gmail.com with ESMTPSA id t9sm2735483lfp.27.2022.02.01.12.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 12:44:03 -0800 (PST)
Message-ID: <ef710eed-b136-8e52-75dc-a68733c2d6dc@gmail.com>
Date:   Tue, 1 Feb 2022 23:44:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: [PATCH] lsm: Remove stale info about sb_copy_data and
 sb_parse_opts_str
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <b81ca774-d45d-6b85-fb74-ffa72223b35a@gmail.com>
 <7164db8a-bf9e-b4e1-0b24-a1d03489f16a@schaufler-ca.com>
From:   Igor Zhbanov <izh1979@gmail.com>
In-Reply-To: <7164db8a-bf9e-b4e1-0b24-a1d03489f16a@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Remove info about deleted LSM hooks from include/linux/lsm_hooks.h.

Signed-off-by: Igor Zhbanov <izh1979@gmail.com>
---
 include/linux/lsm_hooks.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3bf5c658bc44..1f777e3c2ad3 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -136,15 +136,6 @@
  *	@flags contains the mount flags.
  *	@data contains the filesystem-specific data.
  *	Return 0 if permission is granted.
- * @sb_copy_data:
- *	Allow mount option data to be copied prior to parsing by the filesystem,
- *	so that the security module can extract security-specific mount
- *	options cleanly (a filesystem may modify the data e.g. with strsep()).
- *	This also allows the original mount data to be stripped of security-
- *	specific options to avoid having to make filesystems aware of them.
- *	@orig the original mount data copied from userspace.
- *	@copy copied data which will be passed to the security module.
- *	Returns 0 if the copy was successful.
  * @sb_mnt_opts_compat:
  *	Determine if the new mount options in @mnt_opts are allowed given
  *	the existing mounted filesystem at @sb.
@@ -180,10 +171,6 @@
  *	Copy all security options from a given superblock to another
  *	@oldsb old superblock which contain information to clone
  *	@newsb new superblock which needs filled in
- * @sb_parse_opts_str:
- *	Parse a string of security data filling in the opts structure
- *	@options string containing all mount options known by the LSM
- *	@opts binary data structure usable by the LSM
  * @move_mount:
  *	Check permission before a mount is moved.
  *	@from_path indicates the mount that is going to be moved.
-- 
2.31.1


