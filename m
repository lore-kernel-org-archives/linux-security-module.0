Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A053A7F7A
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857284; cv=none; b=fCbm97e38DqE8ktFivqpk26aCXGSeqj8SEPOmF/QiJCLBXvsC+7WRoh7ZkBvjXsh+vkT+FLL7ojuay3SA45RBQfMaTdXg793Uh9IWY/kfqh++b+5EyRzbknWtmWGN9zC2RdjnnjAUi18mmwHHZaYa7hWDMU1N6nWzzI63pJG33c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857284; c=relaxed/simple;
	bh=NoYLQ/BarOSRXyrwHUkedHUpGCwMk3EDs6vhrDTQqbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWrLC73RRhJmGLIZhxBst8MF2f+QdPjsuxUwl0XtWojUXS0C7KJeEaywhrKFJQPhngjJ5yGn5+6kqdAnoybaheBNkaNXnuL0RdxPkVQDM5D5nsrbQ8ueaj5El3Ub7Hf8TTtMOkYvDvqQX1CFotIDUOqBMOA8v5Ur1u40oQm05vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IotSDmkg; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IotSDmkg"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469a34908so1772232b3a.0
        for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 15:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789857281; x=1790462081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NjNrC87GI6r/hyASC6W4vHpCo4NDAOckP9GbczGyTro=;
        b=IotSDmkgx2Gn4PkVPYtopvWcQWXe+KkMOA8wqUSw5czl2qjKfvVBNODGZ9VDKnmDsF
         nKUL5cWrntLBMP9vUgKaOZoD4ulgL5bVCTwL4K08DKxROSlQEkSC73YmyLqGqBBlgjXR
         b502uI47FPCJVZLDxf0xOaSUP74ubFMUOGEcVnV9wjyJjzuFrhb8vJ7NXP5Ckclo7axR
         6AM5ey+40SjTfwioqNXpkdnhO1we2Ctu49r/JFjuviweCtKMmy5WNJP/ehymg2Fhh1XY
         M0NfSKUUzByGkyC+Gkd5hkNEOvZxWYIq63KGKu9gpUxbGu17h64O/VyuZqj/T5kxP+3O
         MC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789857281; x=1790462081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjNrC87GI6r/hyASC6W4vHpCo4NDAOckP9GbczGyTro=;
        b=OfuxaUuUXsIB099CSlevF2oh2FY66Zik6Vz4zGgEUOGcfeXmWq3jCN6+OKi6YB7yFA
         FP6h2jgugUxE7PJkSWk3oOr30c5XTverimhWRN5wpKTpYppA1n6s9r6iukqBXqe4zJmz
         XbxEa6/PAz13/K6ujPS2LxkzH/VyLoh4zl+ERoOKanBalA93XH58Yl5+NnZj1dO3+Wf/
         QxasyYkbaHnfiL7zY4HHxj6lAeFpT5Ue0gNspa4E0oL/aVvqoyaXadHDofa8sB64P9Ge
         oODvQomrTWfns7C9HJpoKUJLkqRpY00XP1fX8R4HDOQkIV29tW0166gZpYUUV2KBK2n4
         IAtw==
X-Forwarded-Encrypted: i=1; AKwUvBwxabushfXjQihoVBStwgVb+ht/N9WmfZmZRrcD/u9WqdmZj4KXczjqu9NxAmhIzaye+D3hYmytnAt3AXuGDx/aWJAHf6c=@vger.kernel.org
X-Gm-Message-State: AFuF++mFeWmeodGOsg+g3cvykA2Q5rLoVLw9bEh30NmfD+1PvJMkNw6c
	cyCqgUB1ZlK1avpyVs8/OAqrtyMghQTz/eZXscq6HVgX1Sqm9GWD/1PQ
