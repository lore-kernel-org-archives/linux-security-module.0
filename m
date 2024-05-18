Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FAADDA5
	for <linux-security-module@vger.kernel.org>; Sat, 18 May 2024 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716012103; cv=none; b=un2gDWma5UmGh2zUUfqx5PFExQr/+LcmNiSD6X9ObVXWLqi4uVwVYZuU67izX+sfZPoV6OPTVGJkhCZ8GmbBqy+jGGCF+xyawgWd3G4b4jO1z9xVfa8UzK4EflpdTuG3ZJ0mimi0BT7ala1T9nQfVABEo5Lbu/Ggs7hZpBZw5FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716012103; c=relaxed/simple;
	bh=/VdRxfU3wbXDwG9Q1YxUDx/jH1ZdhSZQH1OlGoQBaxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgpoTcaoYlA3XVu7r+GwtNLYWMU1Uk3tNEUDV1COir3n/wz4yDrbxshkHFd7fWYV7OApJvJbcXpOetMK4VSL3TJUKZLaZjvzscqny3V9NRD5I8ptVFz+w+vVF5G3pmvgA+gEVpfF0kpma1dOUh0TbSXgefn8jSgXW5izDpzjzv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 44I61Xgj097285;
	Sat, 18 May 2024 15:01:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Sat, 18 May 2024 15:01:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 44I613Tc097179
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 18 May 2024 15:01:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c5bbc4fc-e632-4aa2-aee9-e0ef271d4e30@I-love.SAKURA.ne.jp>
Date: Sat, 18 May 2024 15:01:03 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/5] Reduce overhead of LSMs with static calls
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
        bpf@vger.kernel.org
Cc: ast@kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
        andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net,
        renauld@google.com, revest@chromium.org, song@kernel.org
References: <20240516003524.143243-1-kpsingh@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240516003524.143243-1-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/05/16 9:35, KP Singh wrote:
> Since we know the address of the enabled LSM callbacks at compile time and only
> the order is determined at boot time, the LSM framework can allocate static
> calls for each of the possible LSM callbacks and these calls can be updated once
> the order is determined at boot.

I don't like this assumption. None of built-in LSMs is used by (or affordable for)
my customers. There is a reality that only out-of-tree security modules which the
distributor (namely, Red Hat) cannot support (and therefore cannot be built into
RHEL kernels) are used by (or affordable for) such customers.

Therefore, without giving room for allowing such security modules to load after
boot, I consider this change a regression.

