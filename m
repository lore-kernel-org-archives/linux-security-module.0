Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0D6C433F5
	for <linux-security-module@archiver.kernel.org>; Wed,  4 May 2022 19:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377755AbiEDT6H (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 May 2022 15:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357943AbiEDT6C (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 May 2022 15:58:02 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A596F4E3BC
        for <linux-security-module@vger.kernel.org>; Wed,  4 May 2022 12:54:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i24so1943210pfa.7
        for <linux-security-module@vger.kernel.org>; Wed, 04 May 2022 12:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3ETif9Foq2WWYlVvzrpzb/TRJhspVBRsqqlMfFf5RE=;
        b=bFEhgow2kthggDsRYWLjsBQ4oqoD9Yx8p7YoLuIFcg6vkGF5NKTVgGyZpwGKN6j9jQ
         +eCtLxowhfkljQHHR59zJXDVT8hHq4w54MuvBi6DL2GEsR19pG11rDyZ80nLiS9a3Gy2
         tAO+XKAFFwijLwnlZFmqAIx6vIYSugE1RfQrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3ETif9Foq2WWYlVvzrpzb/TRJhspVBRsqqlMfFf5RE=;
        b=VrLjtWWN5m3nO87xZjwGikDHfzExBKipoRfw7PilaEPW1zhhR2+hlS3h93hxTJINZx
         TKtUVhUx42BEbmn6UzrRSa/3L/QhOPm+pxSn9aAqTc82XkPmzZ+F1ufMm2KmNN7AUePE
         a3Sc9NZDQ0piYOl3Lni4n0zNNMjuopONUn6SFscL1v5+s1Ct6kPodosgH189QDR+ewzi
         vw0iVui5G3JadFw/TnbvRvmmUff6YcK0TtYJ45tNHkqeoQ7rfzIpGYdS93Qk0C7K4t+Y
         8UclxynrjkKOn6GNT8U5BQpwFJQZhWkPwPdbhtyzXFq2P2nqO+6rvTuEtgOqrk31KV5g
         9I5w==
X-Gm-Message-State: AOAM533weF6xJ/PpLrSLEHhfsk1E7lbTttISiieGOwibnqshD/xK6QNi
        pYck3+fRl40RUudOIw4oB0DhTg==
X-Google-Smtp-Source: ABdhPJw3OEAXuCRHeeH+ekWBhlrlqMKIX2kvZ+3Yz7JTRDJfzJoF2x0zxnO0Fgykowymq6svm7lI3g==
X-Received: by 2002:a65:6051:0:b0:39d:1b00:e473 with SMTP id a17-20020a656051000000b0039d1b00e473mr18737927pgp.578.1651694063968;
        Wed, 04 May 2022 12:54:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:35b6:c77b:be04:3bd5])
        by smtp.gmail.com with UTF8SMTPSA id v13-20020aa7808d000000b0050dc762819esm8622355pff.120.2022.05.04.12.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 12:54:23 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 0/3] LoadPin: Enable loading from trusted dm-verity devices
Date:   Wed,  4 May 2022 12:54:16 -0700
Message-Id: <20220504195419.1143099-1-mka@chromium.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

As of now LoadPin restricts loading of kernel files to a single pinned
filesystem, typically the rootfs. This works for many systems, however it
can result in a bloated rootfs (and OTA updates) on platforms where
multiple boards with different hardware configurations use the same rootfs
image. Especially when 'optional' files are large it may be preferable to
download/install them only when they are actually needed by a given board.
Chrome OS uses Downloadable Content (DLC) [1] to deploy certain 'packages'
at runtime. As an example a DLC package could contain firmware for a
peripheral that is not present on all boards. DLCs use dm-verity [2] to
verify the integrity of the DLC content.

This series extends LoadPin to allow loading of kernel files from trusted
dm-verity devices. LoadPin maintains a list of root digests of verity
devices it considers trusted. Userspace can populate this list through an
ioctl on the new LoadPin securityfs entry 'dm-verity'. The ioctl receives
a file descriptor of a file with verity digests as parameter. Verity reads
the digests from this file after confirming that the file is located on the
pinned root. The list of trusted digests can only be set up once, which is
typically done at boot time.

When a kernel file is read LoadPin first checks (as usual) whether the file
is located on the pinned root, if so the file can be loaded. Otherwise, if
the verity extension is enabled, LoadPin determines whether the file is
located on a verity backed device and whether the root digest of that
device is in the list of trusted digests. The file can be loaded if the
verity device has a trusted root digest.

[1] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/dlcservice/docs/developer.md
[2] https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/verity.html

Changes in v3:
- added securityfs for LoadPin (currently only populated when
  CONFIG_SECURITY_LOADPIN_VERITY=y)
- added uapi include for LoadPin
- changed the interface for setting up the list of trusted
  digests from sysctl to ioctl on securityfs entry
- added stub for loadpin_is_fs_trusted() to be used
  CONFIG_SECURITY_LOADPIN_VERITY is not select
- depend on CONFIG_SECURITYFS instead of CONFIG_SYSTCL
- updated Kconfig help
- minor changes in read_trusted_verity_root_digests()
- updated commit message

Changes in v2:
- userspace now passes the path of the file with the verity digests
  via systcl, instead of the digests themselves
- renamed sysctl file to 'trusted_verity_root_digests_path'
- have CONFIG_SECURITY_LOADPIN_VERITY depend on CONFIG_SYSCTL
- updated Kconfig doc
- updated commit message

Matthias Kaehlcke (3):
  dm: Add verity helpers for LoadPin
  LoadPin: Enable loading from trusted dm-verity devices
  dm: verity-loadpin: Use CONFIG_SECURITY_LOADPIN_VERITY for conditional
    compilation

 drivers/md/Makefile               |   1 +
 drivers/md/dm-verity-loadpin.c    |  80 +++++++++++++
 drivers/md/dm-verity-target.c     |  33 ++++++
 drivers/md/dm-verity.h            |   4 +
 include/linux/dm-verity-loadpin.h |  27 +++++
 include/uapi/linux/loadpin.h      |  19 +++
 security/loadpin/Kconfig          |  16 +++
 security/loadpin/loadpin.c        | 184 +++++++++++++++++++++++++++++-
 8 files changed, 363 insertions(+), 1 deletion(-)
 create mode 100644 drivers/md/dm-verity-loadpin.c
 create mode 100644 include/linux/dm-verity-loadpin.h
 create mode 100644 include/uapi/linux/loadpin.h

-- 
2.36.0.464.gb9c8b46e94-goog

