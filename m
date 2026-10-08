Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF64399C6
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493090; cv=none; b=BnGamninxQNFlMZXPLg+6b36bGGG1MFHGyKTnc181efyBm4lhX1twL1MBWsy8XNWuOGO9ZbC2aLQHgXIiGh0hvbnY4A7c2U3q5aLtURVMLtNjJzRFwU7psLNTk41Mofhc9FyjeFP9vGorsRe6M1S+9spi4hZkn8gSuHdBYW+16o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493090; c=relaxed/simple;
	bh=OO89bX2AlrtkrgWYdOos3CyMDWbPk6PcFxH+MWmltFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zi35Nkon8vjOIpSZG9QspThYpII1qWtYs8Jr5GAECehH5Y4ulzQ0TZdVTbre1D65/N+5zALVCvhHTYbIupipFMpZWLqkYZqNyIhZ+dRgzHFFmflFoWzqMoRivM7V/tLrZ/by+myDaHOhxJizH6ogOzum9hsffXrwJycM1FwtK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=NV9yBnHQ; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="NV9yBnHQ"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6767d92cde6so3217285d50.0
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 13:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791493087; x=1792097887; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7804DMseCiWMFbi8mF9JSi9WooE66/vdxlGSeU5B64g=;
        b=NV9yBnHQJ8i1fm3XQlKFyVoMhMU3YmXQfL+1dMrtRds2FqMUOB5F7M5k/p6uluzDqa
         YxbYRMFrcrYvbGksz8PcxvVlk52hrWpSWwwhj69NVPGm9fDW8M6bQNY2AtkV5tQiUUEE
         ASRkRaV8VpojY/1B1CzSf+EQh0UAfLoNdcSgkHvkImsMwuoTE1fhxm/2V8BNgu7j7bQm
         FsQuqW9PwHvrnXqkpOqsdoR9jPLR0dav8T7N+uWuaEHFFrp42grdxKl+J3KOqCsaUAw7
         Zci/6L1wRjXKCleHWYtobEZ86/2n3eb2Aedi/wThVpQhzOZFti3KXrXRca9FGy5SWcFw
         WTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493087; x=1792097887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7804DMseCiWMFbi8mF9JSi9WooE66/vdxlGSeU5B64g=;
        b=xtr6FMAjuL4eo/OgLI5F2UWNAb+pEjtnmFF6dugIsMQJLugYdGDFQoyaE5jyXuzb8q
         eMpKeIW8FCKJ3+6vuX2R2neKDvBpMqu10YoFWUmV1/Cwd3mnaL7FvdTdBHvSbkqy6X9b
         bElBxdAh5i2c4BSOkRLsY4Rr1E5PXw9JDxwGZPhO1Rg00Rx3h9PhDIaS9qSlqrvRknSR
         xUJPLy0O98l28tlTlJJGFteitWaVqjIm15pebeT/UybbPTvgoXSCHpeIXDVsjyamapgY
         9oWnLFNGg6GvDW3kXybV0Ba4tkZGo/LeUNW3QY2BQmGwcphK76FLnzSI3D8BM01AL2aW
         jutw==
X-Forwarded-Encrypted: i=1; AKwUvBwukOp3uFbFiloaJsSrOHUWjq2+bUWrqAdxI8nILdJkSH593SewbcDqlT7JU3x3Mo8LWXbJopoh9RLFgLTdLxCmCLaqwlI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLN4JwObXuzP2GlcmZh7rtbg2l/wJAjVftH8PxwCSnSJ80uFgfs
	yHNJv/RTiNiT8eixFWTvyRacgu0td8LlbUXmDInYkKIA3DbWFlpgn7aeHup7D33W2ZKU
X-Gm-Gg: AYBFou0jqQElQ9sPI7D9HqqCshbaIJA1JlrzdThHeEFB/lwi49jXwwl+0xQUJu5vEwU
	JQDPSDcJqCf78Yiei3g5mOh4nYuWZUGWtyBKZeqoTVC/KXiDCUyNg9W9205bWVuc9k4yXBmsHlr
	k3u9KLsYHnzrKZeM5G5gMYxnAoCZC2ZHGDyWs24RHEtclh+gWoPDfH4hcdEQ8ssGxpWuCdUA9HR
	sUvhjyi3Z8zHxCKfd01CMiUbqMX/fXhc1SMAfUrKrRDxzfLo7NNjLEvKlFJ8Xky35niSpDwhy3/
	DIJnkHr3Mg8Ro4O4vf29Q/wX0HvvQwdAo8o6AZ1kvDMWwxYms7mRLBsOorYCKS1HKNEGZzEiz6x
	id/Bk6Z+CNOSJXHv3fPSPMlMyX5plZ4Z1kMd436UWOmaQk/RkOB7ba2ssHLZYolvoiuRZeOAhie
	RypwI/AbdmWWnFlK+usNtyYXmEDvTcJfeoV05mskAiME4ThVuNpjI7CmTCGx7G2cePTfxZAOCpi
	sA4eONA8eR7WWpn3JoOrODSMskSEj85elLfmnheZxM8DiuDy/DtGaQ=
