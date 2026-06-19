Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B06E2C0260;
	Fri, 19 Jun 2026 00:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829231; cv=none; b=I/U7Wd01oYhnhNgDtdc1X+JC0PWCJBaXLX2RxqYvcF+Sdg94lEK32U/edpGAW86wE+kBD29b9eFgGEUESOuWsrCWONx2p/+A26T1osLyWtLyAntvetD7qd3flkwrvBGLJXz9qO/QdxHuQRIw7xKhe9JaSNgGV5kElDTgfZOZmvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829231; c=relaxed/simple;
	bh=83lkWepdk5zIp961jkR0MopJ0nCKuMwMDnw864GmosA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDXxSJU73qJWoS+tY/qqSZcG/pXw8Bjij6TdrTE6ytp/qIykqHYWJR2Fwnjiwstjga2wANzkqzz+yJgJEabfI4lw05EQzcvj97eGxMtNBOXXvi58h9EbJirZUkikAXlR0KENG1Ctt31OFp5+z6lpxOq+rAOvz+Hq/8t996i9A2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=rA4ePMay; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="rA4ePMay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1781829227; bh=83lkWepdk5zIp961jkR0MopJ0nCKuMwMDnw864GmosA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rA4ePMay0V+CEYeHHp9vCYo5/ZAnNGa4FzLO4f3dg/bmmpRBhIuOiKwgxFSPfrEA1
	 /1ApRMyLFefgCA801jSMTjT4sHEsz5WFHHLJ2+06S/+6HLWMzhr0WkC0D2qzUnTy1f
	 lAEFxG3GDnVT/62AQa7uMU2aBL88AGJGw4OANMeDcTGBZEX2wvGeuZvs8B8agcj3Hf
	 i3iNCNdJvNeEWECNN1IYD1CeRVm9X9yduS9yeGGtW3IMJuXnginX6Yh/BCY8VatMir
	 PryuLNqYOH4vN6cMxi5UTGGYD1nntc4Z3OSjKSg17nhUcOWO7UhgLo4UKi78R0efB5
	 CUweUGtc3QyVQ==
Received: from [192.168.100.2] (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 0A5D91265B2;
	Fri, 19 Jun 2026 02:33:47 +0200 (CEST)
Message-ID: <e0c7b502-931e-481e-89b0-b47687d2b942@buffet.re>
Date: Fri, 19 Jun 2026 02:34:10 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] landlock: fix TCP Fast Open connection bypass
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Paul Moore <paul@paul-moore.com>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260617.eemahv8ui7Ee@digikod.net>
 <20260617180526.15627-1-matthieu@buffet.re>
 <20260617180526.15627-2-matthieu@buffet.re>
 <20260618012527.34964-1-hexlabsecurity@proton.me>
Content-Language: en-US
From: Matthieu Buffet <matthieu@buffet.re>
In-Reply-To: <20260618012527.34964-1-hexlabsecurity@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryam,

On 6/18/2026 3:25 AM, Bryam Vargas wrote:
> One scope note, since you mention MPTCP: an MPTCP socket isn't covered.
> sk_is_tcp() is false for the mptcp parent (sk_protocol is IPPROTO_MPTCP), so
> neither the new sendmsg hook nor the existing socket_connect one mediates it. On
> the patched kernel my MPTCP arm still reaches the blocked port via both connect()
> and MSG_FASTOPEN. If MPTCP is meant to be in scope for CONNECT_TCP, the guard
> wants `|| sk->sk_protocol == IPPROTO_MPTCP` (not sk_is_mptcp(), which is the
> subflow flag).

Indeed, the patch does not try to filter MPTCP: it is not meant to be in 
the scope of LANDLOCK_ACCESS_NET_*_TCP rights.
It used to be, but it was a bug, see:
https://lore.kernel.org/all/20250205093651.1424339-2-ivanov.mikhail1@huawei-partners.com/

Have a nice day!

-- 
Matthieu
