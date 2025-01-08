Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21A6204696;
	Wed,  8 Jan 2025 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374699; cv=none; b=q/tJi9yjLlloyncIhbAV9x9NZpJGfStzW1SlPEQVuu/qi0fN/S9fFXaAMqt6AV9JRbKKhqHhVtO37sKLjWftX4eWYAlT8idJ3Z8ofsAVB2hNICjqqkwBQVAmiFBYyiZPpsUGpahdvKEyNhuTRkeB/OZMB4dhV+XyL58U2ShimbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374699; c=relaxed/simple;
	bh=D3YEGYRPIjSsJsnGb13O3jbwsgGJUSGq4VkcAJGgje0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=riHUAF3viyCLYgd1wbLmNiYTJ8Ygo9KB/moXTNAgB9AFOUKoL2aVIwFhubTIpAsL9UVc2Qz22OU42ri4Na4sd6clVKleVp3TNslrgK+D9/mZBH0ubAAk5erjfhE4v+uUKXO/h4iuvagEa9k9eKJwjzD+wX2PNzyN9KWw43wgGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/4n97Ja; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/4n97Ja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53354C4CED3;
	Wed,  8 Jan 2025 22:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736374698;
	bh=D3YEGYRPIjSsJsnGb13O3jbwsgGJUSGq4VkcAJGgje0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/4n97Ja97fsV1VkrsKZgiFZKEVFryAo/IU+4vMxRnSuyfK2Bj+bUrCUGeqkNVNPY
	 PZzKkGfjawzxat9nnqzXhkFoa7BsQEUQsOJVCewX/oVS+N0iDG7EjB3Z7Qa7ujNB4K
	 V9mrHWMH7YQN8EIH4jY79fIA85ZWzmvcgFVKnA1fMuEaiew1sDnz96LkGP+qfv6c3N
	 fMdgHhaBG/iDFGP5cBiXXhzZPuLvEQyKGm4kgGOpFH8jnBGcQMO6wkk2/msOahf73V
	 Q4qDaW9JkYQ2ucb5pPHuNbD55Q82OLWXzS3DkGTc6aZWWftaFTnx5uc38p706nAD8A
	 QeafOzL99ZohQ==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: Document INIT_STACK_ALL_PATTERN behavior with GCC
Date: Wed,  8 Jan 2025 14:18:13 -0800
Message-Id: <173637469270.1707370.12908421314398024582.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <293d29d6a0d1823165be97285c1bc73e90ee9db8.1736239070.git.geert+renesas@glider.be>
References: <293d29d6a0d1823165be97285c1bc73e90ee9db8.1736239070.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 07 Jan 2025 09:38:57 +0100, Geert Uytterhoeven wrote:
> The help text for INIT_STACK_ALL_PATTERN documents the patterns used by
> Clang, but lacks documentation for GCC.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] hardening: Document INIT_STACK_ALL_PATTERN behavior with GCC
      https://git.kernel.org/kees/c/a9a5e0bdc5a7

Take care,

-- 
Kees Cook

