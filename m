Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574F4129A9C
	for <linux-security-module@vger.kernel.org>; Mon, 15 Apr 2024 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186275; cv=none; b=FEBx7lYW+aExIpYuSADzeTmSBLN70/QSBSXnQ1j8zgfePOaT4TA0so464fgk+QbRZqm5et0lCE9A8d+Eayyfmy0MFonzbQwbdNIWIviy9QKtv4ZXWnR49I6+Q0gJWiYIxQ9tznRCZvdQUapUI/TlwrAgEmLMZNdSVfKHwHjFwl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186275; c=relaxed/simple;
	bh=PbmSS4iAYWEISocJ9w+PkOJnKbBzbsLh++RX1AZOWV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkItJnKkswc2yLrGrq94n0wCyK99vkGjM1Ckh1LjCZ0w01VIFXGZthVVLRAelfeuUDZv91Oe5gOgb8tFKdJn9tmTlI9sM/vCt7TSC50m8Uu8CoW4PzUiay9f8tx1xHQEyAw5JBaJ/Q1I0nKrTbkW0EGlnqZF1A1pF4J+qFQFDJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43FD4VMn055643;
	Mon, 15 Apr 2024 22:04:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Mon, 15 Apr 2024 22:04:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43FD4Va5055640
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Apr 2024 22:04:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <30876b80-c437-4916-b982-97c1a95c0747@I-love.SAKURA.ne.jp>
Date: Mon, 15 Apr 2024 22:04:31 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kpsingh:static_calls] [security] 9e15595ed0:
 Kernel_panic-not_syncing:lsm_static_call_init-Ran_out_of_static_slots
To: KP Singh <kpsingh@kernel.org>, kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <202404151225.ce542e38-lkp@intel.com>
 <757538DA-07A4-4332-BAFA-B864BFD06A76@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <757538DA-07A4-4332-BAFA-B864BFD06A76@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/15 17:26, KP Singh wrote:
> This seems like an odd config which does not enable STATIC_CALL, I am going to
> make CONFIG_SECURITY depend on CONFIG_STATIC_CALL and make the dependency explicit.

If CONFIG_SECURITY depends on CONFIG_STATIC_CALL, architectures which do not
support CONFIG_STATIC_CALL can no longer use LSM ? That sounds a bad dependency.

