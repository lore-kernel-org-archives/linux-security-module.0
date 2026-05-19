Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ACE3BB9F7;
	Tue, 19 May 2026 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222618; cv=none; b=gxXMucK1x+CFUTT2g2JvF/MijF8vHdyjHJ3XU3H7hEFdTscUsDhqR5hF+9NFUFf/+4OiRPxBJyHKriys46BPiHABt2Ar7kjJcgq5OhPRoSVlCNaKdMZjW8h2Ln3FLx6qxk/c9v7Mcj7AAsxSNFNRQwTrW7o4XB5AOCxeZTd9FJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222618; c=relaxed/simple;
	bh=sCcyeX6mrzBbH9PL0gF3h2GXypl0ATtnY4gCm6YK2Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BsS6T0eQHZbkIlwVqxmon/SYXV6y185qnXg2tohWUaUNUcjKsLpovQkZBUAPbJybfca5F+2wGGD9rnvZ/v+JdnddjRQWLNQ/IxIeeVnYQdMs+Ge7PB/vNksTHOGnfF51BQdLULfEnttSG9ColNHbbhFxGE/m2o8KNkW7nkV4enY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuDy7yGs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuDy7yGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5EE1F000E9;
	Tue, 19 May 2026 20:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779222617;
	bh=Mo6HG/Hnf2ANka3npHLJPyZEJJzcaobrBe9C+hEy3nU=;
	h=From:To:Cc:Subject:Date;
	b=iuDy7yGsGbt1Xl/ttFa8UpDtFWmX3/69wEh4iLLD2bRM7muHsRHd7V0jInP6ugMpi
	 5SMicBtJEzYYV86zsvCHSL2EE6WQgk92B7mL83Lcrd3iMmkrShEZdc7/3rAe2bSddA
	 9Z0XLIpdG3PiuglamAA0hNJMIHbUSVoxWNHfDK4ri+Mg/OICbUcVqdgrtY80m83tou
	 /YAlbOcEDna7IvUXh4HwV4EzVUowdBsLcNsJoSu326gYXpqHfhLz+163Gu7SQgCeTh
	 vYDDb4xFGZEWFPwAezVGtrVqPyEWThm/OtRt5cclniWb2QPVG/aUdCkeGmIdoUn043
	 /WeE5oMk10raQ==
From: Arnd Bergmann <arnd@kernel.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>,
	Kees Cook <kees@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] landlock: avoid memcpy static check warning
Date: Tue, 19 May 2026 22:30:05 +0200
Message-Id: <20260519203012.1340274-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The fortified string helpers trigger a -Wrestrict warning when
gcc deducts that the size of the landlock_layer array can
overflow as a result of the flex_array_size() calculation:

In file included from arch/x86/include/asm/string.h:6,
                 from security/landlock/ruleset.c:16:
security/landlock/ruleset.c: In function 'create_rule':
arch/x86/include/asm/string_32.h:150:25: error: '__builtin_memcpy' accessing 4294967295 bytes at offsets 0 and 0 overlaps 6442450943 bytes at offset -2147483648 [-Werror=restrict]
  150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
security/landlock/ruleset.c:139:9: note: in expansion of macro 'memcpy'
  139 |         memcpy(new_rule->layers, layers,
      |         ^~~~~~
  'create_rule': event 1
include/linux/compiler.h:69:46:
   68 |         (cond) ?                                        \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   69 |                 (__if_trace.miss_hit[1]++,1) :          \
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
      |                                              |
      |                                              (1) when the condition is evaluated to true
   70 |                 (__if_trace.miss_hit[0]++,0);           \
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/compiler.h:57:69: note: in expansion of macro '__trace_if_value'
   57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
      |                                                                     ^~~~~~~~~~~~~~~~
include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
   55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
      |                            ^~~~~~~~~~~~~~
include/linux/overflow.h:334:9: note: in expansion of macro 'if'
  334 |         if (check_mul_overflow(factor1, factor2, &bytes))
      |         ^~
  'create_rule': event 2

Out of these individually helpful checks (-Wrestrict, fortified
string helpers, flex_array_size), one of them has to go to avoid
the warning.

Seeing that the length of the array is already checked earlier
in this function, through both an explicit LANDLOCK_MAX_NUM_LAYERS
comparison and the implicit kzalloc_flex() having succeeded,
replace the flex_array_size() call with a direct multiplication.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/landlock/ruleset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 181df7736bb9..26e0b7193a7b 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -137,7 +137,7 @@ create_rule(const struct landlock_id id,
 	new_rule->num_layers = new_num_layers;
 	/* Copies the original layer stack. */
 	memcpy(new_rule->layers, layers,
-	       flex_array_size(new_rule, layers, num_layers));
+	       sizeof(struct landlock_layer) * num_layers);
 	if (new_layer)
 		/* Adds a copy of @new_layer on the layer stack. */
 		new_rule->layers[new_rule->num_layers - 1] = *new_layer;
-- 
2.39.5

