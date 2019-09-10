Return-Path: <SRS0=YGRx=XF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7A8C3A5A2
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Sep 2019 10:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CA221479
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Sep 2019 10:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHdbong6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405464AbfIJKDZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:03:25 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46368 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405452AbfIJKDZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Sep 2019 06:03:25 -0400
Received: by mail-pg1-f201.google.com with SMTP id u1so10347766pgr.13
        for <linux-security-module@vger.kernel.org>; Tue, 10 Sep 2019 03:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=r40Km9SeMoEAm8w6fV7cNpDnhYcE+rjMqoH130Kp7BE=;
        b=sHdbong61Qoi+BbIKKGln345Qiy3DeqhOHgCul55SvBFdXYKycYt9HdpvP4vOwUtRA
         e6XeqPWVJfzS8Mprr6lyw7diodw1kI/Clox6b/90uCbDDsTULGvWnAwQID0XOxQeRwrr
         FP6UHyX3aP1J8Df1uaoNBjipHfLQ/ayxBfs5HDNGp14O4t7RA5VC3Y4o3xEyijxcunTp
         1dR/Ptyb6pyaczugc9pQYj9p4E9ce7jzRL41Y7FnTms/phFh8IEDvs/g1FJHXtyRdojh
         O0gxHJNkgFQDTwYt4kzQu7N1y6wiJwzj4TkX+lW3IifPWc2FAPyKZIcjOKtnruuocAwo
         xlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=r40Km9SeMoEAm8w6fV7cNpDnhYcE+rjMqoH130Kp7BE=;
        b=A9mDRRm9E1kAU8kyxHf9GALq6zAztSNRv1HJ7W0MrREdKBZsck1kx9vXof1mNDBLtL
         4KWbfhjJAgP22sXmvR5bu/ODyL8CnssEa+PCeGUBhP6LfRFuKnW0oRDuCccCTWUeraV6
         A6CZPvlv48pEhEzyttBOv1zodvyJXVyjs8NtYvMrNYyYUJMOb7P2YqzmtrZA3GDdq5z7
         oPjqsHw/+A7HtvZP0epsKTjS9LtCpyc2vJiGQVBYoxuwr0SmSJLo1rBnhB3WIeizKH4r
         lwIcdV86syHWqE5Cgo4GlSxqK/eusjvnM6b+N3t5Xd1TtdzMCEMPSZvNOBiHEaB92SxF
         Mthw==
X-Gm-Message-State: APjAAAWJ3SaEd6Ui4igme6m3zrQTgArPF/xvz9iYm7nW+uPjSXTaNJaR
        f+wRgv2F/K69HNRmLB9USmYWoaMv7te9VKRojXFWww==
X-Google-Smtp-Source: APXvYqym4YdfN5NCZ635dtgyN0Mo3OO0Abij86ACeO+9MdGWn1hlEjvLlL151v1Oriv9nU/uiKBEfgMcr+VXJAs55COPww==
X-Received: by 2002:a65:6904:: with SMTP id s4mr26903237pgq.33.1568109803251;
 Tue, 10 Sep 2019 03:03:23 -0700 (PDT)
Date:   Tue, 10 Sep 2019 03:03:16 -0700
Message-Id: <20190910100318.204420-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH 0/2] Minor lockdown fixups
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Constify some arrays and fix an #ifdef that I typoed.


