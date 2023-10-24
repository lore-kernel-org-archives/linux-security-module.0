Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB65C25B6B
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Oct 2023 21:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344395AbjJXVjY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Oct 2023 17:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344379AbjJXVjX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Oct 2023 17:39:23 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952EDD7A
        for <linux-security-module@vger.kernel.org>; Tue, 24 Oct 2023 14:39:20 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b40d5ea323so1806051b6e.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Oct 2023 14:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698183560; x=1698788360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQXFNTJ7mGZYPYLlNFr9FNMV4nlRJhDiGM0hBaeY25U=;
        b=VO2SiZ8djrKnybbKFqiTCj8oS/oehvojhRzGQd+btul9dYrIXfyI0oVfrNS1ZMhchG
         wTHoC7z6VmEdH/pQ0pdhCwjE/3Aah4q/Pj0uIC6GIgKgsApVfsAOrsqdv7LxkNpqyo7c
         9kkIBUuScJRry7BTZkNazOMFrt21irv0YbsZHMdZOLx+emZdgkX+kpFuWGf6B5lbSeKU
         jyisZPPDVidNWqEIiN3aTmM2Lw2Q2gk9wVPLfrzqxHknHOb8z1+ZURWkeeuEGjThIcTo
         DdyBf3DLFock1RDMbl0G3or/0a5npYprZ+0zvEF7U4YTmtCbG0HKaxNRFwHutgy4RRcI
         GnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698183560; x=1698788360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQXFNTJ7mGZYPYLlNFr9FNMV4nlRJhDiGM0hBaeY25U=;
        b=N1jR7llwlfm+4+RqsXmNHIEAeSSQIvQ61SSxmxjzYFUWirfQjiDwDYGrU6+Au7O+vd
         yiWnXZXpAmYbgiaLtap7E6FI2rHolJ7YzB3bF3fUXS3IZspxnchareQuDHE5TNUhB6GY
         db9nx6esz1hRFCv/QbP0U+lYBQFtRCmacw3ok9itxmHlj3lCkWic5zKB/gw3RobrKI0e
         I9+TURn0zOR0EZT+12rRlJmc9mabKkCQgdxryQK0Z6R24/Ub4w5a+UVCQw81v0SR8jTd
         ky6w9T2l73fDRNhtQRGgZClXbQowSgyeQLqLfFSohQJftf4moAaczcoZKUTREa2N3rz6
         nQGw==
X-Gm-Message-State: AOJu0YwX8wpfQ1amclDiiDII3AYyfchFzd2xYM2fH6GDm+yzOb4YO1ds
        R3WGfLrfFI1RVmvEdVnk7DCyIQvbUK+eEiOnJkL/
X-Google-Smtp-Source: AGHT+IHfCuYRr4AEHk9Dq2dHMahKIbWyJxhVXv7g3AV2Anc96gyixj6uIDs6JE+uF528H+7jEFy+bg==
X-Received: by 2002:a05:6808:2da:b0:3a7:3ce0:1ad7 with SMTP id a26-20020a05680802da00b003a73ce01ad7mr13021801oid.20.1698183559671;
        Tue, 24 Oct 2023 14:39:19 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id t16-20020a0cef10000000b0065afbb39b2dsm3894522qvr.47.2023.10.24.14.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:39:19 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Cc:     selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [RFC PATCH 0/3] LSM syscall tweaks
Date:   Tue, 24 Oct 2023 17:35:26 -0400
Message-ID: <20231024213525.361332-4-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Three rather small LSM patches to address some minor issues found during
the review of the latest LSM syscall patchset that now lives in the
lsm/next-queue tree.

I'm marking these as RFC patches as they have yet to be properly tested,
but I'm building a kernel now to do that and I'll report back when testing
has completed.  In the meantime, reviews and ACKs are appreciated.

-- 
paul-moore.com


