Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC522178E9;
	Thu, 24 Oct 2024 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808009; cv=none; b=TiFKkO4lRj1rz6S8iwyMF6czGGgXDgYkEDe+ogFvJKJANTtxiU58blY2Fgvf20Sp6D+z0J8yFEMQNXhxZqXy05hjVfCTJc7pltt+7lU6O3wk2SIcJgGRRRVL1yPnvs79Bw4OCp6oGUl7F+KVyKKQ4zp/JwKNqPozglak3hJTbqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808009; c=relaxed/simple;
	bh=vJszu9ua02PLYuzMDv+S3jmI83NjZ5d/sxmDSx08Icc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFcysNV+ZK4yaoZRLQ7565M8gHUDk+WNkLLsztQCVE8Cw5TputrQAR4NNggEIpP+SkKdmEZ5mFW6rg/HYnQwUTEPUKu3HfOViWlbhYvKzqAKRm+THRl0UHrz06c/130Z3DFaSSoSfluP6JUOvqCq49SzBIYoTSST1QdQVB19bNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuJ/F8MC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuJ/F8MC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4277C4CEC7;
	Thu, 24 Oct 2024 22:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729808008;
	bh=vJszu9ua02PLYuzMDv+S3jmI83NjZ5d/sxmDSx08Icc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uuJ/F8MCamQnHFXV/ywG1r+CaG4gZFHb819aktXhvVqVb7no1vK8vKCgySGSBlJpC
	 iTqZLzcVYzD2A1VwMqKADi2WnqFJ2I310Tyll86nnJ4vKK63yMrVMmQvKUKCj1jfwm
	 tH2wDoTB4IAsm3bFJOTwsa8d0jV0La/yPLG1pKhpVDFrgfIxEtfSCfHhzt7x7ppZen
	 nIY9s4hpM7+BSjDj0zottMsGUuRlWLykG/NN3mwWbp5Ql5RonXtbInTA7dz8U2leGM
	 E+OIaeAI1FWVAvT1gz11f/lw7EZQ9Av9LCG2UlgGBcjjsYbDljijYQa5BdNp5mot/2
	 qbZCJB8MivE4A==
Message-ID: <8ee41bc4-ca8e-416f-8219-12d4a83e5f8b@kernel.org>
Date: Thu, 24 Oct 2024 15:13:27 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ipe: add 'anonymous_memory' property for policy
 decisions
To: corbet@lwn.net, jmorris@namei.org, paul@paul-moore.com, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1728582157-13884-1-git-send-email-wufan@linux.microsoft.com>
Content-Language: en-US
From: Fan Wu <wufan@kernel.org>
In-Reply-To: <1728582157-13884-1-git-send-email-wufan@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since this patch is quite straightforward, I have merged it into the ipe#next branch for testing and will send it to Linus during the next merge window.


-Fan

On 2024/10/10 10:42, Fan Wu wrote:
> Currently, all existing IPE properties evaluate to FALSE for
> operations triggered by anonymous memory regions. As a result,
> IPE falls back to the policy's default action for such operations.
>
> In policies where the default action is DENY, this behavior blocks
> all anonymous memory operations, rendering binaries that rely on
> anonymous memory unusable.
>
> This commit introduces a new IPE property, 'anonymous_memory',
> which evaluates to TRUE when an operation is triggered by an
> anonymous memory region. This allows administrators to explicitly
> allow or deny operations involving anonymous memory.
>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
>  Documentation/admin-guide/LSM/ipe.rst | 11 +++++++++++
>  Documentation/security/ipe.rst        |  9 +++++----
>  security/ipe/Kconfig                  | 10 ++++++++++
>  security/ipe/audit.c                  |  2 ++
>  security/ipe/eval.c                   | 26 ++++++++++++++++++++++++++
>  security/ipe/policy.h                 |  2 ++
>  security/ipe/policy_parser.c          |  4 ++++
>  7 files changed, 60 insertions(+), 4 deletions(-)
