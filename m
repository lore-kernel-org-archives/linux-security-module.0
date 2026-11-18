Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020972;
	b=tQkJKENUQyvMfXbOf/nCNZp73aFB3Rlk1VILBFHTgQZvOTl7tkfRh04+do0Dakp7C/fO
	 XycMbgPinq4sON7xnAtoAKE77nShk2jpFQtbb4LDcWisQiDERG6t+dNTZtKO/umeVD392
	 QD6SPAzhR8HJfEJXyYZhf5m8qvZfSVsC/s8VS/V2Afi7LslYFYKsypKLH37b+bbx+cKxf
	 TYAplOSPZjhsN0TPhoxQeB7pbKfhsUQC9Ka80qzkMb4NVRvG2mqNrjHHQVS/WLGoyfna7
	 KjAM5Nk0lCj7JQeh8eiY2iZ/DDXGQdSVfJZhY8W1P4GGek+SuDo8UpDVjNh87rRx4WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020972;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Infomaniak-Routing;
	bh=O6YAJmP0gqZO50UwxwyPa+7/ftNTVgwbYikwwi8PCuM=;
	b=JSo2w8poBQUg+BvLlhf3EZcwuiCmSBoZ05rPgTn8Z2woZ1+akd9/+kVcTnyGPDFo//x7
	 c4Lpcizp7goG4m+rG/0Lx+pPKO6PKTxeQbFcAlnZrltn2KyorsLMawg69jqlo4nht06bV
	 deLQenhDhFh+7/vw5l5auwQcnfEKqi0DPMhaD8v889q09efiNuWR4qTbtf/uD2wAmfYEd
	 cXv7sEgceY9adZFFbs7pvZo7AfQYXFZduYyuyYVH87q2Kp1Mh6Ln2qHAu7Bc618Dfdh7o
	 A3xrXdZtu+2HP0v10JewWAbl1bvw5t82qDTzXfgdnjWsmqtb3IckJdErg4p1fTS0clg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=CbUGgxFi;
	arc=none smtp.remote-ip=185.125.25.14
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34EF606A32F
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 16:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B34EF606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=CbUGgxFi
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jV75z6YCFzrnL;
	Wed, 18 Nov 2026 17:56:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795020967;
	bh=O6YAJmP0gqZO50UwxwyPa+7/ftNTVgwbYikwwi8PCuM=;
	h=From:To:Cc:Subject:Date:From;
	b=CbUGgxFiY7+rQzQJNLgE5bYEcH7YN+48iLkMpezyQpWLV6lBn0n/ySdwZB7e6XLvW
	 G4XFh/Y7h7lMjyiClWBrydExjIxxOdkO8Zlp8R0qhUp8Mb0zrwXwT2MuwNFI72fCZb
	 tpWHtJ//vZLPF1mKCw92Paa/ah9LMONF0BInysUQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jV75y3WHzz6kD;
	Wed, 18 Nov 2026 17:56:06 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Serge Hallyn <sergeh@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	John Johansen <john.johansen@canonical.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	linux-security-module@vger.kernel.org,
	kernel-team@cloudflare.com,
	Serge Hallyn <serge@hallyn.com>
Subject: [PATCH v1] lsm: Set PF_SUPERPRIV only when all mmap_addr hooks allow a mapping
Date: Wed, 18 Nov 2026 17:56:02 +0100
Message-ID: <20261118165603.2573289-1-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

cap_mmap_addr() sets PF_SUPERPRIV when commoncap grants CAP_SYS_RAWIO
for a mapping below vm.mmap_min_addr, before the other LSMs' mmap_addr
hooks run.  If one of them then denies the mapping (e.g. SELinux's
mmap_zero check), process accounting still reports a use of privileges.

Set the flag in security_mmap_addr() once all hooks allowed the mapping,
as ns_capable() does after security_capable().  commoncap runs first and
denies such a mapping without CAP_SYS_RAWIO, so a successful hook chain
means that the capability was used.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Reported-by: Günther Noack <gnoack@google.com>
Closes: https://patch.msgid.link/avxjfHybQBcATFKV@google.com
Fixes: 9c0d90103c7e ("Capabilities: move cap_file_mmap to commoncap.c")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/linux/security.h | 6 +++++-
 security/commoncap.c     | 6 +-----
 security/security.c      | 7 ++++++-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 1e89bc1fec17..faf118b58ade 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1209,7 +1209,11 @@ static inline int security_mmap_backing_file(struct vm_area_struct *vma,
 
 static inline int security_mmap_addr(unsigned long addr)
 {
-	return cap_mmap_addr(addr);
+	int rc = cap_mmap_addr(addr);
+
+	if (!rc && addr < dac_mmap_min_addr)
+		current->flags |= PF_SUPERPRIV;
+	return rc;
 }
 
 static inline int security_file_mprotect(struct vm_area_struct *vma,
diff --git a/security/commoncap.c b/security/commoncap.c
index 9794a594bdd9..36c7b394867d 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1471,13 +1471,9 @@ int cap_mmap_addr(unsigned long addr)
 {
 	int ret = 0;
 
-	if (addr < dac_mmap_min_addr) {
+	if (addr < dac_mmap_min_addr)
 		ret = cap_capable(current_cred(), &init_user_ns, CAP_SYS_RAWIO,
 				  CAP_OPT_NONE);
-		/* set PF_SUPERPRIV if it turns out we allow the low mmap */
-		if (ret == 0)
-			current->flags |= PF_SUPERPRIV;
-	}
 	return ret;
 }
 
diff --git a/security/security.c b/security/security.c
index 36365fac5801..fd6717de31ad 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2687,7 +2687,12 @@ EXPORT_SYMBOL_GPL(security_mmap_backing_file);
  */
 int security_mmap_addr(unsigned long addr)
 {
-	return call_int_hook(mmap_addr, addr);
+	int rc = call_int_hook(mmap_addr, addr);
+
+	/* commoncap granted CAP_SYS_RAWIO and no LSM denied the mapping. */
+	if (!rc && addr < dac_mmap_min_addr)
+		current->flags |= PF_SUPERPRIV;
+	return rc;
 }
 
 /**
-- 
2.56.0

