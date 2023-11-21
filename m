Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4FA17D0
	for <linux-security-module@vger.kernel.org>; Tue, 21 Nov 2023 01:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DnI8WOh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21512C433C9;
	Tue, 21 Nov 2023 01:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700528744;
	bh=WydedWHI5hgSzmjYaAgFcEvQrWisnvd0Tah1sl3VwoE=;
	h=Date:From:To:Subject:From;
	b=DnI8WOh3FMfkpG0Mxtk4ZpPa3iLWhHYetmh8d26AMg8rSDpmEYe5jEAZN3N4iQ3An
	 JFf8Or/yR24Upc7xUIKnCGGiJLtCs0/Y8u92RIVM2zx7pY6a2ZGD9O0SM4Na8rQXRZ
	 RB0/sCTWgplnkwGrVKo2Ekbl2wSRoivbTbTJJ+/s=
Date: Mon, 20 Nov 2023 20:05:43 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-security-module@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231120-elegant-juicy-adder-e9ee3b@nitro>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to new vger infrastructure. No action is required
on your part and there should be no change in how you interact with this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K
