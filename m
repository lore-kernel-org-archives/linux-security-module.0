Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766260;
	b=hwT5oAvOLheRX5PfCNsPu5PUQQRS+8NcDDst1SjzT3s/bc1d18v7ERI7l5WU+2URDtpM
	 Ug8txH6PnGpzgOL++KvI0Og962fA25CjS5Nj+0soRftJEJ56GB4/u3xfMf76RaHLXtXhS
	 9WCBjc2xRF73IQTC8xkPU3an6DsfO3I7C/7w5NIrkccEhs+Zpp5oinhz874B5glCUqION
	 r6Os01UWLp9xXPUxNnXNV2bebGTtmOkISJ7+1Ghj3zoL09lJJObrA61ya/c8xE80n469X
	 QCTWFYykaiMKcq9WRxXSQroElSUzuSDImJejShaAgGF80gppIblc7LzcaRKaUmI5zxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zhpeeEWvxQlHrVzNb+mIhoDErkTSVTwiHheVg6+HwpA=;
	b=hKX9IRJ1Ps5f6w85/rbRQ/UPvTXbY2nEmsSpLO0ehPZXn5eqv8ct/0T7iH9kdW8qvMdP
	 G1r8q7ik7TvRWaEyuBVnzWNEQ9r1olFkekHeK6ZmlvHTS9UxGWH5Z0tadrCDA7aPvtkGj
	 gLKeMhv0fiQIX1p0NeHsKKvwfA6CK2Z7FQvpLTARjCg7OpqvzS0GMFAXR/XvGlOKwPtNX
	 n7VCEZb9jXML8q0gq9PRuD1FMhNFJlhqjQX5C4RyOad/nYv/BQNdJ96AyF2RaHH0uwzHe
	 Xrj0nwL4iJ50JUOUp1iJkJA+ms89zFPAvL2EHgzqxN0ZdcN3/tL6GtgtUDBzQXZwo7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VljMGSJL;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066F7606A321
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 07:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 066F7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VljMGSJL
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3863db981d4so10948940eec.0
        for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2026 23:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795766259; x=1796371059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zhpeeEWvxQlHrVzNb+mIhoDErkTSVTwiHheVg6+HwpA=;
        b=VljMGSJLexutiimCumKOoGUm6WsO6r/0+Z+nXt61SWCA+zdAzM06ZztMCKGHP5EFiY
         2miqjQh01oYY6Vkt1FCTBvV1m9iWlhmsjdsU/ne6eqvLoVCQqhEGzpMbd0dDaTjcnHkL
         ofx5oF9kCDnCON3nxwDvOdv06bVfa2YMcco5eDy7dvlJQbnDiol+7uZqUuiAs4CaNQyq
         O8DQWDvUbJ6rm0vWQ3iBKxBq5PyTbMubnM7o7d63l8JsHx5yUs7nPpLjd8SWF54fE+fF
         ej9rj2DVrUcKf6Wc7eFW92ewj4XjHVg6tZhlVYbG5GYz0vk3W4k7yEfR8iYtt0ns7AOT
         rh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795766259; x=1796371059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zhpeeEWvxQlHrVzNb+mIhoDErkTSVTwiHheVg6+HwpA=;
        b=AYnS39q/hldUjBhKcyKtwCXV40Mshrv2cZG8nvkDkOJNkrcH+w/2/7g7NPpkigrSP2
         d/wLCDHo8mfkflRQEoxCWF2QDG6yWjwiORvG0owSKM0ygUxuHt/cm5Ao8hukBvkG7gss
         8IqVmhg/58CavQrt5Pfubsxng6awlKBFBFmXkPramYHWd3gVYSim+OLCEVULsAANet80
         IZtC6bdCol8OhuBQLD5b8gUIYa6aUmVyVbRhoWu9loHBRjMBMdVYmKJkMmwSiBvnMBuS
         ufzqqrF2FPk41ma+CW1UTRRujxAq9pcy/USmy0onCxe4hdZIXGJO2CocilwW5ndFMVrS
         tlGg==
X-Forwarded-Encrypted: i=1; AL+hErGkWd3qGu4VE2Vq6DOnvPRuL0eGjGDFJ+ahiiAc+L+89amXc102fhaW3whzqrFU2yV1La4d2PgiNUgYGmEZyhhdqdGyynI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Fh/ZZpK0Ps76+a/EKMgE35A9oBJxkM854xp9L/38xfCGdgw2q
	yN+keMoRQ6aVw+X4ZfaSSsuzQhKUaPFRu/0eXHgWWxbo3byzOji91VW4
