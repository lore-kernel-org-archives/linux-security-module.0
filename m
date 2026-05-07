Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ADA7081F;
	Thu,  7 May 2026 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178725; cv=none; b=t4svwefvoYlkUdmJXKfIJYYhD1GtrmVp/q5iR/0TKo8yKpx6gykqGZSoNRFtEGlIT1HWqrZAIVKnFkRcaCCxquR2AdXnz/Hkw0fEuY6RQbnrc2dzC/SsfB0g92S2lOEyUx1dHfHKA6rXsiNK0XJ/RfwRVTMznhbXoY7ewVzGmqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178725; c=relaxed/simple;
	bh=b5J+KPKHs2hOnCWi5Pn8JB7sH/di9nBZVHYpk2c7g5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ivDAQsY3nCHqP1rJYUDeRzeMjmjKnFH84xE+6J22NC1O9IukOT4EIYAAsAlTBMR+0gPjOSjTW6N9TB9wjckPfX9hAcApGvseylT7ztrsLsdPGWfmWFLyS+PkXI2CbBItMtUIFMM900vh50C1VWGqsLE3GlQKDoTCDjVv5tAYq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pAW7xBhQ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pAW7xBhQ"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 98F774108F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1778178723; bh=RTMt6BKs/kz2IfrGRlqqQV3gsT6J5jkpN08BrmidNI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pAW7xBhQpMXqkAFPsv6VK/3BQVxo+qWLlIz00LPsw8Tz70jOcJvQqnS50uvA/GzpL
	 K3cJrBMx32G/RALouQnjrRABTpu3cyFoVPnkFeuYmXyFy1LG4xdOSs8YDBcnxOUNGv
	 ljKCK6yXErWpzwNmVu3yew1CsO4AGnEo80Qa+bJ5ZTVcKJTyrhrquZzAPma5RO1tU5
	 D+dK9LEj5nxaLfFdBY680/8D/KL7A23cgpUNfT+z0Ce+D+qCMSSZgywFas/JqYLfEU
	 Zb6297f6LOWiKL8m59Glr8IEYmfgsWS/PEJQcmXXYvIUiV6dYcERrRyEv9qc9DuW3z
	 s5ki6aDxu2woA==
Received: from localhost (unknown [205.220.129.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 98F774108F;
	Thu,  7 May 2026 18:32:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: John Doe <drapl0n.kernel@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: fix typo and formattting in
 security/credentials.rst
In-Reply-To: <afzQVIv4-Up24VNM@gmail.com>
References: <20260506225925.271163-1-drapl0n.kernel@gmail.com>
 <cbe6e145-9d2f-47bb-8d22-1599cfd1a9d4@infradead.org>
 <afzQVIv4-Up24VNM@gmail.com>
Date: Thu, 07 May 2026 12:31:48 -0600
Message-ID: <87pl378417.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

John Doe <drapl0n.kernel@gmail.com> writes:

> Thank you for the feedback and acknowledgment. I thought that since my
> earlier patch was invalid/corrupted, I should submit a new one rather than
> version 2.
>
> I understand the procedure now and will ensure that future revisions follow
> the guidelines.

Along those lines, seeing multiple names associated with the same email
account is a bit disconcerting.  We are not generally interested in
taking patches submitted under pseudonyms...

jon
