Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021781;
	b=oV0kkBqfdztrFOHZF7dMdrDWbXskb5k9dIP8DZaVhboOrJYUS1R3/mxyhw/V7MZGtgtB
	 FgQyzILJCBy6rlR/EcYMKuq6t7BkJLzWsLUosZ399DWUv+D93lwZsQOBz41lIPp7pbo9v
	 XHgg3L3/Y+0jkTUvipm6rrOwuldyUcIUNd+mUIqAEXUXRkaXQQHYaSC3STAkk5FCY5ycO
	 MF+rFgM/VkYc/kRLCUZOfaaAKVGwtzroAyQ3fgfBBeXK0B9D9JDl0/Jhlfm7F6E4Afm4T
	 0TNDSx5HxBGuhHw/bVLEW+A8u8OJcmy5llr331AEj4sD2exaBklmNKFejkoDC97qFgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021781;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PTD8vsLA4VFfeYmEIL50Y436blAuTVZEYGwnTnp7CWc=;
	b=cdPCm8u04/EfCc/1Q7H+FlBIy06mWtOMiIk+pTVvLKu4UgeXGHnAD5o61N0Miq6YM8Nz
	 956rbKOcg4lci84agc0eVUHBcIRrVHq5v3pg7eOh1gMZ1whFol1O3e2Zel/fIL4aG7TZF
	 veghzY65hxOJZHEkyY/9VRBM6vT5+AXHe3CsOEhCsThHlf2LVS1euUqg3ahhpQ5bzx+J2
	 Y2O7mQnL8phZebIbWv237lNjpIILRAkvYo7yOXUi+s9OJmnoufp6oAXku2sGNKaDFpNRz
	 ktR5t6Fd3ZxQT55Icv2V3mgE6zUgCiKJ2Kf/naixe86/uOdrPU1YaRY+wLtwBE7sLig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.com;
	spf=pass smtp.mailfrom=posteo.com;
	dkim=pass header.d=posteo.com header.i=@posteo.com header.a=rsa-sha256 header.s=1984.8680eb header.b=KJ8+6T2l;
	arc=none smtp.remote-ip=185.67.36.65
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D89606A322
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 13:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1D89606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.com header.i=@posteo.com header.a=rsa-sha256 header.s=1984.8680eb header.b=KJ8+6T2l
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 2C8C6240028
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 14:36:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.com;
	s=1984.8680eb; t=1793021772;
	bh=PTD8vsLA4VFfeYmEIL50Y436blAuTVZEYGwnTnp7CWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=KJ8+6T2lyvFCwc1WDPknSq45YbhYbIpuc3x0EJ5n/dkdm84zomfC80Mox0EoWzZ6x
	 z8y1J92/Vx171sFxieg86nAa5MOyi7FKx7eprLrdrbwvwmtwGX0Iar34MImO5LvFQI
	 l1uHBbGTIHNyb5W4VkyF8f/2C0lt8mywvirF0zPDOJKpOefvfKjc9xMxUT1zxvedRq
	 7LtVwV51hf3ziHto2uLKgdMT6yXjYzFe0lvYjh6LqVvzr6UIvSENZUd1b9ZP71NhQr
	 gaVRm1kREuVHiBPuqNzkXXn6R3lLRZAEnTE4v25kGdPiPm9BN1UoXKbjwxDUr3Tm+D
	 89++5JQtaX8TA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jCvlt44T9z6v0l;
	Mon, 26 Oct 2026 14:36:10 +0100 (CET)
From: =?UTF-8?q?Patrick=20Gr=C3=B6ssing?= <invarianztheorem@posteo.com>
To: John Johansen <john.johansen@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Patrick=20Gr=C3=B6ssing?= <invarianztheorem@posteo.com>,
	stable@vger.kernel.org
Subject: [PATCH] apparmor: handle diff-encoded states in leftmatch_fb()
Date: Mon, 26 Oct 2026 13:36:11 +0000
Message-ID: <20261026133600.11252-1-invarianztheorem@posteo.com>
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

leftmatch_fb(), used by aa_dfa_leftmatch() and therefore by find_attach()
to match profile attachments, open-codes the DFA transition and treats the
default transition as final:

	if (check[pos] == state)
		state = next[pos];
	else
		state = def[state];

For a state flagged MATCH_FLAG_DIFF_ENCODE the default state must instead
be tried again with the same input character, which is what match_char()
does for every other matcher. apparmor_parser emits differentially encoded
DFAs by default when the kernel advertises policy/diff_encode, so larger
attachment patterns end in a non-accepting state and the exec silently
stays unconfined. No conflict is detected, so nothing is audited.

One visible victim is Ubuntu's firefox profile, whose attachment

  /{usr/lib/firefox{,-esr,-beta,-devedition,-nightly},opt/firefox}/firefox{,-esr,-bin}

never matches. Firefox then runs unconfined, is moved to unprivileged_userns
and is denied CAP_SYS_ADMIN, losing its user namespace sandbox. The same
profile compiled with -O no-diff-encode attaches.

Use match_char() in both branches of leftmatch_fb().

Fixes: 21f606610502 ("apparmor: improve overlapping domain attachment resolution")
Cc: stable@vger.kernel.org
Link: https://gitlab.com/apparmor/apparmor-kernel/-/issues/8
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2172229
Signed-off-by: Patrick Grössing <invarianztheorem@posteo.com>
---
Tested on a kernel built from Ubuntu linux 7.0.0-38.38 (upstream 7.0.14):
with this patch the diff-encoded reproducer profile from the GitLab issue
attaches, and the stock Ubuntu firefox profile attaches to
/usr/lib/firefox/firefox-bin (all processes "firefox (unconfined)", no
unprivileged_userns denials). Without it both stay unconfined, also on the
stock 7.0.0-38-generic kernel. Compile-tested with W=1.
Based on apparmor-next as of 2026-10-26.

 security/apparmor/match.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index 7713484..796126d 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -751,7 +751,7 @@ static aa_state_t leftmatch_fb(const struct aa_dfa *dfa, aa_state_t start,
 	u32 *base = BASE_TABLE(dfa);
 	u32 *next = NEXT_TABLE(dfa);
 	u32 *check = CHECK_TABLE(dfa);
-	aa_state_t state = start, pos;
+	aa_state_t state = start;
 
 	AA_BUG(!dfa);
 	AA_BUG(!str);
@@ -769,13 +769,10 @@ static aa_state_t leftmatch_fb(const struct aa_dfa *dfa, aa_state_t start,
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
@@ -788,13 +785,10 @@ static aa_state_t leftmatch_fb(const struct aa_dfa *dfa, aa_state_t start,
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
2.53.0

