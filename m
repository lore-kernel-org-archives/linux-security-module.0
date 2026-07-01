Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B93428821
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906386; cv=none; b=nkgck7B5xCbfAF18DBYes4ou3ocFGUxZU+JqeoVa+6DdSUwIjuPaS7rG+XFM8WyZhlqmzuW0ZnO+A+8vMO0r6ESxuD1ZDDl3AnMlo0WVIfx1dtYrqdRtntdu8zEi8fi7rc2o/7CqBBZ2neAGZwj6B9R6fI/4TRCeFCQcjBOeFFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906386; c=relaxed/simple;
	bh=cGMlvT++PX7QN+AlDoh2dpxKf/KH6c+UMUYx581J44Y=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=MTtEtvNNo/nM2nVfuX66eW15otxfC90pG0BxLwUgEI3KHsUwV3bfU5psJHeDQyVj+/qtHhQ4TNvC0/SNuZ6/xLqkpGv9eAF3eNshm2sSzGgTwbrO48/m0+2+E6e1u/hM4gjdxQ5V400Vg0EnQkMmgHnSvfHJZ+2FafPyfIEtwLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 661BkBBM038105;
	Wed, 1 Jul 2026 20:46:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 661BkBkY038102
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 1 Jul 2026 20:46:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <83eb9325-9688-4a6c-9727-e137df773694@I-love.SAKURA.ne.jp>
Date: Wed, 1 Jul 2026 20:46:11 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
        John Johansen <john.johansen@canonical.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: linux-next: apparmor: ld.lld: error: undefined symbol:
 decompress_zstd
Cc: linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp

linux-next is failing to build, for decompress_zstd() is guarded by
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y.

https://syzkaller.appspot.com/bug?id=71887a15323ee1c7728a72bf3bd6356263f4a10f

Please fix as soon as possible, for I'm asking syzbot to test my debug patches
using linux-next.

