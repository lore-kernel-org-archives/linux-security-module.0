Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF123816EF
	for <linux-security-module@vger.kernel.org>; Sun,  8 Feb 2026 23:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770592291; cv=none; b=TEfYh5kP9b+f+gcr8Q+5pkZpn8H83W5GO7X6z5ypeh2G9QqlKnmYCwCvww/dQ8gJS0dp1KSaiO7w9nU7TH5cGBcyeyg6ja3/mogR845IuDa3dGGybJnspf9krimKiX9REZts6R8n0C52ocdpZkgFtdfpV69OTldXPXAv7ReaWwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770592291; c=relaxed/simple;
	bh=H95up0PdF0wT3xiTVLsjcbw/FTqiwcIzLRTN7EvNT9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlXmFGtQRYK90dUxcaPcb7rLpNJ3t8A+eY82oEnRNNVLNCBgHo1LnozLs3T0kBJNornj86Z8c/6efRKG9rqF2FHS2RXrAKsEI/VECkHajVXA9aDzEkCcNWHjoJWFP/iOnwK8TuR0BglSVF8hBH0/0a7idA2mhaxYO8Qpe8oqk0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEeIQe+j; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEeIQe+j"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-436e87589e8so747118f8f.3
        for <linux-security-module@vger.kernel.org>; Sun, 08 Feb 2026 15:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770592290; x=1771197090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuQwtV+v7wYKCTQx1ckWEl3T2al+gSB4N7kOmT9I2y8=;
        b=TEeIQe+jlZ2GisBKfYc+OsoeYk/eiusbCIZLhh70oFHPaoHxsieET8b7u49ciKwM2P
         txbLMaKhIqvv857oHIA31ICeBckPA7JppqGUOlYdnY+A7HciWFZXJDg/Vjx0O5hWd2eI
         VzUfsu1FLZFzX3FT9pjquyflu/dWzy6fMoV2if0+j12g/wfaMS2skUy16US0+W/06Rga
         okLgIHpZpNfaltF8BPV69bQNZ6stcICH594Vz4DwQr+694inzdkEBfi71jlTdutE8Z8b
         c+pY4RgCxh57fHpRk5r6vmZlxleAlWmkp1e1eNP+J20Aj8HHIpe3G8GldnsvTIy1XnWC
         hj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770592290; x=1771197090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uuQwtV+v7wYKCTQx1ckWEl3T2al+gSB4N7kOmT9I2y8=;
        b=wEYT0XZ1OiashKbjakXmZ+kNO6ZnWczseUub5spXGAkiudI3vi1mfupWr+h9mT1bSh
         1LdJA4MdK4orlIZ4E2sCftfD1weUIf8WoiDRYdc3rdztcIgPAtMSZ4RCrEm4DypIOwfx
         nG4DjGzBjP/cDtLdkhqXJa7x6MnqO29fldnaBrlro0GTeEikRAFsw3KUp6/t7RTwmrg9
         M4MCIRc8Q55GjrjJ7Gxr8WZ4cGNlRpD4lwm4yRs71hRnwlxdBzNcdC0DRlL62ubjos5Y
         e4t67YpYiiiRM3REyFkGYPDc2z9FomJyHEiN9/ghfNYe2C6LJaUfOwfnMB5FDmw4m+5C
         /XzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9B8Ic86yjggQJXplhwqccCm16jt6W8W12PXoh/FycUFTqCXilijm3MmO5Xxz7/gIqwtknZr98V00Pep6SDL/M0zAfHp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQJGOjBUmOd8rThoJK2CSRZFcjR/UxI1Wvs9WtkuAnEn/XGP7
	ZGMlTB2zR/riQQKamaJeKQxyNLZ/ybMPqnsZ93NE7wjjIq9itgLColRV
