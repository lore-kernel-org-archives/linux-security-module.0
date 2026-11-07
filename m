Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794076538;
	b=RBQFUJJCm9XFPmzbBeVkfSwxRxyPYqjRYI8LDvQaAo8+UCMyBJ/08OpyeYvS8gJ6gArb
	 MvmiFIUkATeeFMuIp+0jie5cVUFq+8OK0u/fHxnaxt+RddlfYEAI/o4WyPBtwFfZ8T42Z
	 d+UI1UE7wzFj0o+wFNzBaH4dlnlrgrYskAebiUZVdxWHo0sx5nc0ML1Ny5Bc4RFc/6IQt
	 G7K8jwJhVpeI389nvJH+3ERmq1+iDOMSzQ6zeYBcgGC7woMGrO1Kmbj2xQO44486urAW+
	 ZWv50Nabzj+B+/Z/shS+VFFi8snfvEvxkvqP6cGAmkWww0KuxpEe+h+TfT+PlIWnQRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794076538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=edAgMeDTSdzzewfHuukTFL6aVX95e9fem3szzjNzGNs=;
	b=zJbORWcphIxwSb5CtMc0XY++7ULQDmTnnfpg7cQiyGnzxpxe5biS5J7EFJ3vpjkhJeAe
	 8c4eAMhicjJLlfZdE+lItMCtdbfPbvesNcPR7g3Hl+qI45Ru2y48WmzUO1DZjKvoKljLL
	 lpYns6SgfPljGKmjxF+xXeQ0Gxte6zpXZzhJNVs2nm/deDSYnwKryg7h+LZxgAAjNEdDa
	 Wml/4/QyBKCh7mE7wNsMKVLWTJQVG5KvDCMWQTLofO77kp963AMhrmiYaJ6HfvKnfFS9C
	 u4+AIqcrHvvtrTXq+N4iit89YHSkwf77av+W36wH/1AotC0kCN2K2o2/1zMFsXhmkQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KqcwiZ3n;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27C606A32C
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 18:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E27C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KqcwiZ3n
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so644634a12.3
        for <linux-security-module@vger.kernel.org>; Sat, 07 Nov 2026 10:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794076537; x=1794681337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=edAgMeDTSdzzewfHuukTFL6aVX95e9fem3szzjNzGNs=;
        b=KqcwiZ3niNxWjz9hp9UhKgTfpndMRTTSiJDtL6X30kmtqhy87YGmMfb+zrQ9BMf9Tn
         lmnnSftcmxK69g872T+ghkWQIjhefoQ4azpZ9psO/5EwDUEOaygpREJwXq1pcqAAAmti
         wIPYQ7dPF73p7SYGZ17vM3360ibJ/CEpt6xBYPrvsY3Am8UbL7gnQ8ZdAddKCn5Jaknb
         oFHoexi9TCVKysYqbZGRFKKUf1Hte8QKOWKK0+mN6M+j57tKci9afJqc3/owDNDAw0TO
         z6qn6Z9o61otCASh3u9LlUavTlyeEzkDKb3jZmszMja8kIn8TS9d5/v3AD6W8nv8rFIV
         4tIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794076537; x=1794681337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=edAgMeDTSdzzewfHuukTFL6aVX95e9fem3szzjNzGNs=;
        b=22fk/jjO5THwT/fpdTcMKi4+Oc0NMzyO1h/jTr6MDPANy14RTij+KmV42Rc3kvL0MG
         TPkd5Wc6z8SUGPZHvj9xmcn5hjN8bz0N0SzvH86G4KQZ519rVGdKV1N5gJO7MBKKYvCE
         EiIhOPiRVYJOxt22oe98/yhUko+Giu42n3QPyh7j5UPE/P53kkTiewmXHMkr4w28HH38
         5m7xL55pgZneJsj06odCPc/mXIagExe7tQVzGd36/AK8vOW3zF3Ka9mCiSLJPyv0QVvV
         OVbE/7uI8E7himcbv0PgNk8bkeBF87Er3UoNj4gJ42DQcNKvcZbifuuIBaaRsPcJuHco
         qliw==
X-Gm-Message-State: APuU4Z+ow5khDTw79aIsaP1KMt/8WA5AfuoR+dI+CqQWb9ZY1OD2Jds5
	1sR13qC9teTjtT1r3ByPsq6YWXM4cEwKOqMnVReo4On/3bl0QeDYfDrO
X-Gm-Gg: AYBFou2T8NZhZHrG7t7i/u1CLwsTeUOpaJh09Zfziksj89TwFOCtfYGaW96CHQ3TVHD
	h79rbwp0uU5aPGH/rNwkuCxxpkLVCqRGjcw3Et0y5hsDg+W1kOnW2U5cOlttU1SFb5c1jlXaByh
	lswbp5Cb6fU5YLHUMJ4ryr1sn2TMVD6BP9ilL9jCTBJKdADUvCgKlbsbneUL+HfKidcHsvqBltL
	D1heKtNTCikl2AG0qf+3ezgZiyP5g4ddS6oNOEX5jpVnoPCLq01bPnLp8nTXLZZD4/rcbSqe31X
	4Yn+Z1rc2qz9sm5cpoEUWCvLiKj+xheJ9fqE0KhAL24U+kLNCnDdBWLGUD5HbWbY/axaZPkn5CC
	2eR7jUmKvhYml7XhIff0zdg0WIgA6X9zQIABGarEh95P3nRfwy0G6sFxafcrepqlVbALvgaR8pR
	kGkrHztFdLwXmzNMUSsVPkjsykAnhWeHgX5sRbQvNhCe2gK7uaaCMyH0Ohm5lBEj7nX7rGQvVpP
	xDhGKE/BE3cAbTM/YR+W3EXyH7kZKTb2Vs/JmimMqhJTn6lLLrmIKSaII3KwOGfISoieXOq/WdQ
	o/VvMd35SxTesi9Ol7Dl+N/YDSTthYpLCtMYlAcDUPsouaWY3HIhZxveO39MtmDAA/u32cs8EWC
	LAVM=
