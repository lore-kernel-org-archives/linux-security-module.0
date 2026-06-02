Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C54370AF4
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431827; cv=none; b=UDCIZH6MjKibpUXXLJ7h4SHo3GQPxLhLTpNLEu2DojWLbwUnjusxevdamXjlEYxK8Y8ZceYj9Z+cux/3ZRGGNHCqBFiW16gBYydJVq3ocCdJ5dH4hOb2DAOtEb2b3Mn+o1vKx8Qn/RLKwmMxd+bVubbkl+mdpUqGV7tlASguB58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431827; c=relaxed/simple;
	bh=sHFyULwZNsjkICTcacjijepSG1/nng1valQhDnqPrvg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGW2alxz5M9MZ/laE+ecBo9RxIcv/z2UvuqpCQtQrMhPVaN8tLmENb84dILDbes3x5I56C5FDtsKRnR4XcuafE1dsrceK8RyTmL3mmQiFxcUvTUr3+AN6vMyuzUsbJ+GRwqjD16GYRq6f5vaOcCt5uTqkSyeWtEAQBVxwjyB6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nqr1TaRG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nqr1TaRG"
Received: from narnia.corp.microsoft.com (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id C562820B7167;
	Tue,  2 Jun 2026 13:23:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C562820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780431812;
	bh=0RcYQNJVp9Li593GWYq7q1yjZJvdiltBYRQle48wcsY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nqr1TaRGDPn6IHHDrA8b7v/O5N88MIIfoWqJeOcCFvD10DIIBw/g3hlRPSDCUysD/
	 LyM5+zAGEnF57tk0PpgYWib5bEUgrUxVIHcDAbb71+zoy0C/JbrNN0FXLBNthvlrlv
	 rF2nbq2bZPWAm2tQaZNYwCS5I8G/+xM/yhgP1s/0=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: "Paul Moore" <paul@paul-moore.com>,
	"Fan Wu" <wufan@kernel.org>,
	"Blaise Boscaccy" <bboscaccy@linux.microsoft.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 3/3] hornet: update signing workflow documentation
Date: Tue,  2 Jun 2026 13:23:22 -0700
Message-ID: <20260602202336.3579863-4-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602202336.3579863-1-bboscaccy@linux.microsoft.com>
References: <20260602202336.3579863-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit cf5d6b993a43 ("hornet: fix TOCTOU in signed program
verification") map indices are no longer passed into gen_sig. Fix the
lingering documentation reference.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 Documentation/admin-guide/LSM/Hornet.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/LSM/Hornet.rst b/Documentation/admin-guide/LSM/Hornet.rst
index 13dcf686ead71..6551134d8fd59 100644
--- a/Documentation/admin-guide/LSM/Hornet.rst
+++ b/Documentation/admin-guide/LSM/Hornet.rst
@@ -290,7 +290,7 @@ A typical workflow for building and signing an eBPF light skeleton is:
        --key signing_key.pem \
        --cert signing_key.x509 \
        --data insn.bin \
-       --add map.bin:0 \
+       --add map.bin \
        --out sig.bin
 
 5. **Embed the signature** back into the header::
-- 
2.53.0

