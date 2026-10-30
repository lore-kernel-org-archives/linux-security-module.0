Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355902;
	b=eAxa88Ql0LnndrWDoAfH0TjcPOsgVeEZEiX1rw7zGPCjpB/ov5pnaGH7jNdc8Mb1sk++
	 JFuUe5R3E8pwuwab9L0EeVVWX1upZXJp7qbD8iLcKIvzDlZc1ePuYYjp2mEF37O1xfd5h
	 jULQbNmX23kk0E1bLqZba2EzZHs8AINdLhfrcRBe7A4xjfOVZNjjdLXeSBquSq+iUyt/m
	 DY9EazNJeMfWyT7gqcYGS70ffLHsIBum+M/yAbsdIwrA9N8aOHWZ0plV0kEHwdDW2PAYT
	 6QhNEhYzpuzAkGTF0Nd8vCx51YDYKRHoL+qhJ38/hBpvdFf7oSxtRmoSdp/qCYfI36g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=B1hqtT8eKBTLj/QcI6rH3VmrUCTtV1HZS2iOUhxOQ1Q=;
	b=aGI0deGRKqUfZmc356JRvPT78BH0krFoRyMjHN2sSe0LX/CTyYbB7418434dNb7EFC32
	 Ozz60WsxRc7YIZ3sr6D/pV9F9QUnjWHseIiYLV857X8KaBSNqDOg6CN/P/YTxg29giRM5
	 e2KuOPn/7XYZi/B0Z7U4EtbOUoh8yO6jHMVTVQ3RkpvP08F9tosKbgptOXSLWHGth3iRp
	 tPaJ+hWw4O+UgAmujWXgwZF3J6DyzD7j7BKs+qC39/pKMOLP+nfDBW9q8UoWsls8wCBEr
	 kgR8zPUGdpz/6OKh0bvb4ygmVZUk7vjbHVVkP4x1GbLjg9oTEH1og4vFuFnn0hyOCgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zdsBaEyO;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70D4606A322
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 10:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E70D4606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zdsBaEyO
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so6307135e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793355900; x=1793960700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B1hqtT8eKBTLj/QcI6rH3VmrUCTtV1HZS2iOUhxOQ1Q=;
        b=zdsBaEyOCjb10altnH7e89JJDpKcj+5QNV20HaGnijPicGf9wengOHafV4jjC1j4cf
         31t/BTZIcdx67nAjV15lfSKsUjv7Fp7EJMShnaHOg30NO/Gz9D0LpUqLd3skcIWXAGkT
         FCXA2G8vVWd9LFQAxJbgpKpiLE7ErtfY51USIFBJKwBK/LZhezFSgtxJ6fx09gbz55n8
         ayQXmvXbf8344+nX/C0meEJmjnpl86X5YnXUwVzFs6z6ZbW9tgaxikZ3VRmtTmBNyXyb
         D0tOZfyhKKCaKrpn6P5DvnczIFnkQMcqnGn5j/ktsnuKewWHG74mcJqHp+i/HDbXF/1L
         0XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355900; x=1793960700;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B1hqtT8eKBTLj/QcI6rH3VmrUCTtV1HZS2iOUhxOQ1Q=;
        b=UYpOsLBxzG296qOoi2CoCce4ne04Z+8iBjFy2b3nYxh8EHOfPx91zBZ0VNvs4bks7G
         /LFPt5mmScZh+mBwlZ1Ds8TAZ2cboF7EaUYYvaj/x02UpSuIOu520OSeOzMFBrmCHBuE
         6rBo1FeuixtrZSfTJtd3tjuKw4oNKY9ZdsrEWaqlW43Rx/u1peWSoFb2Nkqzb/AcK8/k
         UGQQidWCoG87MWGR2Hr3YLhRUhofDPwxWlVheM7vBC3ekX77fT9BDYKrTDhUl1zg9T1n
         dkFYtjeb3t5meIOFFwHEsg9mioL+dk55bFYJhjU4VqVcvTqemr1CQ8e9UJTx70kORZDF
         KnHg==
