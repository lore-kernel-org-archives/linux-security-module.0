Return-Path: <SRS0=3gqt=6F=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21AEC54FC9
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Apr 2020 13:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD80206B8
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Apr 2020 13:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQLUvXEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgDUNvq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:51:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41683 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728337AbgDUNvp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Apr 2020 09:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587477103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IInilyB2ckeUfP1pJZsdQY8G2HWtqy1MvibEpjmv5kQ=;
        b=ZQLUvXEYD34HVTUmC+OWimcdvwMJzTKI3LpHgyGuPXkoRYh8cWSRL99NkIxAGpjshRakGg
        kg7+yNAyHRvZV2N5kVHqK5u+vKGxMYNO/53Kzpn/dBlSz4GNaN248RsMh2pgdiWK1jD1Zt
        HqO3QEez9SjZq6vi0M71Z1jr3XZt8j0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-89sTI2fmM6yBIM0l4FoEow-1; Tue, 21 Apr 2020 09:51:41 -0400
X-MC-Unique: 89sTI2fmM6yBIM0l4FoEow-1
Received: by mail-wr1-f71.google.com with SMTP id h95so7490164wrh.11
        for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2020 06:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IInilyB2ckeUfP1pJZsdQY8G2HWtqy1MvibEpjmv5kQ=;
        b=tOv03Q5N90LkisxCtV+Vjl143YhDv2t/9IvsIRtNpcENn8fKWgnw7E3vFTCuFnQgXU
         TP8TnrYylJeOFUwtS+EhbTnWcCPhIeSWnEddc5/t3rrZnguC0WGTrnUfZJbSLPMRXH/V
         yBU486ygbeFLuf/vVHsNyjduohFGSwPYq+D6DooybdEnSYXujl6s7yosaWGJ1xIpcNje
         KolEyYRyd3nh/247RT+1R3iN1Oqj8xvyDg/WxsARRAIlqhmsCJNMKPrUF4r89ivVxAjq
         X6KKHG1hRtwLrQJrtwcA/p2wmFe//X8pNTya60T4Rp8AkFpyn644CuWV0pYp3vpj+z0c
         1bXQ==
X-Gm-Message-State: AGi0PuazWbolwYCqamVOR3XFrHnIey1USyi+eq++7d4bGD5yJD7BFTZ4
        c14J6ualYNAbdWOhw7GRe9wqQymComd4bjS60uuJ8+R4WJvf++VxslWhI0qh3IwSn9sLUvSQaY8
        csYSCaFmhuwvDlJnFgfkKKsvVcYHZmxBlG1Uy
X-Received: by 2002:a1c:bd89:: with SMTP id n131mr4916133wmf.3.1587477100744;
        Tue, 21 Apr 2020 06:51:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypL9ml34u2SXsT4cym73Fj9YcZ5gNZl/Vlb+iTik+1IYxflheOGQshudBA/kLdh/qIi+ct+15w==
X-Received: by 2002:a1c:bd89:: with SMTP id n131mr4916110wmf.3.1587477100572;
        Tue, 21 Apr 2020 06:51:40 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.194])
        by smtp.gmail.com with ESMTPSA id a187sm3565830wmh.40.2020.04.21.06.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:51:40 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v2 0/7] libfs: group and simplify linux fs code
Date:   Tue, 21 Apr 2020 15:51:12 +0200
Message-Id: <20200421135119.30007-1-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

libfs.c has many functions that are useful to implement dentry and inode
operations, but not many at the filesystem level.  As a result, code to
create files and inodes has a lot of duplication, to the point that
tracefs has copied several hundred lines from debugfs.

The main two libfs.c functions for filesystems are simple_pin_fs and
simple_release_fs, which hide a somewhat complicated locking sequence
that is needed to serialize vfs_kern_mount and mntget.  In this series,
my aim is to add functions that create dentries and inodes of various
kinds (either anonymous inodes, or directory/file/symlink).  These
functions take the code that was duplicated across debugfs and tracefs
and move it to libfs.c.

In order to limit the number of arguments to the new functions, the
series first creates a data type that is passed to both
simple_pin_fs/simple_release_fs and the new creation functions.  The new
struct, introduced in patch 2, simply groups the "mount" and "count"
arguments to simple_pin_fs and simple_release_fs.

Patches 1-4 are preparations to introduce the new simple_fs struct and
new functions that are useful in the remainder of the series.  Patch 5
introduces the dentry and inode creation functions.  Patch 6-7 can then
adopt them in debugfs and tracefs.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>

v1->v2: rename simple_new_inode in new_inode_current_time,
more detailed explanations, put all common code in fs/libfs.c

Emanuele Giuseppe Esposito (7):
  apparmor: just use vfs_kern_mount to make .null
  libfs: wrap simple_pin_fs/simple_release_fs arguments in a struct
  libfs: introduce new_inode_current_time
  libfs: add alloc_anon_inode wrapper
  libfs: add file creation functions
  debugfs: switch to simplefs inode creation API
  tracefs: switch to simplefs inode creation API

 drivers/gpu/drm/drm_drv.c       |  11 +-
 drivers/misc/cxl/api.c          |  13 +-
 drivers/scsi/cxlflash/ocxl_hw.c |  14 +-
 fs/binfmt_misc.c                |   9 +-
 fs/configfs/mount.c             |  10 +-
 fs/debugfs/inode.c              | 158 +++--------------
 fs/libfs.c                      | 299 ++++++++++++++++++++++++++++++--
 fs/tracefs/inode.c              |  96 ++--------
 include/linux/fs.h              |  31 +++-
 security/apparmor/apparmorfs.c  |  38 ++--
 security/inode.c                |  11 +-
 11 files changed, 399 insertions(+), 291 deletions(-)

-- 
2.25.2

