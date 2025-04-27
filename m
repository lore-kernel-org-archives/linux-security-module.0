Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C88BE7;
	Sun, 27 Apr 2025 01:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745717919; cv=none; b=qau31aixhwTpTq/4LxB8qBu2EQyO9r7G0MXgSJZsCnU+TFeTvVUWPqTu83JOETPTf4E3tIRzI4mq1VoDYViNn13biSdxCLBBlreBI7wgnbSJy1guyooAeI3bzxTV5VCcYGbdRByBnxRcdLakHAgl2uyuqob0mJ2JNRaDhePnPYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745717919; c=relaxed/simple;
	bh=W6SN/J+RmPz+uzurgEk6TqbUvQ3pMLDP/yQDqSqqdIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=N9ALYtJ8mHO5b9GsCfe2z4+k3HLXKqClspWn7WrCRW3byY6g60/+0+pi3k9XdfVoIk/Nrem73XoCl2fBEOw3hrjNSNQS25YP5E9wrZkatsFsMBkK5U/9rAshCtKhKN3prtSak/pIedsdGLMLpm1r1q+rNZFp1RKGebKNcntgT5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKNEOsP2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKNEOsP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD454C4AF0C;
	Sun, 27 Apr 2025 01:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745717918;
	bh=W6SN/J+RmPz+uzurgEk6TqbUvQ3pMLDP/yQDqSqqdIo=;
	h=From:To:Cc:Subject:Date:From;
	b=PKNEOsP26KcYZcTw0psvOQxNfhzsvt6h3QRZZHErbdaEBG72PcaD42zYA4Yq+8vVr
	 DqqrWpEyXJttG8H4HAla1KAPbY0JW7EkTPs9BKxHzoeuUeWYtfep2x6d21p4F+WL2F
	 CzYFQgBoStQhQq95omVQWDB9Bw4JEEzqLyzn/pwcHrpC+HJ2talD45ADh/Ne9PIQj7
	 wSryssH+UalegFIK7qCqhKFqaGWiJEM4VfelRqsY/DsOMB51O1Yd35HRx6F4JcRi3P
	 vdh0yY8Vm/NLOxjKSfvNkS6qoDTZhyJc+CjNdSkJ/3ONAoPG6fjD3Y69iCCpersa14
	 wcLBpx191OdmQ==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Mark Brown <broonie@kernel.org>,
	WangYuli <wangyuli@uniontech.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Bill Wendling <morbo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Petr Mladek <pmladek@suse.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 0/3] randstruct: gcc-plugin: Remove bogus void member
Date: Sat, 26 Apr 2025 18:38:32 -0700
Message-Id: <20250427013604.work.926-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=kees@kernel.org; h=from:subject:message-id; bh=W6SN/J+RmPz+uzurgEk6TqbUvQ3pMLDP/yQDqSqqdIo=; b=owGbwMvMwCVmps19z/KJym7G02pJDBm8XTPP1rEcOrBGSNM6XOiD8hwjxi0cHwK5Ex6bPGkuk jzid9Swo5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCI6JowMS3L1mTLWJv9NnXJR KNtr6/ezprOfT478rSTv+n2h/EnOXwx/pVw5hbjMD/4uzl2ydJHinJStwfOlrikYd+Q2zwxZGLC FFwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Okay, I've tracked down the problem with the randstruct GCC plugin,
and written a KUnit test to validate behaviors. This lets us add
it back the COMPILE_TEST builds.

No need for https://lore.kernel.org/all/20250421000854.work.572-kees@kernel.org/

-Kees

Kees Cook (3):
  randstruct: gcc-plugin: Remove bogus void member
  lib/tests: Add randstruct KUnit test
  Revert "hardening: Disable GCC randstruct for COMPILE_TEST"

 MAINTAINERS                                   |   1 +
 lib/Kconfig.debug                             |   8 +
 lib/tests/Makefile                            |   1 +
 lib/tests/randstruct_kunit.c                  | 283 ++++++++++++++++++
 scripts/gcc-plugins/randomize_layout_plugin.c |  18 +-
 security/Kconfig.hardening                    |   2 +-
 6 files changed, 295 insertions(+), 18 deletions(-)
 create mode 100644 lib/tests/randstruct_kunit.c

-- 
2.34.1