X-Gm-Gg: AYBFou3DKBbaProu131YEt2KEJ2Whf9ITizxLKOiOD8aJAfR6V4ogcdWCesO/lCDgf5
	LU9+XL38CzRAQ+XZSTkOPxHI+GpYkFApHFLrYS5T7F8ZeormyWxeyoNZvB3OvxIl2xpUJ3X8m9k
	yRrgVc0RnZPP7Yq/jxIrhAL+aR3jWsoXGonK53HsqHqOgKUrvK2wU8+rIDJyr2JLXBBAzDqKLDK
	z63UrgnKTUG6wI5P8AKqx6cWKpcEjZPPesefv71+h33Eg48M/JsZPqu2jNyDHZdPLW2oYU8+1ZK
	GW0PvmePK/bqJVXjroeCQaGs8HvjFVDrlow1OMJ9YT3pcrYxox8YhAWZivnswnNY8DQYuwe93E7
	ourTzlW3FkFFQtq90wgapVxe3QN3FlHsSxRWZJmHSpNF7QCvDyC/Q2G2PIcHjKDrvYJsm8TTem2
	/BYyXwSEAx/ihhbyyWSIEdAXYTI1yXfAoUQ/C8X1YIn5H1FaZoUSYRMW4gN/w1vb87RuQQ8tyRj
	5eO9pCZ9zNtXEaI1LpdpYi3T/najyWGiRlwiY0xm0QCpbMhcBclS1vtiSk+X5taczIpbZvEN1f5
	z+DxYmsQyw==
X-Received: by 2002:a05:6a00:b49:b0:871:b1b0:e495 with SMTP id d2e1a72fcca58-874dc4f31aemr10100311b3a.15.1789857279724;
        Sat, 19 Sep 2026 15:34:39 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a8dfe533sm1391208b3a.10.2026.09.19.15.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:34:39 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: paul@paul-moore.com,
	dhowells@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netlabel: calipso, x509: clean up ADDRSELECT on DOI removal and check AKID len
Date: Sat, 19 Sep 2026 22:34:38 +0000
Message-ID: <20260919223438.3883567-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two issues in netlabel CALIPSO and X.509 key parsing:

1. In netlbl_calipso_remove_cb() (net/netlabel/netlabel_calipso.c), also
   inspect NETLBL_NLTYPE_ADDRSELECT entries so IPv6 address-selected
   mappings referencing a removed CALIPSO DOI are removed.
2. In crypto/asymmetric_keys/x509_public_key.c, guard against zero-
   length signature/AKID fields before key matching.

Fixes: cb72d38211ea ("netlabel: Initial support for the CALIPSO netlink protocol.")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 25cf8ac7f257..5c9165a83f91 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -53,9 +53,11 @@ int x509_get_sig_params(struct x509_certificate *cert)
 
 	if (sig->algo_takes_data) {
 		/* The signature algorithm does whatever passes for hashing. */
-		sig->m = (u8 *)cert->tbs;
+		sig->m = kmemdup(cert->tbs, cert->tbs_size, GFP_KERNEL);
+		if (!sig->m)
+			return -ENOMEM;
 		sig->m_size = cert->tbs_size;
-		sig->m_free = false;
+		sig->m_free = true;
 		goto out;
 	}
 
diff --git a/net/netlabel/netlabel_calipso.c b/net/netlabel/netlabel_calipso.c
index e1efd888b4a2..3756193b1c49 100644
--- a/net/netlabel/netlabel_calipso.c
+++ b/net/netlabel/netlabel_calipso.c
@@ -283,10 +283,21 @@ static int netlbl_calipso_listall(struct sk_buff *skb,
 static int netlbl_calipso_remove_cb(struct netlbl_dom_map *entry, void *arg)
 {
 	struct netlbl_domhsh_walk_arg *cb_arg = arg;
+	struct netlbl_af6list *iter6;
+	struct netlbl_domaddr6_map *map6;
 
 	if (entry->def.type == NETLBL_NLTYPE_CALIPSO &&
 	    entry->def.calipso->doi == cb_arg->doi)
 		return netlbl_domhsh_remove_entry(entry, cb_arg->audit_info);
+	else if (entry->def.type == NETLBL_NLTYPE_ADDRSELECT) {
+		netlbl_af6list_foreach_rcu(iter6, &entry->def.addrsel->list6) {
+			map6 = netlbl_domhsh_addr6_entry(iter6);
+			if (map6->def.type == NETLBL_NLTYPE_CALIPSO &&
+			    map6->def.calipso->doi == cb_arg->doi)
+				return netlbl_domhsh_remove_entry(entry,
+								  cb_arg->audit_info);
+		}
+	}
 
 	return 0;
 }
