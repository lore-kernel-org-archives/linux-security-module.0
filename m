Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904839;
	b=DGJuGm7vf1M0lqHGdvJ2uosL0hRMI3NHIMGHXiFU6kpNy9XFrbCh7UDAyDMRPHuLDRMZ
	 m77L2kYvmGiXo2iW8sZ1Wm6vajFN03EihNOmkMPUVHg88yybCf1V9aGGmGlBSx8CrvkHU
	 j+7Z66oKN+81p4CzUX96OXCpWBy/ZCk14ctLDgq1N6fSpU906Bg79tKGXXdwyDJkUlIX9
	 2E6cXsnTdEdOjBnionBSZZZriBdcesKSOz6Kcfy23bLPBfBpFntGMM/oNg4Hm+QcmZaIv
	 EJM3wicGNwuRWhQObUsGeq9BMLlsRtASsdtXncAj7iJIRn7zVFvpxhFC6z6sm2KYZyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904839;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=yXFgoHEW1fISPqx+DguPFuIqzmYDTSmejmjwwKMoL0g=;
	b=Tmcdm4UUPTsJViTPX7qD5PdmuqTP86IzCSmku9kRoULlKvUIAkw4nKpskROG7/md8NZL
	 qDggKjI2JBav01gueXy4MQaBadixa9aGms1qTF3WpHF+3ZPaDtvcg+sQ25k/Bx3u1zeox
	 tvAN9/gACuc+0IaidxRrGYTI4YyXAhHoQZtPnIiW2O3quq8V3xl/l7HAukK/rhjU2K2VT
	 LZXIt6Ftjj8xtNDrRE5AVZRCwG16H4Fn078wT9Z1r2lP+8EX089vaGJASIO9Vb/vayFDY
	 z5PR1chZ3e+9Wf02GorP3UYd33sbmKNx0C5BZtmnilfTevfzpKwUk5XMlAUFAXHiclw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cEKHEsRJ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E9606A886
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 08:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC3E9606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cEKHEsRJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794904837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yXFgoHEW1fISPqx+DguPFuIqzmYDTSmejmjwwKMoL0g=;
	b=cEKHEsRJQ0HahVglj/NoIP5oib4xURYx+csNP4JYYLoglCQPIkBLSCv3VOUPbsfBZdgUxB
	/JBNfMgsOJfQLeQmFTD7ZHGHRxS5I+u3wt8FHZVrg8EEUXa+r06pAocVAPlXAdAvAlT7X/
	mE/h3iYgnbWLEnSp335dTynWCLR367Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-41wtSiStMx6OGywUNbxqmg-1; Tue,
 17 Nov 2026 03:40:31 -0500
X-MC-Unique: 41wtSiStMx6OGywUNbxqmg-1
X-Mimecast-MFC-AGG-ID: 41wtSiStMx6OGywUNbxqmg_1794904827
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 945C01956069;
	Tue, 17 Nov 2026 08:40:26 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95BD1195604C;
	Tue, 17 Nov 2026 08:40:18 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 17 Nov 2026 09:39:21 +0100
Subject: [PATCH v5 6/8] selinux: Restrict cross-cgroup memcg charging
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261117-v2_20230123_tjmercier_google_com-v5-6-1ce975f2a9ad@redhat.com>
References: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
In-Reply-To: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
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
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: airlied@gmail.com, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 op-tee@lists.trustedfirmware.org, Albert Esteve <aesteve@redhat.com>, 
 echanude@redhat.com, mripard@kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794904759; l=2979;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=RrKe9K1q9fyXy57Glgyl5viYPn+7F5Ts4443s8tf3ss=;
 b=13nAju+X3DpbINGKS1zMwlfDyMxGFVKZdQMxrpe6DbAQnYwMF5gKTQEiYFBetkPCvf2hIXqrG
 69WKbxp/kILA3BT/6ZxC3p0yuzpLYhO4G+cfjD7W57tFWJexlYcPhwW
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: XxLjLbcESFCmxXSvkwFr-laoi0tfxQj5-ARneq57IPY_1794904827
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The security_memcg_charge_task() hook allows security modules
to control which processes may charge/transfer memcg
memory to another process's cgroup outside their tree. Without
a policy implementation, the hook is a no-op and the restriction
is not enforced.

On SELinux-managed systems the only limit is CAP_SYS_RESOURCE. A
domain that holds both dma-heap access (today's only exporter that
opts-in) and that capability, can charge memory to any cgroup outside
its own subtree. Since the capability is all-or-nothing, SELinux
policy cannot express which targets such a domain may charge to.

Implement selinux_memcg_charge_task() using avc_has_perm() from
the process2 object class and a new charge_to permission. Policy
authors can then grant cross-cgroup charging selectively,
for example:

  allow allocator_app_t client_app_t:process2 charge_to;

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 security/selinux/hooks.c            | 7 +++++++
 security/selinux/include/classmap.h | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6168dd5f91c2..70de6094b2b4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2204,6 +2204,12 @@ static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
 	return cred_has_capability(cred, cap, opts, ns == &init_user_ns);
 }
 
+static int selinux_memcg_charge_task(const struct cred *from, const struct cred *to)
+{
+	return avc_has_perm(cred_sid(from), cred_sid(to),
+			    SECCLASS_PROCESS2, PROCESS2__CHARGE_TO, NULL);
+}
+
 static int selinux_quotactl(int cmds, int type, int id, const struct super_block *sb)
 {
 	const struct cred *cred = current_cred();
@@ -7681,6 +7687,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capget, selinux_capget),
 	LSM_HOOK_INIT(capset, selinux_capset),
 	LSM_HOOK_INIT(capable, selinux_capable),
+	LSM_HOOK_INIT(memcg_charge_task, selinux_memcg_charge_task),
 	LSM_HOOK_INIT(quotactl, selinux_quotactl),
 	LSM_HOOK_INIT(quota_on, selinux_quota_on),
 	LSM_HOOK_INIT(syslog, selinux_syslog),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 90cb61b16425..4004c05aae5b 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -60,7 +60,7 @@ const struct security_class_mapping secclass_map[] = {
 	    "siginh",	    "setrlimit",     "rlimitinh",   "dyntransition",
 	    "setcurrent",   "execmem",	     "execstack",   "execheap",
 	    "setkeycreate", "setsockcreate", "getrlimit",   NULL } },
-	{ "process2", { "nnp_transition", "nosuid_transition", NULL } },
+	{ "process2", { "nnp_transition", "nosuid_transition", "charge_to", NULL } },
 	{ "system",
 	  { "ipc_info", "syslog_read", "syslog_mod", "syslog_console",
 	    "module_request", "module_load", "firmware_load",

-- 
2.55.0