X-Received: by 2002:a17:90b:4d82:b0:3a8:f70f:2437 with SMTP id 98e67ed59e1d1-3b0db722a02mr5510329a91.50.1794076537030;
        Sat, 07 Nov 2026 10:35:37 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1152fa888sm1392566a91.9.2026.11.07.10.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 10:35:36 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] apparmor: hold candidate profile reference during attachment lookup
Date: Sat,  7 Nov 2026 10:35:15 -0800
Message-ID: <20261107183514.1575928-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

find_attach() retains the best matching profile in candidate while walking
the profile list under RCU.  When matching xattrs, it pins only the current
profile and drops the RCU read lock around aa_xattrs_match().  A concurrent
policy removal can therefore free an earlier candidate during this window.
If the policy revision changes, the retry also preserves candidate and its
ranking state because they are initialized above the restart label.  The
final aa_get_newest_profile() then dereferences the freed profile.

The reproducer triggers:

  BUG: KASAN: slab-use-after-free in aa_get_newest_label
  Read of size 8 by task poc
  Call Trace:
   aa_get_newest_label security/apparmor/include/label.h:413
   find_attach security/apparmor/domain.c:505
   profile_transition security/apparmor/domain.c:700
   apparmor_bprm_creds_for_exec security/apparmor/domain.c:1034
   security_bprm_creds_for_exec security/security.c:793
   bprm_execve fs/exec.c:1861
  Kernel panic - not syncing: KASAN: panic_on_warn set ...

Take a reference whenever a profile becomes the candidate, drop the
previous candidate reference, and reset all candidate state when restarting
the search.  Release the held reference after acquiring the newest profile
or before returning an unsuccessful match.

Fixes: 8c62ed27a12c ("apparmor: fix aa_xattrs_match() may sleep while holding a RCU lock")
Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Closes: https://lore.kernel.org/linux-security-module/20261105164839.66760-1-shuangpeng.kernel@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 security/apparmor/domain.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index af9e8431e3ea..53465caca702 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -395,9 +395,9 @@ static struct aa_label *find_attach(const struct path *path,
 				    struct aa_ns *ns, struct list_head *head,
 				    const char *name, const char **info)
 {
-	int candidate_len = 0, candidate_xattrs = 0;
-	bool conflict = false;
-	struct aa_profile *profile, *candidate = NULL;
+	struct aa_profile *profile, *tmp, *candidate = NULL;
+	int candidate_len, candidate_xattrs;
+	bool conflict;
 
 	AA_BUG(!path);
 	AA_BUG(!name);
@@ -405,6 +405,12 @@ static struct aa_label *find_attach(const struct path *path,
 
 	rcu_read_lock();
 restart:
+	aa_put_profile(candidate);
+	candidate = NULL;
+	candidate_len = 0;
+	candidate_xattrs = 0;
+	conflict = false;
+
 	list_for_each_entry_rcu(profile, head, base.list) {
 		struct aa_attachment *attach = &profile->attach;
 
@@ -477,7 +483,11 @@ static struct aa_label *find_attach(const struct path *path,
 				/* Either the same length with more matching
 				 * xattrs, or a longer match
 				 */
-				candidate = profile;
+				tmp = aa_get_profile_not0(profile);
+				if (!tmp)
+					goto restart;
+				aa_put_profile(candidate);
+				candidate = tmp;
 				candidate_len = max(count, attach->xmatch_len);
 				candidate_xattrs = ret;
 				conflict = false;
@@ -487,7 +497,11 @@ static struct aa_label *find_attach(const struct path *path,
 			 * old exact non-re match, without conditionals such
 			 * as xattrs. no more searching required
 			 */
-			candidate = profile;
+			tmp = aa_get_profile_not0(profile);
+			if (!tmp)
+				goto restart;
+			aa_put_profile(candidate);
+			candidate = tmp;
 			goto out;
 		}
 	}
@@ -495,15 +509,17 @@ static struct aa_label *find_attach(const struct path *path,
 	if (!candidate || conflict) {
 		if (conflict)
 			*info = CONFLICTING_ATTACH_STR;
+		aa_put_profile(candidate);
 		rcu_read_unlock();
 		return NULL;
 	}
 
 out:
-	candidate = aa_get_newest_profile(candidate);
+	tmp = aa_get_newest_profile(candidate);
+	aa_put_profile(candidate);
 	rcu_read_unlock();
 
-	return &candidate->label;
+	return &tmp->label;
 }
 
 static const char *next_name(int xtype, const char *name)
-- 
2.56.0

