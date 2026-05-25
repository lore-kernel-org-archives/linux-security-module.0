Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A0F3542D1
	for <linux-security-module@vger.kernel.org>; Mon, 25 May 2026 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779746691; cv=none; b=fA28HR4i3R/Rs80NOqOdQZXJPEItIBIyVHlkJTlxqjg8s3enS2fzJyeOU3VYw3L/E0eWvKb/4mYcDN/aIeIj9i1QgAbS0Ewhmu6+MMNUu5GcVO+zKcqGtGlH27mBocVlD6K+9HTJEj8+x3iP1z45FoR8wmKHkuaxykBNZPlcFaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779746691; c=relaxed/simple;
	bh=n7UWqtzQfSDd8ke2zpsyNz1xMduyOx0o5jQ/AXwR+Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fapu2A3w2/x9ibx/M7Cg8tRGjIhzULxQe88tBRdVLQCfHokPrJBZKkC6cdR7r1SV9WWeDZ1bQK6VZ+IIUt8/fH+5s5vpYjYTn+1tylQ2Tq+4YmGVgcC35TKsc7GCJnqIBql2BSKy4cqyurmqL0pe8wZpY903HedG09ubpSTtoEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWipLrsv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWipLrsv"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4905e190c71so17049855e9.3
        for <linux-security-module@vger.kernel.org>; Mon, 25 May 2026 15:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779746688; x=1780351488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7RTCGCGe4Su+57ooJAGzTmDyHCOTy856CxFupslfh74=;
        b=bWipLrsv5cnAe/5CxBnqkmhH/zaUiiitF3vX99KLGSiaIoMQvfaJoTUUTBwVV0esrT
         OcYHmWrAr5+tRvfh+F/SP/+A+IoH4QUICezkKUb37Rarl5FciRRDDGNAA/MjKAoT5/uv
         SFw0AgQO4qqcxEP0HwXxMi31u/ajm5lyVrVJbKmGZ1MtO8xOrWDLSlkbrJoPhYA7qPUV
         IXrT7J/ibBPh0V8hwEwnWBoUH0Tf0iF4KYffP1CTU2ENpjX41zfyV9TdDctvCJpxcCFw
         BKAw1nGfEN3dPdnt1SFoJjmxnRFxGcAV0NOeQ04MXDp0HjgvRDuqCUN12AxiYi0k6wiM
         Dn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779746688; x=1780351488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RTCGCGe4Su+57ooJAGzTmDyHCOTy856CxFupslfh74=;
        b=jANby6asATCADZkf+bZ3sAfNKV1kcJgvEygCCROp52x84vLIP4GNaCwXGEw3IOvqD2
         6UtpMnufUgrvFNSKwCWyoykD16FYTT/F8LnWLAAqrXz8B+TV5FCUMktP0iw5Gp8Guly1
         IMg8iz76tp7pg/eQ2LJ/iaq9RX3xLPnW0k326d8WaAjOclpbgWwlRyFda15G+x/VEyaz
         Kz4GfBdx5snGJtZ1uNI8wRx+zCgT/nNP93u4hA3DECdzT2GYHpod18P0jIENTd1l/cii
         2AJT7RQoGiVQF1Sd0M74UurwIztACCVNU0xrh+khQP6GyYzUQDuEL+3xOP/RagF1uJsz
         5/cQ==
X-Forwarded-Encrypted: i=1; AFNElJ84MslmpWgpGko4qHV2SWj9riBni20uXDbd40AtySmokyx98Ah5xVbQEv7PCROvayxqHeT6rWNlHQyEv2eG2YOWGzl0HBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUh2pujYyY5vL+84f2/C/5jIldo3RAP9cFuR7ycS/rdprPbpVR
	xdVDd3eiukkBFIrqMGKv4y9iTlysWmVyB9y8i6yO27JfIzqekOrsRk1E
X-Gm-Gg: Acq92OGudLyOVLIy1jT71RvlJRpwMF6Dx6I7Q03EtAFb2+Wrnra8e4M0vC2MZ/98vaJ
	Q9uT4ofy81GphpfRFVcljTkq4mOrt2LkSUIX04nuNIf6Teb1DrNOO0igYNfK75dti/zWjFm2rxm
	pDyNOH4vWZCbMcuLAYOtTuTOeuFMRHmjwz6YO6H1j/Jra90V4Wox/NFeEqpcImwdG6D079SDo0j
	wSCs7hiN3Qz/XIOD0ipyLPj5tz9DL4tyutMoUtYbrgR7RTPrz+JGp4w01haS+Wx5QFLasPYtaom
	snPMXiibLAU7s8YANPDuJbsN6lgXivMPYRoKowsGGG3534VCPhr1qrJK+yGGhkHk+G3JIAlEH7A
	T2q1vv1J5tRx0zFoGCfz+vM6zZZTn9vnONQwy1gkopPvDsAAMc6HxkGJiixH4TarGkOM1PU2WTW
	kBtqwxwl3Iu751B8e6OnA0NiaLFr1XynU=
