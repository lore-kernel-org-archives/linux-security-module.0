Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7771D213152;
	Fri, 25 Oct 2024 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895568; cv=none; b=K+omCXV7NSPFHDSLYn/KezTcxSc9eZB0DZvWb1XuBEwH/wr3FhCzszVLg+25g7ZAt0R4n/iwKmHiePSNNPVH5bLu9gufICW/czfMzvzvFldl9tHWdGbYruzOOQEuaseFkzWm8KnCUw+EgK+AGCilVX/xMyjVyypEvk/zF1xibtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895568; c=relaxed/simple;
	bh=CCfFTgHSCy6CiuV3dKRDOU8QgqiDy43dW7Yikcn3X7s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g19OX16JMt8ztCltXS9HcKda9wQgwQeAtCgtQOcdg4t/Ml68DSJc2t/ipbhOuEtXnzAUQIq7eVx62CuLB/NcLFRocHLB/vt7t4V1kWBIlCjb4rkCrmkeYpuJ+L6Y8A9tY/ZXh11qzDnedhUknw+I6hCfLvsXLIx6deEsD7+Lr0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1hh76En; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1hh76En"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C853FC4CECD;
	Fri, 25 Oct 2024 22:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729895567;
	bh=CCfFTgHSCy6CiuV3dKRDOU8QgqiDy43dW7Yikcn3X7s=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=s1hh76EnL3o3T65U3z1v95AHjTQfswQNfZI8qjFbVUf9u8zBRUg9oZAtmug10gVZA
	 cQjK6XEI0whz+5zPXijXMoJjmu5B4W5IL+Df3JHZZutyw/NR5pkNaBsTRhXeWl3HpN
	 DjrPr8VHPCEFwmBMwde+Ua2bK843/5MBD7WEGjgu2q48LiK+Ci6DrvSqTlRXtMz6ne
	 I2vqM+ZzVpgjUjNd3vGK5lG9AxAnoJ22aidXX9yHKrF7iItp1M/RtS9dXSMrwnMlTc
	 nPx7N7PNY2KajPJCma0eBy5OxAkxMs5oGVwJ57cbsrRpp27mhnTZgQVM0KmnD5NiWG
	 faUCWDryFVRXw==
Message-ID: <66922c42-c3a2-4634-a8f0-4c8c2b4c051a@kernel.org>
Date: Fri, 25 Oct 2024 15:32:46 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ipe: add 'anonymous_memory' property for policy
 decisions
From: Fan Wu <wufan@kernel.org>
To: corbet@lwn.net, jmorris@namei.org, paul@paul-moore.com, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1728582157-13884-1-git-send-email-wufan@linux.microsoft.com>
 <8ee41bc4-ca8e-416f-8219-12d4a83e5f8b@kernel.org>
Content-Language: en-US
In-Reply-To: <8ee41bc4-ca8e-416f-8219-12d4a83e5f8b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After further testing I found the current approach, i.e. checking the existence of a struct file, does not work with memfd, which does use anonymous memory but also has a file struct in the kernel. There might be other cases that I also need to cover.
I will redesign the implementation and send another version in the future.


-Fan

On 2024/10/24 15:13, Fan Wu wrote:
> Since this patch is quite straightforward, I have merged it into the ipe#next branch for testing and will send it to Linus during the next merge window.
>
>
> -Fan
>
> On 2024/10/10 10:42, Fan Wu wrote:
>> Currently, all existing IPE properties evaluate to FALSE for
>> operations triggered by anonymous memory regions. As a result,
>> IPE falls back to the policy's default action for such operations.
>>
>> In policies where the default action is DENY, this behavior blocks
>> all anonymous memory operations, rendering binaries that rely on
>> anonymous memory unusable.
>>
>> This commit introduces a new IPE property, 'anonymous_memory',
>> which evaluates to TRUE when an operation is triggered by an
>> anonymous memory region. This allows administrators to explicitly
>> allow or deny operations involving anonymous memory.
>>
>> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
>> ---
>>  Documentation/admin-guide/LSM/ipe.rst | 11 +++++++++++
>>  Documentation/security/ipe.rst        |  9 +++++----
>>  security/ipe/Kconfig                  | 10 ++++++++++
>>  security/ipe/audit.c                  |  2 ++
>>  security/ipe/eval.c                   | 26 ++++++++++++++++++++++++++
>>  security/ipe/policy.h                 |  2 ++
>>  security/ipe/policy_parser.c          |  4 ++++
>>  7 files changed, 60 insertions(+), 4 deletions(-)
