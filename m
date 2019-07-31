Return-Path: <SRS0=Q99v=V4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA29C32751
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Jul 2019 21:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E7E206B8
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Jul 2019 21:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y+XYLq1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfGaVal (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:30:41 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:44527 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfGaVal (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Jul 2019 17:30:41 -0400
Received: by mail-io1-f43.google.com with SMTP id s7so139446704iob.11
        for <linux-security-module@vger.kernel.org>; Wed, 31 Jul 2019 14:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=LorXcbFrkDiur0GwKhOS0WtYPlhd7m6A9hFg1D5qG4Q=;
        b=Y+XYLq1GfpFsLdBp2odvBbnfZzGEE/EAyXfNcZDp6CRNDfB+xJ/SwxMyaaLKVBYn0N
         +jVpn09a5mkEl8XQG4Gi6OnmJ+6QOZEPwBvzaziIVbZuLdM4Gx+hUxXTHsBnrpA+F6ko
         W245s6uNCJby+pvNSQ7bsI9RWFURyKTIwAN9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LorXcbFrkDiur0GwKhOS0WtYPlhd7m6A9hFg1D5qG4Q=;
        b=cMfcY1xn1EjPQH4YlWE7CUPMjbI4M9a04B2Ht5uoZ+ByeTiEzje1TyxBFv/qUTtZhT
         UqOFROY3xeHbdmVnbkPFt7fU7WeQC0OrMUw1xFw1Pkx1Pw+a9gu2jf0P05uTGfbNw2bQ
         /lWZm9Fn4zJUK7CZq0Ak0/v3Y4v5xHlier+6SPZCImHm0iDwWP92Zqwv6zIEtadQjJb1
         +cBifR7tCHlauZJFXvL1ytXrs7z8RBVHcRV2bbpqlHhJW+CvFqmXzBFEox0DaR32mpYe
         G7pA6A6GrB2Vz+3aVzolDaiqt1Q4rOa2SlLOOhT2O0WOCv4q+bEpYEXvbBdATRKEKsTb
         Fh3A==
X-Gm-Message-State: APjAAAWUwjI9VOsiRDSYcJmxwhcZW+aVevLLV9h8g5DcTTtD67ud2rlS
        0rg8n7C4L1xDT0bUBinb7VcUp/S83hs7gVsNKv6Bx7eKx6M=
X-Google-Smtp-Source: APXvYqy3BKFTmjWzotYFCuzp4BPjn1MMaYy70Rlzz2fRaa9EbCnLYGgLAER+4pJYzAzQGEaU/wQqEBNu6KjKMF9N374=
X-Received: by 2002:a02:710f:: with SMTP id n15mr87971397jac.119.1564608640491;
 Wed, 31 Jul 2019 14:30:40 -0700 (PDT)
MIME-Version: 1.0
From:   Micah Morton <mortonm@chromium.org>
Date:   Wed, 31 Jul 2019 14:30:29 -0700
Message-ID: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
Subject: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

You mentioned a couple weeks ago it would be good if I added myself to
the MAINTAINERS file for the SafeSetID LSM. Here's the pull request
for v5.3.

Thanks!
--
The following changes since commit 179757afbef5f64b9bd25e6161f72fc1a52a8f2e:

  Merge commit 'v5.3-rc2^0' (2019-07-31 13:45:16 -0700)

are available in the Git repository at:

  https://github.com/micah-morton/linux.git tags/safesetid-maintainers-5.3-rc2

for you to fetch changes up to 7e20e910eabdf0af90fd10e712f15b413be8e135:

  Add entry in MAINTAINERS file for SafeSetID LSM (2019-07-31 13:58:11 -0700)

----------------------------------------------------------------
Add entry in MAINTAINERS file for SafeSetID LSM.

Has not had any bake time or testing, since its just changes to a text file.

----------------------------------------------------------------
Micah Morton (1):
      Add entry in MAINTAINERS file for SafeSetID LSM

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)
