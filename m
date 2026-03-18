Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124453033FF;
	Wed, 18 Mar 2026 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871963; cv=none; b=nLQVal4WUAZt4MeI4P0+l0syBHufqNpLC+clqU/0son6Ce7XEkgfo1R/3S0xJtDVd6+8N/Si/VnepId8zYN/T0enls4kqScnoXYzxhpTUN8qqGoKBZwJdJwLfX8ybjDBlBYKEf/xfncbyApRX0qAdBYwK3/QNoAXeckhwYYpW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871963; c=relaxed/simple;
	bh=A/YFEWmQFkLBq9Mlf1e19+zH9zHfMrictWL2PzF8c/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWt0JRCB1Wot/Bi7lkmHZ7eqcsZ/32QGj4IiTmCsPyZNmkrnTEOvkoPs8WIRt7BXDetu7JxZpM043VdCdIeb2QORPL9DLBFJjUiyXJn8D8Jy4Tze+CrGKP4BZm3snZa7FZ9hnrgWtf3LBTI0U6+UO70R/d4W3R/M/m+bqBFeI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZsGk+gZu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZsGk+gZu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=wx4UUAh+LQNE6uFenGJ2i4m1LUK5OoHCvU8Zj8sS1Ns=; b=ZsGk+gZuB3ZWjDO2sqvsNZUScc
	/rjPKX4k5VBbZreyFYaNIr/molV8erbCZXRDPu9BPmmHSfYLz5kYvyWywustRd9gBHszccJjN1NjO
	WQ0jKvDkXjiMDh4DyEjNcpziT6NB1LXs5rBWpxNkd1xLAF7sP6NAiNQXB9m6tSGvlPTKERgZNAiwm
	8amej3cSK4M+zH5Up1AJjAvCGJzn5QSXKK29zb5FxtppDqRp8KQwyJRcLYFod7z34P0tXoKD3OnaM
	8eDCwD84tJ+r/WQAKem5g/R42XnqnRYK8P0oX9VoYlyuvGZNWThoY5xZjgJVfa65D6cpi0vRj+Q15
	U83bKmHw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2z84-00000009Q04-3azN;
	Wed, 18 Mar 2026 22:12:40 +0000
Message-ID: <f2a83432-f0ee-40a2-a3d0-71eef9db48fc@infradead.org>
Date: Wed, 18 Mar 2026 15:12:39 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Mar 18 (landlock docs)
To: Mark Brown <broonie@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dan Cojocaru <dan@dcdev.ro>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, git@n0toose.net, linux-security-module@vger.kernel.org
References: <abrYTGOZRH9oP2GQ@sirena.org.uk>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <abrYTGOZRH9oP2GQ@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/18/26 9:52 AM, Mark Brown wrote:
> Hi all,
> 
> Changes since 20260317:
> 

linux-next/Documentation/userspace-api/landlock.rst:198: ERROR: Error in "code-block" directive:
maximum 1 argument(s) allowed, 105 supplied.
^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: c
    __u32 restrict_flags =


Please insert a blank line between ".. code-block:: c"
and the code.


d37d3347aa59 ("landlock: Expand restrict flags example for ABI version 8")

-- 
~Randy

