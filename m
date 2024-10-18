Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A65C18C92A;
	Fri, 18 Oct 2024 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286763; cv=none; b=raBIyaru+1+nIoTW6T7jFBdClhsIOMUwalRcrlGyu31Yy6B/XKvfPRQx9uUX2RnVEc+yA8WbmDFqD7gFK0lttprFAXcpazWgnO0KE49hDPtF0PkUk6NexntT63DMKZYxG5ErvAAPUGgNMXVPKGt2nxNj2vRjb5oxXwGu5VCdI+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286763; c=relaxed/simple;
	bh=ud+pt89q3E9Fzyl9qzIkdMTd5lgetY/I/nL6Z3p94bc=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=qV6OhipbnnRCgTGI441onlCD1GHpXtZ40N5+Me6I1/J1lp6fe4lhdaa+VFpcNq0sgG5bPGlRT5ZVwFXZeUxdGBEUliNi+46OfA8D9Fe78gV+FhcMxbgmall9WN9eml6yCqvAuPrmlEI5WGjbHeoNayjW1w1ZkFpaejbjpK6R3ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjb0TRwL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjb0TRwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E733C4CEC3;
	Fri, 18 Oct 2024 21:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729286762;
	bh=ud+pt89q3E9Fzyl9qzIkdMTd5lgetY/I/nL6Z3p94bc=;
	h=Date:From:To:Cc:Subject:From;
	b=bjb0TRwL2km/JR7zNqb88KXMgK4f9BPU1ZPPqObP7Lzjg4qXvLTiPhvWZXei9SYiv
	 o0tzlj2iO1R4vqKObTU9HU83pZGXMQzCYm7Uj4MBbzo1dzhcoQelZodzV8Www0w/Mt
	 A+foP2QqCAK/0rXgM2f/5pogzH958V/hEBJ1rqCWGVW5y3emdBRJgvEa3Qo/X6ej5v
	 PFwbLyJD9kIEk6GYNNx+/oBrIjxE/kGgXoJwIDMjPTuFOD0SX9WhS4BqElZL7tGI2G
	 k/8t3VYsq8nIsuHPc2GLh30OoO8BlJIi+9c1VDkcYmLxyOmTOBItGDDjpCbKBYkB7/
	 OD5cT+WkqTNcg==
Message-ID: <cbe8cfae-e700-4c2a-849e-b7b457130608@kernel.org>
Date: Fri, 18 Oct 2024 14:26:01 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Fan Wu <wufan@kernel.org>
To: torvalds@linux-foundation.org
Cc: bluca@debian.org, paul@paul-moore.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] IPE fixes for 6.12-rc4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

This PR addresses several issues identified by Luca when attempting to 
enable IPE on Debian [1] and systemd [2]. It includes four commits 
focused on enhancing functionality and resolving issues:

The first and second commits address issues with IPE policy update 
errors and policy update version check, improving the clarity of error 
messages for better understanding by userspace programs.
The third and fourth commits enable IPE policies to be signed by 
secondary and platform keyrings, facilitating broader use across general 
Linux distributions like Debian.
The final commit updates the IPE entry in the MAINTAINERS file to 
reflect the new tree URL and my updated email from kernel.org.

As this is my first PR submission to you, I apologize in advance for any 
mistakes. Could you please consider merging these changes into v6.12-rc4?

Thanks,
Fan

Link: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1233 [1]
Link: 
https://github.com/systemd/systemd/commit/394c61416c19bcc3231d3f717b72ef9d90b89ee7 
[2]
--
The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

   Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

   https://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git 
tags/ipe-pr-20241018

for you to fetch changes up to 917a15c37d371bc40b5ad13df366e29bd49c04a1:

   MAINTAINERS: update IPE tree url and Fan Wu's email (2024-10-18 
12:15:37 -0700)

----------------------------------------------------------------
ipe/stable-6.12 PR 20241018

----------------------------------------------------------------
Fan Wu (1):
       MAINTAINERS: update IPE tree url and Fan Wu's email

Luca Boccassi (4):
       ipe: return -ESTALE instead of -EINVAL on update when new policy 
has a lower version
       ipe: also reject policy updates with the same version
       ipe: allow secondary and platform keyrings to install/update policies
       ipe: fallback to platform keyring also if key in trusted keyring 
is rejected

  Documentation/admin-guide/LSM/ipe.rst |  7 +++++--
  MAINTAINERS                           |  4 ++--
  security/ipe/Kconfig                  | 19 +++++++++++++++++++
  security/ipe/policy.c                 | 18 +++++++++++++++---
  4 files changed, 41 insertions(+), 7 deletions(-)