X-Gm-Message-State: AFq9FYIWZYM7rstcjNgMimaPpvQPj7dyZyh/yhlMHlVQVHkQqhrqlVfv
	syCGw0zLjISoKXHGDb5POZcNPi14slrXPSB/uUEIJsFpPwvsnGVSzhhp
X-Gm-Gg: AYBFou2FnWK6uYW1kM9EFFmOf7gvDDMB9ru2WCrDwQtxf7uaQmUX0rn9aqDbRPfINf5
	BjWMB+Oumxjmm0ne2fmjfDSiHTZlVvjAKqwv2f42raQxam45FXGMY485eyfwSEGuVxj/Wrzmecg
	qIZJKMnyjDn0emwGo9ZY9LiIKmVSis++A/xr92wFIuOEiZuCwIk++6z0wF+rw5hQfefXvj3xXrC
	stLrEI48BdKvGo9rif7UDB0YR+Pes5mBsr/TwPJ5BFulOqKs80F29ya7ZBiiqQLGJI8lmUdzQX7
	BoUmUeSmxCS9EfIb3Lxj3EC0Mc5Q3ftsNtIT/IwvbwvOMQZnkevEZs7gAuN/BD5jdWtsoEuah/U
	KxhaLuSUpyaqJ/1I8q3H0SMNNR/ZmlSvf0CV5vfx7x3lrxMZsze48D22CcYE/J1ujAO2+P6gpEM
	T793rbpgPoqQbEzOmIsbalyJ+O5PNSIcCf0JWSkieYCrm8se9a+/E0xin367wjonoO1tCutHAae
	1g2avSDK71UEb7KON2322RLb12doof7k/ERrsmJS+p6vSJMV6wur+290dP5rYd2aJ5gSuuvNWqa
	W7J+sjXHnN/zc+LyxXpXecU1+67LLtGM2kw82DDW8JfHgPm1pwdofA==
X-Received: by 2002:a05:600c:848c:b0:4a3:5da2:38ae with SMTP id 5b1f17b1804b1-4ac17a3628emr38043095e9.14.1793355900196;
        Fri, 30 Oct 2026 03:25:00 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6e63e0esm66892605e9.12.2026.10.30.03.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:24:59 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	Dwi Siswanto <me@dw1.io>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] landlock: Fix layer composition of LANDLOCK_ACCESS_FS_REFER
Date: Fri, 30 Oct 2026 11:24:08 +0100
Message-ID: <20261030102411.12985-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030102411.12985-1-gnoack3000@gmail.com>
References: <20261030102411.12985-1-gnoack3000@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In landlock_get_fs_access_mask(), only add the
LANDLOCK_ACCESS_FS_REFER right if any filesystem access rights are
handled at all.  This prevents us from accidentally treating
non-filesystem layers as if they handled LANDLOCK_ACCESS_FS_REFER.

landlock_get_fs_access_mask() is used when initializing the layer
masks for doing access right checks, so this bug meant that we
unintentionally denied "refer" (e.g., link, rename) operations in
layered cases, where the same operation would have been accepted if
only either one of the two layers had been enforced.  If the rulesets
individually allow an operation, the composition of these rulesets
should also allow it.

The bug only manifests as soon as one other layer handles filesystem
access rights.  Otherwise, Landlock filesystem path walk is guarded by
an early exit for the case that no filesystem-enforcing layer exists.

Reported-by: Dwi Siswanto <me@dw1.io>
Link: https://github.com/landlock-lsm/linux/issues/67
Link: https://github.com/landlock-lsm/go-landlock/issues/66
Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Cc: stable@vger.kernel.org
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/domain.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 428c1d9890db..693e569f5387 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -258,9 +258,16 @@ static inline access_mask_t
 landlock_get_fs_access_mask(const struct landlock_domain *const domain,
 			    const u16 layer_level)
 {
-	/* Handles all initially denied by default access rights. */
-	return domain->handled_masks[layer_level].fs |
-	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+	access_mask_t handled = domain->handled_masks[layer_level].fs;
+
+	/*
+	 * Handles all initially denied by default access rights, but only for
+	 * layers handling filesystem accesses.
+	 */
+	if (handled)
+		handled |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+
+	return handled;
 }
 
 static inline access_mask_t
-- 
2.56.0

