Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0390A19CC24;
	Wed, 30 Oct 2024 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321969; cv=none; b=X1HpMPFBOoB7VRpybW7fTGyIrHt08xkMp69OHdLOk2aXzeLD0o0UIrBGk7MoXa9KTLo/deQcw7Htta8zpQSOV6GqQ/KbW1pKwmKnEdysddhBsAesOZlz+MUsWRwzr1WzT6T7FbDezmpiljNi0Zqw8Meg57zEfjkltb5VUfoPUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321969; c=relaxed/simple;
	bh=6yZQof9bOtOgXNl/3jzelOOKHTSLQAkwb38Dh8q5LqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcJfhIxv5CWnxAog2+VmahlCa7RoU9xFi/l+KP6PorAoMtoTZPOVpDfdcYJEGuDIQ3i0DxwAokcxehPP0rE+nRasA9Tvi8eF7Os0nKHc+Ly9fcjDqLCF1uuRJO8E7+q0pirQ/GXklbVtBgLJg/Lnl7AhnceiZRSLO02Y+u9s/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id DF98067C; Wed, 30 Oct 2024 15:59:17 -0500 (CDT)
Date: Wed, 30 Oct 2024 15:59:17 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jordan Rome <linux@jordanrome.com>
Cc: linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>, Serge Hallyn <serge@hallyn.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [v4] security: add trace event for cap_capable
Message-ID: <20241030205917.GA160675@mail.hallyn.com>
References: <20241030013314.2188163-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030013314.2188163-1-linux@jordanrome.com>

On Tue, Oct 29, 2024 at 06:33:14PM -0700, Jordan Rome wrote:
> In cases where we want a stable way to observe/trace
> cap_capable (e.g. protection from inlining and API updates)
> add a tracepoint that passes:
> - The credentials used
> - The user namespace of the resource being accessed
> - The user namespace in which the credential provides the
> capability to access the targeted resource
> - The capability to check for
> - Bitmask of options defined in include/linux/security.h
> - The return value of the check
> 
> Signed-off-by: Jordan Rome <linux@jordanrome.com>

Thanks, applied to https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git/log/?h=v6.12-rc1%2bcaps
