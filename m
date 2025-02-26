Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C12F224249
	for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605369; cv=none; b=lbJYjvsqhhoqioxhxUM9rWmblDoAozX0SuimuzxjB8AaOhuQkQFufOygn6fLK8Ce7TXAJKMTxkSAIS5bYIZWFia+0z9GQtQY3JjHapszaXrE3EmAbdwclSwCwpauwuv0sOlmRPBQ4KfH3j2bSXnzx19Lt9+b0f+zbyjvJ1rj2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605369; c=relaxed/simple;
	bh=4c1W67uLZrgxB9sAEDciFUwLTPadRpcYiUGZY8sUkOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ILP0OwAlt0cyQxOEbonYzPRulaZXnnI0kGy+f00MNcJ8qIS9DcgloB4PXSUd5jFVglKw5ro0njKLsTkgIiUrg9OhIc7a+YsRbpdyp8wmwzgGp4ag1yjblH6uMcRjK3F1CgD5B+GGBsU1o7ttWyqmBXR32rul1uovq+9s2bS22TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJ8zS84f; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJ8zS84f"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5df498f31ccso157701a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 13:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740605366; x=1741210166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4c1W67uLZrgxB9sAEDciFUwLTPadRpcYiUGZY8sUkOk=;
        b=ZJ8zS84fVC101eLXS07yBDRETnqdtA0SA7Mju+9BEkGUBccCZpKaUp3uIXrSffgzSD
         279sx2WJyKenlAfuFnfk225MkpCthOGbgcbSpfQ59KCurKqcJqx8M6rpt76yx8OyGAll
         RxnQpdkqZujFzKhBQLQMSgNPbp8tOFsGCxFx9O5fuL6i8ufMz+z3PjoroPpM1ezKOLEX
         jfIRSF1l4H+30wCRKP3V82rPKD1eb+fo9kbMwDch73DcwQWygPFHr/hHn5bUEbnjlCHL
         YzUOFlFWBh6B1Lm7Pi4hA5YyqAjNHYbHqtG4gQJh/+ZiepC5xj7xRMfbo1kdr/9Gkh0Y
         Zs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740605366; x=1741210166;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4c1W67uLZrgxB9sAEDciFUwLTPadRpcYiUGZY8sUkOk=;
        b=WO/oE/4Q2xKnjyOFAi4DSdK4/mLxRE1Ja0Bg+bJeRnEGpNtE3w5TrpKQhppzywDleF
         wBp9WuTdLEmYXcAK2yH76IoNxeuyCFi59yNJASWjeFDYtYUu4gowVh6obpZg1cRfbRVn
         AEXVxo+RhcLRqupXLLyjwbB1xI0Vdfa5ul/xRUknY+FD14XYBjNVWRTHTYo8RsX3QUdH
         pDOu3gwHKxKO61N4MJN0i7ZyV5pVoHFIo1okQac6I+V/CTiEjDFcUDF89BPy6Naa0IDx
         wBEZuYx2ooMXiweJnqF+r/Q1zDmJ/o9Km4/8BBYJ6eioNCa7FCjwI0JoL7yRmSgWmghN
         sO6A==
X-Forwarded-Encrypted: i=1; AJvYcCUVkIBRktxQCmYIWvlwhJY2y8AFiOp5r+VN6cN4OZWVMy9jVJ8E7WJrTCe06TsYC0tsRLG37TNQznjNFTOA5IP0V+H0tRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp+iRdq0FOLc/YO88MNYjnxQZ6oKq49XZioE7Y9f3gwITo7moA
	u0ONsOw8G21afhIhW0F0ifs0eW1+irRd44fu6kFEd5sHIKJ5psQfcQMXIhKUmZ75lmLDKOuO7se
	IXA==
X-Google-Smtp-Source: AGHT+IGG7RjsjipOWACrZiJ8sYe0vibY/vyX4/ROVpvQv+jC79J6/N0hcrKQygQ3w0BlMg3+EOfXFDIRqXI=
X-Received: from edcc15.prod.google.com ([2002:a05:6402:1f8f:b0:5e0:9f1f:6f6e])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:35cf:b0:5de:a6a8:5ebc
 with SMTP id 4fb4d7f45d1cf-5e0b70bdc9fmr24907618a12.3.1740605366607; Wed, 26
 Feb 2025 13:29:26 -0800 (PST)
Date: Wed, 26 Feb 2025 22:29:10 +0100
In-Reply-To: <20250226211814.31420-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226211814.31420-2-gnoack@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250226212911.34502-2-gnoack@google.com>
Subject: [PATCH v2 1/3] landlock.7: Update description of Landlock rules
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: Alejandro Colomar <alx@kernel.org>, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Tahera Fahimi <fahimitahera@gmail.com>
Cc: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	linux-security-module@vger.kernel.org, linux-man@vger.kernel.org, 
	Daniel Burgener <dburgener@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This brings it up to date with the wording in the kernel documentation.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 man/man7/landlock.7 | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/man/man7/landlock.7 b/man/man7/landlock.7
index c6b7272ea..11f76b072 100644
--- a/man/man7/landlock.7
+++ b/man/man7/landlock.7
@@ -39,13 +39,25 @@ the running kernel must support Landlock and
 it must be enabled at boot time.
 .\"
 .SS Landlock rules
-A Landlock rule describes an action on an object.
-An object is currently a file hierarchy,
-and the related filesystem actions are defined with access rights (see
-.BR landlock_add_rule (2)).
+A Landlock rule describes an action on an object
+which the process intends to perform.
 A set of rules is aggregated in a ruleset,
 which can then restrict the thread enforcing it,
 and its future children.
+.P
+The two existing types of rules are:
+.P
+.TP
+.B Filesystem rules
+For these rules, the object is a file hierarchy,
+and the related filesystem actions are defined with
+.IR "filesystem access rights" .
+.TP
+.B Network rules (since ABI v4)
+For these rules, the object is a TCP port,
+and the related actions are defined with
+.IR "network access rights" .
+.BR landlock_add_rule (2)).
 .\"
 .SS Filesystem actions
 These flags enable to restrict a sandboxed process to a
--=20
2.48.1.711.g2feabab25a-goog

