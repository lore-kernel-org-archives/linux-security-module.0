Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1D45012;
	Thu,  6 Jun 2024 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699276; cv=none; b=KTfs2ul6HMV0pJfUfyXiyVqXFHDt+ntpuiRi4/V6KfPU9cXrjeSreLbIod9fJkjV3tn1y8ngujvAjz0WAz60YIjzETUnLn6Dn7k6TOSaXEHc6eZ92KUnPMutzMrjAjhY27RZeGCLwL6ytM7mXTgSirlpsUMYwBj1MBNMVh4gxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699276; c=relaxed/simple;
	bh=Ly0SqIj5WlemWgxRiDvVndeGtcs/ovTqnPzD254vT9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oy0NgOUXw66fKGXBeWWxjGmTU+9vskub05GbKaoMrWeq8ST2SqlmMrMwi3/QH7ZV8ZLB0rksm1Q9lsMimj3FnnhoalKGr+/PIcD9G/WaOHpAXGBRoyeXRAW85qvCmDdvZXvwsbHnFsLtCoem0BmkSnD6fg++p697MPEi60YUPMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVyIfY9x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVyIfY9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF3CC2BD10;
	Thu,  6 Jun 2024 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717699275;
	bh=Ly0SqIj5WlemWgxRiDvVndeGtcs/ovTqnPzD254vT9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YVyIfY9xqvu5qzFj9AyT4ge1NRGhOUV/Nv/QIQ5cGHV52/QS7/6PZePLrXixt+9T3
	 yUvh9g2e0jpC4S1Wo00uHnJN/yI8dX+ES+R6yOhP2yVwLfI3ekznAYPCBr+H1KlWEh
	 E9H9uHQ/QBSJjdtiZc86Yqp3Kl7EYb2jP9alMl5u0AN2smISbRIk1H3bgQQNK6TsAi
	 hG3zg9+WHv2NfaqqqqnJ8rFVcf7+P8mXK8dxaWjsIxerYpS1CrzICSdV1qgkpcu9zl
	 2xuqwU5FHvcWDIgSuuYxuRgJoYM0ZZ1z/nw9p4Qudr1Vjd0w/qA/Jxokz2HLYjR9Vk
	 3EAaSa65/8mow==
From: Kees Cook <kees@kernel.org>
To: linux-security-module@vger.kernel.org,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Kees Cook <kees@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] yama: document function parameter
Date: Thu,  6 Jun 2024 11:41:11 -0700
Message-Id: <171769926724.125569.8640491304656584040.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315125418.273104-2-cgzones@googlemail.com>
References: <20240315125418.273104-1-cgzones@googlemail.com> <20240315125418.273104-2-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 15 Mar 2024 13:54:10 +0100, Christian Göttsche wrote:
> Document the unused function parameter of yama_relation_cleanup() to
> please kernel doc warnings.
> 
> 

Applied to for-next/hardening, thanks!

[1/2] yama: document function parameter
      https://git.kernel.org/kees/c/f7d3b1ffc654

Take care,

-- 
Kees Cook