X-Gm-Gg: AZFdTZe4CbARPVYeIH7AEU4oQtR5zhhQ8BnDPTOwLOY86OWAVJ+4WXVIcWRJZ8abLk7
	lUGLOg7ilSP3x+WmdJ4W7Xl4Ys+zRi3XN6k02nGzXoLpV2tWtLdfARSjfgTqoS/udNOUqjKbJHN
	eVW+F9ts5vrPMOROQkL+bGYqJNUlYvybqFRUS8hzPLeX5XWoLos+QDzKu8VUHFo49mIGE1IZj1U
	L2Vqvznd2xXa6ydUy1HO9JGX96/9aBjToEeEpuckh/fEwkeQ0D2bHqJd3gwzi6qhjSeaPN6VApX
	VX3SSvJ8oO5H//cKOWSQ+BOgANhTAKL+IqlktDTBL9Ce886pK4JwBhTFzTde1IdoVCvnN/4LnOC
	ZPtcrjTUV5zcLO9KxJP+CfrVACeLHmcMZzi1x2DLUGgUcqyUJyEm2KKVYXSTKYBCKqlaXUuohP5
	5fkXIcYAjy4JKXzDekJQrzTW+WDbcVu4y/qDXYDnxTuYoxy9Aa38/xIuuqRvvwHKhsfHbfpeA8r
	Nkg+RL0n9rzn3HRqmEXNp0U/eg+np3XaSjstFvwTL89bac2aLNkivuV+ZMmgtdd/09xuMTRpluG
	BvFd1BRoHXKQbjMgqpqmlhWenML6AtbwLAtdvdFyyBxuRwU=
X-Received: by 2002:a05:7301:d81c:b0:386:b7d2:a279 with SMTP id 5a478bee46e88-386b7d2aba6mr12774546eec.34.1795766258950;
        Thu, 26 Nov 2026 23:57:38 -0800 (PST)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm65363944eec.13.2026.11.26.23.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 23:57:38 -0800 (PST)
From: Cong Nguyen <congnt264@gmail.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ima: allocate the new hash table before detaching staged measurements
Date: Fri, 27 Nov 2026 14:57:32 +0700
Message-Id: <20261127075732.252471-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ima_queue_staged_delete_all() moves the staged measurements to a local
list and clears the staged counters before it allocates the replacement
hash table with ima_alloc_replace_htable(). If that allocation fails, the
function returns -ENOMEM with the entries already detached from
ima_measurements_staged and never freed, because ima_queue_delete() is
only reached on success. The entries are then on no list, and a retry
finds nothing to delete.

Allocate the hash table first, so that the -ENOMEM return leaves the
staged state unchanged. Both steps run under ima_extend_list_mutex.

Fixes: c26d9d9246cc ("ima: Add support for flushing the hash table when staging measurements")
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 security/integrity/ima/ima_queue.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 67782c004cdf..d58b33950bcc 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -377,14 +377,6 @@ int ima_queue_staged_delete_all(void)
 		return -ESTALE;
 	}
 
-	list_replace(&ima_measurements_staged, &ima_measurements_trim);
-	INIT_LIST_HEAD(&ima_measurements_staged);
-
-	atomic_long_set(&ima_num_records[BINARY_STAGED], 0);
-
-	if (IS_ENABLED(CONFIG_IMA_KEXEC))
-		binary_runtime_size[BINARY_STAGED] = 0;
-
 	if (ima_flush_htable) {
 		old_queue = ima_alloc_replace_htable();
 		if (IS_ERR(old_queue)) {
@@ -393,6 +385,14 @@ int ima_queue_staged_delete_all(void)
 		}
 	}
 
+	list_replace(&ima_measurements_staged, &ima_measurements_trim);
+	INIT_LIST_HEAD(&ima_measurements_staged);
+
+	atomic_long_set(&ima_num_records[BINARY_STAGED], 0);
+
+	if (IS_ENABLED(CONFIG_IMA_KEXEC))
+		binary_runtime_size[BINARY_STAGED] = 0;
+
 	mutex_unlock(&ima_extend_list_mutex);
 
 	if (ima_flush_htable) {
-- 
2.25.1

