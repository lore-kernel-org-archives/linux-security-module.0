Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C63C4167B
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Dec 2022 18:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiLSSBU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLSSBT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Dec 2022 13:01:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B74E12AD7
        for <linux-security-module@vger.kernel.org>; Mon, 19 Dec 2022 10:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671472831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FnAiHz6ljM7ODJu0/GD9MQOC3mm+47bLds2l/+g+s9s=;
        b=BtBWpY2qbPyfGOJX2lYD+JlTylIFQ970HOiLo/pwDNTfB88pCrafWM7b7bTF0hI9KZAe63
        OO22QHV8T0GeavNeB8qN85DCO4IPNzAmRmdXWYXdAWSkPoBlCBnQAdc3HiwHnPqlZTb6kf
        mqCtVeT/HBSnYoeDCsLhM+N4I6meX6Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-154-SkEj704XPAmgMW8AXyFnGg-1; Mon, 19 Dec 2022 13:00:30 -0500
X-MC-Unique: SkEj704XPAmgMW8AXyFnGg-1
Received: by mail-ed1-f72.google.com with SMTP id j11-20020aa7c40b000000b0046b45e2ff83so7066721edq.12
        for <linux-security-module@vger.kernel.org>; Mon, 19 Dec 2022 10:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnAiHz6ljM7ODJu0/GD9MQOC3mm+47bLds2l/+g+s9s=;
        b=yJIjGnF6tPPvlsQ37Yyv0/ZZbmS4Pkbn4gYYgK8k/xlQQNX+PeuRsuUvZ29kZ8W3UX
         Wh0+tp6nSjqYTidyoigKA5NzPYKycvQSHyhTZNfwH8rLYxVKG99oXoay+lqXH+vfSP0h
         DKMcXDhNAKney19OXzf6Bam40Z+5LbiCUSSMwa/eSb6t/lK6Lm9vK8i+GAu6qTLbwn/a
         ohy1xo3HnMf4D0/TWYBkmoYV0y8/b/a6y+6b2GpHrD/q/abPx3jZvwZOroZxxCnj/HHq
         JDpemYvJcUJ3MSQzCp+9u8z/eN1oqzXVHLDYVInDcxAQd2TdqnviDP83ajMymQXahmFQ
         eo9Q==
X-Gm-Message-State: AFqh2kpgPdGTnkadCUQaNMllAYwDaWx1iQzRnoqfCPOpY0eZYnWWN1d6
        IBXbMHPqytqjst6GH9O0/mcjOBlObKBywIV2nAtWQL+xFfrMk0qsbpC39ATE00nFyLDiPs25xsk
        jfzwTnomr9eqd/AxYBdou35qxb3r09+gAwLy4
X-Received: by 2002:a05:6402:1f0d:b0:479:400a:d943 with SMTP id b13-20020a0564021f0d00b00479400ad943mr6176714edb.28.1671472827163;
        Mon, 19 Dec 2022 10:00:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvlBT/l+uXXqTk1XexJcN7ZXQbzHi34u/bh3Ff8AMn9P0qzZpjUeRRniCuAT6UP0aQe5u+iDA==
X-Received: by 2002:a05:6402:1f0d:b0:479:400a:d943 with SMTP id b13-20020a0564021f0d00b00479400ad943mr6176702edb.28.1671472826989;
        Mon, 19 Dec 2022 10:00:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id b10-20020a056402278a00b0046bb7503d9asm4617691ede.24.2022.12.19.10.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:00:26 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-audit@redhat.com,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Michal Sekletar <msekleta@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>
Subject: [PATCH RESEND 0/2] Provide matching audit timestamp in the SELinux AVC trace event
Date:   Mon, 19 Dec 2022 19:00:22 +0100
Message-Id: <20221219180024.1659268-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

(Resending due to an error on the first attempt.)

This series allows to match the SELinux AVC trace events to the
corresponding audit events via the audit event timestamp. This
will help with troubleshooting SELinux denials.

Ondrej Mosnacek (2):
  audit: introduce a struct to represent an audit timestamp
  selinux: provide matching audit timestamp in the AVC trace event

 include/linux/audit.h      | 13 +++++++++++++
 include/trace/events/avc.h | 25 +++++++++++++++++--------
 kernel/audit.c             | 23 +++++++++++++++--------
 kernel/audit.h             |  4 ++--
 kernel/auditsc.c           |  9 ++++-----
 security/selinux/avc.c     |  4 +++-
 6 files changed, 54 insertions(+), 24 deletions(-)

-- 
2.38.1

