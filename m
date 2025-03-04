Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8CC1FCF4F;
	Tue,  4 Mar 2025 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110648; cv=none; b=NBtD3JZu3P18BzYF45nM7qA8dnvNmWaQtqBkt0i8P7BAKAosaY4E3unytyw63AN8GceR4ozray5gpaNshPQxhsrfGkcLjEGVGbGabvJTO173SFVe5k/JLt0TKSVA5MsJLKotMlZS0tvpTCUnTQr7jXrRSHOTj27qFlvQ+IX9cB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110648; c=relaxed/simple;
	bh=stqbPtGtEoTsmvvD0BvrvJ9ag8H9MyLeEeDpLmC9Vw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Blv3XEk7J3Fl0Cj52iu8WlZ7gVFYWyYN+f5svd8ttPb3lromW7y/6S9V6Rq89IolByo2WuGf90zwDADI8X9Da0G2eXuzAdRYAA0xhXZGwPaf+Fm8gNV2K5qMV9jisnciYZNf6QwJ3vDjIIuEViugQkWoPvutrwsVcJ+s9gw2ZCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=up4yF2Td; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="up4yF2Td"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38524C4CEE5;
	Tue,  4 Mar 2025 17:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741110648;
	bh=stqbPtGtEoTsmvvD0BvrvJ9ag8H9MyLeEeDpLmC9Vw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=up4yF2TdVsC2T+pMfyfy0GGXXY9kyqhbXoPo3pFHamZMUzFJGxWfxO8RGs57B/SGT
	 w2j0xUoZsFrH+o5FyPXg+37zwzTAygCSXJW2lbj3AzLMAJWjVJyP+qCinTGUCzE79K
	 vAKLA2CylUO34gym3zzEi/GzdWhn1VXEj8wuniYy/wpKKCelNNzmWY/LkyR46IUL7/
	 F2Xj2oOLF4h4tOnFrIlnxLPE/mJLnuw6KqWFzLFs/edHUQWiDJZqWa4sWiloXurM0i
	 kh5kIYkWUoMUNBVAXjwLIupe4uKeZfb8jus0XMqc1uLeg3m43j1EptuEAKed901ICH
	 dlAR0KA6n448g==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] hardening: Enable i386 FORTIFY_SOURCE on Clang 16+
Date: Tue,  4 Mar 2025 09:50:44 -0800
Message-Id: <174111064321.3934933.4843198067758331073.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303214929.work.499-kees@kernel.org>
References: <20250303214929.work.499-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 03 Mar 2025 13:49:37 -0800, Kees Cook wrote:
> The i386 regparm bug exposed with FORTIFY_SOURCE with Clang was fixed
> in Clang 16[1].
> 
> 

Applied to for-next/hardening, thanks!

[1/1] hardening: Enable i386 FORTIFY_SOURCE on Clang 16+
      https://git.kernel.org/kees/c/3e5820429980

Take care,

-- 
Kees Cook

