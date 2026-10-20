Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504837;
	b=A/TIYcWEtF3p80t5qn1UP15jTWE2Hr5xEbdSiUpf+UmYIR3aUgiLGr20InMwWhZof+DX
	 Ewr3g3QxAkwzE/n4BfIrqUVwjxt1yktK9+UfATd6qqTChDU0C0a06eQthpoeDA6yNCdrB
	 Y9xK69Q7AJ/1ivo717vgErG3wjkqk0VMqZPSme/iZkKqVCFP//0sXfNrnNgUtxWsqQtPQ
	 A346xFueREYT4ccgJ32GHw7gg0xfMKKeQPvuHyZVpr5teG/qfJj6h//ZHE7syOT+zI/XG
	 KENT0D8TzD1BJqBWnvPn6lXepyfqnseMRqMYZqG774iMJn3TZAOf+KpnP1iEqjbjgPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pvvWiB/HIs4H59vNoAsA0sD6AI7vR7sZ6M7N6d5Xgws=;
	b=ipnTYNw6lpAKYt2e/rH3hpZNhWtUwzDvLXAdylenidlNmRLJKXpxkqTc9AGfA0AUqBGV
	 Tdi/uNlV7Pz7g6zs5OOOBT7CJbEEmYPKNIEoc3pzLJlUEXNOoNiNj3vBr2qjCjR1MdiZ6
	 ZLg13RRCtgk6wSfF+4VwVSJ3Z0esL7i7jT4YO2zyifMZ50ijuAOH5WhkrDfQ3NhSuexll
	 UJNmzaMReYe14r0ZxyuWg/zAvjkVkpy0W6TzYi27HYeReTsk9MuLLQ4X/j37cETaYNwuj
	 t+XEp/MetYbV1ZtmdfGDwTs1mHpTGHA4xczMNTndcVYUZF6gFhgELblrA3bySyz64tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=spStT64T;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A3060A263B
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 14:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90A3060A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=spStT64T
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so4496174a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504835; x=1793109635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pvvWiB/HIs4H59vNoAsA0sD6AI7vR7sZ6M7N6d5Xgws=;
        b=spStT64TSdX9HNwicqMbVM8oRQSavile+EArNF1PJmJM5guZBb5z331MenwaNSGI+h
         Fwx00CGIghbLZ2Kms8oTkCLDQ3G+djkxMGWX1MIbd0ftStBUZaSZQg9rYNYvPmCON4lD
         P9A3oyDZEdeZ/QozuU13RBOh9zXUP8EVrTVnnLrjSV7KyXKpHkb2qqLLC1n/D4zCaqC3
         mY72cQZ2Ll96uqONMO3UEiZawQ4Kdg1JgraQt0Gpd0mdJJnDE/RNrRTSy/aRokPc56Rh
         mcU7nvVCV8BHtum4PuVWw+ANTq5p5e09x9l0PMv7+dLYfHNJ9Zn95sV9a9F9ZfSRm+ns
         d8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504835; x=1793109635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pvvWiB/HIs4H59vNoAsA0sD6AI7vR7sZ6M7N6d5Xgws=;
        b=0HCMed3gbOgC62cx3VRmGobKnCEnOdWM7tRWWk/3ohO4g1YWWH6673OuYDcrx1KGSy
         P8M8MzNIqkalYMiuK0Hge9yeGnqi/WSGjr0RG28X3RIaWVAdiJ3bJJtY/U5IWLGI8qRI
         jpxSgLdhefYSS3TrijYAI4skxTwspFkHXl8suRWrgPbChDRxm6GG9pMFWuFpGdB3H15y
         CAh3lvAvbPGToL3gKVqiHGla2J4+h7AWG+YTeY6pvhL5wGW9Cu7r4zTk6WAELPdeeduy
         KcdJAXyLPdxP3w/UzTpV1AVT7gfLExn4Sr/kC+CX5CCFQKhVADGd1nTYyPuf7QAE1AVH
         GPIQ==
X-Forwarded-Encrypted: i=1; AKwUvByQ39L6jn8uV6i5Y8QdXdRDWPFKz0mhYIxevWB8sSwL0CMyPUJ4xnEuDcdPOORgHHjlYnHKFTvBJGjTftJoxj4HVF/2nKc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhD33k9bYxYj4BaP+1YPALBPN7k9DaOcqPseRToQ1wi7uuPfCs
	59IdU9JAGU6xTPBCFJY2oETinLlsTpjob4WzJmPPoTS5UdyjkiPWUe/B
