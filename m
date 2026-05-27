Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1CC3D7D86
	for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779906105; cv=none; b=PVYHotxhvKyt/f8RdQ27aw+58zLxDV+mf8yY2nna+eIZY1k5DSW9Z2O9w2wMEbFpCNqG2by/Koc3rqO/lxyxaKHeBYOl8geCIwNYzUhP0ezdD+xEUOCQsHaKhtgOFN6Ebaa7G3ZmRsuxSl6V6rPVChKYiFgVz/rXHJ3NB7ETH5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779906105; c=relaxed/simple;
	bh=8rS+DukaTqLN04TBmGEZh3uakWhBLyLIYCDNGld4Z6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBouCxSujW5whoxzMnTKov7rah1MAKULO5FwgO9ryHY2obmBdFzBUH/BR3jKSFXp4ek23jxjq3NI1HLcHgjRo0nbAtHp9npT2pcfxfWo9XZpWJI16sUCbjd7eoamGW5y2QgX9CpNspnZtnZBv8/O7v+7Cifz9uqDvmdeCovif4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nuWI4pWG; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nuWI4pWG"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gQd406BthzWBT;
	Wed, 27 May 2026 20:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779905504;
	bh=RXNG/+pVLjgNee0AIS52LpFThIZUiLGGamx5FlG4tcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nuWI4pWGXMbah+3vhzGJho8miPF0ttF1UnBvHI/ehFySaWMxLLgFL3GAfpZibeEH0
	 I0zgbv+0NSN9MxwikMgBeCiQFy+6SwTbXX744YqbNxIXXo/cQNgg0dhQB49bgwr17s
	 bz1b46brqT7CPe9J4MK7qaCHo82I0sN+RD6YkDgc=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gQd400WQNzlgG;
	Wed, 27 May 2026 20:11:44 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Daniel Durning <danieldurning.work@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/9] security: Add LSM_AUDIT_DATA_NS for namespace audit records
Date: Wed, 27 May 2026 20:11:15 +0200
Message-ID: <20260527181127.879771-3-mic@digikod.net>
In-Reply-To: <20260527181127.879771-1-mic@digikod.net>
References: <20260527181127.879771-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add a new LSM audit data type LSM_AUDIT_DATA_NS that logs namespace
information in audit records.  Two fields are provided:

- ns_type: the CLONE_NEW* flag identifying the namespace type, logged
  in hexadecimal.

- ns_id: the unique 64-bit namespace identifier, retrievable from
  userspace via NS_GET_ID or listns(2).  Unlike the proc inode number
  (inum), ns_id is never recycled.  For namespace creation denials,
  ns_id is 0 because the namespace does not exist yet.

A new audit data type is needed because no existing LSM_AUDIT_DATA_*
type carries namespace information.  The closest alternatives (e.g.
LSM_AUDIT_DATA_TASK or LSM_AUDIT_DATA_NONE with custom strings) would
either lose the namespace type or require ad-hoc formatting that
bypasses the structured audit data union.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://lore.kernel.org/r/20260312100444.2609563-3-mic@digikod.net
- Replace inum with ns_id in the audit record: ns_id is the stable
  64-bit namespace identifier (never recycled), accessible to
  userspace via NS_GET_ID and listns(2) (suggested by Christian
  Brauner).
- Add Reviewed-by: Christian Brauner.
- Add Reviewed-by: Günther Noack.
---
 include/linux/lsm_audit.h | 5 +++++
 security/lsm_audit.c      | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 584db296e43b..526a8e7471c8 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -78,6 +78,7 @@ struct common_audit_data {
 #define LSM_AUDIT_DATA_NOTIFICATION 16
 #define LSM_AUDIT_DATA_ANONINODE	17
 #define LSM_AUDIT_DATA_NLMSGTYPE	18
+#define LSM_AUDIT_DATA_NS		19
 	union 	{
 		struct path path;
 		struct dentry *dentry;
@@ -100,6 +101,10 @@ struct common_audit_data {
 		int reason;
 		const char *anonclass;
 		u16 nlmsg_type;
+		struct {
+			u32 ns_type;
+			u64 ns_id;
+		} ns;
 	} u;
 	/* this union contains LSM specific data */
 	union {
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 737f5a263a8f..404ccbbbf94c 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -403,6 +403,10 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 	case LSM_AUDIT_DATA_NLMSGTYPE:
 		audit_log_format(ab, " nl-msgtype=%hu", a->u.nlmsg_type);
 		break;
+	case LSM_AUDIT_DATA_NS:
+		audit_log_format(ab, " namespace_type=0x%x namespace_id=%llu",
+				 a->u.ns.ns_type, a->u.ns.ns_id);
+		break;
 	} /* switch (a->type) */
 }
 
-- 
2.54.0

