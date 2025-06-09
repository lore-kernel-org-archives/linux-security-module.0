Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F016132F;
	Mon,  9 Jun 2025 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749457250; cv=none; b=lxediOXUDS8k+8g0O9KQpHd6z6tULbg8KUbVz7xbz6Cf+CkTuXDc5MCm1YtVyMMaoIQGYJJZ0YmWFrgMIThxJD5ZOdZ4FZlajkLzTShNB3dTFbjsqFgoeT6pWaAWmfmwFkDZCFoKxDbP4n36sXiPo2t5mBATJqiDZT7YnEQ7cuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749457250; c=relaxed/simple;
	bh=Ek6re5MbESOaXEOEYjJE2cnjCEAdgooEaU3+vaHHHOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U/FddvyZh2TdABzGI+otawDX0d015NHSdioN92o1MGywojT6DMwJBrkLD+d48Zhephg+4hemLPKD0wc2ozATQTTSm88JI792Z2309yJrlY5bgQVseaS2+c4lFADRr1aTK+d22b/AHSQAuHUh4gVIYR+HTyTmJlHbrepipfcMV6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cqao6s2O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cqao6s2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CFDC4CEED;
	Mon,  9 Jun 2025 08:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749457249;
	bh=Ek6re5MbESOaXEOEYjJE2cnjCEAdgooEaU3+vaHHHOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Cqao6s2OBzOIA94YfL/3u1tlwIEeeb/h4lofmWpufdOv5vAs4jrRi1J1M295UN8qw
	 cyTZ3n96cf2kbrIDKn5q/OgUt2AozHBsIwtA29H/t45M5sxjT0J+n/XmfF2TaGUzZo
	 HAAjmh852MYHIPrBc6MCoPdpEBFDZam9mzieCpiyvKL3Pbbi6MTkXq3MOVDS2IJyld
	 as3vGv15n6Izc5PLiCRtbeBTadNgkz9iJ3bK0Cd8ELYTJChL0i09b/CRXVroo96ey8
	 28hdjZZsvcvqcCtYA1+KkdOWTjXsRz2dJVHBS7xCZ61loPMn9DW7h90myznWKTplZZ
	 dblof9w+DVc6g==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D2ACE1AA975B; Mon, 09 Jun 2025 10:20:36 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org
Cc: bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Subject: Re: [PATCH 00/12] Signed BPF programs
In-Reply-To: <20250606232914.317094-1-kpsingh@kernel.org>
References: <20250606232914.317094-1-kpsingh@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 09 Jun 2025 10:20:36 +0200
Message-ID: <87h60ppbqj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


> Given that many use-cases (e.g. Cilium) generate trusted BPF programs,
> trusted loaders are an inevitability and a requirement for signing support, a
> entrusting loader programs will be a fundamental requirement for an security
> policy.

So I've been following this discussion a bit on the sidelines, and have
a question related to this:

From your description a loader would have embedded hashes for a concrete
BPF program, which doesn't really work for dynamically generated
programs. So how would a "trusted loader" work for dynamically generated
programs?

-Toke
