Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2FC1DC9A7
	for <linux-security-module@vger.kernel.org>; Wed, 19 Feb 2025 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981699; cv=none; b=Zkhn5ur9l+g4fA06pkchiVaD4vtCBT6Sn5580h7vOEfkkQhZ0Y8ds/B96/GYTTbIsE1TvfFzGX+gCgV5bcsiQ/hGcKBJrMFfGq+3uZlDbMLDvV3ATnoyuK/iowfDnPBDkZPXkz8IUUaP/TUoSi3/M8+qDGjRuiUjqMDIEMm7Bx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981699; c=relaxed/simple;
	bh=BydXj2d1wp0pcKWu35dDfMG3nLQTkfZH/OgCQu++sK8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XKBXKliEU+UCxOilgXYXz2aA4pUCHs27PtaxNJjDRDjMA6c80pa8oNegVMv+AqEV7OLrQ4l+yEHXZVJCFEvaqqitjFEK2sNhI8Ct9dfnvqKODxnLaBCk4/dwsoN7LLx2qS9ujWQS8q7FThlPSMafcMqg4VK4qkB92HHuNyxlOEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMfiZxSi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMfiZxSi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739981696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=tSeDNWgGZSmT9QMIfeqqrndMXQ69jdFLbo5e2ZUiTVs=;
	b=fMfiZxSikapMqy6SYBPG5ommAY2g16PnyiDMFrjTwpsV0PW5e5xtkao3+nwMFmwYL/UYUw
	hMvxNEa0w5pnkXXXmKYhbL9J0y7OE6VRprXL3L/kUotDPwjKdqEjKXpa8koEuAxkSnanMu
	37PghEjDRF6q/qDL19i9ZtOqkYBRFZs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-XWIhTvYmMxCtf7_1bTaH-A-1; Wed,
 19 Feb 2025 11:14:51 -0500
X-MC-Unique: XWIhTvYmMxCtf7_1bTaH-A-1
X-Mimecast-MFC-AGG-ID: XWIhTvYmMxCtf7_1bTaH-A_1739981690
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91D8818EB2C6;
	Wed, 19 Feb 2025 16:14:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.102])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BADC1300019F;
	Wed, 19 Feb 2025 16:14:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Feb 2025 17:14:22 +0100 (CET)
Date: Wed, 19 Feb 2025 17:14:17 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] yama: don't abuse rcu_read_lock/get_task_struct in
 yama_task_prctl()
Message-ID: <20250219161417.GA20851@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

current->group_leader is stable, no need to take rcu_read_lock() and do
get/put_task_struct().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 security/yama/yama_lsm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 1971710620c1..3d064dd4e03f 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -222,7 +222,7 @@ static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			   unsigned long arg4, unsigned long arg5)
 {
 	int rc = -ENOSYS;
-	struct task_struct *myself = current;
+	struct task_struct *myself;
 
 	switch (option) {
 	case PR_SET_PTRACER:
@@ -232,11 +232,7 @@ static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 		 * leader checking is handled later when walking the ancestry
 		 * at the time of PTRACE_ATTACH check.
 		 */
-		rcu_read_lock();
-		if (!thread_group_leader(myself))
-			myself = rcu_dereference(myself->group_leader);
-		get_task_struct(myself);
-		rcu_read_unlock();
+		myself = current->group_leader;
 
 		if (arg2 == 0) {
 			yama_ptracer_del(NULL, myself);
@@ -255,7 +251,6 @@ static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			}
 		}
 
-		put_task_struct(myself);
 		break;
 	}
 
-- 
2.25.1.362.g51ebf55


