Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33240849;
	Sun,  9 Mar 2025 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741525695; cv=none; b=H23IHbeSsQjbAEfj9cjLK+9l7cWE/RafWJOWScYJfE2R40E9oO9uQE3T+t+b8NarLUo3UGOuFTABv1ovdo4c4O1GW3dP4Bwf0aEh+D4mK9EmjVVah6+73rebaNv5Sz2mi3CWe+CIiW/mm3NqT+RPNq/cZ1R1HIJKCbD6htcY1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741525695; c=relaxed/simple;
	bh=1xvCgkzPAesc6rhz6X5pleeBpHyMzBKI2nr/j8pTbxw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WA7brfY3MvF+ealKxf7lSKZMBiJouGtpWn7+1f8X1tUEeFqJvK+nhXUEfR8baOvqUl8+gyGgFeMncCD4OUpf7skvPKXaMkxDNgI+1x4eW5Mkw2IlivYealukAyaTuBQgfr5nKgMsOOvOdwp87//aJ+Lz9/O4c6iwamTaoInvdwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDO6+16N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDO6+16N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56219C4CEE3;
	Sun,  9 Mar 2025 13:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741525694;
	bh=1xvCgkzPAesc6rhz6X5pleeBpHyMzBKI2nr/j8pTbxw=;
	h=Date:From:To:Cc:Subject:From;
	b=NDO6+16Nf0vxEPCVQU2dLRyyUnrvlH6hwoW8j0pv/joPiX9pwmDBBwyQXWT3slRW1
	 1a4Dd8f0tJQGwLVzY+DPtbdDkKquMbz8SAG6L9M7oZiVEDiwYe2JsuQZBD0aNaKEjX
	 66Xz/Q4e9Q5v9VuVWeZgQZ5HF5jpKhtXarZ3yyiJuKoJXPA6LBLBM4L2bRVVkwiIj8
	 D3LpP1s3qtrCHNAdoe3Io8rMD3GpRRxhU2xC8kfknHGA2k2wgVF4jRp9MYSLaOXikm
	 aK2vSQ8BDSwfXE5NkSo/OXp7vIOrKjd8rSO8ivySQOQARJvGO/w3cWqdpKVMBtp+Cu
	 pgP+nBnt1yO8w==
Date: Sun, 9 Mar 2025 13:08:10 +0000
From: sergeh@kernel.org
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
Subject: [PATCH] MAINTAINERS: add Serge Hallyn as maintainer for creds
Message-ID: <Z82Sug-XLC1r5wKE@lei>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Also add the documentation file as suggested by Günther Noack.

Signed-off-by: Serge Hallyn <sergeh@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68e4656c15ea..54b47bfc4abd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6141,11 +6141,13 @@ F:	drivers/hid/hid-creative-sb0540.c
 
 CREDENTIALS
 M:	Paul Moore <paul@paul-moore.com>
+R:	Serge Hallyn <sergeh@kernel.org>
 L:	linux-security-module@vger.kernel.org
 S:	Supported
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
 F:	include/linux/cred.h
 F:	kernel/cred.c
+F:	Documentation/security/credentials.rst
 
 INTEL CRPS COMMON REDUNDANT PSU DRIVER
 M:	Ninad Palsule <ninad@linux.ibm.com>
-- 
2.34.1

