Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597429;
	b=D7q+6hr2eWVTia0zezp9dgF5iFMIoUREszj5tICHi388I5weqWizefDfsNEknR7ymbAB
	 IGYA4R/KHfb3SzkaY2ExjtXPKMgEh4f7tLLUaM9L0mmetsc2m+X7dSBRZna6n5qVG+gBK
	 grTLmqSbopEU+xukqpunj1KhHBgliu7kCdUmEItQRKPT0JgPEgZRfNIlilRDSNidJrZER
	 7i2gsIC1+1tgd5evo/+b2XF3Q7S8OQ29Kf5C8+5eo2cQ1SF9UAkMaWCzM89qiFxU5LzEW
	 l9r+p4YFYHr6PRjYaJKZBJC7jwinSWzfidPHMROFzm6H5Xrjxz49hBM1I9Xt8KF6sjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597429;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=Dk6wwXssduvkysnCFA49Mb0DnkBZNEAPmUUXIY9glP8=;
	b=Sq98M4l4fdStS2Hagtl14/fIh/eUBrxBhMpVCRUPx+33YYF4z4u2ZSkxi7Nr3+gIp3Cc
	 7JYfsYI5Nh2ejqr/dOjK07g/flziNx3lH4BIjOFFf8s99whcMkIXrmnWWXU4xJZF9zFJq
	 C3yRhhQ9VWEqS/V2uKjM0BAq0p1ilz3H+cjpPCq/kr7PIY9U4tyeRqJlLYKd2mU/umpPQ
	 82TOcZ7lkMbKzsdV7eBIs1LqHcz0b4xXjMH40097bYl4d6fOJ48wsNcc7s3r+AzwNZKtr
	 zizEF7rWES6+hkfwnW4dWuXPh1+oraMiursbgRO/Q5Kox4ufDvipK3uRHVEtIC2kMlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gcz9ySeW;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F060A2638
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 15:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 325F060A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gcz9ySeW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792597427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dk6wwXssduvkysnCFA49Mb0DnkBZNEAPmUUXIY9glP8=;
	b=Gcz9ySeW2hza2XLss+eZcHv8vdev3DdHpcVXINYSuSHtAw9xzm33fMYFeSL96pcgSlNmlP
	6QPkHNvQMoWvlpr2BchTrDhSgWe6/k92UjVp2ddMLEn6fLMwogyyLuNDHnIJdyVyJDZ7N7
	oKJnMoX1Gz3FuzKm7xC9etcOQY6FNi0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-JjkEKVxdN4ykZuUXpUfnjQ-1; Wed,
 21 Oct 2026 11:43:43 -0400
X-MC-Unique: JjkEKVxdN4ykZuUXpUfnjQ-1
X-Mimecast-MFC-AGG-ID: JjkEKVxdN4ykZuUXpUfnjQ_1792597418
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39A0D1956055;
	Wed, 21 Oct 2026 15:43:38 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADBF918002B1;
	Wed, 21 Oct 2026 15:43:30 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 21 Oct 2026 17:42:27 +0200
Subject: [PATCH RFC v2 6/8] selinux: Restrict dma-buf direct cgroup
 charging
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261021-v2_20230123_tjmercier_google_com-v2-6-ef6ee2dd8c5c@redhat.com>
References: <20261021-v2_20230123_tjmercier_google_com-v2-0-ef6ee2dd8c5c@redhat.com>
In-Reply-To: <20261021-v2_20230123_tjmercier_google_com-v2-0-ef6ee2dd8c5c@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Albert Esteve <aesteve@redhat.com>, mripard@kernel.org, echanude@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792597359; l=3371;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=WhNF22wskvchWhAOLXz5tK1hE/8N9oZT6SVHpLAxSMQ=;
 b=varrJblz1GmvQzfke0vE+VKqGOZD7frOjl2u1GrLrmjgsm5CEcK9ExzBs5iyDAiQiA2o3+Vtv
 HP7IXuHUoouDUYcFR/lpCtvrCnDI873UHcD6SIkoRdCsHZeG/oUcSe6
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: hYlYQ8D6X7Qb3p4Klz8kjOoJyQWAr4aAreGkeJMCtPI_1792597418
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The security_dma_buf_charge_cgroup() hook allows security modules
to control which processes may charge dma-buf to an arbitrary
cgroup via cgroupfd passed in charge_fd. Without a policy
implementation, the hook is a no-op and any process that can open a
cgroup directory (effectively any process) can charge memory to it.

Implement selinux_dma_buf_charge_cgroup() using avc_has_perm() with
the dma_buf object class and a charge_cgroup permission. The target
SID is derived from the SELinux label on the cgroup's kernfs
directory, so access control follow the cgroup filesystem labeling.
Policy authors can then grant cross-cgroup charging selectively,
for example:

  allow allocator_app_t cgroup_t:dma_buf charge_cgroup;

The hook matches the fail-open semantics of
selinux_kernfs_init_security(). This means unlabeled cgroups are
unrestricted by default.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 security/selinux/hooks.c            | 33 +++++++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 +-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8f39d91eabc9..8de5e16951de 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2210,6 +2210,38 @@ static int selinux_dma_buf_charge_task(const struct cred *from, const struct cre
 			    SECCLASS_DMA_BUF, DMA_BUF__CHARGE_TASK, NULL);
 }
 
+static int selinux_dma_buf_charge_cgroup(const struct cred *cred, struct cgroup *cgrp)
+{
+	u32 cgrp_sid, clen;
+	int rc;
+	char *context;
+
+	rc = kernfs_xattr_get(cgrp->kn, XATTR_NAME_SELINUX, NULL, 0);
+	if (rc == -ENODATA)
+		return 0;
+	else if (rc < 0)
+		return rc;
+
+	clen = (u32)rc;
+	context = kmalloc(clen, GFP_KERNEL);
+	if (!context)
+		return -ENOMEM;
+
+	rc = kernfs_xattr_get(cgrp->kn, XATTR_NAME_SELINUX, context, clen);
+	if (rc < 0) {
+		kfree(context);
+		return rc;
+	}
+
+	rc = security_context_to_sid(context, clen, &cgrp_sid, GFP_KERNEL);
+	kfree(context);
+	if (rc)
+		return rc;
+
+	return avc_has_perm(cred_sid(cred), cgrp_sid,
+			    SECCLASS_DMA_BUF, DMA_BUF__CHARGE_CGROUP, NULL);
+}
+
 static int selinux_quotactl(int cmds, int type, int id, const struct super_block *sb)
 {
 	const struct cred *cred = current_cred();
@@ -7681,6 +7713,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capset, selinux_capset),
 	LSM_HOOK_INIT(capable, selinux_capable),
 	LSM_HOOK_INIT(dma_buf_charge_task, selinux_dma_buf_charge_task),
+	LSM_HOOK_INIT(dma_buf_charge_cgroup, selinux_dma_buf_charge_cgroup),
 	LSM_HOOK_INIT(quotactl, selinux_quotactl),
 	LSM_HOOK_INIT(quota_on, selinux_quota_on),
 	LSM_HOOK_INIT(syslog, selinux_syslog),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index b4ebedc6e424..90d1e04c3d27 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -181,7 +181,7 @@ const struct security_class_mapping secclass_map[] = {
 	{ "user_namespace", { "create", NULL } },
 	{ "memfd_file",
 	  { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
-	{ "dma_buf", { "charge_task", NULL } },
+	{ "dma_buf", { "charge_task", "charge_cgroup", NULL } },
 	/* last one */ { NULL, {} }
 };
 

-- 
2.55.0

