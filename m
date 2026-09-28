Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1DE399007
	for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622399; cv=none; b=KIWCvk1R9vSdub8yf9XIkwLkR5B82bc+rHJSpq/+SSEws4IR2UQbxpomzehIrq63nA/Ow8YDzUAQmXwhkwviyu9sSaV192I4UeG7Tt70/cVLXoWGxyd6AvmcEpgyAOzTXrvdtBv6D/4X44ht5EuOTw1lA/OKsBx0eT2upa2DShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622399; c=relaxed/simple;
	bh=lA4VVckwZyDUviaHA5qDSJSGW+JBfmccZu+VKDJm210=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LyjyrKcaD1TZW1g+VGfRrz0TBbEx8LV/D2+piKNL0KALK8Jznl7lXeW15GeTGlESOhWDQjyANMZAZO/IdPM2ExCxOACWFFuW2DclhRcOAjttByt6UqZYcelEo3Ea/K1YngIdZ9hnO53BAWS16AFl20A7ef3jedmHl39pINItA40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlnuLsKs; arc=none smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlnuLsKs"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-988bb9d055bso42870241.0
        for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790622397; x=1791227197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=37h0dgQHnE/SfMF6D6xYZ3lFDCaYhtl79yfdJkjwAFE=;
        b=XlnuLsKsUlHngx50nCbN0IoSWTn0S0fGv1eRKIJG+SSI7UpaE1/k/zrlVsm0LlK0IW
         yPtoE2NXZVpETS7uvWpc4bL8Lu3lXsUkMifMnW4d6Z0Rye/7/MOpzVCpgrQQ7jLHEvCW
         AeXX7ZqhrOnRqatchQhaHnkw5ljs6trjMsPxbe1nYW+Iembk6pYjOXCwDH59RFMqjM9S
         njnGm99GlEClLpDkC+N7rei4AHKy8DvW0WogqZMd4tGcUZCJGRWw2uSaxQPGM5/2OMwJ
         /IvNfgFRROEyxBho32MV/xcwLZTkpSh4wdAQQYv1MGRjd7JfYLdRpNgngUvems9bezFR
         yfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790622397; x=1791227197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=37h0dgQHnE/SfMF6D6xYZ3lFDCaYhtl79yfdJkjwAFE=;
        b=WxFDfrClrFkbmCv3swsKmg0QYKrvni5kB7Z7dnaulww6y8pLVpn5AS4Uk4kKuxe05B
         9zNzMfyzORH3JMSRIMZpO0Tnu+xdSnetJypYO/pnl58dhLliF6K8RE4sQgm91P1SJ8GE
         nqqjsYistSKL2ITNOF7+Xm0gxkPOK0FZskOx88sfy7aHd2KwO3xb6hr1ZYL4WatL3YcC
         wOpN+goM4/C8cj3BVq0oUlRoJBH1xANPCuwx/O11ompRSyKyRBiQxDWnLJWr1r7hXwB+
         FZJ5lqtuk81SwH+nxhj1Z9jlQbozn+QcHmQFm2+m4ZsLtHcA8U+ajJdDMWpSYlhyor+T
         Wimg==
X-Forwarded-Encrypted: i=1; AKwUvBxJwSv9Th3BHvzrhsjaNCjU2u3arqfe+W0o22XKlwTsTggpCLAOwhSciRIEQMIXltvXC0CERI3tvXrmUMn393ZvOZI9x9o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLXkVWgg9KoBKneeDr2U8JlHvXmYiQBDzsrl94MJYq+wSQxQ/L5
	UPdVxJmtRVpewNf3nxakB2Yoczv1uGxdtgF6CmN8LuK5fh5Bw1s+chmu
X-Gm-Gg: AYBFou2nCJ7L1cVuIVGeJFfmJsaaOkSVu+KYFMse1aWyRNidmOIxbxh/PylQPBbVtu5
	rilvpRWp1+tEGtGgChJu88udpW4hF8HGZo0gQHJTGnzqMZ0avEnYhgMMmn4mtvjzUhlBVaJm2K6
	R2x6H/rtunwDRqjPdvOZ8cZvKM2FsA0C1mMNuNUloOKqsXQpFL1SHRDVuWnUa5JanDRpqMVWQYY
	mH3TGvMBm/lmUJhem2lHxkLP5jFYnhcxhIQHWWPZZ6JubJHbBIsTIdGu5sdvJ8br0yVS76O8u+Y
	5sLq/7C7FWgtBe6J8IaVIjU93hw3td1moVB2ql7RV0xYAUNMMmkoXYwiD0pZdilZZj+LFZ8D2jf
	QoCR/MLeU8oaKC+ehi1DlKKMUvrucEXMcgDmGT+8u9xE5oporUJJebUOe8R+SGdVEFFj7OEOIyN
	lOWPLnlCx8jBMAA5iyAhBF1FGYvkKebbeXJwnuFBqTMka8cmuhEhnkE5W7fQLLbe4KFhza4loNb
	8M=
X-Received: by 2002:a05:6102:4b11:b0:7a5:e455:182f with SMTP id ada2fe7eead31-7af1dce60b5mr5365884137.26.1790622396723;
        Mon, 28 Sep 2026 12:06:36 -0700 (PDT)
Received: from adriano ([2800:300:6531:5ab0:8a1a:ad67:2d9c:5936])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9889b08b6fdsm8042370241.4.2026.09.28.12.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 12:06:35 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH] apparmor: resolve pivotroot paths before the failure audit
Date: Mon, 28 Sep 2026 16:06:20 -0300
Message-ID: <20260928190620.1154576-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

build_pivotroot() stores the new and old path names in the audit data
while it mediates a transition, but it returns early for unconfined
profiles and profiles that do not mediate mounts.  Resolve the names in
the failure path in that case before the audit record is emitted.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 security/apparmor/mount.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index 4ed7b9136beb..cd869a07335b 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -698,9 +698,18 @@ int aa_pivotroot(const struct cred *subj_cred, struct aa_label *label,
 	return error;
 
 fail:
-	/* TODO: add back in auditing of new_name and old_name,
-	 * needs lifting of name lookup out of profile cb
-	 */
+	if (!ad.name) {
+		struct aa_profile *p = labels_profile(label);
+
+		aa_path_name(new_path, path_flags(p, new_path), new_buffer,
+			     &ad.name, &ad.info, p->disconnected);
+	}
+	if (!ad.mnt.src_name) {
+		struct aa_profile *p = labels_profile(label);
+
+		aa_path_name(old_path, path_flags(p, old_path), old_buffer,
+			     &ad.mnt.src_name, &ad.info, p->disconnected);
+	}
 	ad.mnt.trans = target->hname;
 	error = aa_audit_perm_error(label, AA_MAY_PIVOTROOT, error, &ad,
 				    audit_cb);
-- 
2.51.0

