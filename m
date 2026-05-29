Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF0D306B31
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780025670; cv=none; b=Y0e6pHVlweC1cND4NlWys41srylcRbCJjCpUgBwnjv/aFS3o/HHMenSnU9ooFW+BfRwwgJKCLrR8/9SDS3KblUiZD2FdYS/w15ouXmND42qSJiFWZ8T5wt58t/Ba1p4S7HStedyDylPQ1IavdfoHVWghzPCBSH+ukj1CAuGi8ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780025670; c=relaxed/simple;
	bh=/X9Gx9nrlqqYvQNamVBrEU//0++TS8PHZQfk3nvxaZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p8vJaolQyD/LjaeqaVvHeaUquoATmyPU8M6qmxtQrr9MxY6YcSy8x7qRH97++ewB95d/k4nQ5JxkdAd49f6+FSKxtFwzFP/pybkRcu8mqNjRmcTS5X6frFxOBQkVmMnkGW1wtYd/hEk7cXcUWziwEhSpE9hz9SOp0lt+U6ghljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khzVJKIy; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khzVJKIy"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c80167f56cdso5706461a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 20:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780025669; x=1780630469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3sgklvG/C53PAwo2/sITXhbGcqoDKxJ+Vu3aUEy7pgU=;
        b=khzVJKIyzoldyqXjx0vtdgTgVinGQXl+ICHzf/maHvnabr/BCEJRjSMdvIW0FboD6L
         PysVk3ByfyB5OK8viJ4yUvE+jeN8b5aWR5GBV1d/FbU0bL9NvC0+HVeMr4YYY04KwKOw
         UXpKvGNDavxIRffcKjR1unIrKcB632gFyRcXGnRuM0PlzFR31wsJ9pdXt7o1cit7/4Q8
         eCJZp1okJdc925AdpEWGNcuoo1aAS+voGAhPNqwtjzEmtzzEOXVhH7EQFFgFcHj961rG
         UPkqPbbTxswj5GKFmchNN1qPUGR1dxuj9G3COzQZBFJoXoEnypNd4F0fqVttlAw5ufu6
         E61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780025669; x=1780630469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sgklvG/C53PAwo2/sITXhbGcqoDKxJ+Vu3aUEy7pgU=;
        b=o43kV/sU6hHGHAxCpzIx+giCLaDBhNWVpgQYPGXMKFTrFI6O9VR6zlx3sYBaRSVhW+
         AamjXigFX7qtpml85SoMs/XGLcEldcuvKAaXd7ecbSrxfOdjZY2hRXD+owwI3TNElKWM
         bfy5RpyFQKRUo2p2JuTSC+nRTNgnhC62ObHkG7lwbWUMaHWsfrZnnFtnstqnU8HxjGFT
         kN3IyRPPo1dk6HdphBt2cbNW9E6dQ45WsoXPxS9SMhmEbtgxvZcBMzZZ33HvpBU+O3bN
         H/4/2bExO53hTnwQUhc8mZkvzDD02CaLicIotg5r0nYl7+t87zk9mlqM9WEy1DuGQxa4
         qmbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Fc84psqOgDUOvsxqmA1Ak/rwGSUsV+2CbLa8vS3gfzIc+r1nPCAyrKYEoJ3hqxg/EgYtgbh6mSUuh0nynpB+NKHzKoC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQyllB8xC7lLhHR0LrT6JaA7CTxpHuNizm1EDsaXybKGbuo8w
	6SKShWQhDcq2JWAegV1R/CzpQ0PzZGZCHevhiT7tiWGn1Ke7YqL4qpNK
X-Gm-Gg: Acq92OH+8OL8Vmy8HCse3TpP0B/SZGmT8DuItnPwHRW7XEn/KbmpjGKLlbSXG22FyMS
	J6Kgbeat5sGx0/2oTlDZnoOWnk9NAq3O7eDXbJIw3r0zL9tifqVWMoKA4+pAz8tQL8otL1FpvmW
	6GC7TX3W6C4eNGDFrAnZvBVvLVmd45FUSl45uyerS9MI+ki1EyNE17RbvJc89RNH6ScQqVPsXfJ
	honyKg2iUE/LcNJSFTCRZQg7KX7Tz69/aDX427MLfMFZoYJJfJRl6WVlG4hmHyuhvf/gFTNgd+J
	dGNJr2G7RDBQ0i1I1MLuiw+XPCKTq9lvYLMDip20yEMpcJPHCKMjARkAbJ++Zzq+JkJXknenm8h
	asWerMnV+U68qXx7JbrAOIvE70ikTmzFgxkZ7eob6acOy/kYYQIY8SxHJU4/1g8uhFYctTCaPP1
	F8667lDSDNSIvmOSMpI21UsN82YucqWGqQIsip9KAc/sNVMnrJeuAEGKzW2pyEhSWK+7EAwLLO2
	G8b1n1e7mQ8MKHv4yH2AfBhQOXBYRpR5O855QH2Wm7lXo9a4u3OCuwj6ok9KiwgPOyRLeAskZia
X-Received: by 2002:a05:6a21:1519:b0:3a2:d79c:4149 with SMTP id adf61e73a8af0-3b412314c2fmr1086635637.28.1780025668501;
        Thu, 28 May 2026 20:34:28 -0700 (PDT)
Received: from bass-virtual-machine.. ([163.61.198.39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85771a7c04sm306821a12.1.2026.05.28.20.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:34:28 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: keyrings@vger.kernel.org,
	dhowells@redhat.com,
	jarkko@kernel.org
Cc: ebiggers@google.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH] KEYS: Use acquire when reading state in keyring search
Date: Fri, 29 May 2026 11:34:06 +0800
Message-Id: <20260529033406.20673-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The negative-key race fix added release/acquire ordering for key use.

Publish payload before state; read state before payload.

keyring_search_iterator() still uses READ_ONCE() before match callbacks.
An asymmetric match callback calls asymmetric_key_ids(), which reads
key->payload.data[asym_key_ids].

Use key_read_state() there to complete that ordering.

Fixes: 363b02dab09b ("KEYS: Fix race between updating and finding a negative key")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
Found by auditing READ_ONCE() used for synchronization.
A similar fix can be found in 8df672bfe3ec.
---
 security/keys/keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index b39038f7dd31..243fb1636f10 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -576,7 +576,7 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 	struct keyring_search_context *ctx = iterator_data;
 	const struct key *key = keyring_ptr_to_key(object);
 	unsigned long kflags = READ_ONCE(key->flags);
-	short state = READ_ONCE(key->state);
+	short state = key_read_state(key);
 
 	kenter("{%d}", key->serial);
 
-- 
2.34.1

