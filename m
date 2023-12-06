Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FDA182C3;
	Wed,  6 Dec 2023 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sA6PY1R4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF43C433C8;
	Wed,  6 Dec 2023 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701878131;
	bh=r2YsCivF9Cppc6KHcqLTRG8cjx3g+qvqtil1NCQPhe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sA6PY1R4681rZkqWfjHhdZMPOuaiWPF6f/HLgLGjwLeQz0L5N/LbBO43INJJZf5fc
	 5IZLRnhfCTWKeD9DfWDyaJxx5y28Az6yuJADfKoinB1Z+3mxbsdFwr/ztyACUMjQV9
	 NwGA2FOBpB6lBQsORWZWyunUhxbOkLnO/hqC15BkU2vR/FJY5j2p9oBiMlFU1w3l8P
	 ITmidrFnBHENjrNCb+gexXwcwFadXG+Vc0pSFAgDuIcOiBNQslRmUxxxKOwMwbOM7r
	 jSQ9LdSQv177zffhkv9wfpSzuY0JDIVaYXtD/alQIXIwydtxPMlUfMKkNglDS6P+rc
	 fgrWXGoAaz8BQ==
Date: Wed, 6 Dec 2023 07:55:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Huw Davies
 <huw@codeweavers.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
 <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net v2] calipso: Fix memory leak in
 netlbl_calipso_add_pass()
Message-ID: <20231206075529.769270f2@kernel.org>
In-Reply-To: <CAHC9VhTEREuTymgMW8zmQcRZCOpW8M0MZPcKto17ve5Aw1_2gg@mail.gmail.com>
References: <20231123092314.91299-1-Ilia.Gavrilov@infotecs.ru>
	<CAHC9VhQGX_22WTdZG4+K8WYQK-G21j8NM9Wy0TodgPAZk57TCQ@mail.gmail.com>
	<CAHC9VhTEREuTymgMW8zmQcRZCOpW8M0MZPcKto17ve5Aw1_2gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Dec 2023 16:31:20 -0500 Paul Moore wrote:
> A quick follow-up to see if this patch was picked up by the networking
> folks?  I didn't get a patchwork notification, and I don't see it in
> Linus' tree, but perhaps I missed something?

Oops. Feel free to take it via your tree.
