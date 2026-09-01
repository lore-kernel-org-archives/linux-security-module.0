Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A43E1D130E
	for <linux-security-module@vger.kernel.org>; Tue,  1 Sep 2026 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272107; cv=none; b=JR04SN+LSvk710eDW9bAM/nrWz/Or+wmCKlIGUFyL5SlQ5WG+paUvm/wJvnooHwyYnIKKr4KNAvPrgFeslYlmdpXAGaNivp1O+IQdmjWD4eJt9karaM+KcuIyern7MxqK0fkushNHmP6kYcXCFqwhJGBqXTkA3MHtcjHFaY5FOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272107; c=relaxed/simple;
	bh=CsJNy4BO+fjZ02cve6rSLEVHTvix8T+IyaDdsEQSpOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wy/eeT7l8IMExFmayhtzriroTsaV9kDsbqBOesax8UKdgWzWgqOx/tLOfvsiAPYlD6OxgSQ/HhoYzNaO3nSW1LmsQi3iCz/79MGcXAgmflDH8FnJA5BOK+zXaO2YINZipNCVKVZg2cU10pH5uvY2a2Fdr9jXzFvdRhOxjoMMaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=fwyyPOtM; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="fwyyPOtM"
Received: from sec2-plucky-amd64.. (lfbn-idf3-1-218-1.w90-22.abo.wanadoo.fr [90.22.217.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C9FA44000D;
	Tue,  1 Sep 2026 14:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788271686;
	bh=E9DJYrw3QEd+ZMFQ8S7oW66VZq1HZG+GshXJqUqjsTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=fwyyPOtMjehsoxH12/Fpg8EEWQVNF/jnUL7mC+hEbhRMb40RZ4rg8Ofss4uRplO4h
	 4E3s5aJr7LDDgf+3v8zqnOb/Ls8Zon4UxCCJ9S/vIjDXmTuP8RitOI+ekjiccpwc8H
	 I+5m9o8GUBJfbyXWvDoh0CUlIxbNXS5iCtABEkowHwje+4++NdXfLix+hQx4WMNjlg
	 1WAyBiH87fONmjih62ASSIAL1YeW0mQTtacT7Uid25yWG8NT3lVG4Y2US6I9PbfTAU
	 zCy+DxLjonNRs3dCeUdzjLglqOTNdRhdAdz09Jj5AXTXDkFfKciPwRBIqf+RjRHRAr
	 KwsfB2jF/umhTqk/XlNHDZ6OKjjUHY8aXg1f4i3PV2OfrmYvkwJW5ofzsJrllZxqJi
	 QCtGDywCjL1pbSfsbb3MxAbMx/mxheNAsF70CQx5UvVCv/3kzubYeABPwPFL3xAm39
	 qnRKiiFTpZmeWmWzElDYuk3zW9hsDvjCZ3vwSrdgbmI/4xs4rcW7jiTryOpF3UaEYe
	 /ht2zYgKzob+w4A6Kedz+Y6vbHD/viDHxKxytn/SGA0XiqW9qIMXWNsjtL+nxOFqqb
	 zlYh1QyIuw+LOLWna44wcuo5nCN9EbWxhchid/MfO8u1bWXtlOXmqdJ7Fi12qwqY6n
	 eHeBztvDmnivsHOPQttIouFw=
From: =?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH] apparmor: convert duplicated dfa transitions to match_char()
Date: Tue,  1 Sep 2026 16:07:15 +0200
Message-ID: <20260901140740.2629-1-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For historical reasons several matchers duplicate the dfa character
transition instead of using match_char().

This is because aa_dfa_match_until() and aa_dfa_matchn_until() were
written on a branch that did not yet have match_char(), and copied code
from aa_dfa_match(). leftmatch_fb() used the same pattern.

When match_char() added support for diff-encoded states, the change was
never ported to these copies.

match_char() resolves a diff encoded state by using def[state] and
retrying the same character, until it reaches a state with a valid
transition. The copies instead do a simple `state = def[state];` after
the character is consumed, so on a diff encoded state one byte is dropped
and the walk continues from the diff parent in the wrong state.

This makes an unnamed px/Px/cx/Cx transition resolve to no profile, and
exec fails with

  apparmor="DENIED" operation="exec" info="profile transition not found"

Convert the three copies to match_char(). For a dfa with no diff
encoded state this is a no-op.

This bug is latent until the kernel advertises policy/diff-encode.

Closes: https://gitlab.com/apparmor/apparmor/-/work_items/663
Fixes: 21f606610502 ("apparmor: improve overlapping domain attachment resolution")
Fixes: cf65fabc2a2c ("apparmor: add first substr match to dfa")
Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
---
 security/apparmor/match.c | 52 ++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index 7713484f6a36..5e5030c12393 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -614,7 +614,7 @@ aa_state_t aa_dfa_match_until(const struct aa_dfa *dfa, aa_state_t start,
 	u32 *next = NEXT_TABLE(dfa);
 	u32 *check = CHECK_TABLE(dfa);
 	u32 *accept = ACCEPT_TABLE(dfa);
-	aa_state_t state = start, pos;
+	aa_state_t state = start;
 
 	if (state == DFA_NOMATCH)
 		return DFA_NOMATCH;
@@ -625,22 +625,18 @@ aa_state_t aa_dfa_match_until(const struct aa_dfa *dfa, aa_state_t start,
 		u8 *equiv = EQUIV_TABLE(dfa);
 		/* default is direct to next state */
 		while (*str) {
-			pos = base_idx(base[state]) + equiv[(u8) *str++];
-			if (check[pos] == state)
-				state = next[pos];
-			else
-				state = def[state];
+			u8 c = equiv[(u8) *str++];
+
+			match_char(state, def, base, next, check, c);
 			if (accept[state])
 				break;
 		}
 	} else {
 		/* default is direct to next state */
 		while (*str) {
-			pos = base_idx(base[state]) + (u8) *str++;
-			if (check[pos] == state)
-				state = next[pos];
-			else
-				state = def[state];
+			u8 c = (u8) *str++;
+
+			match_char(state, def, base, next, check, c);
 			if (accept[state])
 				break;
 		}
@@ -675,7 +671,7 @@ aa_state_t aa_dfa_matchn_until(const struct aa_dfa *dfa, aa_state_t start,
 	u32 *next = NEXT_TABLE(dfa);
 	u32 *check = CHECK_TABLE(dfa);
 	u32 *accept = ACCEPT_TABLE(dfa);
-	aa_state_t state = start, pos;
+	aa_state_t state = start;
 
 	*retpos = NULL;
 	if (state == DFA_NOMATCH)
@@ -687,22 +683,18 @@ aa_state_t aa_dfa_matchn_until(const struct aa_dfa *dfa, aa_state_t start,
 		u8 *equiv = EQUIV_TABLE(dfa);
 		/* default is direct to next state */
 		for (; n; n--) {
-			pos = base_idx(base[state]) + equiv[(u8) *str++];
-			if (check[pos] == state)
-				state = next[pos];
-			else
-				state = def[state];
+			u8 c = equiv[(u8) *str++];
+
+			match_char(state, def, base, next, check, c);
 			if (accept[state])
 				break;
 		}
 	} else {
 		/* default is direct to next state */
 		for (; n; n--) {
-			pos = base_idx(base[state]) + (u8) *str++;
-			if (check[pos] == state)
-				state = next[pos];
-			else
-				state = def[state];
+			u8 c = (u8) *str++;
+
+			match_char(state, def, base, next, check, c);
 			if (accept[state])
 				break;
 		}
@@ -751,7 +743,7 @@ static aa_state_t leftmatch_fb(const struct aa_dfa *dfa, aa_state_t start,
 	u32 *base = BASE_TABLE(dfa);
 	u32 *next = NEXT_TABLE(dfa);
 	u32 *check = CHECK_TABLE(dfa);
-	aa_state_t state = start, pos;
+	aa_state_t state = start;
 
 	AA_BUG(!dfa);
 	AA_BUG(!str);
@@ -769,13 +761,10 @@ static aa_state_t leftmatch_fb(const struct aa_dfa *dfa, aa_state_t start,
 		/* default is direct to next state */
 		while (*str) {
 			unsigned int adjust;
+			u8 c = equiv[(u8) *str++];
 
 			wb->history[wb->pos] = state;
-			pos = base_idx(base[state]) + equiv[(u8) *str++];
-			if (check[pos] == state)
-				state = next[pos];
-			else
-				state = def[state];
+			match_char(state, def, base, next, check, c);
 			if (is_loop(wb, state, &adjust)) {
 				state = aa_dfa_match(dfa, state, str);
 				*count -= adjust;
@@ -788,13 +777,10 @@ static aa_state_t leftmatch_fb(const struct aa_dfa *dfa, aa_state_t start,
 		/* default is direct to next state */
 		while (*str) {
 			unsigned int adjust;
+			u8 c = (u8) *str++;
 
 			wb->history[wb->pos] = state;
-			pos = base_idx(base[state]) + (u8) *str++;
-			if (check[pos] == state)
-				state = next[pos];
-			else
-				state = def[state];
+			match_char(state, def, base, next, check, c);
 			if (is_loop(wb, state, &adjust)) {
 				state = aa_dfa_match(dfa, state, str);
 				*count -= adjust;
-- 
2.51.0

