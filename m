Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FBF23B62B
	for <linux-security-module@vger.kernel.org>; Wed, 31 Dec 2025 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767216804; cv=none; b=R5xyFGMTY3s8Da+rNt5VIV9xfkmB4sq70+Nx0zYJwvkD47mzJlAOpUsmKKtDX9YnEas5CmVPvVt8h+0PmeWwQCh3+IioLKP7e9jSF6ICC8SolwzOwaMTjZEtASdKPhOhxAbaRr0CIneSnKA0xT+TXjjy4wd3B3WPmG6xOHxsFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767216804; c=relaxed/simple;
	bh=EygjOIJsYKRojkxpA/41v9UMDNDsGvEG2MfSxBOSaqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GigF20OUIEUoJLyn/oe2S0KvaEhKh/hCl/QGZBWfGAEI6WDIwPA4c7cWpd+0RPp0/mHy+6gZGe7KaGiCZx2mXx52Gm051+rvYu77LhvofB75yxIEA6CTns5/hEqCngO1mwSN28jylxf5JCIWKaZeGrAX/PZgybIZ1Ttrmz9HuPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjSU4e3z; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjSU4e3z"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7881b67da53so92121377b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 31 Dec 2025 13:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767216802; x=1767821602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wBCpAO7sdjZfJGz7bpZwxFzuAwNuSKAoKLO0csHuYSg=;
        b=AjSU4e3z77Abg0flzBGMo+lTnN8QxWa0Rd/jtEnFAQr3BeaqAmp5IjmbgqJWESVES3
         QReWyOHAiKkpypyBaRcdRA3rfJjyirO3G6YMpPhZEi2jIfYQvg1Exnw6RslYgdnC2gG/
         GKZqG5ie80UEF/2N6SQOwuX9ll0GlI27TW9EVpDoj0R91r8LK9Pd3ViHK0acurWbcfLK
         O32pNImGUnKWACeUm7HuqxLR4zIT95yf++SC2ALs9XZYgJ/0DaAYvmIxItXq9mKGFbux
         Rf//eFmVUzxxStndKCKI5Fq2uzlnjY+jHmitOBevYxRK6U8M3lnsDhWUD+uqHmzSLDPJ
         Fb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767216802; x=1767821602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBCpAO7sdjZfJGz7bpZwxFzuAwNuSKAoKLO0csHuYSg=;
        b=rr4o4YuplnYSFYYjdixkeaQxPaJYRIyInMtCt8AY1MZaVbg+rA+NjuMmnEwDyvbeF4
         CKO3MOLNbuWp7f9SXxlZFX3/KW4iUMmOXGQ46w9a5du2x+LZrgOtLzAn8Y0ktCT0OfCd
         aInXVD2KCKsUttXvB4yGs/S2o4FksugcI/Ybzm7d600RGEY1jevK59/PvvJftZw3AwVF
         uIfkKfebtLvZmV1SwFEztFfzFwaNT3M86zVMXUNrxawHQ1ZA85SDwV2pGIBzVg1Wx3e8
         nROLhZNCAI/XR09zdKqyWdNqjQLs9FNOF4p3PTiq8tWGJsWfn9hwyxxVCbTkb28PhPrj
         G3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCX96CPVCuPMivdfLyj+H3S1J5LWzi4kxv7zvtEXB7KEOJqwhLePDntdk/+9HAnZxuxIGW1/YG6kI7vEq4v7jxyAtLn6O4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzObV0QRnwbXR8RYMTT53Fqu7IyVwWmHDloX2qYWEYzm/Qbq1rg
	AOh/RIb4hXDmEeWN+yEOQVOKrQSHRHDR4heGDzuOiLdF5jlpjMvYI4Og
X-Gm-Gg: AY/fxX7/K0xRUiAYp/Jr0ba4Xc5yNrE8SYZ5kjaW0F6Hd8y3H2f1MTsxDIpPadVsH2O
	Q+Gwnum8WFIeW38AqLWaCj+zYerGe26q46tj3XMk9h3UwyYSk6e+tUkXj+pX72pumNEa1ySH8aI
	ks1GalXxPK1XEh7lPkM8kNfChQZb64Ts6YdTYpJ8eYjf6OiTGO3teYjRLyDr5AdF0bLWxIi/aZl
	e5AmXq5kodQH3wdvCgPiS20HDGlWs4RAEwU1BCPY+pmW3TF0MQQa2NcXs2sxVsAaiZvfj8EAZw3
	S4QWenb+N8a190NHApuodW6ZTPWtlezLVprRDLMTB1qs/uFWaQ1zO/n2KRPeOPedY2OaBpUyd0Y
	wv/6zK0b9LmAm4PHPPg3FGdOvfkiwv5nrKfHLtB9yt0CFCRmNGioLy9uPHCKia/8OXyC6SB3sRO
	fpZcnh1n43GQm57j+t/NIzVBw1R+PnNy9Rwc/z5Kr1tKfH6AErtdZsDZ2kOnH1
X-Google-Smtp-Source: AGHT+IGrW2dkVeXMGDiviLFRn2PyNQO/MTMW1mEtQKQfGK+fRZMPfcXJuwCFnc21umrHxZR/LgYOfw==
X-Received: by 2002:a05:690c:6311:b0:788:17ef:4ecf with SMTP id 00721157ae682-78fb407e423mr360305577b3.50.1767216801696;
        Wed, 31 Dec 2025 13:33:21 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb44f0d57sm141931647b3.31.2025.12.31.13.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 13:33:21 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
Date: Wed, 31 Dec 2025 16:33:13 -0500
Message-ID: <20251231213314.2979118-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This patch introduces a new LSM hook unix_path_connect.

The idea for this patch and the hook came from Günther Noack, who
is cc'd. Much credit to him for the idea and discussion.

This patch is based on the lsm next branch.

Motivation
---

For AF_UNIX sockets bound to a filesystem path (aka named sockets), one
identifying object from a policy perspective is the path passed to
connect(2). However, this operation currently restricts LSMs that rely
on VFS-based mediation, because the pathname resolved during connect()
is not preserved in a form visible to existing hooks before connection
establishment. As a result, LSMs such as Landlock cannot currently
restrict connections to named UNIX domain sockets by their VFS path.

This gap has been discussed previously (e.g. in the context of Landlock's
path-based access controls). [1] [2]

I've cc'd the netdev folks as well on this, as the placement of this hook is
important and in a core unix socket function.

Design Choices
---

The hook is called in net/unix/af_unix.c in the function unix_find_bsd().

The hook takes a single parameter, a const struct path* to the named unix
socket to which the connection is being established.

The hook takes place after normal permissions checks, and after the
inode is determined to be a socket. It however, takes place before
the socket is actually connected to.

If the hook returns non-zero it will do a put on the path, and return.

References
---

[1]: https://github.com/landlock-lsm/linux/issues/36#issue-2354007438
[2]: https://lore.kernel.org/linux-security-module/cover.1767115163.git.m@maowtm.org/

Kind Regards,
Justin Suess

Justin Suess (1):
  lsm: Add hook unix_path_connect

 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 ++++++
 net/unix/af_unix.c            |  8 ++++++++
 security/security.c           | 16 ++++++++++++++++
 4 files changed, 31 insertions(+)


base-commit: 1c0860d4415d52f3ad1c8e0a15c1272869278a06
-- 
2.51.0

