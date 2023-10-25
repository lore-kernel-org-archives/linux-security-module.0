Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F20C25B71
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Oct 2023 14:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344688AbjJYOEM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Oct 2023 10:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344545AbjJYODu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Oct 2023 10:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB181B3
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 07:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698242544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOOGhallOPxnWGST34MdPR6LpOdkhm6q6XmykKHjQ0c=;
        b=TM2T/R6DR1mwGxfBwbYr07mHiMKv3evL3E4yxNGUQ5zkfOf+/797CMD4+y2zHMV9/KciNb
        QRdvTgFhoVt0ysb51i6+AURWHHfco01yreRbEQaAn3FI9aEEN287UMd+McQzCHsMJ+d6Rl
        V2ak1Zeu9YHjncCRJiO/w0wpSyi4MrU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-iLCsDytAPvu59oAufEYwBg-1; Wed, 25 Oct 2023 10:02:12 -0400
X-MC-Unique: iLCsDytAPvu59oAufEYwBg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c797b497e8so308368666b.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 07:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242531; x=1698847331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOOGhallOPxnWGST34MdPR6LpOdkhm6q6XmykKHjQ0c=;
        b=ZHkdmvMR8kcWAUE2E3eaa72dzD1KX1ydG1TiPUoLtlA++DdkFM3+Vwmyc1hzyWw625
         NirbrLwH+fPHkttEz3YdvwbBdA6bTfCjW6PSTJsYaq/cj2/dQ9GLiAJ4UmkVz5uCuaOv
         Q/p6+bOqpR6lSRkOTTqH4gt6YkhJw0OctVjvXmMvCdfDVHCPHRnNpsZ9VC1w0+kHKztz
         MHUqm5AVysyitg71QfFazCM+Oa1XLvXfF4bANaTVpKcnvhFSf3ljKB0l9tV9vnB3YBcO
         J742W9VG/UiA9h6VXMBUz7emUsuimGpL/q7yfndV0p99PPXvZqYz8yOrno8gN0jBmTrZ
         DjJQ==
X-Gm-Message-State: AOJu0YxJS1KfvIiAtGbWWHHaNo6h9YcRcOapZDTMC3CUlVgcVqToLlEG
        hlMzdO+9aE42q/S/YJSy59ZRixkZlkDbYs/heqXB/eKjgifHE5aVVq79CsAhhjRW3rM+bFPK4Fu
        rpNy07f9W1SpSyUclsZ87xGV8gTNU941s9x/N
X-Received: by 2002:a17:907:7214:b0:9c5:64f2:eaba with SMTP id dr20-20020a170907721400b009c564f2eabamr12173175ejc.53.1698242531659;
        Wed, 25 Oct 2023 07:02:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjFyLKoZkQVe5WJ8FMZvmHP9TlGwCthXsPC2ClyGzG4V59SQ3WuYohHWjLbekPtDQTXUhMwQ==
X-Received: by 2002:a17:907:7214:b0:9c5:64f2:eaba with SMTP id dr20-20020a170907721400b009c564f2eabamr12173147ejc.53.1698242531456;
        Wed, 25 Oct 2023 07:02:11 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (92-249-235-200.pool.digikabel.hu. [92.249.235.200])
        by smtp.gmail.com with ESMTPSA id vl9-20020a170907b60900b00989828a42e8sm9857073ejc.154.2023.10.25.07.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:02:10 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 3/6] namespace: extract show_path() helper
Date:   Wed, 25 Oct 2023 16:02:01 +0200
Message-ID: <20231025140205.3586473-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025140205.3586473-1-mszeredi@redhat.com>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

To be used by the statmount(2) syscall as well.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/internal.h       |  2 ++
 fs/namespace.c      |  9 +++++++++
 fs/proc_namespace.c | 10 +++-------
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index d64ae03998cc..0c4f4cf2ff5a 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -83,6 +83,8 @@ int path_mount(const char *dev_name, struct path *path,
 		const char *type_page, unsigned long flags, void *data_page);
 int path_umount(struct path *path, int flags);
 
+int show_path(struct seq_file *m, struct dentry *root);
+
 /*
  * fs_struct.c
  */
diff --git a/fs/namespace.c b/fs/namespace.c
index 0eab47ffc76c..7a33ea391a02 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4672,6 +4672,15 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 	return err;
 }
 
+int show_path(struct seq_file *m, struct dentry *root)
+{
+	if (root->d_sb->s_op->show_path)
+		return root->d_sb->s_op->show_path(m, root);
+
+	seq_dentry(m, root, " \t\n\\");
+	return 0;
+}
+
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 73d2274d5f59..0a808951b7d3 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -142,13 +142,9 @@ static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
 
 	seq_printf(m, "%i %i %u:%u ", r->mnt_id, r->mnt_parent->mnt_id,
 		   MAJOR(sb->s_dev), MINOR(sb->s_dev));
-	if (sb->s_op->show_path) {
-		err = sb->s_op->show_path(m, mnt->mnt_root);
-		if (err)
-			goto out;
-	} else {
-		seq_dentry(m, mnt->mnt_root, " \t\n\\");
-	}
+	err = show_path(m, mnt->mnt_root);
+	if (err)
+		goto out;
 	seq_putc(m, ' ');
 
 	/* mountpoints outside of chroot jail will give SEQ_SKIP on this */
-- 
2.41.0

