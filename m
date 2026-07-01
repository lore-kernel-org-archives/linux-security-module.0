Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86C431E7C;
	Wed,  1 Jul 2026 21:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942713; cv=none; b=oIK1wLH2wo+G+joUAwDFcCGAUWEA4P4iEaak4h/9AcCdFiauANS5DY3sbV51rOjMv6Gm3r9JXSA7WIrPOArjtEYJw8BLWnSntWbfVpx9KQFctdW2M2z/gCXWC715SWtKOFve9PiBzauF+lhOthGoJLa/0KOqE/VtkJblKzzYxVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942713; c=relaxed/simple;
	bh=WO9Us4vfLgLqjM5YqNhNxrYNNGbGT3swRepzpHqECEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hY6UqPF4Qpb0HDQknop5bbEp9wiDSTLTdcfEhKyuCM61OgkLFPQEDxeNWpfy/VPQQJu03vXHW1DxEd33cbVTBRsp5SD4o/5S0SFvNsbsqcCkz9QYzBRHA6EldgT/HnMeC1dno+vaHBRAc6U+bebl0m4pfRxCos9KUobVW7NOh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=ORq+0J6l; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="ORq+0J6l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1782942157; bh=WO9Us4vfLgLqjM5YqNhNxrYNNGbGT3swRepzpHqECEw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ORq+0J6lf5t5CVTPe3gm+qXbWbgqj/AHpe0LOR6ZTZbe9U/pZkMzerK7si/zYowcG
	 LRcnk2ByGGVV805HdVkburxhiPUIS5YUucZmbRFNbEkbzFNCTl7c+MFQWRkhlNEy/z
	 b6O4E7Ftr2eeLD346TdD6HR50itOb59XjIofDzyFJrsg6JYK8Vd/dNM/BGuQmOsPfO
	 l0mgU5RqOV515Wj6fwlYrZC9buiMBDQt9ZQT/qvZ+W7Aq4JRoL8piZPisoR6Uixxs4
	 O2TnPBWxtMrFxJmG5b3K8YT2S24vK/OqE7MdhOECYasDsreod+ZsapuVzpz+ousd8I
	 ak6pxvgOwj2Ww==
Received: from [192.168.100.2] (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 5293712664F;
	Wed,  1 Jul 2026 23:42:37 +0200 (CEST)
Message-ID: <c21cf4f3-6c21-4170-b578-13c1bfd48b87@buffet.re>
Date: Wed, 1 Jul 2026 23:42:35 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] landlock: fix TCP Fast Open connection bypass
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Bryam Vargas <hexlabsecurity@proton.me>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, linux-security-module@vger.kernel.org,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Paul Moore <paul@paul-moore.com>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260617.eemahv8ui7Ee@digikod.net>
 <20260617180526.15627-1-matthieu@buffet.re>
 <20260617180526.15627-2-matthieu@buffet.re>
 <20260626.taijohThood1@digikod.net>
Content-Language: en-US
From: Matthieu Buffet <matthieu@buffet.re>
In-Reply-To: <20260626.taijohThood1@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mickaël,

On 6/26/2026 10:40 PM, Mickaël Salaün wrote:
> Thanks Matthieu, could you please rebase this serise on the master
> branch (especially on top of your UDP changes)?
Yes I hoped I could send it just in time before the UDP merge, but no 
luck. Here is the patch with your feedback, and rebased on next over UDP.

Have a nice day!

-- 
Matthieu
