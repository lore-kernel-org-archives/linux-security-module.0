Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F5E3D1AA6
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 05:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522728; cv=none; b=YL1w/cIFt9gEo9joTRJRCR/OW5iGtQl43F1u8VH5YtgfY7i8xzu6ayVQZykKBK2Yc+HYLfIt7v3StEKcpP1rw7qwcjx/fzw0Y+Z1gxiWs4nR4xhD4PL1qWUClHbL+ptLEDvLeLhDD5RHa7PrT07ZZB0mQrixJC7Ct9CNSEvq0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522728; c=relaxed/simple;
	bh=KVSI28pLKveuaijeq+vfPCZEsHZG5fb/0TEQZZOkPdY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BuYzg1z7I/uSdRgz4RnmzZc9puM9Q8rVsU5tW+raWFfg/Bhlx+GoLWIQ26Npu8itM2WZpDEZv14eHdjhrmJWOxklaKrHt/KgmrwyNKbBALKmUx2H0aofiDGtrtKKUMPMGCz6M3dw/s8q2hRoxVulL/atPnTcsseneNaoBy6cyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBRksm71; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBRksm71"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so2055663a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 22:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791522727; x=1792127527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=009PzhldLqq67bHKwh2PTPo29cF7R0BHqE31k6CYPpc=;
        b=jBRksm71QWE44dsyAJrnrdMEHmiDlAoXI5ierP9fhHK21eXyEXPsjExs8Xt7BgOheP
         tQhCR59vFYduQ1h8C3DhiUjCUN8SAL6Z80reGrK7tvezyjxRpH4mMHV/DAaAjrgRwlxx
         rxAGtad1pG9kj7W11lbNbj2fk3YmoSgnpwdgHPaNHCyHN4XM0FeGOaTeRjdREZFYbAk1
         bjK5r9usX09ffm2dquYv2ihiFvqbFtsucE6wugTBjfcayGqSO0XGNtu2ERJUH9TQGlNW
         uTK0RHjf+q9o9ZdEu9HjyQ1bUDjdUJDxq2CskbiQ8ISjUxuNkC/O59FM/fyAVbMG2vl2
         fs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791522727; x=1792127527;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=009PzhldLqq67bHKwh2PTPo29cF7R0BHqE31k6CYPpc=;
        b=M8e/otoS16nafLBEQHBbWOOtvQrqomyRTiNCAvK36V/MKRuntIlxWZy+yrNZtgL6ZX
         LnFF6xEDp/pThPh9ufgFjwHf1wvfot5m+uY3JhmpM8agYIRCplrHk81fGlCabkO1sPGT
         AiJTlrJJJs/JaQyXe9m6X2SiGIkdiZy4bOG/Ma/jB/A+Awsp0QUew39hoppcrkqDR/00
         yQUISSksU5L/o6tIsCoacMpWhoHPml65++tdmLQSR24A3S1F7UVEZKsDwKvr32wCLPf6
         h76LtovYutznlqZ96AYZZMx13znJ5WwgZ728UqW4T+KpWXlhYlT1eF+dGT9FJFM9RXdO
         H7KQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOJRUXSRll3SPU4TDIG7wfgpzrpEUsyqYvjGJez1RhR9uU5SH5ZV/NDQyEFLS6IsqLAsEOpvS085a9OVI21V4A3AB06UA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJADiOwWGzvFXhalEgwEUR7I5qiTPX7nE+FgXnm/lReMCgvIiVv
	AABxVEQ1RBKF9dLbaDICVLw3lgyuSVEVhR7O2G2pG3Mufa8vFG0j4D6j
X-Gm-Gg: AYBFou1FSyoFQ3NtcGHyu8bRz4UqrRGn8tB+I7OXRmWlgVPOGnbmhJhhrJNvtivpRMc
	bQdGQN0E7sD5Ou+hrLU0e2FIGNH9kXM//MOnP7dKMBCGXUNsxxU1p8aoFj866AIA/UuO2a0A6rX
	V7ZjanHvJt7iP1Yx46SiEiV3dq7pUUv15pxleJ8zcXbyW0wBO2FXUeLacWS2q/Gqe4tcGTPgchq
	K0HrYPDlMeIlRcgou2s/Ap+977t1mUdVasUh/GC3hd8ty14pQvNHNzBJdwWV5t+YJyai+1p4JjZ
	Z7AnN8fwK18wd1Q8D13ufDz13btbPvMbCK8B/Z/49vU6OKNZsG92KtguumOtWTz3FUH673xJ02H
	b+oFcEo3/1hKq2Kk9WLVpFJV+SM0lL1Hv47hqDwLQrGPJyji3QwYgBYYnQ/vCCNpyvD4qi4Yuig
	U5bgaFtnMSjXCyQBPhW14ODGspoF9MZo6MwddGwWrCX6vfe8652V6CQ43zkZXwAz3CXUw=
X-Received: by 2002:a17:90b:3d81:b0:3a8:5f61:1bd4 with SMTP id 98e67ed59e1d1-3ab3ab5cfa5mr726141a91.51.1791522726584;
        Thu, 08 Oct 2026 22:12:06 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38ff0ce7sm1827045a91.15.2026.10.08.22.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 22:12:06 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	sergeh@kernel.org
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] keys: Avoid the owner account dereference in named keyring lookup
Date: Fri,  9 Oct 2026 13:11:59 +0800
Message-Id: <pm-key-management-objects-candidate-0002-v3-2baa8cad2bb554364e10@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Named keyring lookup must keep the storage containing the owner UID
alive through the namespace mapping check.  find_keyring_by_name()
reads keyring->user->uid under keyring_name_lock, but that lock protects
the keyring's name entry and allocation, not its separate key_user.

A named session-keyring join can overlap a privileged KEYCTL_CHOWN on
another CPU.  If the keyring holds the last reference to its old dynamic
key_user and the ownership transfer succeeds, the following ordering is
possible:

    Named join                         Chown
    find_keyring_by_name()              keyctl_chown_key()
      read_lock(keyring_name_lock)       down_write(key->sem)
      load old keyring->user
                                         replace key->user and key->uid
                                         up_write(key->sem)
                                         key_put(key)
                                         key_user_put(old user): free
      read old user->uid
      read_unlock(keyring_name_lock)

Chown neither takes keyring_name_lock nor key_session_mutex, so it can
free the old account between the pointer load and the UID read.  The
lookup then reads freed memory even though the keyring itself is alive.

Use keyring->uid for the mapping check.  key_alloc() initializes this
inline owner UID and keyctl_chown_key() updates it on chown.
The existing name lock keeps its containing keyring allocated throughout
the check, so lookup no longer depends on the account's lifetime.  This
also matches the owner UID used by the permission check.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in find_keyring_by_name+0x577/0x5d0
    Read of size 4 at addr ffff8881128ae2ec by task keycase/500

Fixes: 2ea190d0a006 ("keys: skip keys from another user namespace")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Changes in v2:
- Trim the KASAN report to its two-line fault summary.

Link to v1: https://lore.kernel.org/r/pm-key-management-objects-candidate-0002-v2-dd6c20a1d92928b33ab7@gmail.com

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 15bf4af8f28218ec3f12c97630d1c76939af7eca..46f774be72967a9bd16b0ddfdf323eda36edeff4 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1158,7 +1158,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 	 * grants Search permission and that hasn't been revoked
 	 */
 	list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
-		if (!kuid_has_mapping(ns, keyring->user->uid))
+		if (!kuid_has_mapping(ns, keyring->uid))
 			continue;
 
 		if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
