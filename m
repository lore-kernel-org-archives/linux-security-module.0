Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C82C55ABD
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Nov 2020 17:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AEDD22245
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Nov 2020 17:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f97H1ARf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKMRqX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Nov 2020 12:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKMRqW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Nov 2020 12:46:22 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F01C0613D1
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2020 09:46:22 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id e17so9203518ili.5
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2020 09:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wlkCnCceQqz7r02K1vtWGsLoDGFR8kTVMD9I+999BVU=;
        b=f97H1ARf2FMEwRo6bCGKK0SmxlmBhNSJtwWc3H6Tp4QKaxU08w23m3Se3VH2Y6LKi1
         gseBKxaY3ws5p5mowtY+hqCqm8ItrgLkWZnDGKw5mEp6i0F2TmRT/ux7nL/fZREJMVer
         c6f8DNGj7zG6O5hQfyRFzevjFKbqYn7LHQRmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wlkCnCceQqz7r02K1vtWGsLoDGFR8kTVMD9I+999BVU=;
        b=HZPC7WN52zmGMlkXtmrAkdd2yYXdq+k7O40B0KILUxr+xEGK5L/Y8OL6V2MhFz0MGo
         qSkYuTqPiXXb3lqf60YDj/+9fcPsbMHYL5fOmXgnZSblCN6kEE4EFOklM7oimfQl3VFQ
         ZIZua5R3JYcDEp3K+2NshgrquehLeYDo8uM1mMd83LPE+WJz8CeDU7S91ntpG5jPUWzn
         VrWK2nQY88966/Vy4uqUKE1IppfN1Ts7FSgIiev2KM8n+pexv/R5v6hxaJegkvCFfJFG
         ZLJFz0whymlKkevRPKeN9fxWNfp2yG5s0tWEvF5TRkoZBSISOYAOr5ZyNn8aS59YOlJI
         +CqA==
X-Gm-Message-State: AOAM5331RIHU7x8pMCREJOEDg36xg6ZN+KkeD9uZDy8fmqVQBhqW/fbP
        itesFn4K2DkC20cxJCHNjkiXGg==
X-Google-Smtp-Source: ABdhPJzWnweOgT/x9lrJyFWdNrmH6LCnt9T1bjCno9YJu8lBPBBn+UixdhXRz6BHbKAiFEys/ytZcw==
X-Received: by 2002:a92:9acd:: with SMTP id c74mr690025ill.299.1605289580958;
        Fri, 13 Nov 2020 09:46:20 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y14sm4772585ilb.66.2020.11.13.09.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 09:46:20 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peterz@infradead.org, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        minyard@acm.org, arnd@arndb.de, mchehab@kernel.org,
        rric@kernel.org, valentina.manea.m@gmail.com, shuah@kernel.org,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 00/13] Introduce seqnum_ops
Date:   Fri, 13 Nov 2020 10:46:02 -0700
Message-Id: <cover.1605287778.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Sequence Number api provides interfaces for unsigned atomic up counters
leveraging atomic_t and atomic64_t ops underneath.

There are a number of atomic_t usages in the kernel where atomic_t api
is used for counting sequence numbers and other statistical counters.
Several of these usages, convert atomic_read() and atomic_inc_return()
return values to unsigned. Introducing sequence number ops supports
these use-cases with a standard core-api.

The atomic_t api provides a wide range of atomic operations as a base
api to implement atomic counters, bitops, spinlock interfaces. The usages
also evolved into being used for resource lifetimes and state management.
The refcount_t api was introduced to address resource lifetime problems
related to atomic_t wrapping. There is a large overlap between the
atomic_t api used for resource lifetimes and just counters, stats, and
sequence numbers. It has become difficult to differentiate between the
atomic_t usages that should be converted to refcount_t and the ones that
can be left alone. Introducing seqnum_ops to wrap the usages that are
stats, counters, sequence numbers makes it easier for tools that scan
for underflow and overflow on atomic_t usages to detect overflow and
underflows to scan just the cases that are prone to errors.

In addition, to supporting sequence number use-cases, Sequence Number Ops
helps differentiate atomic_t counter usages from atomic_t usages that guard
object lifetimes, hence prone to overflow and underflow errors from up
counting use-cases. It becomes easier for tools that scan for underflow and
overflow on atomic_t usages to detect overflow and underflows to scan just
the cases that are prone to errors.

