Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC42121ADAB;
	Mon,  3 Mar 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023217; cv=none; b=aLpVvX5lzJ4WICgdJJ7uZ3z205kXFTkL7jXkn80V0SdgNF2rzS1G+rPp1PM66uUgKfDzK47wsODNjNsONEuUTQ+P3/miFy6jbbmFa75Yz175MEO12GbVKDL4dZJAJjJkgmcjndikZ9VHq/wUfaFFIiD0IpZ8xPj7JGkUrQgiKFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023217; c=relaxed/simple;
	bh=v1OOtc1Sxyp2JpmkMnkMjZ76Aqzn4r7fyIhcgNLcKfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qa4aCGkg0M1qm2wwN1mFYFSZMlJ/yVoFzjbl8r5jizeFhvid7Wu41zaKfG4Eh692ZGxemFnBYJlLK2RLGxckqI9KpYFCKnVlXqgQK+R1pLIRBN7TRtT5FkIcIewJwgT1bNl4JaqMRqXDDNIPWDbY3uYW4y5BkdEdW0T8d41v5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yi0jnXxj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi0jnXxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D726C4CED6;
	Mon,  3 Mar 2025 17:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741023216;
	bh=v1OOtc1Sxyp2JpmkMnkMjZ76Aqzn4r7fyIhcgNLcKfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yi0jnXxjvyNjjlLI2MqsMUpBHzJHNY+UOzkXF3bPLWZB6YNvrJohQR5tHDLrptgyz
	 Zyy3zaePRestaU0xoO1o20q3pGzZ1m48PZnOvmFqlSYQemuGwC+ocMtCbovcv0LK13
	 ccHcMSm+/flzWMEDA4tQe0ADusZzAOFU54j4dT1QzPebKyoaMAW2fOv9SGHqJuekoX
	 YZ5kNmdYDeehrTv5IjaCGcVBBdpvCrThiIdHkrKBvZvD3I35tSS4qvqDhC3625vFIK
	 Ogdc2qBHANQ3AuNe8abNaIVjxUk6uABakIvXzkZea/1WotK+hjPE3EUYrEEhvnv/C4
	 cy9ptLIm7+l2A==
From: Kees Cook <kees@kernel.org>
To: linux-security-module@vger.kernel.org,
	Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
Cc: Kees Cook <kees@kernel.org>,
	cedric.hombourger@siemens.com,
	srikanth.krishnakar@siemens.com,
	linux-modules@vger.kernel.org,
	paul@paul-moore.com
Subject: Re: [PATCH V3] loadpin: remove MODULE_COMPRESS_NONE as it is no longer supported
Date: Mon,  3 Mar 2025 09:33:32 -0800
Message-Id: <174102321115.3198404.1167712384935086288.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250302103831.285381-1-arulpandiyan.vadivel@siemens.com>
References: <202502281136.66F12960A1@keescook> <20250302103831.285381-1-arulpandiyan.vadivel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 02 Mar 2025 16:08:31 +0530, Arulpandiyan Vadivel wrote:
> Updated the MODULE_COMPRESS_NONE with MODULE_COMPRESS as it was no longer
> available from kernel modules. As MODULE_COMPRESS and MODULE_DECOMPRESS
> depends on MODULES removing MODULES as well.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] loadpin: remove MODULE_COMPRESS_NONE as it is no longer supported
      https://git.kernel.org/kees/c/fdafb7e70cca

Take care,

-- 
Kees Cook

