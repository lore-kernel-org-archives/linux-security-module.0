Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4E7423A6C;
	Wed, 29 Apr 2026 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490093; cv=none; b=o/22J8GkIoOYSG+k/BNhnDCj7lk0NjFFTxn7OEqewUJjAj9CY5M6+n2UWrAeYdnuq4MzF9X0aqdqoCZnOM58hmg6JY2NY3KB1pnXZ94Nx606/JuDLNc8SDnQy6cALrcrkLv3kq9qtbsSZZMnrsdNyA+l3NNzMIzYavgA8nDu3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490093; c=relaxed/simple;
	bh=0zA1iY10OAejTHGLKVAyct5fV1I29qtDkgUyjhfh6VI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2D9FwJG+U69KzduIVsaaCmqWht08cXuNTtkGM1oLJx9gHQxjtUs+hDLHxdMdNe2sKtpXULsfyOeQ2bDeWu3Zukx2r0ZnaS3WzU1/vWOhzOL2AJPxZqQ2P9xmnj2grZUsPO6ulYubi7RkBAs0vQifm+bn3cWm4Jd/iGMmnL849o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b2TtEl3b; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b2TtEl3b"
Received: from narnia.corp.microsoft.com (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id 833C220B7171;
	Wed, 29 Apr 2026 12:14:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 833C220B7171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777490092;
	bh=D1OsiZIRk5fwjHT2yiYyh62NPa6JsLWz8+CUIzDsvys=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=b2TtEl3bH5vjZaQNwf9krRt0LAXENctaMhLgdCANtQsIDHWTXAAusOnR5zsYmqo70
	 pYU0EOe38r7mpmGwzagg/J7guWIK4fQjlILPVdOj/s1FwG1r9VpZ5hYfKzlmbFdbZh
	 FyDsstJzUS4HNNAEl0J2X/woKBuudiNr7iBuoUVY=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Paul Moore" <paul@paul-moore.com>,
	"James Morris" <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	"Fan Wu" <wufan@kernel.org>,
	"Ryan Foster" <foster.ryan.r@gmail.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	"Song Liu" <song@kernel.org>
Subject: [v6 05/10] lsm: security: Add additional enum values for bpf integrity checks
Date: Wed, 29 Apr 2026 12:14:10 -0700
Message-ID: <20260429191431.2345448-6-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429191431.2345448-1-bboscaccy@linux.microsoft.com>
References: <20260429191431.2345448-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First add a generic LSM_INT_VERDICT_FAULT value to indicate a system
failure during checking. Second, add a LSM_INT_VERDICT_UNKNOWNKEY to
signal that the payload was signed with a key other than one that
exists in the secondary keyring. And finally add an
LSM_INT_VERDICT_UNEXPECTED enum value to indicate that a unexpected
hash value was encountered at some stage of verification.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 include/linux/security.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index b3fd04baa78d0..4b4b8808f67de 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -106,6 +106,9 @@ enum lsm_integrity_verdict {
 	LSM_INT_VERDICT_OK,
 	LSM_INT_VERDICT_UNSIGNED,
 	LSM_INT_VERDICT_PARTIALSIG,
+	LSM_INT_VERDICT_UNKNOWNKEY,
+	LSM_INT_VERDICT_UNEXPECTED,
+	LSM_INT_VERDICT_FAULT,
 	LSM_INT_VERDICT_BADSIG,
 };
 
-- 
2.53.0

