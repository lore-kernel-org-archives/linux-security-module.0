Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3848D893
	for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404127; cv=none; b=bfOrQT+QOhKBVyXK6iDALwBdUZsYQwiv8boFvoKPxNgNnE7eBuxkElEJ3fK4T/ueMch6sfi1/lWwNrNf7srN1jDTaCYfwX0P6UwA9i+otkM0cdRlqblBROs4QU4qAx4snWEl5VxCQskPYKQslFE0BYtitl1gtIi6y0csIltXmwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404127; c=relaxed/simple;
	bh=zafmxxNjheNFUeJK3AIQJ8pVbd1q5BFmpHhmp6iOmBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aaLzMPxTjbMsTIjyvti2X7zz3sS2ZXzfA3wxVzbrBo0STMiZM+J01KyyDLfrz2gSrShyaus1TK88gJFl4LDoDU0Wgy6+1pKzXM81Lfc8t/Ure0yetCcEZ7iWY7QnMJnz0mMJEx3pzDovi7Y0FEgkgy5ToGGyrc/BGmMgwadjrbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=HJP6SlE9; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="HJP6SlE9"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab20a32so2241577d50.2
        for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1789404123; x=1790008923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qFr7b5bBk2c57QN/ffKr2kggj2VzIZRrazmGOtkcSoQ=;
        b=HJP6SlE9Ko3G5dsx3ikhG/qyJQwXrTQvT4DHlEOSrohajQ4Mh1xEqoP1SN7nnN9hiR
         L8spXU1ylNlp5NrKGH6JSCdwr4pGEvwdO+UUsXuJ0vx3GV/6blYzUZamXMpLbLTKf/hV
         9PHZzBtJqVceZNw1vwZ0EALhCstg0ozpruUB3dnnpKqfh1hmHOhW2F59Bv8vz66uKw84
         tA86xsvFe65On7ILwRmUrsxU9a8J5W8rU6hJZm2O6niKRkWRkyDRMA7CJHPfSMNjUpCi
         FRaXxw/Da4pSsEhjjvUiDCneQqWiGFIhB7ph8yYsNUTI70/8GkEvLGr19hyIh/kYsn3f
         5SVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789404123; x=1790008923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qFr7b5bBk2c57QN/ffKr2kggj2VzIZRrazmGOtkcSoQ=;
        b=h5DSl3TPbm3cbHiwzlNw2BBR09u3nHkG4No2oFMb3cdc6vG6/YAB03uaZy2TZUIjcj
         boUBkNoukLww3cGXz/geUTB6St0BaTm48uTGg2NiRECwNJ7txXmRqHFB1w2CpTBDSrSJ
         nOJUkRQ/kHLWOrrEA2UUmE/mpy7xCy+s7NFN9WyOwE+DnenHay55azHP4dZpTfigcSBN
         4+PluJ6PAWKd9N/16Vydmuh9aQt8Se093w/A4F+LmV1g37vR8sRqCrvcREpnJe3YipvC
         04dDmuLmqZtW+9DPb+IcKT9tcSq3Dh88SbaJ5aUY8FdAQDgRGGBop13+TMUzbVOmTd5y
         vdnw==
X-Forwarded-Encrypted: i=1; AKwUvBx+Qc2DjuM2UTnbuDtItbzp6kfuQ4YUFmbYw929UF7T6Sn3sqWYlVaAvhU3HTGGigDO86jobJEXpc6NDa7jWE7Kx4TqfyQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kfQFCb1Uwysqf2Jf++7RgI6ODFSchgPF5prGPJnrx8vUOag5Gv
	UYsUJ+2EE/YwT8EQrdYwXfUckILd7/CuekmAxKW31FsnUYc7pQVJlHO2GabpOeP7T5ec
X-Gm-Gg: AYBFou3IxmbW0EaM9LdM37vNCvR6QwZvWdw1+x0BuuQfB1RwGgo0nC0LQKWK/HV9SzX
	ZBoKQwHi+gjL7vl+gfswxT2B130omrqOr8WfLJAwQ5c3yIEpiLr1tX1en9Ktc+eERgcRBPfWZNi
	4t2PG/cfRzwsTwrsry64eGdC4OxTymv4oIjmYhvgDytm1GBhMotFfCEPMw8Y6ElFk17k/xatZBT
	kdCKQ07Peb6FB+xceeC7cyDtNZNNn/UZi88Kn9oYGyPGy293QO03S3i3uLnheulTJdRyuUVNt1P
	6kbnsGW/Q/hkAAevnHKkN3CGFhdwiPuHcFlwaFIMmQhOxElOsMcTuu2dbzqyoHF/kqfmsGDoXyC
	lx9+sGTss1wFt4ZO/UsR1+AFo5tZsnVLaqAgpP6H0XhLXHwI6zY7aJkG7xA6bhmHXGeyBWdl6vy
	8JrKsvxYQxmPUw8k+2Y0IyBEJEVwZ4yl9iNKvTj/MCZv3EbYkw8Nz2U9dNxgOH
X-Received: by 2002:a05:690e:1388:b0:668:1c09:aef1 with SMTP id 956f58d0204a3-6714dfc8bb9mr968611d50.6.1789404122960;
        Mon, 14 Sep 2026 09:42:02 -0700 (PDT)
Received: from [192.168.1.110] ([2600:1700:1ff0:d0ef::d15])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125df42a8sm4879023d50.8.2026.09.14.09.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 09:42:02 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 14 Sep 2026 11:41:43 -0500
Subject: [PATCH 2/3] keys: add KEY_SPEC_FS_VERITY_KEYRING
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ajhalaney-dmverity-key-identifier-v1-2-01922dc1366a@amutable.com>
References: <20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com>
In-Reply-To: <20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
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

