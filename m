Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D63C465
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750038669; cv=none; b=Tn3IyJxFHo1VxtrrGWNnCXVr+oQ7BOskQrg2AFrsjg6Zj2XxMvLByc9n/4WSwfWiDE7AvoLdRlxU3Y/y+QB764ktSzv8gt4u36UPc28pDWzo/chAz+/0Rq0qXNihj7Djo9/c0v0mNG5flcsDomVXOMYPI4679Pk7ok1+5zRntFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750038669; c=relaxed/simple;
	bh=9s1PJV1j3hlNi+4TSr6xKKounQypyxYL78uJT2oUGQU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oAN35KUwcliLdUsoJc2spaoKFeml4gQnys0T6ylqwVuc3hWHE/2r14MSqeMUHC/tyjkio2n40xNrnbEnD7VZTpc+VvUG89/rmZWYKaDU1F1H9aqtY18UqPMAlKFTKgxfanhim3NaVa304ELBB73H+Z2wXbLfgTY3K9o2LjrMZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=vLr2BVSE; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="vLr2BVSE"
Message-ID: <0c8e9341-d044-42ca-9332-2b284a0e3e5f@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1750038663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pe1y8o2p3mtFL4Ag24BAPY5Og8zefvVpFuS5n9Ae03E=;
	b=vLr2BVSEB2/HxX3wCVowLSrzV+aKxcDqyYBbOmpNdmRXYcjDCZSt9QOCTUzm9eHznC3vct
	zVZ3mwc+XXeuUYKuZmA+m8liTm9o3tPLUSb0lzv7bhEyJW1rsfr6Ynu7cNJ5d3gvXQOjQe
	z3ey+ga/LLob8xk2PO5PA0/fOYo9TxU=
Date: Mon, 16 Jun 2025 04:52:01 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] smack: fix two bugs in setting task label
From: Konstantin Andreev <andreev@swemel.ru>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
References: <20250315015723.1357541-1-andreev@swemel.ru>
Content-Language: en-US
In-Reply-To: <20250315015723.1357541-1-andreev@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jun 2025 01:51:03.0687 (UTC) FILETIME=[1E2AB170:01DBDE61]

Konstantin Andreev, 15/03/2025 в 04:57 по Москве:
> These two patches have distinct subjects,
> but work on the same object,
>    security/smack/smack_lsm.c`do_setattr()
> and the second patch partially overwrites first,
> so I combine them in a series.
> ...

Hi, Casey.

If you have time and you could have a look, that would be great.

--
