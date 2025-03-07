Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584D5254AED
	for <linux-security-module@vger.kernel.org>; Fri,  7 Mar 2025 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376699; cv=none; b=TVcihMOEM/CL3eCMFbb87dC/eJdHSBuRV4S5k3c5S/yKgsIpH4TCNloyjmSgWSONXN9mAs105GlSuGp3hWP2+PvINd+cJQBYaoE5rZsPDx7vpapzQwkQy5kIESWVjF+AZPu27XfWPrZxeC1x8KiuzGFrXqfCFsvfvbpNgpq1+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376699; c=relaxed/simple;
	bh=+HwLAw3joFU68rLs7v8xjmi2wBfMBvpXRgjyer/JubY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Boga0+LY07uINl8X/Qlyo3oHq9NPg2EPn9vvQQELiMPRvjR9zo7rrq67RcftJcRsEqdScIhX9Yy3RzhZTA3PW8ywMDlJ0/NfasQMHKQg9H3Js0UEn6eiTtdn4X/0gWFjasgfflckXEA5dFeT5GHsqHRI3wjkGUXz5IEypy/DIHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=RvzGIeBV; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="RvzGIeBV"
Message-ID: <ee317f30-0626-413e-9b38-5bc75eb02d7c@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1741376689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vE6zjOL3NzaWVkEhYJH2PObZKOF6/kgP5rwSDMT1rQQ=;
	b=RvzGIeBVf1rlV4KNesL/qqGEoMbQDv6ncPNqOgG/lcIU+ucxFjwprFqpZALBYx8kULtADO
	a+w1jP7IzfYldvUhFjheNf55RHoRajyb5I/mEHd9oF6Y+86Cz2DY3tjsMisBNGfOWlpLPY
	mmOKUF12KlHeFoqMDpXqWK6pS9vfZMk=
Date: Fri, 7 Mar 2025 22:45:42 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re[2]: [PATCH 1/2] smack: fix bug: unprivileged task can create
 labels
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
References: <20250306224317.416365-1-andreev@swemel.ru>
 <20250306224317.416365-2-andreev@swemel.ru>
 <2ad83890-f96c-4848-8820-78455d56caa2@schaufler-ca.com>
Content-Language: en-US
From: Konstantin Andreev <andreev@swemel.ru>
In-Reply-To: <2ad83890-f96c-4848-8820-78455d56caa2@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2025 19:44:48.0684 (UTC) FILETIME=[62BC56C0:01DB8F99]

Casey Schaufler, 07 Mar 2025:
> On 3/6/2025 2:43 PM, Konstantin Andreev wrote:
>> -	if (skp == &smack_known_web || skp == &smack_known_star)
>> -		return -EINVAL;
>> +	if (labelstr[1] == '\0' /* '@', '*' */) {
>> +		const char c = labelstr[0];
>> +
>> +		if (c == *smack_known_web .smk_known ||
> 
> No space before ".smk_known". I can fix this if/when I take the patch.
> 
>> +		    c == *smack_known_star.smk_known) {
>> +			rc = -EPERM;
>> +			goto free_labelstr;
>> +		}
>> +	}

This is to align two ".smk_known"s in two adjacent lines.

I strive to make monotypic operations visually monotypic.
This catches reader's eyes and lets him recognize the pattern faster.

Of course, If this spacing violates the rules, it should be corrected.

--
Konstantin Andreev
