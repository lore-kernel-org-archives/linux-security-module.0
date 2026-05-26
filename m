Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689662C21F1;
	Tue, 26 May 2026 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779761120; cv=none; b=bcNqVK6Je0QmmaVN0bl37HtUM8bRfloofEH96NRgUJIIzxco3ydXlk55TyARtqmwG7IBXOdDQElwv0m5Cabg6ghMmWxrrF36GgYi1nMTP8ikPS5fyBSXzyvZ2J2jWuG+yar0SYBKYQJ3df8l/5ZfppQauOmpCIQvVs1oqMxMpiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779761120; c=relaxed/simple;
	bh=9Wc5mzKmHVv7kPhEsGiEGPZKOOkKCsfZe76yVzvQJ2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNIkp1nWvXBn+kpCx+XPtje6n63y8FHQ5ArtPpZqUuEI2Vv0B/p5j8QMLhMwhkxxwpChKjhshaEvvu/HCA01IOYDvGRmaDgWAUnrQ+7BT6j4jjZWiGdiurW3pmmP3aqqDFff3vfeSP/nHpWBa6lJzp9HEu2dB4aPGMdtqNrwBxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64Q24krU023940;
	Tue, 26 May 2026 11:04:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64Q24kut023936
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 26 May 2026 11:04:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <814a7f61-67b2-49e9-b5bf-fd049b458079@I-love.SAKURA.ne.jp>
Date: Tue, 26 May 2026 11:04:46 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tomoyo: Fix NULL pointer dereference in
 tomoyo_init_request_info() when domain is NULL
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Cc: "Serge E . Hallyn" <serge@hallyn.com>, James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20260526012315.762144-1-xujiakai24@mails.ucas.ac.cn>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260526012315.762144-1-xujiakai24@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav205.rs.sakura.ne.jp
X-Virus-Status: clean

Thank you for a patch, but I don't think we need this change.

TOMOYO's initial domain is &tomoyo_kernel_domain, and each thread belongs to
a non-NULL domain. Therefore, tomoyo_domain() is not supposed to return NULL.

> Found by fuzzing. Here is the report:
> 
> Unable to handle kernel paging request at virtual address dfffffff00000003

Is this a NULL pointer dereference?
It seems to me that this is just a random memory corruption.

