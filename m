Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3D192D9D;
	Mon, 25 Nov 2024 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732532374; cv=none; b=LlLnCEhH191ItSX/Cjqd43rUpcPR2DnOp/NebaJPFqni6sjXGM3ZwzbwMzn3qKZCRS1MjZmDY9zZfIqv0/fFmjYVqpH8oN+OvVMziaNXJCAQHj9oHW8WfD5mU12klsOGH3fpxD3xcupcZvwaK8vvwIzuuSmsxCPusVDRE8WNpH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732532374; c=relaxed/simple;
	bh=VimjDT3Hayked/DeNb8urYupk5NRmRIo2RxQQ9dK7p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CVNGmIM4olB6ze5rhK1Ia6rVTffhZpu6brJ5GN9g/Sa8pDhBcpu4bomXVyu/VGWfVJHIERm4HUXlzSm6gXbYLJNA+jRBewFyHBVVzbSW/EzRBY/r1IMg84zlD5qgHOJ1Bx9kAwn0pA+UnoVvSIXpo2YzTQqEPBaMsMgMOrKBuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=SxrqhGwy; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="SxrqhGwy"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732532370;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9DispIXRCSkK1gOuTv7Tgcr1f35tLRYfYUm8bmrsFNg=;
	b=SxrqhGwyyOYKCJw23sLQJQNvK32j0MqbpMaembD6FWEGH3r3dDkSsu5C/yU95YqAEsjwH+
	yMqS05Hqh2dO764KAxDkgL0ytqmfukIKq71DtOdebR4LFQ4XUFaZp40DK0QcU8gZDFhYcH
	ZJjMq85b/881g/07N44iIbjmHlRbNdkkwhqeKxRkhK3d12T8/HLiv/FgUwm7aiFyV3HXSG
	8ItnPN6KEnIDlbAAy+EMBozeLxfLikNglwfLzxe47uyvowlwJLasDk5OG9mz7mD+Q/Phdc
	Wa6fUuNA1rSRDyU7opGdG33bGEQOWf07DrQO9cPg52kwMQmXO5tk4ey4OABdHw==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 2/2] lsm: rename variable to avoid shadowing
Date: Mon, 25 Nov 2024 11:59:23 +0100
Message-ID: <20241125105926.47141-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The function dump_common_audit_data() contains two variables with the
name comm: one declared at the top and one nested one.
Rename the nested variable to improve readability and make future refactorings
of the function less error prone.

Reported by clang:

    security/lsm_audit.c:302:10: error: declaration shadows a local variable [-Werror,-Wshadow]
      302 |                                 char comm[sizeof(tsk->comm)];
          |                                      ^
    security/lsm_audit.c:200:7: note: previous declaration is here
      200 |         char comm[sizeof(current->comm)];
          |              ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/lsm_audit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index f1fe99f2221d..429096bf8fe0 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -299,10 +299,10 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		if (tsk) {
 			pid_t pid = task_tgid_nr(tsk);
 			if (pid) {
-				char comm[sizeof(tsk->comm)];
+				char tskcomm[sizeof(tsk->comm)];
 				audit_log_format(ab, " opid=%d ocomm=", pid);
 				audit_log_untrustedstring(ab,
-				    memcpy(comm, tsk->comm, sizeof(comm)));
+				    memcpy(tskcomm, tsk->comm, sizeof(tskcomm)));
 			}
 		}
 		break;
-- 
2.45.2

