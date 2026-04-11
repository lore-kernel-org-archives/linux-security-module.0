Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052FF33030F
	for <linux-security-module@vger.kernel.org>; Sat, 11 Apr 2026 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775898632; cv=none; b=lbaIh/YSSSOtKXtB5wq+UWa7SKel3hIYYBzaDYw4IohIYiT8XnNM+5DvQcPT41VShTXNF4h1Ym13R9TD6aeblXQMwzR76ephxmCQ2uX8eBmzHoMXDaHBbfI3D3NfI52CDSjFQiM4QoxwbGP7wZx1O6dB+b2XlzcRq/iLJ4TmQMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775898632; c=relaxed/simple;
	bh=pRn5phT5b+R2/NilYzHhsU+CNoN/+FkxlNaFoHJoUMk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qDEl0IoPTihN41hgNy7kHLpSvm+cpXACyoIrwcgtjvmrzkYt33t+zWMbcO01WPEinbDH6vH8EHi7M859Ywi5DvNATOSC96PxxMSw8aFC9rcDo5DAEKM2dzQa2lKM1uc29LGZ5GN04m9zeAlS8IkyxZXIgQ4BOsyDtw3LIqUvqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R5NAIg1Z; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5NAIg1Z"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b9c1d1f7e5dso279448766b.0
        for <linux-security-module@vger.kernel.org>; Sat, 11 Apr 2026 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775898629; x=1776503429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+xA6u+LUB3RXMM//tom+XNtzK17JipP19IsxM4MBgI=;
        b=R5NAIg1ZabWLysGU2MmQQOb05iJv9QDULL98OluoZ9Cz6axVQMzbJn371sEZGhqNCZ
         l3kMS5LzW+vQYbqxEXSoY4CNwC6kIeaigiUnkKVrLUze76Qu5eaDLm2/wuqXv7Q9SpCq
         ATDY8zGAgl9MOAMWmdPkRyqgyy6U217H5m+mGTH08u0cgoGo3+ZwX9ZKC+CeJDCJYoKD
         Hnk+9Qw7kJtxlczuqZX91EpzgtUl/G+Myopko6WImoKhllxhpC560B03trpdCnW59GgF
         uiWIWF9hlvklUEi9W1BQ1BeWHMXqx4qeRER4/V+ekK0U3J/52rfqtCeVKqbhSMfLA69r
         Zqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775898629; x=1776503429;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H+xA6u+LUB3RXMM//tom+XNtzK17JipP19IsxM4MBgI=;
        b=R6M7VbXW/lX+iFtA07i4ao3nvwcbXQEGZoOzjMZ0gGdTQE/j+7VFnUDJlxnWb8vcvs
         ly9O3IXIXrlUtEBTCsSUCiV/wRpFQI0uKIjfl648pbvFEVu+XQ9T27K2ZeY5263y7xip
         GyoZHNYqq0nvEJmf0+J/LPIP7RWZ4aWfbGLkj1AajCT8KwzHiGuz7TqjGg7TQA9cFO0B
         atRrmcuFfZezuJB8/46RydQUMtaRn6n4EUggsOn/5WU26OP33UzqD07+Q+JnF1kfCccw
         ehTxT40+SArEX/eBHKbRCL18lPu6v/aI95nuZRmLfk268P36ybq9uMTS1HYCmu0CJSbc
         PaJQ==
X-Gm-Message-State: AOJu0YzaapykSEgnhyo5Z9XqZBGdl5UbIhtE/lSGwmH0y86M4qh249dT
	qlz+k3QLDvcRjvojzlc/UNzDtwnLPeEdbfW3s7bgB/eIGpq2kwgsQGNgIBliS8DtBQ00kfCVplL
	5gaNT9w==
X-Received: from ejchr16.prod.google.com ([2002:a17:907:3f90:b0:b97:9f24:aa3c])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:fe04:b0:b9c:3d56:e4ec
 with SMTP id a640c23a62f3a-b9d726579edmr346097666b.24.1775898628814; Sat, 11
 Apr 2026 02:10:28 -0700 (PDT)
Date: Sat, 11 Apr 2026 11:09:44 +0200
In-Reply-To: <20260411090944.3131168-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411090944.3131168-2-gnoack@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260411090944.3131168-4-gnoack@google.com>
Subject: [PATCH 1/3] landlock: Require LANDLOCK_ACCESS_FS_MAKE_CHAR for RENAME_WHITEOUT
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

renameat2(2) with the RENAME_WHITEOUT flag places a whiteout character
device file in the source file location in place of the moved file,
bypassing the LANDLOCK_ACCESS_FS_MAKE_CHAR right.

Fix this by checking for LANDLOCK_ACCESS_FS_MAKE_CHAR if RENAME_WHITEOUT is
passed.

This does not affect normal renames within layered OverlayFS mounts: When
OverlayFS invokes rename with RENAME_WHITEOUT as part of a "normal" rename
operation, it does so in ovl_rename() using the credentials that were set
at the time of mounting the OverlayFS.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 security/landlock/fs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c1ecfe239032..2b84a229e4d8 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1519,6 +1519,19 @@ static int hook_path_rename(const struct path *const=
 old_dir,
 			    const unsigned int flags)
 {
 	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
+	if (flags & RENAME_WHITEOUT) {
+		int err;
+
+		/*
+		 * This check would better be done together with other path
+		 * walks which are already happening for the normal rename check
+		 * in current_check_refer_path().
+		 */
+		err =3D current_check_access_path(old_dir, LANDLOCK_ACCESS_FS_MAKE_CHAR)=
;
+		if (err)
+			return err;
+	}
+
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, true,
 					!!(flags & RENAME_EXCHANGE));
 }
--=20
2.54.0.rc0.605.g598a273b03-goog

