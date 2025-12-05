Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196B275861;
	Fri,  5 Dec 2025 04:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764909785; cv=none; b=JRAnJgZZ0tDalvYBlR9tvvzZk0517r8VtYwAD6lyKmqbBY+HCMVb+2nLwQ/ir8fbEXAKEb1cEb1KimpHZmIdTm5oUVNT3tZHe7+y1AiDH9+kahQDPu2XFaP1wkVn4urpsxm5ZdR58eSm0RNxMzcjd2BGOFGb7sVxeGcU9GoddCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764909785; c=relaxed/simple;
	bh=orXkNS/fp5rwMiiG6x6M9Tm+eXfxiD8Q1DlRKAXMnhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMeCCDJkLIGNjdCU0A4IAljDCDNmt3xqfAqwr+ubnuhHUaWXeddgph0kGKHtBZ1S4EaKIFnBrNfIYkkhsqaM6UoYgzMhoLARHTzhsoeJrhigdKdqJTpNeXTEa4adAiXC3OwqYUxXVwA6rSCqSH+WQqXrvjepqURsOyHUuJBMcXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 44D995A4; Thu,  4 Dec 2025 22:43:01 -0600 (CST)
Date: Thu, 4 Dec 2025 22:43:01 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ryan Foster <foster.ryan.r@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [GIT PULL] capabilities update for v6.19
Message-ID: <aTJi1TunpnTguOtm@mail.hallyn.com>
References: <aTIm6grHZUhRncFH@mail.hallyn.com>
 <CAADWXX_rO42NznU6c+rjqzaUuTLMp_DXSf_mn8rVDCe+1AMUTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADWXX_rO42NznU6c+rjqzaUuTLMp_DXSf_mn8rVDCe+1AMUTQ@mail.gmail.com>

On Thu, Dec 04, 2025 at 05:20:18PM -0800, Linus Torvalds wrote:
> On Thu, Dec 4, 2025 at 4:27 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > This contains the capabilities changes for 6.19.
> 
> This email was in my spam folder.
> 
> The reason appears to be due to it being marked as "DMARC: FAIL".
> 
> I think it's simply because your mail domain doesn't have a dmarc
> policy at all, and gmail has been getting more strict about having
> both dkim and dmarc set up.
> 
> Anyway, I obviously found the email, but I thought I'd mention it,
> because while I check my spam folder fairly religiously, it's still
> mostly a pretty quick scan for possible emails. There's no guarantee I
> always notice...
> 
>            Linus

Thanks!  I set up SPF years ago, but guess I will have to figure out
DKIM.

The odd thing is, when I send emails to my own gmail account I don't see
any complaints about DKIM or DMARC, only:

ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of serge@hallyn.com designates 178.63.66.53 as permitted sender) smtp.mailfrom=serge@hallyn.com

But I'll fix it.

thanks,
-serge