X-Gm-Gg: AZuq6aKs+Bxvpemuwx0gnOO/3BEE2+fz7ZDP4wyt4Sc5ZmShjf7cyaoMUUxtLJDC9Zc
	DHjRmIVjJufsPo8KnuQ5lSZ068RQAk1vlQiTWdx/sHeHgCydS9dpkxEaaRjVPrmXPgH5/Ck9bMj
	wfdU7tcakwT2eiLn4uMFRPkcZchLtqtzaNwxjTi1VlvSOEdDFvEWD0Q2VXG5gjR7g1yZVBH5USx
	garzETwtVww5s8FUw3dSFZQV+32syv2wUwP8aiBWsDSR8hDT+x5Cch1crulv05Tez3xVhG8ZsX1
	6ouwLeJhq6bCJKAZFdAqTAzGB+7pUqH6WUJFE+9+SpEhy0vuOgjkhvvRBTmKoVNDOSjbs8fPnGV
	swWya8y55LDkz7V3u6h6n/CzL1NQuLXtAzXVlcNo2Ys0dZsVrto893x4HHeKdywJ6Hwrey0VgPX
	mtHrhQsTo6F5UUDQAw7yk+uVfgX0EDJknQRUvw
X-Received: by 2002:a5d:6304:0:b0:436:3155:86da with SMTP id ffacd0b85a97d-4363155874emr7726318f8f.27.1770592289694;
        Sun, 08 Feb 2026 15:11:29 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436297462a8sm20369524f8f.30.2026.02.08.15.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 15:11:29 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>
Subject: [PATCH v4 6/6] landlock: Document design rationale for scoped access rights
Date: Mon,  9 Feb 2026 00:10:16 +0100
Message-ID: <20260208231017.114343-7-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260208231017.114343-1-gnoack3000@gmail.com>
References: <20260208231017.114343-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document the (possible future) interaction between scoped flags and
other access rights in struct landlock_ruleset_attr, and summarize the
rationale, as discussed in code review leading up to [1].

Link[1]: https://lore.kernel.org/all/20260205.8531e4005118@gnoack.org/
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 Documentation/security/landlock.rst | 38 +++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index 3e4d4d04cfae..49ef02d5e272 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -89,6 +89,44 @@ this is required to keep access controls consistent over the whole system, and
 this avoids unattended bypasses through file descriptor passing (i.e. confused
 deputy attack).
 
+Interaction between scoped flags and other access rights
+--------------------------------------------------------
+
+The ``scoped`` flags in ``struct landlock_ruleset_attr`` restrict the
+use of *outgoing* IPC from the created Landlock domain, while they
+permit reaching out to IPC endpoints *within* the created Landlock
+domain.
+
+In the future, scoped flags *may* interact with other access rights,
+e.g. so that abstract UNIX sockets can be allow-listed by name, or so
+that signals can be allow-listed by signal number or target process.
+
+When introducing ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX``, we defined it to
+implicitly have the same scoping semantics as a
+``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` flag would have: connecting to
+UNIX sockets within the same domain (where
+``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` is used) is unconditionally
+allowed.
+
+The reasoning is:
+
+* Like other IPC mechanisms, connecting to named UNIX sockets in the
+  same domain should be expected and harmless.  (If needed, users can
+  further refine their Landlock policies with nested domains or by
+  restricting ``LANDLOCK_ACCESS_FS_MAKE_SOCK``.)
+* We reserve the option to still introduce
+  ``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` in the future.  (This would
+  be useful if we wanted to have a Landlock rule to permit IPC access
+  to other Landlock domains.)
+* But we can postpone the point in time when users have to deal with
+  two interacting flags visible in the userspace API.  (In particular,
+  it is possible that it won't be needed in practice, in which case we
+  can avoid the second flag altogether.)
+* If we *do* introduce ``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` in the
+  future, setting this scoped flag in a ruleset does *not reduce* the
+  restrictions, because access within the same scope is already
+  allowed based on ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX``.
+
 Tests
 =====
 
-- 
2.52.0

