Received: from outbound.baidu.com (mx14.baidu.com [220.181.3.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 118A1364EAA;
	Thu,  8 Oct 2026 03:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429851; cv=none; b=XtMdqt3KRwostQgTZyUjiCjY9UmuuUwgjvMQQHkPq+SIJBfkVjrnVk/PwBArBf6JcyfrSwAHhXw3kyaz56Np330mXAyRFoPiqK9VNm+hlS4CfDYF8VKpSlzgwqy2h2Gh3U/LgxyGPfIWPLirxcB87fg2tbOn31c0IZYsvY1iPCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429851; c=relaxed/simple;
	bh=4AvEwY2cUnZrmTgunvfeNSLhssZjcgm/24muDyY1EFo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aGXd8/oRNZHXw7RitZ5I3pMPgXxKHuVTajdj6QuR7YP6X7CdW6WOQ2sA2lBrLp6c2eiMGpKnkfkXPYFrLtTeRPegj+kuCNIYamnyynes221Ngc8C8w36Y/nS4slG6Asvk9DPgX6eIdMyWQbPo8gpO+DqIOmivC8qm7/0hpO6+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=YtmnNBj9; arc=none smtp.client-ip=220.181.3.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="YtmnNBj9"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: John Johansen <john.johansen@canonical.com>, Georgia Garcia
	<georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
	<apparmor@lists.ubuntu.com>, <linux-security-module@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] apparmor: avoid potential double free when remapping DFA tables
Date: Thu, 8 Oct 2026 11:15:33 +0800
Message-ID: <20261008031533.2205-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc11.internal.baidu.com (172.31.3.21) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1791429344;
	bh=lUvjjuqbzXiwEaLxsb/yXr637XjK2E+u2wTSP//VJio=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=YtmnNBj9kwL3IdHM+k+HZIvn9zFq+kYZcbxGCIp6KXpP32+xKZ7+Kwd2qlAS8r19h
	 CNkyMIdwYzUhZaqJlhnXRJKjei0HFUu9HAv+uxHWmKVdeZPUm36SIdt3D4pGx4JpzU
	 dGNCRfsJiiHUKr8lYbrJShqJ6ygDZUSFeDzEFNe5g3o2l5idvIIbM2ON4huZ0jG5EC
	 YJ/P2YCDAIh3cOxeCnb5U82gnOhfeN/6dDNniuvL6f5lolJzRMwwpCIaLUCTRB2CU4
	 FAHDSJFOJzMGnJB8x2u6UVqUotnaUbblDZ61r8AbWLa0AvZHlENDNW/dbpmxE0MOUV
	 kK16yRLhAUxbQ==

From: Li RongQing <lirongqing@baidu.com>

When unpacking a DFA, aadfaunpack() stores a table in dfa->tables
before attempting to remap a 16-bit table to 32-bit.

However, remapdata16todata32() frees the original table when
allocation of the new table fails. This leaves the corresponding
dfa->tables entry pointing to freed memory. If the unpacking then
fails, dfafree() attempts to free the same table again.

Only publish the table to dfa->tables after any required remapping
has completed successfully, so that dfa->tables never contains a
pointer to a table that has already been freed.

Fixes: 9208c05f9fdf ("apparmor: add support for 2^24 states to the dfa state machine.")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 security/apparmor/match.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index 7713484..ca30a42 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -397,7 +397,6 @@ struct aa_dfa *aa_dfa_unpack(const void *blob, size_t size, int flags)
 		/* check for duplicate table entry */
 		if (dfa->tables[table->td_id])
 			goto fail;
-		dfa->tables[table->td_id] = table;
 		data += table_size(table->td_lolen, table->td_flags);
 		size -= table_size(table->td_lolen, table->td_flags);
 
@@ -414,9 +413,9 @@ struct aa_dfa *aa_dfa_unpack(const void *blob, size_t size, int flags)
 				if (!table)
 					goto fail;
 			}
-			dfa->tables[table->td_id] = table;
 			break;
 		}
+		dfa->tables[table->td_id] = table;
 		table = NULL;
 	}
 	error = verify_table_headers(dfa->tables, flags);
-- 
2.9.4