X-Received: by 2002:a05:690e:1445:b0:675:83c7:7382 with SMTP id 956f58d0204a3-67935ed66famr38766d50.1.1791493086647;
        Thu, 08 Oct 2026 13:58:06 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67935707401sm78814d50.24.2026.10.08.13.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 13:58:06 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Thu, 08 Oct 2026 15:57:36 -0500
Subject: [PATCH bpf-next v2 2/3] keys: add KEY_SPEC_FS_VERITY_KEYRING
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-ajhalaney-dmverity-key-identifier-v2-2-008456d189cb@amutable.com>
References: <20261008-ajhalaney-dmverity-key-identifier-v2-0-008456d189cb@amutable.com>
In-Reply-To: <20261008-ajhalaney-dmverity-key-identifier-v2-0-008456d189cb@amutable.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, 
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, 
 "Theodore Y. Ts'o" <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, fsverity@lists.linux.dev, linux-doc@vger.kernel.org, 
 Andrew Halaney <andrew@amutable.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.14.3

Same problem as the dm-verity keyring: .fs-verity is allocated unlinked,
so the only way for userspace to name it is to scrape /proc/keys.

Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 fs/verity/signature.c        |  2 ++
 include/linux/key.h          |  1 +
 include/uapi/linux/keyctl.h  |  1 +
 security/keys/process_keys.c | 25 +++++++++++++++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index 0302a4e506ec..07657e913b22 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -135,4 +135,6 @@ void __init fsverity_init_signature(void)
 			      KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
 	if (IS_ERR(fsverity_keyring))
 		panic("failed to allocate \".fs-verity\" keyring");
+
+	key_register_fs_verity_keyring(fsverity_keyring);
 }
diff --git a/include/linux/key.h b/include/linux/key.h
index ae8d3314fd93..dd386c56278c 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -442,6 +442,7 @@ extern int keyring_restrict(key_ref_t keyring, const char *type,
 
 extern void key_register_bpf_keyring(struct key *keyring);
 extern void key_register_dm_verity_keyring(struct key *keyring);
+extern void key_register_fs_verity_keyring(struct key *keyring);
 
 extern struct key *key_lookup(key_serial_t id);
 
diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 75923941f1b3..00cc0942203e 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -26,6 +26,7 @@
 #define KEY_SPEC_REQUESTOR_KEYRING	-8	/* - key ID for request_key() dest keyring */
 #define KEY_SPEC_BPF_KEYRING		-9	/* - key ID for the BPF-specific keyring */
 #define KEY_SPEC_DM_VERITY_KEYRING	-10	/* - key ID for the .dm-verity keyring */
+#define KEY_SPEC_FS_VERITY_KEYRING	-11	/* - key ID for the .fs-verity keyring */
 
 /* request-key default keyrings */
 #define KEY_REQKEY_DEFL_NO_CHANGE		-1
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index dba3df41638b..655c58a96fcb 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -29,6 +29,9 @@ static struct key *bpf_keyring __ro_after_init;
 static struct key *dm_verity_keyring;
 static DEFINE_SPINLOCK(dm_verity_keyring_lock);
 
+/* fs-verity keyring reachable through KEY_SPEC_FS_VERITY_KEYRING */
+static struct key *fs_verity_keyring __ro_after_init;
+
 /* The root user's tracking struct */
 struct key_user root_key_user = {
 	.usage		= REFCOUNT_INIT(3),
@@ -629,6 +632,20 @@ void key_register_dm_verity_keyring(struct key *keyring)
 }
 EXPORT_SYMBOL_GPL(key_register_dm_verity_keyring);
 
+/**
+ * key_register_fs_verity_keyring - Publish the keyring for KEY_SPEC_FS_VERITY_KEYRING
+ * @keyring: The keyring to publish
+ *
+ * Make @keyring reachable by userspace through the KEY_SPEC_FS_VERITY_KEYRING
+ * special key ID, so that provisioning it does not require scraping its
+ * serial out of /proc/keys first. Called once, from an initcall, and never
+ * undone.
+ */
+void key_register_fs_verity_keyring(struct key *keyring)
+{
+	fs_verity_keyring = keyring;
+}
+
 /*
  * Look up a key ID given us by userspace with a given permissions mask to get
  * the key it refers to.
@@ -799,6 +816,14 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		key_ref = make_key_ref(key, 0);
 		break;
 
+	case KEY_SPEC_FS_VERITY_KEYRING:
+		key = fs_verity_keyring;
+		if (!key)
+			goto error;
+		__key_get(key);
+		key_ref = make_key_ref(key, 0);
+		break;
+
 	default:
 		key_ref = ERR_PTR(-EINVAL);
 		if (id < 1)

-- 
2.55.0

