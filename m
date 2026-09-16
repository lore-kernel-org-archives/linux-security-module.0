Received: from mail-oo2-f25.google.com (mail-oo2-f25.google.com [74.125.231.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5FA4DD3C7
	for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578236; cv=none; b=ek+hVftauS0hAy92AK9OL6U6NW0Ith0zTH6Rz54L7xt2GoYuLW9mOK7oQnBvqHy02aGwRPLxLKCzdr+LOfs+/ENreUzmWijSePF5+AZzgq4KAkyYyrnrD698fO2zriFN0anQoqyZRt1PE1Ud9dZ3LciOIZVwCczmEYevwZEn+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578236; c=relaxed/simple;
	bh=Ks4WXakjDHaULISnrpHV/j5kbM2MXAKKMjVWUBVW3xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lLiGsPUBHHQaGlapWI6GWGyXu7IHWCLI6+X2JSyXlcLRiJc526AsqF9XSo7wqYUF5JXO+MPcjqaJBtLjNZCSSxgaOu6gxFw3ztRv0r9Opvoz7BhpOBsgmpHtjgn61eHLqqHsfaFHhgPzXTZn5KiwO4OKCyxHZhzlxtNDatO+kck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTlmxjDC; arc=none smtp.client-ip=74.125.231.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTlmxjDC"
Received: by mail-oo2-f25.google.com with SMTP id 006d021491bc7-6c901f4bfffso61464eaf.2
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 10:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789578220; x=1790183020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XPj8i2bxKQOSEoNifSANwZq2nYwCvvCNoM4rujFqkpk=;
        b=LTlmxjDCgOTX+Iv6NIjiaRTEPmNIhR5QIOJrzuzqpJ/PmD8+T56CPau6AKI8ZSqpPR
         9Hr0e+aF1z/vizB+FR14KiigEESe1c6oxW9OVJhP8II96/FCVOLJpWPd/HI2Fa5rBRt9
         Gg2tRV0s4GKp3KyrGBD0PAHE6CvQz617q61mHp30b9oOVcDckzCuc2AF3lsxZlAo/VeT
         U+QBurRoWMDiqsX3Pbb3/0o/Z1WedhTOQRfqH/VFrxoUAHvadn9jbVV/3sfFYoVzodqA
         VcbydKCq3zzvESwlNwej+gAeeKQIud68AqCIJxzrSIUlr44vO3M0XHXXNrbfgObOiLqK
         pTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789578220; x=1790183020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XPj8i2bxKQOSEoNifSANwZq2nYwCvvCNoM4rujFqkpk=;
        b=m/ljny4BpCankrIEuHa8IAQkZ1vNywgXTetcMaZy/BMgHTgsYbycurQA2DyI3WoMjM
         uzR3ThIh1ByxqzIGSwdGO3IgAfLi0gQfrlKCVq1VBOs+PcHYTzoG5lPSHZ6ubUl45Q/7
         yT4HKmmqrpUFCaHV5basI4nLg1VKciEBM7yfrN31t9IxAEOLqRUFiJjI7tokAy0Yk8hx
         OmzM1kjS6YVBM9EcXqmh/1wTwbVb3FPevV92PAJMerqjbYs1egMLxddBv9KNvw9hygWu
         g29FFIAVQ/TRFsAR6C+a2L7KYI5YqgFmxfVDO2QUplHW1cp/eNowyU0wekBgCcTcHAcN
         yv4g==
X-Forwarded-Encrypted: i=1; AKwUvBwEtvRP/cD7n0NxdzY5B8IdNlxe1qrQ51M+AE9YNyAkEGNtkt5vkTgsfyDTCjmBHGbrMqtaJhYB5pMj5k1uMBPzgnSiOi0=@vger.kernel.org
X-Gm-Message-State: AFuF++mDwN6D84oX+9B0rfZlXFjyV8Y1MHyH8cG9NuMJL3aRs/DbKFCS
	oYAUBw1hrLXCOON4eIdyTaBww7X2B3Qa1G99S0OfHjA72QSiFvSBd+6p
X-Gm-Gg: AYBFou1B1jrR/oqVA/tMy+36edmvtN/14HZ1adHJKXGgyN0KP6o36DrrpJzYtqw6Fl+
	9wk9szsxnKKAFU7cR7V5QFJqE4cP6iIMRQEqg04OvSYryMy7yBlysDkD01WNIzakYOsfchpxCXn
	AF6T+UciAnYZso1UeDdjcGV2jAIxsaJXPStheg1t1dAm4QhEWgH2oYvCHWqmfw5bzBuZO+feI3i
	aCFBkULEqMttG60VaiYagQy1JfpTM2fvIMWAgXeZW/JvtMt2KaBVduCX9D+3s9F0H8aGoKpHolm
	6czORLNZGe9mJB+4iFSEFA0bP6zBwLuVAwabEawSlinL4f59Br2dfpZ9q/MeZVGqaAupucG9ycd
	ShVx8UVmFix5Bn/rHeZvOZLDzlDAH+uwi6bcICGh1qKtaqwwO5KqSr9qwpc/sUuI54Q+BlIMTVm
	HC8lXsHclzKQxEc0ruHQ6B0pr0Z1V4J6rMCefo7hgo
X-Received: by 2002:a05:6820:1f04:b0:6c4:28bd:fdf3 with SMTP id 006d021491bc7-6c7d340555amr3126331eaf.34.1789578219819;
        Wed, 16 Sep 2026 10:03:39 -0700 (PDT)
Received: from gmail.com ([2804:1b3:c402:7a4c:6d25:8c4:21f3:ba2c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c8f7bc41basm366840eaf.15.2026.09.16.10.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:03:38 -0700 (PDT)
From: Murilo Duarte M de Almeida <muriloduartemouradealmeida@gmail.com>
X-Google-Original-From: Murilo Duarte M de Almeida <murilo.almeida.dev@outlook.com>
To: john.johansen@canonical.com,
	georgia.garcia@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Murilo Duarte M de Almeida <murilo.almeida.dev@outlook.com>
Subject: [PATCH] apparmor: lift path_name lookup in umount
Date: Wed, 16 Sep 2026 14:03:09 -0300
Message-ID: <20260916170309.396648-1-murilo.almeida.dev@outlook.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before this change, pathname lookup for umount permission checks was
performed inside profile_umount(). This mixed object-specific path
information with profile-specific path configuration.

PATH_IS_DIR describes the object being unmounted, while path_flags and
disconnected belong to the current profile. Keeping these inputs
together inside profile_umount() unnecessarily coupled pathname
resolution with the permission check. An existing TODO in
profile_umount() already called for lifting this lookup.

Separate pathname resolution from the mount permission check.
Calculate PATH_IS_DIR once in aa_umount(), since it is specific to the
object. Then, for each profile, combine it with profile->path_flags
when calling aa_path_name(), using profile->disconnected from the
current profile.

Move this per-profile pathname lookup into umount_path_perm() and pass
the resolved pathname to profile_umount().

Keep profile_umount() focused on checking the resolved pathname against
the mount policy: DFA matching, permission lookup, profile mode
handling, and the final AA_MAY_UMOUNT check.

Signed-off-by: Murilo Duarte M de Almeida <murilo.almeida.dev@outlook.com>
---
 security/apparmor/mount.c | 42 +++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index 4ed7b9136beb..c7dfdae95747 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -541,13 +541,32 @@ int aa_new_mount(const struct cred *subj_cred, struct aa_label *label,
 	return error;
 }
 
-static int profile_umount(struct aa_profile *profile, const struct path *path,
-			  char *buffer, struct apparmor_audit_data *ad)
+static int profile_umount(struct aa_profile *profile, const char *name,
+			  struct apparmor_audit_data *ad)
 {
+
+	AA_BUG(!profile);
+	AA_BUG(!name);
+
 	struct aa_ruleset *rules = profile->label.rules[0];
 	struct aa_perms perms = { };
-	const char *name = NULL;
 	aa_state_t state;
+
+	state = aa_dfa_match(rules->policy->dfa,
+			     rules->policy->start[AA_CLASS_MOUNT],
+			     name);
+	perms = *aa_lookup_perms(rules->policy, state);
+
+	aa_apply_modes_to_perms(profile, &perms);
+	return aa_check_perms(profile, &perms, AA_MAY_UMOUNT, ad, audit_cb);
+}
+
+static int umount_path_perm(struct aa_profile *profile, const struct path *path,
+			    int flags, char *buffer,
+			    struct apparmor_audit_data *ad)
+{
+	struct aa_ruleset *rules = profile->label.rules[0];
+	const char *name = NULL;
 	int error;
 
 	AA_BUG(!profile);
@@ -556,23 +575,14 @@ static int profile_umount(struct aa_profile *profile, const struct path *path,
 	if (!RULE_MEDIATES(rules, AA_CLASS_MOUNT))
 		return 0;
 
-	/* TODO: lift path_name, need to separate profile path_flags from
-	 * the lookup
-	 */
-	error = aa_path_name(path, path_flags(profile, path), buffer, &name,
+	error = aa_path_name(path, flags | profile->path_flags, buffer, &name,
 			     &ad->info, profile->disconnected);
 	if (error)
 		return aa_audit_perm_error(&profile->label, AA_MAY_UMOUNT,
 					   error, ad, audit_cb);
 
 	ad->name = name;
-	state = aa_dfa_match(rules->policy->dfa,
-			     rules->policy->start[AA_CLASS_MOUNT],
-			     name);
-	perms = *aa_lookup_perms(rules->policy, state);
-
-	aa_apply_modes_to_perms(profile, &perms);
-	return aa_check_perms(profile, &perms, AA_MAY_UMOUNT, ad, audit_cb);
+	return profile_umount(profile, name, ad);
 }
 
 int aa_umount(const struct cred *subj_cred, struct aa_label *label,
@@ -587,12 +597,14 @@ int aa_umount(const struct cred *subj_cred, struct aa_label *label,
 	AA_BUG(!label);
 	AA_BUG(!mnt);
 
+	flags = S_ISDIR(path.dentry->d_inode->i_mode) ? PATH_IS_DIR : 0;
+
 	buffer = aa_get_buffer(false);
 	if (!buffer)
 		return -ENOMEM;
 
 	error = fn_for_each(label, profile,
-			profile_umount(profile, &path, buffer, &ad));
+			umount_path_perm(profile, &path, flags, buffer, &ad));
 	aa_put_buffer(buffer);
 
 	return error;
-- 
2.43.0

