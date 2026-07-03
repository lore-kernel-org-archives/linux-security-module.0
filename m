Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9A3D9DBF
	for <linux-security-module@vger.kernel.org>; Fri,  3 Jul 2026 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088256; cv=none; b=htrOuH3brKI6FUlr2aX4EK/Skdh3L3W2+5cpC4Gs/QVL8XL7UF5vNTS0BJAUfv/HqS+UWB484HBWxLnFQhb0cB+9YWg/gsLLkxqXAACaWTqdpx+CZpdfjR24aVOqSmfJLz1+2KzUuus1iQfh7FmREjKDZzbF1THfceU9okFRdI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088256; c=relaxed/simple;
	bh=om30d7yDWl7g1/H6QiwiuMSQMJOT79jSOXJDR/n/l7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZfCn8EwThnPwH087/m53EZR/vQO0O95PcmaQz7SQi4QBm/2rI0kRXsESMdvUMFHiq0Bth5pF5rIr3nHdjpADFmT7SYmAmKVXY+BhIW3NUaDD/R9YeIhMtEFdo7MUpVKmpqqYDv3j8236ObBP2ydB9US43uYVdTRGj6+jYUy6sMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rw8bIqm2; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rw8bIqm2"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gsG6T6VzgzKTT;
	Fri,  3 Jul 2026 16:17:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1783088241;
	bh=n2NN5qQIx98PNiSneR8W1bI8hrWbrAtI0hhrS+4EJ7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=rw8bIqm23Pp1CPCSUihwIamlACR45pdvpQf8bdw4DvQkesetn2NvOlzsknwg8I/VU
	 MaMtOBNUeej+xbI1ogk11NcAzMclF1b3JJWStGvep7sQNQbFEfApOzmazPa0sZrc5x
	 7cU746JotR6P+GTlz96tpGs65HB1wbkhsuR0A7JI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gsG6T2KpgzGGW;
	Fri,  3 Jul 2026 16:17:21 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v1] landlock: Fix kernel-doc for the nested quiet layer flag
Date: Fri,  3 Jul 2026 16:17:09 +0200
Message-ID: <20260703141711.2016964-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

kernel-doc emits "Excess struct member 'quiet' description in
'landlock_layer'" because "quiet" is a bitfield inside the named nested
struct "flags", but its inline comment used the bare member name
"@quiet:", which kernel-doc attributes to the enclosing landlock_layer.

Use the canonical dotted notation "@flags.quiet:" so kernel-doc resolves
the nested member, and include it in the generated documentation.

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Tingmao Wang <m@maowtm.org>
Fixes: a260c0055665 ("landlock: Add a place for flags to layer rules")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/ruleset.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 61f3c253d5c9..0437adf17428 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -35,8 +35,8 @@ struct landlock_layer {
 	 */
 	struct {
 		/**
-		 * @quiet: Suppresses denial logs for the object covered by this
-		 * rule in this domain.  For filesystem rules, this inherits
+		 * @flags.quiet: Suppresses denial logs for the object covered by
+		 * this rule in this domain.  For filesystem rules, this inherits
 		 * down the file hierarchy.
 		 */
 		u8 quiet : 1;

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.54.0

