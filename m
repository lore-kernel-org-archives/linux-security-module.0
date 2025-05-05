Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CAC3982BD;
	Mon,  5 May 2025 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487264; cv=none; b=QthfOreH5hbqRRAEpKiLQ8FwgT5Qkv/bDOG+9MA428PLVhNbNmFah6W9C0LwgYGy8J4XOs8mK4YmSFSOzJCsVcakzxMsCY3UrPPbF0CJ4LWmAcmfAVURLa3OhsxV9NaX6fON6RsPgMwIzVzTenlb4a/kkxWVxXNxpzSdu8eV/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487264; c=relaxed/simple;
	bh=uj0KpZHU7zZBolhsv3LfmtH2uwGVxWca9Mqq71j2Waw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iIiJnJUAqxGHPkcPfSl5OT8PfM5P5GVt4LNZBu693/VL74TVJnjkv3l3ciFdY1/B20QdFZRoZLbLSr3sXtqnFFoORuZnbUtH84EwPqYBh99KRC1ERqBjc5L6NcnqfJjgYqDcQ6qCiKYROdK+0ccDlAc3BM1d1N4RmjZtgJanMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwfyOPlv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwfyOPlv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C94C4CEE4;
	Mon,  5 May 2025 23:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487263;
	bh=uj0KpZHU7zZBolhsv3LfmtH2uwGVxWca9Mqq71j2Waw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwfyOPlv0jWQa99BRsxF+fGj2rCHu9wFPpqQ2VyUi4gU48klLfdmtXB/waPxUb95o
	 wGg58IM4v4CDywEjcmKt0vwJzKL6+IhOmfUwbmrjU34ifkngK8PRSIYeJFrFIthSn4
	 /W3T/4Y5N8Ekqf6Z7NvHkndyCkJYhS51KVHreKCw/ywPwAiIDgZq2aOe1cmbW91Mxm
	 yo58yNXgWxoi/MGigkPCnxwDjw2TO3kXKVADZHGLjVL9y539oG06HjFk9J3s2zGfRF
	 iF8QPLBqX/pCU5WWptuquPFQK73Up6J3/N00w5+vvg2HR7ZvMkNVb+RYvuHf+DlO1s
	 ZrmMS+Rp1rusg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Andreev <andreev@swemel.ru>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Sasha Levin <sashal@kernel.org>,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 088/114] smack: recognize ipv4 CIPSO w/o categories
Date: Mon,  5 May 2025 19:17:51 -0400
Message-Id: <20250505231817.2697367-88-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Konstantin Andreev <andreev@swemel.ru>

[ Upstream commit a158a937d864d0034fea14913c1f09c6d5f574b8 ]

If SMACK label has CIPSO representation w/o categories, e.g.:

| # cat /smack/cipso2
| foo  10
| @ 250/2
| ...

then SMACK does not recognize such CIPSO in input ipv4 packets
and substitues '*' label instead. Audit records may look like

| lsm=SMACK fn=smack_socket_sock_rcv_skb action=denied
|   subject="*" object="_" requested=w pid=0 comm="swapper/1" ...

This happens in two steps:

1) security/smack/smackfs.c`smk_set_cipso
   does not clear NETLBL_SECATTR_MLS_CAT
   from (struct smack_known *)skp->smk_netlabel.flags
   on assigning CIPSO w/o categories:

| rcu_assign_pointer(skp->smk_netlabel.attr.mls.cat, ncats.attr.mls.cat);
| skp->smk_netlabel.attr.mls.lvl = ncats.attr.mls.lvl;

2) security/smack/smack_lsm.c`smack_from_secattr
   can not match skp->smk_netlabel with input packet's
   struct netlbl_lsm_secattr *sap
   because sap->flags have not NETLBL_SECATTR_MLS_CAT (what is correct)
   but skp->smk_netlabel.flags have (what is incorrect):

| if ((sap->flags & NETLBL_SECATTR_MLS_CAT) == 0) {
| 	if ((skp->smk_netlabel.flags &
| 		 NETLBL_SECATTR_MLS_CAT) == 0)
| 		found = 1;
| 	break;
| }

This commit sets/clears NETLBL_SECATTR_MLS_CAT in
skp->smk_netlabel.flags according to the presense of CIPSO categories.
The update of smk_netlabel is not atomic, so input packets processing
still may be incorrect during short time while update proceeds.

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smackfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 44f0b5148a5b9..6402626e47c69 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -921,6 +921,10 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	if (rc >= 0) {
 		old_cat = skp->smk_netlabel.attr.mls.cat;
 		rcu_assign_pointer(skp->smk_netlabel.attr.mls.cat, ncats.attr.mls.cat);
+		if (ncats.attr.mls.cat)
+			skp->smk_netlabel.flags |= NETLBL_SECATTR_MLS_CAT;
+		else
+			skp->smk_netlabel.flags &= ~(u32)NETLBL_SECATTR_MLS_CAT;
 		skp->smk_netlabel.attr.mls.lvl = ncats.attr.mls.lvl;
 		synchronize_rcu();
 		netlbl_catmap_free(old_cat);
-- 
2.39.5

