Received: from a6-53.smtp-out.eu-west-1.amazonses.com (a6-53.smtp-out.eu-west-1.amazonses.com [54.240.6.53])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D11F2B88;
	Wed, 11 Mar 2026 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.6.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773205745; cv=none; b=J2Bx3qzXkIeeLXPtr8L0wRMkh87Y+JjWWD2BDszW/y3MEPRylLSYLb6x+Vthmx4U1G5IE/jmXFCxepYdFFNvKjKdLfPngF0HQobn7y50mwQJ3Emu3hevD7XeHNWZnkxXKAZoB4b2zbR2opmlSf65+OayV+pRpffPrMahBMj7v0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773205745; c=relaxed/simple;
	bh=AJT01gfysrn2yvDHqpr0ZQlYns1wvan5+KLbUT+mzU0=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=hozUmbJHIcKGjoHtoOq4iisgBAj3yJiOyCsOiw6+GSA+caCB2FMbFdxDcjiVCGeSffwmSCSVRgPs8RJkc6lg5zJA1TJ6tkf7lvIgmWR75VeBMIn4WrY2OxF1XtuRWv+iX6UMPbjaeYdZvjZlk3UYBTeXkzJKyB30jy6zSCD5Bz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com; spf=pass smtp.mailfrom=send.matrixforgelabs.com; dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b=ccZHpoDa; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=FVZgmw7/; arc=none smtp.client-ip=54.240.6.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b="ccZHpoDa";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="FVZgmw7/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=matrixforgelabs.com; t=1773205743;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=AJT01gfysrn2yvDHqpr0ZQlYns1wvan5+KLbUT+mzU0=;
	b=ccZHpoDa0gu0lnyNIWE8Td782ZYgxPcqFGUVuJYVxRth0WiRNxjDAnfuM08dUwBI
	5jOhcM2UMQGnxoiD85PZz/4t4EmhFtv30BHaYT0WaFPKfWCv28oCFh4qZHCVF0SwGxS
	+esTW6qSuL2UXCxVA+VnXVZC8fQiJFlg/+rphbl0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1773205743;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=AJT01gfysrn2yvDHqpr0ZQlYns1wvan5+KLbUT+mzU0=;
	b=FVZgmw7/ANI3yDj1E1cgOc78Qh2MI0PFl9HiJo6PXH+TZZXPXys3mFuGNstULZBI
	fWcaTKKNPtKdhYd3s/tmPgRqL2VDdL2Pj15eEn9hwRjGwzIpOG+dJJ0FxHpivOuplzk
	NyohxJpCYdbBoVaP1Q/YyXtKmFjs1JOqN3bwAnXg=
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311050854.657422-1-jamie@matrixforgelabs.com>
References: <20260311050854.657422-1-jamie@matrixforgelabs.com>
From: Jamie Lindsey <jamie@matrixforgelabs.com>
To: rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	jmorris@namei.org, serge@hallyn.com, jamie@matrixforgelabs.com
Subject: [PATCH v2 1/5] rust: bindings: include lsm_hooks.h to expose LSM
 types to bindgen
Message-ID: <0102019cdb4c6516-ec8251f5-7b55-45aa-9d57-9b86c70c3c02-000000@eu-west-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Mar 2026 05:09:02 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.eu-west-1.dUvNRtpqGVRXeo8wh60CXsl7GQehaaQ6nnrtD0cVQa3Ql6wtvHFwU/L0ElxknTtyiIJqbukn1OjAm5wWeKC4/L/mSl4kXjXWbCD+H4nPl2leK4flNX+koNzOtq4VJ309U1FPreISQBpCbnqANIVuwUyneL8ocSNAtI9Qxd/4vCM=:1.eu-west-1.xc5b6Z4+0WlftYwtQHAHsTtsfYdZQImSOXWypZD9BdY=:AmazonSES
X-SES-Outgoing: 2026.03.11-54.240.6.53

Add lsm_hooks.h to bindings_helper.h so that bindgen generates Rust
bindings for lsm_id, lsm_info, security_hook_list, and LSM_ID_*
constants.  These are required by the Rust LSM abstraction layer
introduced in subsequent patches.

Placed alphabetically between jump_label=
.h and mdio.h.

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Jamie Lindsey <jamie@matrixforgelabs.com>
---
 rust/bindings/bindings_helper.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helpe=
r.h
index 083cc44aa952..b819592868e3 100644
--- a/rust/bindings/bindings_he=
lper.h
+++ b/rust/bindings/bindings_helper.h
@@ -63,6 +63,7 @@
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
+#include <linux/lsm_hooks.h>
 #include <linux/mdio.h>
 #include <linux/mm.h>
 #include <linux/miscdevice=
.h>
--=20
2.53.0

