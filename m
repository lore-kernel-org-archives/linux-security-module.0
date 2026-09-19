Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164A325DB12
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789822890; cv=none; b=RRD90fwJpGgE9QhC/TbarInWrJF7fn1chRksAPVA8OCQtWwbD7k6i2DYr9tmEk0f5veB+R3u3QANiJns2HBgjMoMlaISxcPV5waJhSN3dfzWPoCNcVGcautyJSD04rgSUoYZbXR0WoMv0nwCUS8nYmMeGJ0sKcHTvyIcMjqSyaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789822890; c=relaxed/simple;
	bh=V0eWpBQvz/Ry/xCDmYcBD7H2SMVvdq/tWHa0j3num7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fN9SlwGQ79X+ze1F5twDWCxADm486wM1ofPGrzMd/g3sO7F1J+dhWYc65FU1PpWqfW1QEzFi9ea0kPAEfxJFFN0VbF+AF+QDO/Sv+g677fSRhAJ1cQO6SY30spV1oxXgGFIQkAYREdvFAwKfv/s22iMXaMsbEMxV3h24hHQ7J8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQyEenI5; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQyEenI5"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c7bd056863so746421e0c.0
        for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 06:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789822888; x=1790427688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bsaC+AjRRGatXzF0gESEkY1s/Ci/jXJoxJDjBn+GCG0=;
        b=pQyEenI5EkCApmnuxmpQdpOz5NOAIrjPoVpV8J5/NQ1nJybcx48Q8avzjo2p/t+hZA
         KsfgroSlYtIMBCJlIN2kh94zP356LJYLLASsK/dwjBdYroy/HrOZ/RQUG5+qDAvd/tb5
         b/51KbUrxU8ttKKQXWwUJpy4V+gUZakdhIDe4TbIa/mgaHy8kAZ59Q9ka0VsPbaUsPXQ
         Lxg6LXHfIPHZOvoaVMpH5hMLdOjNja5DHp9XvIENb3L3JSTMWTbyprKZWZf1ofvGEEXE
         +3s2i2DoxcNCo+re7JfOH6DSpULiSI4qc1qKg2CDrvJY9eEdopazItvSKWR2sZQu08ap
         UwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789822888; x=1790427688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bsaC+AjRRGatXzF0gESEkY1s/Ci/jXJoxJDjBn+GCG0=;
        b=oOnTm2zlVIj03511ZMz53yLEGvh0lWVl8O0ESSb3+gssge/yyAJblLlX/sIlB+TrI2
         pYa6WiXNe8aNZ928V3iwcKEvFRD5swvBP4tJq9e/yEK3D1Uo15UDUp+FfJoto+4RL62t
         SJaTfvple3MMn6XT0ilkARQazYaC5QRH2UfxYomoLPBbsUTdMFAHncpdz38FHohs0SsK
         MJ6oPhVDmNvJ6Cw9j8a/FAG3z5CUbKwRnUhCHew0ZA0aHrrHm0JdG49VIYG8kRtK2MYH
         z2GZGKlarl9Z5Knqb/VRRU993qcSCkk4Ez5HF9pDxpPdzh4O0AX4rasSVXUs3kZsGC3T
         liZQ==
X-Forwarded-Encrypted: i=1; AKwUvBztc7DFQv4ZJpQXIPZJCMpg0ooMHIAfoiY0FuCjSV3l3yzI0xnOSSseknsYobYqAIbyD/z8yGWsS4QgOEqrN8vmEMWAzEQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lGB+SsIFBRgKz+Su3Py8u04n13fzqLO9PFl5FFIgRe1vhEYCi2
	+X+9sfyXIehmBYtKGzEZ50dYgc5gdb9IDSCz9dbDuNSDYUgFak8pVNuS
X-Gm-Gg: AYBFou3kdRZZH+O3fdDcQPIieP4RrsTjD6NKUDycW9fLs0xrrINpnBhf1waM/78fAjI
	hB3tG0LbPLE4WVYtEN+4iITLuFMUoXEI7oX88rj5bO+TkHuEOV8gRSE0I/yk7HE3Fw/sFqEAf5/
	Z4n99DfUZjNro7OjfGNF8c59TT4Q7/azhXEK7nFxixTPRqsiDNJKgRkgHU7QlKZ/TgdClWciagQ
	vHmvm2Mm1xNgFwtRVxrUQ+2FEFJj52x2E4iaq6ilZIgHdnlHxkHCxGQyIXbRwSztZwdllTkn2PW
	uPUYsBEoDMnm2/Za2svTWoPBR9zUwx8wXsTV/wpTzr3ek0MBVGG8wKqVj/dgLBMHOrKUphT09Zk
	s5Hh2jYCrxl3Y61xk27uUx4Y1mBQZK136Pj6N57oC+Vt174cOQ8bfq8RbuKQBar5G3LnrXq82aJ
	ryRZ4Y6l3XjFVG6bJBm1fiAsAeWvnmXGxzybeg/KbNWHSP/cTza1LJNzHEXK0KyLKdZ/DCYiUKd
	Q==
X-Received: by 2002:a05:6122:2908:b0:5c9:a5be:7b50 with SMTP id 71dfb90a1353d-5c9b58fee8emr1631580e0c.7.1789822887773;
        Sat, 19 Sep 2026 06:01:27 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9c19350f6sm2154957e0c.13.2026.09.19.06.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 06:01:26 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Serge Hallyn <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH] security: commoncap: clarify CAP_FS_SET comment in cap_task_fix_setuid()
Date: Sat, 19 Sep 2026 10:01:12 -0300
Message-ID: <20260919130112.849932-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CAP_FS_SET is defined as exactly the capabilities an fsuid of 0
historically granted (see CAP_FS_MASK in include/linux/capability.h),
so dropping it when fsuid leaves 0 is correct by construction, not
"too harsh". Replace the stale FIXME with this explanation.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 security/commoncap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 3399535808fe..e0a2f386c556 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1169,11 +1169,13 @@ int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags)
 		break;
 
 	case LSM_SETID_FS:
-		/* juggle the capabilities to follow FSUID changes, unless
-		 * otherwise suppressed
+		/* Juggle the capabilities to follow FSUID changes, unless
+		 * otherwise suppressed.
 		 *
-		 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
-		 *          if not, we might be a bit too harsh here.
+		 * CAP_FS_SET is exactly the set of capabilities that an
+		 * fsuid of 0 historically granted (see CAP_FS_MASK in
+		 * <linux/capability.h>), so dropping that set when fsuid
+		 * leaves 0 is intentional rather than too harsh.
 		 */
 		if (!issecure(SECURE_NO_SETUID_FIXUP)) {
 			kuid_t root_uid = make_kuid(old->user_ns, 0);
-- 
2.51.0

