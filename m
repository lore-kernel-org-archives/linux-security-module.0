Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63557248886
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 02:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781663167; cv=none; b=XHj7Vw9BTQ9Go2alK+480AzjyxkNmoN4U8EwL89rvvCR44Q4ODWbdZVxr87inDnU+nCP/eNkH81m5gDXQ4vPkWtMZFN6wMXckgZapeXdhnRcOng2VJ39icDD7rQavIjxphaN3ryY2XwHtQiyJkSVX3lzNvwRNOufw66tPQRFKkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781663167; c=relaxed/simple;
	bh=XWkT0S6L+d+2Zh4pMvZhCzEN+mCK+F8W5cQsmwgihxo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4gj/nU3rEPjQfR1rwJJ2/YaUPLXfB0ggZzYRbPnxIr8QlNP4Us8phu3BHdU3d6rVniPtCC610BhwYhG8PfaPO9HFeNkCj+CLrji8DB9KblAk1cuk1fpOv3MfBqJ2D0yYhbbSJfmwn8IsPlZhDIYfiIxMTcpHClWkjqA6K+2JGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZWWsnlaA; arc=none smtp.client-ip=109.224.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZWWsnlaA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781663155; x=1781922355;
	bh=XWkT0S6L+d+2Zh4pMvZhCzEN+mCK+F8W5cQsmwgihxo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZWWsnlaAyAMlshPzCPxE90WIFw4+Fxkm/0mjPCf6fM113V9NgxrW8Odi/W8QhSQ19
	 2W1yTYU8IKt6saGEqqtLbt7TOrzNnWGgxD898sTsiywk8XAcVEyUB7V6/92DyS9Bde
	 XDf01jqvFJjJGFxp+IRnoGyeOt0LBD2dEzTFsB5RQfKIluCiN8N9vjWGD0LpIhLr+C
	 lqWdftg/BuIvqyd7HJg2v5wngERBuZgVbjT0VjTIJVXYsJL00m8MOeofWEuLKTJB0c
	 M1vOy3zBx2ZpEJAT+9SjgbgXRp361JnYucBI34pCerpWkY69YqlSI6JsFQR74Abzjb
	 Af8ZY5R8+gunw==
Date: Wed, 17 Jun 2026 02:25:48 +0000
To: Jens Axboe <axboe@kernel.dk>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, linux-security-module@vger.kernel.org
Subject: Re: Landlock: LANDLOCK_ACCESS_FS_IOCTL_DEV bypass via io_uring IORING_OP_URING_CMD
Message-ID: <20260617022541.328550-1-hexlabsecurity@proton.me>
In-Reply-To: <fcfa9bc9-4f7d-478c-90a2-ec4efd4c7d43@kernel.dk>
References: <20260616201633.275067-1-hexlabsecurity@proton.me> <fcfa9bc9-4f7d-478c-90a2-ec4efd4c7d43@kernel.dk>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 69dbd47064b6102bc5e735dc8555ef902d531dce
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks Jens =E2=80=94 noted, the fix belongs in Landlock. Micka=C3=ABl has =
the full report.

Bryam