X-Received: by 2002:a05:600d:4453:20b0:490:2238:4021 with SMTP id 5b1f17b1804b1-49042494fe3mr189225585e9.8.1779746688062;
        Mon, 25 May 2026 15:04:48 -0700 (PDT)
Received: from x1.tail0e71db.ts.net ([46.140.7.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49048f70f55sm80501465e9.17.2026.05.25.15.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 15:04:47 -0700 (PDT)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Cengiz Can <cengiz.can@canonical.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] apparmor: fix use-after-free in rawdata dedup loop
Date: Tue, 26 May 2026 00:04:46 +0200
Message-ID: <20260525220446.975352-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aa_replace_profiles() walks ns->rawdata_list to dedup the incoming
policy blob against entries already attached to existing profiles.
Per the kernel-doc on struct aa_loaddata, list membership does not
hold a reference: profiles hold pcount, and when the last pcount
drops, do_ploaddata_rmfs() is queued on a workqueue that takes
ns->lock and removes the entry. Between dropping the last pcount
and the workqueue running, an entry remains on the list with
pcount == 0.

aa_get_profile_loaddata() is an unconditional kref_get() on
pcount, so when the dedup loop hits such an entry, refcount
hardening reports

  refcount_t: addition on 0; use-after-free.

inside aa_replace_profiles(), and the poisoned counter then
trips "saturated" and "underflow" warnings on the subsequent
uses of the same loaddata.

Before commit a0b7091c4de4 ("apparmor: fix race on rawdata
dereference") the dedup path used a get_unless_zero-style helper
on a single counter, so the existing "if (tmp)" guard was
meaningful. The split-refcount refactor introduced
aa_get_profile_loaddata(), which has plain kref_get() semantics,
and the guard quietly became a no-op.

Introduce aa_get_profile_loaddata_not0(), matching the existing
_not0 convention used by aa_get_profile_not0(), and use it for
the rawdata_list dedup lookup so dying entries are skipped.

Reproduced on x86_64 with v7.1-rc5 in QEMU+KVM running Ubuntu
24.04 + stress-ng 0.17.06:

  stress-ng --apparmor 1 --klog-check --timeout 60s

Without this patch the three refcount_t warnings fire within a
few seconds. With it the same 60 s run is clean. Coverage is a
smoke-test only; a longer soak with CONFIG_KASAN, CONFIG_KCSAN
and CONFIG_PROVE_LOCKING would be welcome from anyone with the
cycles.

Fixes: a0b7091c4de4 ("apparmor: fix race on rawdata dereference")
Reported-by: Colin Ian King <colin.i.king@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221513
Cc: stable@vger.kernel.org
Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
---
 security/apparmor/include/policy_unpack.h | 19 +++++++++++++++++++
 security/apparmor/policy.c                |  8 ++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/include/policy_unpack.h b/security/apparmor/include/policy_unpack.h
index e5a95dc4da1f..b9de0fdf9ee5 100644
--- a/security/apparmor/include/policy_unpack.h
+++ b/security/apparmor/include/policy_unpack.h
@@ -163,6 +163,25 @@ aa_get_profile_loaddata(struct aa_loaddata *data)
 	return data;
 }
 
+/**
+ * aa_get_profile_loaddata_not0 - get a profile reference count if not zero
+ * @data: reference to get a count on
+ *
+ * Like aa_get_profile_loaddata(), but safe to call on an entry that may
+ * be on a list (e.g. ns->rawdata_list) where the last pcount has already
+ * dropped and the deferred cleanup has not yet run.
+ *
+ * Returns: pointer to reference, or %NULL if @data is NULL or its
+ *          profile refcount has already reached zero.
+ */
+static inline struct aa_loaddata *
+aa_get_profile_loaddata_not0(struct aa_loaddata *data)
+{
+	if (data && kref_get_unless_zero(&data->pcount))
+		return data;
+	return NULL;
+}
+
 void __aa_loaddata_update(struct aa_loaddata *data, long revision);
 bool aa_rawdata_eq(struct aa_loaddata *l, struct aa_loaddata *r);
 void aa_loaddata_kref(struct kref *kref);
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index b6a5eb4021db..e103cce6f4af 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -1223,8 +1223,12 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 			if (aa_rawdata_eq(rawdata_ent, udata)) {
 				struct aa_loaddata *tmp;
 
-				tmp = aa_get_profile_loaddata(rawdata_ent);
-				/* check we didn't fail the race */
+				/*
+				 * Entries remain on rawdata_list with
+				 * pcount == 0 until do_ploaddata_rmfs()
+				 * runs; only take a live profile ref.
+				 */
+				tmp = aa_get_profile_loaddata_not0(rawdata_ent);
 				if (tmp) {
 					aa_put_profile_loaddata(udata);
 					udata = tmp;

base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.43.0

