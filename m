Return-Path: <SRS0=bfYL=P7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EF8C282C0
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 11:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00EB21726
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 11:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wr6sF2dn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfAWLER (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:04:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46853 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfAWLEP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Jan 2019 06:04:15 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so991328ply.13
        for <linux-security-module@vger.kernel.org>; Wed, 23 Jan 2019 03:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eOH0evUuoYnXDQzpGOjj3b0HOCtKjXfnS8BAvgmzoB0=;
        b=Wr6sF2dnqShAFPTeXkP0pt6mBKUJKO97OmiEruwT4K55nJajA+h03gbSSobjz2XPfv
         dmHCD/XalktgqQ0IiUYMC5jVtzQxKJiJoguJ4OOCavlkG9DFAMd11Miq++jy+d12pAW9
         urv3sOXBGTMXSshhkP6/iBRMUbWJT7/wXVNA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eOH0evUuoYnXDQzpGOjj3b0HOCtKjXfnS8BAvgmzoB0=;
        b=N9ROPxjc/Il+VMbb5IiYW2BvREB5ntFyZhNZVc7Ovc1dqavnFqvPRYpeXe3a8/zFl3
         oYbJtvV/I68uQRl9G6cCFRapRAvEae0nynZm4RCBeWBHWlQZFfTKeV0UtGwvKKT0sJlo
         WzL0SCJXVslAPEImJISzgow3rRAW1PxjVNV0JpdSxooIHgUGmZbw9Jrp07a20Q0Debrv
         dJWF0vaiE6pIf9wmR2qXLaza5kjKtVlFJ2eiBe5z99yQJV6XfGW6+uqtNHcX3OambtRa
         IF8WBSo0SBgoGCIWqVAtyz9OSczlxz4Cn02TICyD1jajf7TtOUu42xzR9ERNa4OEpYYT
         mr9Q==
X-Gm-Message-State: AJcUuke2FxhEmiPSuasUvedhqiMT5xL7JcvigVbFnq4oZHCG2WuPVp/Q
        KRAPyITosSnyEoofuHUzrfDXCQ==
X-Google-Smtp-Source: ALg8bN4MaWR5XqsDsgdWgLwpfKZxt4LUG4ZZGKgogh3VDQfDjkiUg54eL3BLTvjTOGXKhvj7c+hNuQ==
X-Received: by 2002:a17:902:714c:: with SMTP id u12mr1770044plm.234.1548241455187;
        Wed, 23 Jan 2019 03:04:15 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id n186sm23207263pfn.137.2019.01.23.03.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 03:04:12 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Alexander Popov <alex.popov@linux.com>,
        xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dev@openvswitch.org, linux-kbuild@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH 0/3] gcc-plugins: Introduce stackinit plugin
Date:   Wed, 23 Jan 2019 03:03:46 -0800
Message-Id: <20190123110349.35882-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This adds a new plugin "stackinit" that attempts to perform unconditional
initialization of all stack variables[1]. It has wider effects than
GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y since BYREF_ALL does not consider
non-structures. A notable weakness is that padding bytes in many cases
remain uninitialized since GCC treats these bytes as "undefined". I'm
hoping we can improve the compiler (or the plugin) to cover that too.
(It's worth noting that BYREF_ALL actually does handle the padding --
I think this is due to the different method of detecting if initialization
is needed.)

Included is a tree-wide change to move switch variables up and out of
their switch and into the top-level variable declarations.

Included is a set of test cases for evaluating stack initialization,
which checks for padding, different types, etc.

Feedback welcome! :)

-Kees

[1] https://lkml.kernel.org/r/CA+55aFykZL+cSBJjBBts7ebEFfyGPdMzTmLSxKnT_29=j942dA@mail.gmail.com

Kees Cook (3):
  treewide: Lift switch variables out of switches
  gcc-plugins: Introduce stackinit plugin
  lib: Introduce test_stackinit module

 arch/x86/xen/enlighten_pv.c                   |   7 +-
 drivers/char/pcmcia/cm4000_cs.c               |   2 +-
 drivers/char/ppdev.c                          |  20 +-
 drivers/gpu/drm/drm_edid.c                    |   4 +-
 drivers/gpu/drm/i915/intel_display.c          |   2 +-
 drivers/gpu/drm/i915/intel_pm.c               |   4 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c |   3 +-
 drivers/tty/n_tty.c                           |   3 +-
 drivers/usb/gadget/udc/net2280.c              |   5 +-
 fs/fcntl.c                                    |   3 +-
 lib/Kconfig.debug                             |   9 +
 lib/Makefile                                  |   1 +
 lib/test_stackinit.c                          | 327 ++++++++++++++++++
 mm/shmem.c                                    |   5 +-
 net/core/skbuff.c                             |   4 +-
 net/ipv6/ip6_gre.c                            |   4 +-
 net/ipv6/ip6_tunnel.c                         |   4 +-
 net/openvswitch/flow_netlink.c                |   7 +-
 scripts/Makefile.gcc-plugins                  |   6 +
 scripts/gcc-plugins/Kconfig                   |   9 +
 scripts/gcc-plugins/gcc-common.h              |  11 +-
 scripts/gcc-plugins/stackinit_plugin.c        |  79 +++++
 security/tomoyo/common.c                      |   3 +-
 security/tomoyo/condition.c                   |   7 +-
 security/tomoyo/util.c                        |   4 +-
 25 files changed, 484 insertions(+), 49 deletions(-)
 create mode 100644 lib/test_stackinit.c
 create mode 100644 scripts/gcc-plugins/stackinit_plugin.c

-- 
2.17.1

