Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187DA1272D8
	for <linux-security-module@vger.kernel.org>; Tue,  5 Mar 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654233; cv=none; b=myWqPx7/WajuG1CR42hH+7L4OhRPAOe8rmRgl4y6yvVdMDozAnzy61eZUdZNNgTfALLi+pDYQlm3cfGdkGTtdeU71WWwIRVDZhovZSCmi/WjK6uT6CQCRaduc22nPGZuCc+uAiAPC/A4MpXs6x+SUgjAXVYT+yV6Tz20avwWguI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654233; c=relaxed/simple;
	bh=I6gF3hfQ4KICQO4I9Zkg+VI3/UW5S3YBcpg42GN3wbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLIR9UxZ9GRHHcj2s0bXQ1CtJQbQRZ7W/C3STEQ3eQu8fcjYgAjzRcral0gUDMPIH4Uo5EQpZ+y352+iHUuSz6SG0gx6n4OUamZYV5rLmv4iu1S7x1rhVSvKnhtDsmkvR6cJ2k5Ql1a/6eXQ8hRHNMtMg5qKkYVZ75omfsbAXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=TWylsQD3; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="TWylsQD3"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tq0Yp39PPzMs5h7;
	Tue,  5 Mar 2024 16:57:02 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tq0Yn5H6gzFTp;
	Tue,  5 Mar 2024 16:57:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709654222;
	bh=I6gF3hfQ4KICQO4I9Zkg+VI3/UW5S3YBcpg42GN3wbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TWylsQD3JTxGxylCvErZitLxLBG2JQTMvuFxh+i6Z49W0ZffsovD/v9CVO/EKLV+0
	 p7gbyfi3PjPz3YeQhg4CIerXeIcS+xkqdhyR3XEnFBuqbviuaJS9v0vatT9aRqewtj
	 esATKj8Bbv/AgB8zxPBfTXAvSF17jDwt2kz8MuDs=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	davem@davemloft.net
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	edumazet@google.com,
	jakub@cloudflare.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v1 0/2] Merge TEST_F_FORK() into TEST_F()
Date: Tue,  5 Mar 2024 16:56:46 +0100
Message-ID: <20240305155648.1292566-1-mic@digikod.net>
In-Reply-To: <20240305.eth2Ohcawa7u@digikod.net>
References: <20240305.eth2Ohcawa7u@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

This is a long due cleanup to merge TEST_F_FORK() into TEST_F().

This second version includes Jakub's "child" default value fix, proper
signal handling (TEST_SIGNAL), and move fixture setup and teardown to
the grandchild process by default.

This also removes the step counter and simplify Landlock's test
teardowns by removing some umount calls.

See https://lore.kernel.org/r/20240229005920.2407409-1-kuba@kernel.org

Regards,

Mickaël Salaün (2):
  selftests/landlock: Redefine TEST_F() as TEST_F_FORK()
  selftests/harness: Merge TEST_F_FORK() into TEST_F()

 tools/testing/selftests/kselftest_harness.h | 72 ++++++++++-----------
 tools/testing/selftests/landlock/common.h   | 58 +----------------
 tools/testing/selftests/landlock/fs_test.c  | 22 +++----
 3 files changed, 48 insertions(+), 104 deletions(-)


base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
-- 
2.44.0

