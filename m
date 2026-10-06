Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0253D70808;
	Tue,  6 Oct 2026 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791258793; cv=none; b=L/NzwcahPDPRkdrRLEGomuckVBq6/i/WkQ5aoLeUWtj+y5BylVYZfoRd6HGmQC0SXZ4uiKOXCxotpEnHjUMA8B8+oMhrXFZzyIUhLI+J1g1/suDimkEJTv+3449EPh7oq3EFvH+MugPuLj4LK5UvIPwWyhbDZcvaJ4jV1yaXORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791258793; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SUhghmXl1uvLJJXpZqdY8Xruta7HhBbVvFBHfeoyH57Z1B8Xxtjg8kSK8Nzj/yGf8un42WewtXu2JwjNkbjPEf52Sj/03QKWewHNRimJSgoBkSHn0rgocoFuMSRmE9ZVU2WpSJShZX1RQ+gFWn3pN8t+jleBVspy9GTSbg2i74A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muATwRgW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muATwRgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32A11F000FF;
	Tue,  6 Oct 2026 03:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791258791;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=muATwRgWJn+3TpdDmj4OMn1iaJD1JNvj2sLAYqlr/r4lVDLq7DoM+L3Jtv8/32Fmj
	 fv6p79jmQeCdtlz3N72EfBNIosO0HJQR+/R7yA5K6AP5nqG0DFiSzdXaact7CkkuNL
	 3TG7Yn0vM+Ximwzw/+FnhRGEUGIpGDvFHSLQkhHIaPTkeHPTWSv2ID8nCf24w7psLW
	 VuUsS4dYb4ZJ9DGxuWhB60UEPYbxplocY5r/K/jIPtYpOhHT0kvgFPPBUwXmtHxJBx
	 XOPiqwdbbapZykfDkxF4VKtxa70Kh09eIxIboQkD8G962BjIAZLzv2+pLtSHpu+Sdr
	 5NZyZiCmodNOA==
From: netdev-bot+sinfo@kernel.org
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>,
 Ondrej =?utf-8?q?Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v2] cipso: adjust cached option offsets when removing CIPSO
Date: Tue, 06 Oct 2026 03:53:10 +0000
Message-ID: <179125879018.2231598.2279398827764907447@kernel.org>
In-Reply-To: <20261006035108.3101440-1-4ncienth@gmail.com>
References: <20261006035108.3101440-1-4ncienth@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
