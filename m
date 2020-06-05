Return-Path: <SRS0=NT9g=7S=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEF2C433DF
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Jun 2020 23:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB92C206A2
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Jun 2020 23:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Py6p74Df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgFEXAL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Jun 2020 19:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgFEXAK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Jun 2020 19:00:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A149CC08C5C5
        for <linux-security-module@vger.kernel.org>; Fri,  5 Jun 2020 16:00:10 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w20so5838955pga.6
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jun 2020 16:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aFt/anDS7nzNEkZvhj5E9jn5B6aPNRUTEUXG6gw+rMw=;
        b=Py6p74DfoglbZqlPUm+YTvpOKViQG5W31OSdRj5ooXbxZ7v9F5LHL7MtsfOWDDDU9c
         1esc8ikGjD2AI5glOmFX+wit2+4KpFX+kgu15NT5UPlYNYjQAsZu1PjPC6igT5y2TO5y
         B7EDpj9FWNU37TDEyMNM6XGZU8GVHZZgD7Qvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aFt/anDS7nzNEkZvhj5E9jn5B6aPNRUTEUXG6gw+rMw=;
        b=Dk7vzVUN7P0VcfZo91+4yR5dhG/bX/dt8YMW5EM0nJ+dX4XBsirkDw+qWN/3Cv5YD/
         aCKevx/1wQKtEJSs+Y0Ee3FEYy1+1QzSHobshcnxHQksA5VG+lqsL0siY2PSLnArfktr
         jqmk3+GCWIA+7J4YXfoOUAx3/xcQzPCrIXhXmvsc/byshuKfhC4OCLsRF59DgJSq/I9G
         ItPLeoEN/Exf9ndzl2nayXF0FQgCb0owxFBVEKfisUY95wi/WSAffHmlptJF7rlh0cud
         HHFHAW/l3loqTA61Jsv76b6ZEejMTNLac4qDEVKU0P1vC++LlmtNlpYPBkWh5r7JiSZ6
         oc9A==
X-Gm-Message-State: AOAM5330w5AQUusPC8HE1wcG/FbnQba02WwuQhCg5DpOyo5PeAkkLMoi
        8yjB7jqCNca9DaeXGf0NJgl9pw==
X-Google-Smtp-Source: ABdhPJx5c+3Xg5qF+vGQ769wR5tgBUCXJFBzPtw7IvPiy2SjtCdYHnvg1mO9ySVZ+HFM95K2Zb1MqQ==
X-Received: by 2002:a63:1c42:: with SMTP id c2mr10937728pgm.296.1591398009780;
        Fri, 05 Jun 2020 16:00:09 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b140sm568974pfb.119.2020.06.05.16.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 16:00:08 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v6 0/8] firmware: add partial read support in request_firmware_into_buf
Date:   Fri,  5 Jun 2020 15:59:51 -0700
Message-Id: <20200605225959.12424-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch series adds partial read support in request_firmware_into_buf.
In order to accept the enhanced API it has been requested that kernel
selftests and upstreamed driver utilize the API enhancement and so
are included in this patch series.

Also in this patch series is the addition of a new Broadcom VK driver
utilizing the new request_firmware_into_buf enhanced API.

Further comment followed to add IMA support of the partial reads
originating from request_firmware_into_buf calls.

Changes from v5:
 - add IMA FIRMWARE_PARTIAL_READ support
 - change kernel pread flags to enum
 - removed legacy support from driver
 - driver fixes
Changes from v4:
 - handle reset issues if card crashes
 - allow driver to have min required msix
 - add card utilization information
Changes from v3:
 - fix sparse warnings
 - fix printf format specifiers for size_t
 - fix 32-bit cross-compiling reports 32-bit shifts
 - use readl/writel,_relaxed to access pci ioremap memory,
  removed memory barriers and volatile keyword with such change
 - driver optimizations for interrupt/poll functionalities
Changes from v2:
 - remove unnecessary code and mutex locks in lib/test_firmware.c
 - remove VK_IOCTL_ACCESS_BAR support from driver and use pci sysfs instead
 - remove bitfields
 - remove Kconfig default m
 - adjust formatting and some naming based on feedback
 - fix error handling conditions
 - use appropriate return codes
 - use memcpy_toio instead of direct access to PCIE bar

Scott Branden (8):
  fs: introduce kernel_pread_file* support
  firmware: add offset to request_firmware_into_buf
  test_firmware: add partial read support for request_firmware_into_buf
  firmware: test partial file reads of request_firmware_into_buf
  bcm-vk: add bcm_vk UAPI
  misc: bcm-vk: add Broadcom VK driver
  MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
  ima: add FIRMWARE_PARTIAL_READ support

 MAINTAINERS                                   |    7 +
 drivers/base/firmware_loader/firmware.h       |    5 +
 drivers/base/firmware_loader/main.c           |   59 +-
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/bcm-vk/Kconfig                   |   29 +
 drivers/misc/bcm-vk/Makefile                  |   11 +
 drivers/misc/bcm-vk/bcm_vk.h                  |  408 +++++
 drivers/misc/bcm-vk/bcm_vk_dev.c              | 1312 +++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c              | 1438 +++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h              |  201 +++
 drivers/misc/bcm-vk/bcm_vk_sg.c               |  271 ++++
 drivers/misc/bcm-vk/bcm_vk_sg.h               |   60 +
 drivers/misc/bcm-vk/bcm_vk_tty.c              |  352 ++++
 drivers/soc/qcom/mdt_loader.c                 |    7 +-
 fs/exec.c                                     |  101 +-
 include/linux/firmware.h                      |    8 +-
 include/linux/fs.h                            |   30 +
 include/uapi/linux/misc/bcm_vk.h              |   99 ++
 lib/test_firmware.c                           |  144 +-
 security/integrity/ima/ima_main.c             |   24 +-
 .../selftests/firmware/fw_filesystem.sh       |   80 +
 22 files changed, 4595 insertions(+), 53 deletions(-)
 create mode 100644 drivers/misc/bcm-vk/Kconfig
 create mode 100644 drivers/misc/bcm-vk/Makefile
 create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

-- 
2.17.1

