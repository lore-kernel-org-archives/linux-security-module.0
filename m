Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6F8305E2E
	for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769091190; cv=none; b=F1x/eO4ONB9uX2DuZ1E6U6vE8cC/CGjt0wlXr1rt7funMw8c7daZU1JHezoZEdQhFKBhDWMLaG3Gh3SnooEnSRXdXqmlSO91+nCs1numH0g1OFSOg0blVGI4/NvOhpvkTTGkQTOI+NfPRB+Jg9aWsysBzgoNSLUBnsHzj5kwQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769091190; c=relaxed/simple;
	bh=Mn21BPD3AuBamNBIQ/yf9Rn2jlT2v4WIxJAUKQ0U16g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Lc6phjSCXXeIEIJ/pQGZQr7Oh3qSFekCJIAldhbGFXMAzqQ4Bm3PiJms1Le8yl6/L+pcK1wnkFF8akfAKqXo91cNiy952LZZp00WtwD7q+GLgC0gtfHJwXoa1gBCZucGr0FOyem3/xPjfmd6IIRmYG4PScK/hb6ZC0kbGMQ1gMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISfBTR1x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISfBTR1x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769091187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5RQjD78hKqWJwoQ+yeMvpqjICnn41Udh857/CjWOTDc=;
	b=ISfBTR1xZ+2aCU7CpuFgM0pZmemGRzTXVIikxrKuYG16XZmuwN6wJhP2KOBd9qi1wy12/p
	sy1MwhJGvodC+VJvCwCFuYYaUM7vVrZxKz0Pa8so88YPWkjfR2QgJ6FdisnysT+ZCSqv85
	hNgGifIMiICvhQJMGLLxipe4MmP8rcM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-Cgff-N_cN8OZ0Z4zn8niPA-1; Thu, 22 Jan 2026 09:13:06 -0500
X-MC-Unique: Cgff-N_cN8OZ0Z4zn8niPA-1
X-Mimecast-MFC-AGG-ID: Cgff-N_cN8OZ0Z4zn8niPA_1769091185
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-432c05971c6so812624f8f.1
        for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 06:13:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769091185; x=1769695985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RQjD78hKqWJwoQ+yeMvpqjICnn41Udh857/CjWOTDc=;
        b=tcTr38Pc5/rHsA2339pX4o3PAYxTmhHQzpKQeXcgq9TK4a3Z3aog29uHdJGnGcQT5m
         YhoC8ciXhk2FpIZ3F/oluuxBehHpNwNXMAV4h0j47udc87eBq43xAw+BNpVGR0y02Itw
         iP+ckH1gZrkq7azbrZtwaK7x9QRtoBZ57Pnb3SsE2EkFDX4zV3PcJTSMsUNZR8qejOin
         BSB2aaD/o5NegpzvU811zIdCD7ibmLI1EjPPNmEz5MAT1c4/gXqjpD2xXQB5G9j7F7vc
         KQataDQYyMWvO5zD+e3hn8RQRp8TNrV07RwZMYWXKFMyAdWTlI8LNKhncNXIutTJp9dD
         nxrA==
X-Forwarded-Encrypted: i=1; AJvYcCWnf5Pa+4DYLJqxCOwT8+y0qX8A6KBYqpSUmVSk8w0Rhc/H6w+8SadapAQzD0ZgUsC5gwW4hqsOBoZhjGLXUjMtsJydRuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOD70X76I9oRihgj2iTo6o2C89p1oYb3DIbGNBV39XAigAMluH
	tzK3UmJubEWGigJyLeA2ju4gaqfzbFBEie5rXSrSlKOU7dF+kjkfOCdtJt7p1MWrvbFC0TvW7/D
	PEAukrer7GOaccSvzCCG0V37KjzbQOgyv5ojtMBeRvJ/eWpYccAkcCEJU/bzLbNVRINYTAvoI0X
	vC3w==
X-Gm-Gg: AZuq6aJG62EuxuBAustErHD7XZBJ6V5oOwqn17W4Zht5MA6ga/IiT38ilSkLP/0GaLS
	k9R7nDiQWV6SyC+nWMaPBYpCEsmBzsmW8bYpDA1SXx3Z0JqPgSauPBeChVua0/ISFtincL2tT4s
	M4WACLN+7m8KiuPysysWepgznIuzqd0JEeySB+z6svsTrAHgA0raBWwx6Jt5ERzoGTKKay/ZAZz
	MydcwveE2xfgZMmPKna+nCqzkeIpFiX6UXd1bzjuja16Ib+fKxXnyF3opDgYRt8H4DdF8XFot2k
	4yb1lf4jlr2Je9ffbdf/RfDDGmBuJKEwIfiJAa1xkNgu+8UmUlZMsPyh3ZOq6GwSQO8=
X-Received: by 2002:a05:6000:420d:b0:431:de5:93c7 with SMTP id ffacd0b85a97d-435a5f5ccfdmr6243332f8f.2.1769091184998;
        Thu, 22 Jan 2026 06:13:04 -0800 (PST)
X-Received: by 2002:a05:6000:420d:b0:431:de5:93c7 with SMTP id ffacd0b85a97d-435a5f5ccfdmr6243286f8f.2.1769091184544;
        Thu, 22 Jan 2026 06:13:04 -0800 (PST)
Received: from fedora ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43596090493sm17643302f8f.25.2026.01.22.06.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 06:13:04 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>
Cc: Alexey Gladkov <legion@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH] ipc: don't audit capability check in ipc_permissions()
Date: Thu, 22 Jan 2026 15:13:03 +0100
Message-ID: <20260122141303.241133-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lRwi_raaAPV3Q1MXAuvu0wanvSUBPyBoO9nPM1oEynM_1769091185
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The IPC sysctls implement the ctl_table_root::permissions hook and
they override the file access mode based on the CAP_CHECKPOINT_RESTORE
capability, which is being checked regardless of whether any access is
actually denied or not, so if an LSM denies the capability, an audit
record may be logged even when access is in fact granted.

It wouldn't be viable to restructure the sysctl permission logic to only
check the capability when the access would be actually denied if it's
not granted. Thus, do the same as in net_ctl_permissions()
(net/sysctl_net.c) - switch from ns_capable() to ns_capable_noaudit(),
so that the check never emits an audit record.

Fixes: 0889f44e2810 ("ipc: Check permissions for checkpoint_restart sysctls at open time")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/capability.h | 6 ++++++
 ipc/ipc_sysctl.c           | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 1fb08922552c7..37db92b3d6f89 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -203,6 +203,12 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 		ns_capable(ns, CAP_SYS_ADMIN);
 }
 
+static inline bool checkpoint_restore_ns_capable_noaudit(struct user_namespace *ns)
+{
+	return ns_capable_noaudit(ns, CAP_CHECKPOINT_RESTORE) ||
+		ns_capable_noaudit(ns, CAP_SYS_ADMIN);
+}
+
 /* audit system wants to get cap info from files as well */
 int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 			   const struct dentry *dentry,
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 15b17e86e198c..9b087ebeb643b 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -214,7 +214,7 @@ static int ipc_permissions(struct ctl_table_header *head, const struct ctl_table
 	if (((table->data == &ns->ids[IPC_SEM_IDS].next_id) ||
 	     (table->data == &ns->ids[IPC_MSG_IDS].next_id) ||
 	     (table->data == &ns->ids[IPC_SHM_IDS].next_id)) &&
-	    checkpoint_restore_ns_capable(ns->user_ns))
+	    checkpoint_restore_ns_capable_noaudit(ns->user_ns))
 		mode = 0666;
 	else
 #endif
-- 
2.52.0

