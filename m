Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4C38E5EA;
	Thu, 26 Feb 2026 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772090427; cv=none; b=D4dYD8bf/25lpYkdQV04MGi2IJfBK9fvLp8xfVr88iNu/PYMnuDGv9Z/CFIRnlnBodn9LtACfRR55hMzSvySh68S4HeJAma8Sv8kPVmsM+fdj7dPhxtRKWNxiHTRyziBMrnRf4rk9KwE5qSJ1HXhdVf9zyilJT0LmewLOWMIYsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772090427; c=relaxed/simple;
	bh=hGVXNH283Vz12qyYtbmn+Cp6jluvfJ2jA9ujNd1m+MM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mo5qFqMFnBhru8mhkt5ZixjN5oYKvAzQeXQ1ELrVIis9qTFoLigXDAZYLJyAm+PGWbBfkkz9i4DFKwIpf3sl0orkdu32vTtpbaaLr9Tv7PnwEi+NPlwmTNLCSYE2Pm3OeC6rbxzoD+PTf/iEszu4VEXGdaLf3rwt8gpzluv1NSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ok3Ub7un; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ok3Ub7un"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772090423;
	bh=hGVXNH283Vz12qyYtbmn+Cp6jluvfJ2jA9ujNd1m+MM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ok3Ub7un4nVRc77yXyUtPQlm2mrep2h8nZA/ZGeNPePQ8CkRmwLhbw8s0BAds4Z0u
	 zbj26mSFuo/d5TWj0IpyP36rn8f5eGiKZj7eeEVlggl7H7l6qqN818GO8nzoYSIyoO
	 XDKg10Du5Q9bCVEAd/ctQ9crDqMrB09PO5TuYijg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 26 Feb 2026 08:20:13 +0100
Subject: [PATCH 2/2] powerpc/ima: Drop unnecessary check for
 CONFIG_MODULE_SIG
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260226-ima-ifdef-v1-2-8b9613edbbdb@weissschuh.net>
References: <20260226-ima-ifdef-v1-0-8b9613edbbdb@weissschuh.net>
In-Reply-To: <20260226-ima-ifdef-v1-0-8b9613edbbdb@weissschuh.net>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Aaron Tomlin <atomlin@atomlin.com>, Nicolas Schier <nsc@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772090423; l=974;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hGVXNH283Vz12qyYtbmn+Cp6jluvfJ2jA9ujNd1m+MM=;
 b=G/Yhhszig1FESswrq2MsfL5TAZFn0WCOohRmn3HPMOhnbyqu9YUz3c9FlB4SOit5T+vJ4YC8I
 t1lqaIGPIDPBZFHzXvicJ/TgrCUa8y5xYNyWNbicaLYV8WsOpPoTa9J
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

When CONFIG_MODULE_SIG is disabled set_module_sig_enforced() is defined
as an empty stub, so the check is unnecessary.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
---
 arch/powerpc/kernel/ima_arch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
index b7029beed847..690263bf4265 100644
--- a/arch/powerpc/kernel/ima_arch.c
+++ b/arch/powerpc/kernel/ima_arch.c
@@ -63,8 +63,7 @@ static const char *const secure_and_trusted_rules[] = {
 const char *const *arch_get_ima_policy(void)
 {
 	if (is_ppc_secureboot_enabled()) {
-		if (IS_ENABLED(CONFIG_MODULE_SIG))
-			set_module_sig_enforced();
+		set_module_sig_enforced();
 
 		if (is_ppc_trustedboot_enabled())
 			return secure_and_trusted_rules;

-- 
2.53.0