Changes since v1:
- Removed dec based on Greg KH's comments
- Removed read/set/inc based on the discussion with Peter Zijlstra
- Interfaces are restricted to init, increment and return new value,
  and fetch current value.
- Interfaces return u32 and u64 - a few reviewers suggested unsigned.
  After reviewing a few use-cases, I determined this is a good path
  forward. It adds unsigned atomic support that doesn't exist now,
  and simplifies code in drivers that currently convert atomic_t return
  values to unsigned. All the drivers changes included in this series
  used to convert atomic_t returns to unsigned.

Patch v1 thread:
https://lore.kernel.org/lkml/cover.1605027593.git.skhan@linuxfoundation.org/

Counters thread:
lore.kernel.org/lkml/cover.1602209970.git.skhan@linuxfoundation.org

Shuah Khan (13):
  seqnum_ops: Introduce Sequence Number Ops
  selftests: lib:test_seqnum_ops: add new test for seqnum_ops
  drivers/acpi: convert seqno seqnum_ops
  drivers/acpi/apei: convert seqno to seqnum_ops
  drivers/base/test/test_async_driver_probe: convert to use seqnum_ops
  drivers/char/ipmi: convert stats to use seqnum_ops
  drivers/edac: convert pci counters to seqnum_ops
  drivers/oprofile: convert stats to use seqnum_ops
  drivers/staging/rtl8723bs: convert stats to use seqnum_ops
  usb: usbip/vhci: convert seqno to seqnum_ops
  drivers/staging/rtl8188eu: convert stats to use seqnum_ops
  drivers/staging/unisys/visorhba: convert stats to use seqnum_ops
  security/integrity/ima: converts stats to seqnum_ops

 Documentation/core-api/atomic_ops.rst         |   4 +
 Documentation/core-api/index.rst              |   1 +
 Documentation/core-api/seqnum_ops.rst         |  89 +++++++++++++
 MAINTAINERS                                   |   8 ++
 drivers/acpi/acpi_extlog.c                    |   8 +-
 drivers/acpi/apei/ghes.c                      |   8 +-
 drivers/base/test/test_async_driver_probe.c   |  28 +++--
 drivers/char/ipmi/ipmi_msghandler.c           |   9 +-
 drivers/char/ipmi/ipmi_si_intf.c              |   9 +-
 drivers/char/ipmi/ipmi_ssif.c                 |   9 +-
 drivers/edac/edac_pci.h                       |   5 +-
 drivers/edac/edac_pci_sysfs.c                 |  30 ++---
 drivers/oprofile/buffer_sync.c                |   9 +-
 drivers/oprofile/event_buffer.c               |   3 +-
 drivers/oprofile/oprof.c                      |   3 +-
 drivers/oprofile/oprofile_stats.c             |  11 +-
 drivers/oprofile/oprofile_stats.h             |  11 +-
 drivers/oprofile/oprofilefs.c                 |   3 +-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c |  23 +++-
 .../staging/rtl8188eu/include/rtw_mlme_ext.h  |   3 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |   3 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  33 +++--
 drivers/staging/rtl8723bs/include/rtw_cmd.h   |   3 +-
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |   3 +-
 .../staging/unisys/visorhba/visorhba_main.c   |  21 ++--
 drivers/usb/usbip/vhci.h                      |   3 +-
 drivers/usb/usbip/vhci_hcd.c                  |   7 +-
 drivers/usb/usbip/vhci_rx.c                   |   5 +-
 include/linux/oprofile.h                      |   3 +-
 include/linux/seqnum_ops.h                    | 118 +++++++++++++++++
 lib/Kconfig                                   |   9 ++
 lib/Makefile                                  |   1 +
 lib/test_seqnum_ops.c                         | 119 ++++++++++++++++++
 security/integrity/ima/ima.h                  |   5 +-
 security/integrity/ima/ima_api.c              |   3 +-
 security/integrity/ima/ima_fs.c               |   5 +-
 security/integrity/ima/ima_queue.c            |   7 +-
 tools/testing/selftests/lib/Makefile          |   1 +
 tools/testing/selftests/lib/config            |   1 +
 .../testing/selftests/lib/test_seqnum_ops.sh  |  10 ++
 40 files changed, 524 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/core-api/seqnum_ops.rst
 create mode 100644 include/linux/seqnum_ops.h
 create mode 100644 lib/test_seqnum_ops.c
 create mode 100755 tools/testing/selftests/lib/test_seqnum_ops.sh

-- 
2.27.0

