Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B790CC433F5
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Nov 2021 22:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948E161250
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Nov 2021 22:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhKJW6p (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Nov 2021 17:58:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233725AbhKJW6p (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Nov 2021 17:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636584957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ffRLM5/6i0/EpV2nOMpGLKukcrPEwSXDgFx3WFdW8vs=;
        b=YCQZEoBBG0KCrv64sX2YflA+HrH/yxbIrunDEwXURj4Fm61DyCTDnujvbkPP7iZUcZsF6C
        hVuGzwyYA9ucWKDf/E3wxMFySL1HUGaP9ujrNz+OtPKq9wp9BTvq9HX7uADGmu6Nb6IwJz
        dEbFs5dZX+23OnIDLL8Y8eAsDqlDd5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-fdGcCOIZNzarAtBdzxH2FQ-1; Wed, 10 Nov 2021 17:55:55 -0500
X-MC-Unique: fdGcCOIZNzarAtBdzxH2FQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4ED7319253C0;
        Wed, 10 Nov 2021 22:55:54 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.10.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 542A869FBD;
        Wed, 10 Nov 2021 22:55:43 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E1F75223DF5; Wed, 10 Nov 2021 17:55:42 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, virtio-fs@redhat.com,
        chirantan@chromium.org, vgoyal@redhat.com,
        stephen.smalley.work@gmail.com, dwalsh@redhat.com,
        casey@schaufler-ca.com, omosnace@redhat.com
Subject: [PATCH v3 0/1] fuse: Send file/inode security context during creation
Date:   Wed, 10 Nov 2021 17:55:27 -0500
Message-Id: <20211110225528.48601-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

This is V3 of the patch. V2 was posted here.

https://lore.kernel.org/linux-fsdevel/20210924192442.916927-1-vgoyal@redhat.com/

I took care of feedback from Miklos. Changes since v2 are.

- Merged two patches into one. (Miklos)
- Renamed fuse_secctxs to fuse_secctx_header (Miklos)
- Added total size of all contexts (including fuse_secctx_header) field
  in fuse_secctx_header. (Miklos)
- Fixed changelogs (Casey Schaufler)
- Removed one unnecessary if condition check (Miklos)
- Removed a function argument to function create_new_entry() (Miklos)

Thanks
Vivek

Vivek Goyal (1):
  fuse: Send security context of inode on file creation

 fs/fuse/dir.c             | 103 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          |   3 ++
 fs/fuse/inode.c           |   4 +-
 include/uapi/linux/fuse.h |  31 +++++++++++-
 4 files changed, 139 insertions(+), 2 deletions(-)

-- 
2.31.1

