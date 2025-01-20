Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA7E1B4149
	for <linux-security-module@vger.kernel.org>; Mon, 20 Jan 2025 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737371726; cv=none; b=klPfU56hBJjjJUeYSKTN4RqlvZWJdFQyAPs1kyeiTkdbE7ap3xAm9J8c9zlH8ssE3vZlXIvAeLzSddcm/l0qPFUhmAxFOmoSzZq/HhKWDDG9bFkR6ye0Z/gTnTVmhrl8+zeaXv8XGbdy45IFNcCwKNDc8eAlWvs6RiywU8KnUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737371726; c=relaxed/simple;
	bh=cYb1ralunzlVQ2H9iyCjbc8h0FXLlV22JB0qPucfO+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=UeGuswX3nXu0IKmA+BolDtEs2qiM4YLlx03RBcvCn+BCs37NgYJ8I2dlhc05W0O/N7ukYxXDMcNmF2KtQEjIKVOVRzioKo25H5a7LYjAjlpz5L6TIuwXhPFOkHLryRMSx+fjPdyAhcIEW6vAqVIqxDwggqoPSpmtMcXd5bfUyy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=U2fOLFya; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="U2fOLFya"
Message-ID: <3fa2d093-8070-48ae-b595-e2441966c72a@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1737371721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6ca9nowYKFmGlE+V94M9kf6idGrAIGGmYRQBcybkF0=;
	b=U2fOLFyayebkNJV7fDUgUfAdisUC9sTcJm71En4cmydU66ZBaf8GHgrZDGtLvt5qH0ixdb
	ZZ5g+gL8vONKpo/NyTULoIJIkgDvhXepNOuaWLj84QB6wZmRb1N5KN1pwG0/KGZI3tFF5L
	9Vp2yyZQl+Yz215H9XRqehSaMRgGkrg=
Date: Mon, 20 Jan 2025 14:16:07 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re[2]: [PATCH] smack: remove /smack/logging if audit is not
 configured
To: Casey Schaufler <casey@schaufler-ca.com>
References: <20250117214655.3138888-1-andreev@swemel.ru>
 <5589ad00-89f9-4f87-9de1-c869fa527c8c@schaufler-ca.com>
Content-Language: en-US
From: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <5589ad00-89f9-4f87-9de1-c869fa527c8c@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jan 2025 11:15:21.0076 (UTC) FILETIME=[98050340:01DB6B2C]

Casey Schaufler, 18 Jan 2025:
> On 1/17/2025 1:46 PM, Konstantin Andreev wrote:
>> If CONFIG_AUDIT is not set then
>> SMACK does not generate audit messages,
>> however, keeps audit control file, /smack/logging,
>> while there is no entity to control.
>> This change removes audit control file /smack/logging
>> when audit is not configured in the kernel
> 
> Is there a real reason to do this?

Not more real than there are real reasons for
fixing typos and spelling errors,
removing unused or duplicating code,
keeping one tab indentation, etc.

The matter of style.

Personally, I deprecate fake controls,
they make me (as a user) think that
it's me who is missing something.

> I can easily see systems that expect to turn logging off getting
> upset if the interface disappears seemingly at random.

To me, the system builder who compiles audit out, on purpose,
must be prepared for special treatment of his system.

Certainly, I may not have a full picture.
--
Regards,
Konstantin Andreev
