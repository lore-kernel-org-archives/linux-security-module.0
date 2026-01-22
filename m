Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF873340A69
	for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090872; cv=none; b=U1aWJTQi8mfZGWJG61ttrlvgKfeGq8l5mCxJLvV79lBlZqU5NAa9iKCCRxpAk9QItDTOEW7fX5Cgin6WWlIpk5yFO1oVFl92vnvLz2IybqyVmK3i4RNSNk2MDOT7I0TBpyi5QFwAFIFOgwqcPkCSBNhqOHCosUueoc+qvVlPfnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090872; c=relaxed/simple;
	bh=G07Wvq8WvGFjY0dmP+/uGwYn1jnRFIolVqzUSFCwWXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=UvtVfGwvamEiZFiRPxI6yH7n992Qs6qIyXCVMy2okFeYbsSl7LXuxPSGt/pjDsa2SmCuXmMUHU92zpoD8z9jvT3UPSAjBsdtfTlsKPJTSaVrulkCNi0vs/IQISxLVIsQDeKuTX/o8iIZhYtNGAWveGlkW533ITvf5c0GkC2dRNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+a3XEnF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+a3XEnF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769090869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EtcMyJILD4z1qrnqIkPGVFTkZx7N2Lh4EB8ICDznUWY=;
	b=A+a3XEnFsC/NgCeTBprnk0+qqyiACEYZuOnfEZE9f9PUTYjuA2bDHv2MBieSBM7s5/w/E1
	RIMpf/mzcSnVxQYimOqpjycam/Zu96iaDsYvPrdcoXsqUYrvoAtcxYdKBd7LXxa3D8yxNH
	ABWjbL59bTQLXotPikd3bSjBlooNKiw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-OvkOrz8mOU--k-sIZZtWQg-1; Thu, 22 Jan 2026 09:07:48 -0500
X-MC-Unique: OvkOrz8mOU--k-sIZZtWQg-1
X-Mimecast-MFC-AGG-ID: OvkOrz8mOU--k-sIZZtWQg_1769090868
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4325aa61c6bso630722f8f.0
        for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 06:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769090867; x=1769695667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtcMyJILD4z1qrnqIkPGVFTkZx7N2Lh4EB8ICDznUWY=;
        b=QLqI0EML14luumC4njtVsXP65YDNVOaMrkyJCRstAAjaHvyH6XimmlXaqgJUJFzCQ3
         YEjqaNC1FC+OvlDkLlG2bZaF5xbYc7H3dJAH/A3L4mftj7KiR5DxrgX9BZRBgeITr0hJ
         9HnL5UjA9tDYdXEASjb0AvKagjxQjW1KIWVClGWSYPApzR+7O6IrzfYTVudmP0gvjMky
         P5I/YwY/Q4GeRCkvEroOgfI3mSFW/O5DIwHN7NK3Lbw3SMrsceJg2sz+LjljXd4t/Q/8
         gENKD6wGwSYmkGq0is0h6xPjGXeiMnv2tyWyf99VXWu1XsB3vmjAv5HSco4vv49uM/Gq
         Kq5g==
X-Forwarded-Encrypted: i=1; AJvYcCV14/js2dcIipvmWAv2x6O0XNviT3da6NEMmvYHDQnfYD2qm16EwhWxxa1yukquBSNi7lILVC+4WIz+YcTIC2xRZmJ1ZHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5vCW2a4ONuaOZU2zuhPI7oe+PH6iBmuKLXFVxkpqUSbTly95/
	pwn+7cYapttGwDOO7Z/zMeCzQVf0un+DwJbJZ+f3WPxLaKEcoqrdS854B6o0qpfzy4J5hZq5iDA
	EILjV8NbkfpFANPR01hMBJlTX3e24IU7r2WkiwGkJinvauuzVt4Zxcj2lpgZ2ZfKQtj7O1bCmb6
	bFS16XGygx9A==
X-Gm-Gg: AZuq6aJ9XFO66dj8llxVNWeBZjTg2Bq03jJcKHjYgbAP+ST0k9FXbFusY1kNyDA7ZGu
	pSq485349FHXyYg1tLkLnCGeSJXTpQrskBrBdxj13LftCPjQcXe69mtat7atJGVLM5vkq0Xpx3+
	hDIpBsfiKhX+EhGpnXES55Xd//YC0rglr2F8heCHgBulflra5VnEQC6mDCeYBdZjtn5ZRaW9Vxf
	nEo0aYLYWGqCJyNCB/xkOhzxTbH986EfqvBm61HPbscvOpnjuZpIlYCZCvsl0vYxAHn+1DHkk23
	SYmSqQPRHxolvewwVJeg9Wtd6ZeKmUarrAAg07B+77/eRUrOLCdQ/XlaNRReFpXDmSA=
X-Received: by 2002:a05:6000:25c7:b0:432:5bf9:cf15 with SMTP id ffacd0b85a97d-4356a024907mr35369562f8f.5.1769090867082;
        Thu, 22 Jan 2026 06:07:47 -0800 (PST)
X-Received: by 2002:a05:6000:25c7:b0:432:5bf9:cf15 with SMTP id ffacd0b85a97d-4356a024907mr35369503f8f.5.1769090866620;
        Thu, 22 Jan 2026 06:07:46 -0800 (PST)
Received: from fedora ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43595e0a705sm17390416f8f.14.2026.01.22.06.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 06:07:46 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH] ucount: check for CAP_SYS_RESOURCE using ns_capable_noaudit()
Date: Thu, 22 Jan 2026 15:07:45 +0100
Message-ID: <20260122140745.239428-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GZZdxqrc0RutzZuV84slPSrM6KZ50KRACpzy22zI4g8_1769090868
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The user.* sysctls implement the ctl_table_root::permissions hook and
they override the file access mode based on the CAP_SYS_RESOURCE
capability (at most rwx if capable, at most r-- if not). The capability
is being checked unconditionally, so if an LSM denies the capability, an
audit record may be logged even when access is in fact granted.

Given the logic in the set_permissions() function in kernel/ucount.c and
the unfortunate way the permission checking is implemented, it doesn't
seem viable to avoid false positive denials by deferring the capability
check. Thus, do the same as in net_ctl_permissions() (net/sysctl_net.c)
- switch from ns_capable() to ns_capable_noaudit(), so that the check
never logs an audit record.

Fixes: dbec28460a89 ("userns: Add per user namespace sysctls.")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 kernel/ucount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 586af49fc03e4..fc4a8f2d30965 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -47,7 +47,7 @@ static int set_permissions(struct ctl_table_header *head,
 	int mode;
 
 	/* Allow users with CAP_SYS_RESOURCE unrestrained access */
-	if (ns_capable(user_ns, CAP_SYS_RESOURCE))
+	if (ns_capable_noaudit(user_ns, CAP_SYS_RESOURCE))
 		mode = (table->mode & S_IRWXU) >> 6;
 	else
 	/* Allow all others at most read-only access */
-- 
2.52.0

