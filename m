Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD57C433B4
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Apr 2021 11:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBE36100A
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Apr 2021 11:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhDILNS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233864AbhDILNQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Apr 2021 07:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617966783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LlwhhPpg7/dsLVztmTdE1jlVBmRFkdvw6ZvqHL4cSJY=;
        b=Fj9gjnFxe/LxayvHnDbYEAUOuZ3JmlTZNQI7KU3Q3jb0LVJV+BKsWmQsX7fSmCBIFHwnhG
        NAlolKGx+qgj65OLh8QkDEIeilaKWcFld9K9SpL0nkXCeL6OrdPia6/td+WxQZqxWik2j4
        pnme7mAL7npIAgK3bUkfwpvOMxgplps=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-EvHNSwPJOBqwkqJb2EnLnQ-1; Fri, 09 Apr 2021 07:13:00 -0400
X-MC-Unique: EvHNSwPJOBqwkqJb2EnLnQ-1
Received: by mail-ed1-f72.google.com with SMTP id o25so2477725edv.20
        for <linux-security-module@vger.kernel.org>; Fri, 09 Apr 2021 04:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LlwhhPpg7/dsLVztmTdE1jlVBmRFkdvw6ZvqHL4cSJY=;
        b=dHSADPMv9uNela9kIpe/OZEtvmx+90oVSSBuy7aSiB6S0DcbmHuBWyeBSueNIj/Egn
         LslerQOG7OmqG5KSookSm1xB3Irn1XTgNlvtPnPijhDbBMMxzuWkhGiPdhwNSep3D3Ea
         4hrq+rEKwwGYnQhnM9TJuaKu+FGy1oI5ZWbiHjFQQS/mW8C9QxXvU81l/HO6O90KYa2H
         lD34Vosf1udxdvYlPkfN+yTJoO5aT9p3yMOpBkGRRbSTdWcCh3YP7nnmPTw3sDkv4Nhd
         SXmjD0K1VUVqJOUVoSrJSmW2KDhJA8ffriEl4b1/XNnHKhcmhs/Vk0MlYEv9NGLXgfdj
         xN0w==
X-Gm-Message-State: AOAM5325Fg8+8eeysV+nxyMOOeFxQsbPA56xWT32VJ0AYuM2LUAd+PDz
        4522aYSAO9DY2JWmGk90QvswMeVQwn7ljIs7/cv00g/GFmxpo5Ld3WshdNyOxfbv9oYZJsBaqgY
        lpQbtS8hkcdFPbAtYFdV1o+xfDmG/P16dLyqBEYcTjr/SSbBew5r6g/uXvGJ5BbQJYDCt7aynA0
        c9gRlhFc3priaS
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr16886115edj.178.1617966778621;
        Fri, 09 Apr 2021 04:12:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9DN2Sw6T+TRJMgdrKflu/6Pq2gsJ2XI7RSTKrE+UZAOitmzvCa6P+n4y7usKpGVJqkST9ag==
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr16886085edj.178.1617966778324;
        Fri, 09 Apr 2021 04:12:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id w18sm1046854ejq.58.2021.04.09.04.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:12:57 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 0/2] vfs/security/NFS/btrfs: clean up and fix LSM option handling
Date:   Fri,  9 Apr 2021 13:12:52 +0200
Message-Id: <20210409111254.271800-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This series attempts to clean up part of the mess that has grown around
the LSM mount option handling across different subsystems.

The original motivation was to fix a NFS+SELinux bug that I found while
trying to get the NFS part of the selinux-testsuite [1] to work, which
is fixed by patch 2.

The first patch paves the way for the second one by eliminating the
special case workaround in selinux_set_mnt_opts(), while also
simplifying BTRFS's LSM mount option handling.

I tested the patches by running the NFS part of the SELinux testsuite
(which is now fully passing). I also added the pending patch for
broken BTRFS LSM options support with fsconfig(2) [2] and ran the
proposed BTRFS SELinux tests for selinux-testsuite [3] (still passing
with all patches).

[1] https://github.com/SELinuxProject/selinux-testsuite/
[2] https://lore.kernel.org/selinux/20210401065403.GA1363493@infradead.org/T/
[3] https://lore.kernel.org/selinux/20201103110121.53919-2-richard_c_haines@btinternet.com/
    ^^ the original patch no longer applies - a rebased version is here:
    https://github.com/WOnder93/selinux-testsuite/commit/212e76b5bd0775c7507c1996bd172de3bcbff139.patch

Ondrej Mosnacek (2):
  vfs,LSM: introduce the FS_HANDLES_LSM_OPTS flag
  selinux: fix SECURITY_LSM_NATIVE_LABELS flag handling on double mount

 fs/btrfs/super.c         | 35 ++++++-----------------------------
 fs/nfs/fs_context.c      |  6 ++++--
 fs/super.c               | 10 ++++++----
 include/linux/fs.h       |  3 ++-
 security/selinux/hooks.c | 32 +++++++++++++++++---------------
 5 files changed, 35 insertions(+), 51 deletions(-)

-- 
2.30.2

