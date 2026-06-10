Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEAE3DDDA7
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098876; cv=none; b=Y8v9eKndkAIhAvucBeu/4Ky7eR9hakLv7DLzz8PRZDMaB2srAu/MimESp6DCcquxOLJuqMrWqAiOYcDBnl/R9gewoM0kDIIUoYvIyYSIuac6ouUlpvtbDBJRJPfzeUwEIoeu7s8rWhEYNuOFRfP8bQ++gNWeAFfBhKJ45/Y51c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098876; c=relaxed/simple;
	bh=13bDWRDU+bV//FKEG2JFdsE/L4O/PID+GTapqRir2Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgM5w8pDqnDD+K9LkbCCEcmxZ7iho9JWg8cOIuSDQKq5v5NZqhkwkCqYksoc/qSZgM3fjtPVHrrzX2J/x3t5ZYJex0ZYGtpOr6uFPpqQ9R5sQBknjbOOVAvYVh/3NPRs3wIrVNJ5n9EDSrLGpPy2Z2d6PNsNAPq2RDm2VSCC77g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zgyv8dYJ; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zgyv8dYJ"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gb6PF71qHzT3F;
	Wed, 10 Jun 2026 15:41:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1781098865;
	bh=9IbNFTBAPwVkbbxM/7G/QIDntBWjd1skjffO1NixWa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zgyv8dYJFVw9J+lHJMY4XYr66tV2z6VqkuVYR5RG04UuAaRZpmtkZWDrHxyx8vu2c
	 j3xGS8V7JthV6ecyOgnJKGWy2nwqG5FUcRleGaWfGoZyqi5aem54eD0qWJV+N9xVR7
	 7iv7X8YAKbWVPGMbWuSp0lrfq9cCZnq8h6J5bjSE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gb6PF1sS3zCLP;
	Wed, 10 Jun 2026 15:41:05 +0200 (CEST)
Date: Wed, 10 Jun 2026 15:41:03 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Tingmao Wang <m@maowtm.org>, konstantin.meskhidze@huawei.com, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/2] landlock: replace __sk_common struct sock field
 accesses
Message-ID: <20260610.rai6icahch2L@digikod.net>
References: <e561a8c3-de10-45ba-a931-27b9a5751dc9@buffet.re>
 <20260609211511.85630-1-matthieu@buffet.re>
 <20260609211511.85630-2-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609211511.85630-2-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

Thanks for the fixes, but can you please send a full v5 patch series?

On Tue, Jun 09, 2026 at 11:15:11PM +0200, Matthieu Buffet wrote:
> Use the proper macro to access __sk_common.skc_family like everywhere
> else.
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  security/landlock/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index 111e58fd9325..fc2acf8bd898 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -71,7 +71,7 @@ static int current_check_access_socket(struct socket *const sock,
>  	 * The socket is not locked, so sk_family can change concurrently
>  	 * due to e.g. setsockopt(IPV6_ADDRFORM).
>  	 */
> -	sock_family = READ_ONCE(sock->sk->__sk_common.skc_family);
> +	sock_family = READ_ONCE(sock->sk->sk_family);
>  
>  	switch (address->sa_family) {
>  	case AF_UNSPEC:
> -- 
> 2.47.3
> 
> 