X-Gm-Gg: AYBFou2Qnjl7TjLcGBBosgpY217AzzjA4zNYbM5wU/Q7QcHvr5oLF00VDu6UqPKJDNc
	8ViOlNrmfG46EoW7j7jfJyJcc1NsyKDeF9mnoMTYAHrk4P7OGn5lPFGyfUrP9QGaUjmPwt8jQWA
	ldF1OYfGHw+HN8I02FRMzPF5r5UmgQ7CTx5DMFloh5ipyEraULiPTfG8UaYNb2IxmljW9wTXWXu
	UVHXyGAR/9HE44gDMM227cfLRHwUu/X8hNun74LyvM9uV0dEmb3Fcu7jrYfOeZ54Ux8EVA+C6Lk
	7qWlEmvDy78/TeTA3cEd8lJbLdgalpUJDrICPy2O6scYA/y2c74VtEsaoy++CGYMNLxjTt9lgcg
	Z3jYRVPTcK5FTpHIJ3fEKeQL/pIYVotomnhesK09YpsiejSFJYwPi3D6UHHFN3HsfB3FGxc3SVb
	+JmIM9tLwv58bWr/6PN5JfZhi4XkENh93xGR8Bc6qOaLuTIS9E2uz/kRrBLp/kKwrKa8kE5dmSr
	51P66Gr2GGrnEGkT4y4dncwW7nFNyUCBV6wWqw3aVKd/02VtKldXFCos5H7PgolDcfdqR+f2gIO
	T2qXl5EeO6xUFU/0dYO0CequGQ+r6ZcsoRoqhUpgyxs=
X-Received: by 2002:a05:6402:249c:b0:6b3:bca6:b480 with SMTP id 4fb4d7f45d1cf-6b3bca6bacfmr6223968a12.44.1792504834506;
        Tue, 20 Oct 2026 07:00:34 -0700 (PDT)
Received: from Martyna-s-A34.localdomain (ip-80-113-116-3.ip.prioritytelecom.net. [80.113.116.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1c6364sm5431458a12.14.2026.10.20.07.00.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 07:00:34 -0700 (PDT)
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] apparmor: check address length before reading AF_UNSPEC bind address
Date: Tue, 20 Oct 2026 16:00:30 +0200
Message-ID: <20261020140030.92643-1-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bind_map_addr() handles AF_UNSPEC on an IPv4 socket by reading
addr4->sin_addr.s_addr to check for INADDR_ANY. At that point the only
length check done is addrlen >= offsetofend(struct sockaddr, sa_family),
i.e. 2 bytes, while sin_addr sits at offset 4. move_addr_to_kernel()
copies only addrlen bytes into the on-stack sockaddr_storage, so a
bind() with a short AF_UNSPEC address makes AppArmor branch on bytes the
caller never supplied.

Depending on those bytes, a confined task gets -EAFNOSUPPORT instead of
the -EINVAL that inet_bind_sk() returns for the same request. Kernels
built with CONFIG_INIT_STACK_ALL_ZERO read zeroes and happen to behave
correctly.

Check the length first, as inet_bind_sk() does, and as the AF_INET6
case above already does for inet6_bind_sk().

Fixes: 89ac6aa752ec ("apparmor: push inet mediation into profile callbacks, and improve auditing")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
Tested on v7.3 built with CONFIG_INIT_STACK_NONE in QEMU, with a task
confined by a profile allowing all network access, calling bind() on an
AF_INET UDP socket with {.sa_family = AF_UNSPEC} and addrlen 2 and 4
(200 times each, after leaving a non-zero address in the kernel buffer):
unpatched returns -EAFNOSUPPORT every time, patched returns -EINVAL
every time, matching unconfined tasks. Other AF_UNSPEC, AF_INET and
AF_INET6 bind cases behave identically with and without the patch.
---
 security/apparmor/af_inet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/apparmor/af_inet.c b/security/apparmor/af_inet.c
index 516c9016537c..a617f8058634 100644
--- a/security/apparmor/af_inet.c
+++ b/security/apparmor/af_inet.c
@@ -196,6 +196,9 @@ static int bind_map_addr(const struct sock *sk, struct sockaddr *addr,
 		 * AF_UNSPEC if the address is INADDR_ANY
 		 */
 		addr4 = (struct sockaddr_in *)addr;
+		/* Length check from inet_bind_sk() */
+		if (addrlen < sizeof(struct sockaddr_in))
+			return -EINVAL;
 		if (addr4->sin_addr.s_addr != htonl(INADDR_ANY))
 			return -EAFNOSUPPORT;
 		family = AF_INET;
-- 
2.56.0

