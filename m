Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698318DB32;
	Fri,  7 Mar 2025 03:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319163; cv=none; b=ZaKu4bXuZAeKH9yyhHeCYpXceYi/Pw+8c3DJNlQwpeq0VBwaE8tMDKwPBMMRO2CdxNQ4EP/vHQPBsJYkrxSX3A6Tlea2jY6GjAxEuvjUDwU1a+U4RsyOHKTUsNSKC85Fg+FLYri/DtjTk6xwhyGB+eLtlVDm7yzYxfqHH5cAHtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319163; c=relaxed/simple;
	bh=HqkVtEDf0p4y9TxtMur9tdjhvByo0aozITD3vARWJS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnijhbiyG5g7lOsJI8oyZCCPTdYf7iYv0vwp95WYBqrxwDmA8DEnkmaI8uZWis5v5I41mMx7ju9bAxLkMjkpIlcWOWCuFPO8BGPGPc/70hCibYsJEEdxn8NKHZdWHfFP8Euz1EyuBwwk7adZ/9chlhlLR414RlVRk8vlt7JUPHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmbgNhkR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmbgNhkR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19CBC4CED1;
	Fri,  7 Mar 2025 03:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741319162;
	bh=HqkVtEDf0p4y9TxtMur9tdjhvByo0aozITD3vARWJS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cmbgNhkRLemxZPpOSTbWMiZWD0iFLIZDcRWm0XbCYGsXdnw58vt1OrRAEs0navkxJ
	 eGl6F12tGg1Da8XvnQXVfcIeQ+SQakEQPxggficsJiQFKIQcnG4AdWOQcjGHuyg188
	 pOIecFX8EVkL5Y1AmdQu7mT26WwDZG5vyIFBf5V5iMOwAZk1GpnRrHWOggY0Q2W5GX
	 DUygQ2I4ikqltsNG8ShJYCOzR2OxyBtlE7L/ZeCjbWgoOAOaNlLfoXf+4OUcPqD4+g
	 DcRLab4BTC/pUCN4WcAYxyQ5fBS8xo53OYBB77AjIhnq/H8rLhR/5195Bmk5Jd2Yce
	 gVjY9fRpsKDtg==
From: Kees Cook <kees@kernel.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Kees Cook <kees@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] samples/check-exec: Fix script name
Date: Thu,  6 Mar 2025 19:45:58 -0800
Message-Id: <174131915705.900594.10701719115017257985.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306180559.1289243-1-mic@digikod.net>
References: <20250306180559.1289243-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 06 Mar 2025 19:05:58 +0100, Mickaël Salaün wrote:
> run-script-ask.sh had an incorrect file extension.  This helper script
> is not used by kselftests.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] samples/check-exec: Fix script name
      https://git.kernel.org/kees/c/6c2c85820b2a

Take care,

-- 
Kees Cook

