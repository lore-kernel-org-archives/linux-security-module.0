Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF16F2D5414;
	Tue, 24 Jun 2025 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776553; cv=none; b=tXjQXV/r78Xv935tIeBhPx8RWsLDGLI5oYYy8UB9XI5yqTh06QX5EziRDLYzPylqaOkDg+t98WLmF3PVZVx9Pns4PHhu1cW/tSG+vbAmSzlgpOp3lcrad3IRq3A04mG9Ot9q19djpll5XkSiZ64HP4lqj7CwQWK65LnpY+yW60g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776553; c=relaxed/simple;
	bh=XSmcinKea+soXlmgc6EymGPV4s+49fMw/x6yfEf4UpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fzgvUeuaBnqYRpRfUFAoDaZvjuA3bQHmvVnj0GWj5p+gk+j7J+EALt0uxdb3jlF5Q+NY7Y2gkTdkDd3/D2+aJj54yMWADzluVmSsKjHjuvvTt3MVFmgLEJfqwYcMwJLo01nZS4ubxLznCNjp+HR6ZBHOfT8d9A2TgtA8TXkQGqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=OHgi/w9Y; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="OHgi/w9Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hwtEdFGTH8iYwyCWvuA+AVH/7v/hzPHDC9TpX58Pza0=; b=OHgi/w9YOXcZd89Cx/zcRzQLVv
	Cn7qs+Yz+57TJ1Eaufap0yB+s5cEQVR27CI5IMMXlDzrqR2WhXc27tuehnmLSqunCSxsom0MiIkHD
	l2QUyA3UofBzRcAGe0pfBMtDV4mhX5h0+okvF6qC+BgsqrAVCJGl/1jYty/qjFvONOw1j3tA1Ij3e
	6Rpx74fTqrDnBhwmzZf4tF0gJHTLu/YeWAfWPBRUGA8EoDBCnT2Nr15YK0um2E5ZysPPqnXtsWB+0
	6A9dl4u25mtOpOrxRRW9HyNB7ew0bnH0CYzORNcgeWa0KBkKKgSL2+tHq5VuZn5kGbtfdHqio8FUM
	m+3GsiZw==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:36435 helo=[10.224.8.110])
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1uU4xL-00000008LEa-2tuI;
	Tue, 24 Jun 2025 16:49:03 +0200
From: nicolas.bouchinet@oss.cyber.gouv.fr
Date: Tue, 24 Jun 2025 16:48:51 +0200
Subject: [PATCH] MAINTAINERS: Add Xiu and myself as Lockdown maintainers
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-add_myself_to_lockdown_maintainers-v1-1-bed2bc934666@ssi.gouv.fr>
X-B4-Tracking: v=1; b=H4sIANK6WmgC/x2NzQqDMBAGX0X23IAGf2hfRUqI5otdqolkpVXEd
 2/oYQ5zmTlJkBhCj+KkhA8Lx5CluhU0vmyYoNhlJ13qpmx1raxzZjkEszdbNHMc3y5+g1kshy2
 DJAptM9Rd5TH4O+XQmuB5/0/653X9ALFWoA50AAAA
X-Change-ID: 20250624-add_myself_to_lockdown_maintainers-e65b471febf9
To: Paul Moore <paul@paul-moore.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
X-Mailer: b4 0.14.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

The Lockdown LSM has been unmaintained for some time now. It requires
some work to ensure it works as intended.

Xiu Jianfeng and I volunteer to maintain the LSM.

Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c1d245bf7b84f8a78b811e0c9c5a3edc09edc22..776c7fffcaec08f71faf2740599f0b4570179832 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14060,8 +14060,10 @@ F:	Documentation/admin-guide/LSM/LoadPin.rst
 F:	security/loadpin/
 
 LOCKDOWN SECURITY MODULE
+M:	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
+M:	Xiu Jianfeng <xiujianfeng@huawei.com>
 L:	linux-security-module@vger.kernel.org
-S:	Odd Fixes
+S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
 F:	security/lockdown/
 

---
base-commit: 9fc86a85f36c51dd9e628c82091326151c8ff638
change-id: 20250624-add_myself_to_lockdown_maintainers-e65b471febf9

Best regards,
-- 
Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

