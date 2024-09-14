Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28291E487;
	Sat, 14 Sep 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726326346; cv=none; b=SmszlbdMirvfvl8sp/FLJ9urWzbAZH9yNKwFwQYUIgW+Xp8PsYuwQtcvLJJswKE+ondxkeSzeZbODkVTROQEkUpceot75EZfP/Htsxk1J67t+TFcbPR0ibQ+X/tyQj/3yUSzGqH4qH+nCYICpUMfwW3TbrtNDLxqlT1HwmOLKJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726326346; c=relaxed/simple;
	bh=e3178mH9e3miqrwA2yB1b/UwBrX2B7lngCjU2EwYQTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+i9raNHabVSdMo8oUDCBP7a4xzD18z1DzVZG4lw+wSKoIc1j5b0cnf3h8JzjESGISUWg4zpYvnZvVBAlEWtOJ8wyiqIGTu9kZlfUVUgdxdzSJcq4/nAa4gNXM93sQahQLcFlWtr2KxAryGfMTf7RvdbF3Qe8+DRO3tp3p5Wj+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 48EF5TYI066665;
	Sun, 15 Sep 2024 00:05:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sun, 15 Sep 2024 00:05:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 48EF5Tr0066647
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 15 Sep 2024 00:05:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0529f07a-d8c5-4290-8056-6d04aa70c670@I-love.SAKURA.ne.jp>
Date: Sun, 15 Sep 2024 00:05:26 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] LSM: Add the lsm_prop data structure.
To: Casey Schaufler <casey@schaufler-ca.com>,
        Konstantin Andreev <andreev@swemel.ru>, paul@paul-moore.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20240910184125.224651-1-casey@schaufler-ca.com>
 <20240910184125.224651-2-casey@schaufler-ca.com>
 <2e1da617-c437-4ff9-93e0-e0e212aabfaa@swemel.ru>
 <d6de966e-ff67-41a4-8a37-1709119be9fd@schaufler-ca.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <d6de966e-ff67-41a4-8a37-1709119be9fd@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/14 8:05, Casey Schaufler wrote:
> There has never been (to my knowledge) an effort to "ban" out-of-tree
> LSMs.

No, commit f3b8788cde61 ("LSM: Identify modules by more than name") is
an effort to "ban" out-of-tree LSMs.

