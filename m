Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820AF146D5A
	for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 02:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959141; cv=none; b=HQ8l+bu6Sr+UI3ePnwG3v+fU7hXGk19hC1nGty1K9uEBY6X0Jwyqr7DB59bG34iyssNLSCc2cmhUcbaa7G8smi81OdWSRCoEPjs9jxxJApAjQXexCmgXBcZryo/MXWfdN4fOm8A8+YY1FXQsM0nmevlfERB8LxYzrflmGvDVfuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959141; c=relaxed/simple;
	bh=uH7eKxt7kWAo1rOgj0dYifOKmGydyRI1l6nx5HpvG8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TiDiLncOPgtgqHv7XPGzE6ZsbKMIesW9+bjLPO77GGLBiVuKM4HHXWVCWCItHNgBak9jv0GvEmbxdoEVLx5sQNY5vJtf7lB8JPtvcZlOcKP9gex1Vf6YolbEIgwxEdrloWL1uMkTKmuErmn6by9RwNhCj80aQJqHO6NTTQ39aK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQwDiX6B; arc=none smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQwDiX6B"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-97e7c62dde2so490016241.2
        for <linux-security-module@vger.kernel.org>; Sun, 20 Sep 2026 19:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789959139; x=1790563939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fylApfWtPHGuyYyrsXRrUYGweIIt0QHbKGqTTf5IA9E=;
        b=OQwDiX6BOkW5hwaKzmCKMZINMNI7n92Hjhdt6ZiDNMEa90LYgFK+HwkktjuZ3JILk/
         Mf2nNQAuArW1WSbYkPdF5aOryEFqib+/IcGuvFTIk3GQGB7ZeDt4RGtpoXpKKzecOzle
         1M4Vb362vLTiAv+iRZhrUy6nU2gYLwwK6W1T4GFPu3GFylpsFP+wyMimi6XnEu1bwYMz
         DGC51J1E9Wi8RSDPRrxho5DMeK+pdJnpt9ffLpXRG7AdEjAU60L8ESJP7og/QIkznup0
         M405xJs17RnjuLS561FRvcT2clA7VEzMwbT66BWWjlZX5uXE0GWlr/vSjujfz6D4y7NO
         d4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789959139; x=1790563939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fylApfWtPHGuyYyrsXRrUYGweIIt0QHbKGqTTf5IA9E=;
        b=2VOonIHFMTL0luwmLn5Vocw2YhSUi4Ym5XVETJHvlIa3ObC9s7VonM35NJJQnPCQCr
         ONsBs1xIzu9aew6bBjrCZrltdD8G5lYn4Fs6vdwOSCQRnA6kmDXwiAio0kkQMiPeO8F0
         eERmgIAk9vjAItf33bElk3losaNQHNQFoi2mRfGdKKgKfccHGRuiXbFZONRBdRcKXE13
         Dr5EL434zJDJzTmaoDZyL+Irbgt3bAyXktgw+Xj1ffOhRS+XyJvowoq7jHu9Qa8hs4Fu
         EWkn+TdM5Ya7kQG0TEuxFqbTpxuIHxJJnygvJ2+w36DePSVTvWMiqaYfW7bwMIgKnWQv
         g2bA==
X-Forwarded-Encrypted: i=1; AKwUvBwMb3zuoXwODiU79Cj/w4KSDPAnCjcjcECUiYmM9pl1J7SYBtcHAP2Q7QcsX5BaeMhfanyHH98eaNm/SZ7Hs/QZOjSyMAA=@vger.kernel.org
X-Gm-Message-State: AFuF++kioEKougG4WfspAlHPzy/sNN753BoqQFUM/DCD8Cgrt4te8YoN
	pwHKJByySl1+1mKOFEZXlzp8BnsVXakQG1P72NzcGzBz7+UZnvrRIeYPAOFpF+70
X-Gm-Gg: AYBFou3NhVztCgnw4oety3gzDwd5iqgegUIu2Eg4oeDFQx35vYlA7j9VkQJLQRPvbDH
	wr5BhqDJmKoQPhlfz7FV00h5eUbJ9IV46XwNqpaEeZzvdljZUz87u2OLmccoRgUXFJh9grZFlgf
	eRhqTcDQgmXqqLehN8zMEq6SIyR8fwBIRFpib0w+THQWzaU51qcboeELIUKCK71s45co82WpFvz
	abmvlnGRwXNHsugPD29RKJ3dT5UxMz5nsJHl8ryo23U2pHJw4tIFB2qRXik1eGjpsD3cL6PHyGG
	fLX7FAkIdb93hoK3LWvU4ipgowY83cqRnsi+wLjLVx4bPP41pgEhSrSd85gLvGRFIPQ4G/ow3iV
	l/K5AGfCmkqvXZ8HijLR4O1j36gyyqy0jhQiGRPqFMj1YpxOLJOhRHwxaH24Q+SBnuv2Vb35KxE
	S1xQH9kPPyWoTrnvIgLn3hK1zKd9D/5g1Ts8sUOE2o8W1CY5ObhWAUXjn+afwSQTg=
X-Received: by 2002:a05:6102:2929:b0:7a7:ad9f:53c6 with SMTP id ada2fe7eead31-7a7ad9f81fbmr1337410137.13.1789959139182;
        Sun, 20 Sep 2026 19:52:19 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a6acafe715sm6809839137.11.2026.09.20.19.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 19:52:18 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Serge Hallyn <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2] security: commoncap: clarify CAP_FS_SET comment in cap_task_fix_setuid()
Date: Sun, 20 Sep 2026 23:52:08 -0300
Message-ID: <20260921025209.1023530-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CAP_FS_SET is exactly the set of capabilities that an fsuid of 0
historically granted (see CAP_FS_MASK in include/linux/capability.h),
so cap_task_fix_setuid() drops that set from the effective set when
fsuid leaves 0.  Replace the stale FIXME with this explanation.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
v2: reword the comment to something more concise.

 security/commoncap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 3399535808fe..1ba2ea2651fc 100644
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
+		 * <linux/capability.h>), so we drop that set when fsuid
+		 * leaves 0.
 		 */
 		if (!issecure(SECURE_NO_SETUID_FIXUP)) {
 			kuid_t root_uid = make_kuid(old->user_ns, 0);
-- 
2.51.0

