Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013C6335C7
	for <linux-security-module@vger.kernel.org>; Mon, 26 Feb 2024 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965011; cv=none; b=n7dr3OOQXqc9ndU7xWps3VH9qpnRpGfC1ewp93zIJLFhtxj7Q/pJovjZdhhDsqLH6/TPD6GHN28FcLt0MNPrXxCa+BZ1kZhwIbRRX7PXQyX1SBcczt2tH4Xv4MDopuIFVDrAZPQxoROfuvB+SUBAFqu0J5kRaWiZtu8/9alaICA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965011; c=relaxed/simple;
	bh=olTfBIftIqoEp/VOpd1IMdJpxpy9THNXLqxVEH7X7MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEzdy+ifjwpmLy2A/gnHoJC+d898t2QubI7comv2n3ihX70G6dllGM5OU3xcN34FFnWw/cbJ93NDQ0IoS47qAr8oAN67rrF5zHBr7TmpXEPO483X6mPkU6YwcM8uNj5GtRDkKihcaOSc4jf7nwdu5NMZtvGaGJpF+DJLA5DiTxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xZDChlsE; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xZDChlsE"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tk5XK1qpszMpp1c;
	Mon, 26 Feb 2024 17:23:45 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tk5XJ2PmTzMpsDh;
	Mon, 26 Feb 2024 17:23:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708964625;
	bh=olTfBIftIqoEp/VOpd1IMdJpxpy9THNXLqxVEH7X7MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xZDChlsEztJl/3JzQC3Bn0c7msXOSlb54AMYIWcWZux52vvfqgon1+CEliOtKCA45
	 eMnXxs1tNnsEop7VQ2Z+0WvzcU5AjBbdkBrocJ4XX8Omt4CKGSH4CrW8ytlWLnOhe8
	 OfjmD8h155QlFnNOglWeBImQq28ksGZA+KxKIYoI=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
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
Subject: [PATCH 0/2] Merge TEST_F_FORK() into TEST_F()
Date: Mon, 26 Feb 2024 17:23:33 +0100
Message-ID: <20240226162335.3532920-1-mic@digikod.net>
In-Reply-To: <20240223160259.22c61d1e@kernel.org>
References: <20240223160259.22c61d1e@kernel.org>
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

This should simplify Jakub's patches by removing the step counter:
https://lore.kernel.org/r/20240220192235.2953484-1-kuba@kernel.org

Regards,

Mickaël Salaün (2):
  selftests/landlock: Redefine TEST_F() as TEST_F_FORK()
  selftests/harness: Merge TEST_F_FORK() into TEST_F()

 tools/testing/selftests/kselftest_harness.h | 56 +++++++++-----------
 tools/testing/selftests/landlock/common.h   | 58 +--------------------
 2 files changed, 27 insertions(+), 87 deletions(-)

-- 
2.44.0

