Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4D1E7C18
	for <linux-security-module@vger.kernel.org>; Wed,  6 May 2026 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778046576; cv=none; b=F8uwLHYQsnzDYRiaHlEGKvk6gvJ1m1VOsCI3f8rf/UZ1EfCeVca9nNKo6Fp1lHLj2+uk+IQVhCFeCIVwinhenitlx2Asa+PyML2cYqBdcLPHbBwsc+nxiB7sUIAb0OLET5+O8Tw4z7IGY+4Fk2cNPC9kw3KPwvizj2sOdDCx2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778046576; c=relaxed/simple;
	bh=V63HCRFuyfYgt+cbtqqWh5Ry5LYRNQC5sAiPc4io1AA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PB8J9cBsv2ImlT39YB0HXCyHvh/a+M33H4PwrxmcRjCvGrgW8kwwXduc9BDs5t7io7cYmUu9qgud6MgZ77GD/f8IcXGlIjt+9xCcI87ZOPxFbvvgUzVpZ/Ag1sMAT1EB3/Nu99SIAdpyqwW+p6GeoHtChMELA0tOevG73jTp1T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Yp1YYKIk; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Yp1YYKIk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1778046564; x=1778305764;
	bh=KpcgUtDn3EXTG1BBcztlZzlGN9ycWgoh9qrRkBRq/p4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Yp1YYKIkP1entrrA514OkrKPwHtv8aoy/9HiyP7QU+871t63DbSEYnJ0v5bIlFFG6
	 LRD8M4CWo+DdUxV1hPgxFBX2mFG4YBGF86rKDV2c48Hp+fGoCtLZsQmqe2XfiEQcbe
	 ETUAXI4Mn1wLr64/0FI8lhLYK38Xv3Uzr6CsiNZaw6En9p+l+j4XdKBm5rfvJ01CQB
	 YOnBaPB8UuWlEAXn1+nRjqNpEY5osV194W6soJuBSmZXM058679XP+9nIgSog67UaW
	 jTYWv8Fmgvv8R77j2qFMvRHRlw9suOkc5mBiuEoN7KVE025Fs5Iih8AW8rcQVnZ4as
	 A3VA9endSPhQw==
Date: Wed, 06 May 2026 05:49:18 +0000
To: Paul Moore <paul@paul-moore.com>
From: Mayank Gite <drapl0n@protonmail.com>
Cc: Mayank Gite <drapl0n@protonmail.com>, Serge Hallyn <sergeh@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: fix typo and formattting in security/credentials.rst
Message-ID: <20260506054914.162806-1-drapl0n@protonmail.com>
Feedback-ID: 27639855:user:proton
X-Pm-Message-ID: 7ea98b8c116dfdecef9204ec1d3c723a46d2eb38
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

- Fixes a typo in "Keys and keyrings" section. Replaces "keying" with
  "keyring".
- Updates formatting of keyring types.

Signed-off-by: Mayank Gite <drapl0n@protonmail.com>
---
 Documentation/security/credentials.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/security/credentials.rst b/Documentation/securit=
y/credentials.rst
index d0191c8b8060..4996838491b1 100644
--- a/Documentation/security/credentials.rst
+++ b/Documentation/security/credentials.rst
@@ -189,9 +189,9 @@ The Linux kernel supports the following types of creden=
tials:
      be searched for the desired key.  Each process may subscribe to a num=
ber
      of keyrings:
=20
-=09Per-thread keying
-=09Per-process keyring
-=09Per-session keyring
+=09- Per-thread keyring
+=09- Per-process keyring
+=09- Per-session keyring
=20
      When a process accesses a key, if not already present, it will normal=
ly be
      cached on one of these keyrings for future accesses to find.
--=20
2.53.0

