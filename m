Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A17A932
	for <linux-security-module@vger.kernel.org>; Sun, 22 Feb 2026 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771793245; cv=none; b=SyNo9eU6UpghKdy5bqeS/xCXaQyzCjwqF/GPPjDSI2vz0duo1VwWZnq7LV5KLmx0lcK85cYF65bsEh4uQKMjFz8qcJFkbgq1CuFvH6wRSBPhfoCV42AZQ3uSIoZXrEScNPJcHocXw/P5Sv/djJav+C0jHhCSL7g/I4R9+mUfEYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771793245; c=relaxed/simple;
	bh=2UOp/Z3Tly7h1l8RLnm/+DpeMv0dVLr1frldWJlwRbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ag9/eR3MRVrYEqn19O7IJw2txSHuloa9Atdt0OG4KqJQOdDuwrltWzwG9EpgtM5uEda+cYQtnvbXa06p3BBgPZtmeo8WlZi52MjtKLLDrAiR/9gLjO8dGnDT4hrdAMTwsOsOE+X4s89ihe1S1wOipvpjMmjcLSUXWNziSC9CZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RFeDAnE1; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RFeDAnE1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771793241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mBVBsImbL6slcvq/bXMQF+c3KE7+jBmOhTTFhlYXES4=;
	b=RFeDAnE1BDzOShOlYu9gVb7MkFhI6CYiUipRBouuSikKLlBdIuxuem8IQxQYlE5kT7fIkj
	IVLhHIAItba5CB5dGypdhLWnP6393A0KsQJw8Fzx5KptEAv3LEbHvcAfYKxoZcsW31wNml
	xwO8jdpiGkUQdQduyh7StYT7kXKW8Hw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] apparmor: Replace memcpy + NUL termination with kmemdup_nul in do_setattr
Date: Sun, 22 Feb 2026 21:46:44 +0100
Message-ID: <20260222204645.285727-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use kmemdup_nul() to copy 'value' instead of using memcpy() followed by
a manual NUL termination.  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/lsm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c1d42fc72fdb..49aa6ad68838 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -858,12 +858,9 @@ static int do_setattr(u64 attr, void *value, size_t size)
 
 	/* AppArmor requires that the buffer must be null terminated atm */
 	if (args[size - 1] != '\0') {
-		/* null terminate */
-		largs = args = kmalloc(size + 1, GFP_KERNEL);
+		largs = args = kmemdup_nul(value, size, GFP_KERNEL);
 		if (!args)
 			return -ENOMEM;
-		memcpy(args, value, size);
-		args[size] = '\0';
 	}
 
 	error = -EINVAL;
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

