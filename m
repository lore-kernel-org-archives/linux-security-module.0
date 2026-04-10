Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8102C08C8;
	Fri, 10 Apr 2026 23:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775864051; cv=none; b=r1ZzTqAxSj3xOv9Pu7cDOP2PVGp9qBM9p05UBS0hS1Vfg9z5LzErufs0BzDg5MzSM81kiMctYYPBWns9kiQLFyligGlpBB1ppzVsP09Gj7QvY3XPcS4HoArokQCfNOz1jVkv+H8KJ/KfwPgjFSVVywqSxAvT8nxO6apimTkLXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775864051; c=relaxed/simple;
	bh=Bj93IXMmPcAzY8rlhDUFSvQg/VYN5yCpwGAu2Rycsyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0IHfaOd5LtccYLPF8SzyP68cK+SiLya0qSTrZ23xFY9VCuAe9dgBVfQ6EzRSGjF1iG+oSLMjHqaPu3gW0NzYepwdLiaIyj2LeOwQIwGmixisBOA/X4s2NMDy8s+dxAVGe0e71lGpckQKco2xeXWfEx7r24UGtBmF9UIgyuXEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=uc1Rjfp7; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="uc1Rjfp7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1775864046; bh=Bj93IXMmPcAzY8rlhDUFSvQg/VYN5yCpwGAu2Rycsyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uc1Rjfp7NEsALkH1yjqs849+w2agm5a480JQ+IhDZciPQITnLNxcs7FSM98v+Z2in
	 gXOcqeTpNRMqPyiBKtvJCLq/I4HuPZ9HqkV9ZFsaDqCeedEN6536t4bY0i1h4oa3eP
	 2qaKusCoP8Z0MlG56pupN44BLynvCF1B9BT8GQni07SCsU3qUH0TvtjAADUH/HoYHk
	 1FB7xBvfAwW9vpUh8fDpj0PnmAYRTol71yVffCNA3TwLjSKa6xZGR+fKZoTefTiPuz
	 GZudGgn8jPsSFBf1VyfUPztOQLcnBdeFJSrKdmurCA18tTQBjI9i8jTI410qEyN8/Q
	 9TRKOwR+W9bAQ==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id B6639863; Fri, 10 Apr 2026 18:34:06 -0500 (CDT)
Date: Fri, 10 Apr 2026 18:34:06 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	linux-security-module@vger.kernel.org, paul@paul-moore.com,
	jmorris@namei.org, linux-kernel@vger.kernel.org,
	Kaiyan Mei <M202472210@hust.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Subject: Re: [PATCH] security: remove BUG_ON in security_skb_classify_flow
Message-ID: <admI7uhx8OZ5NzFS@mail.hallyn.com>
References: <20260408114257.298500-1-jiayuan.chen@linux.dev>
 <adhLQDIILT/sHpzL@mail.hallyn.com>
 <a17199c6-fb52-493b-b76a-505faf27cfa0@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a17199c6-fb52-493b-b76a-505faf27cfa0@linux.dev>

On Fri, Apr 10, 2026 at 09:56:22AM +0800, Jiayuan Chen wrote:
> 
> On 4/10/26 8:58 AM, Serge E. Hallyn wrote:
> > On Wed, Apr 08, 2026 at 07:42:57PM +0800, Jiayuan Chen wrote:
> > > A BPF program attached to the xfrm_decode_session hook can return a
> > > non-zero value, which causes BUG_ON(rc) in security_skb_classify_flow()
> > > to trigger a kernel panic.
> > It would seem worth it to have pointed at the previous discussion at
> > 
> > https://lore.kernel.org/all/CAEjxPJ5aA01in+Z1yLF1cwe-3uqL_E8SKGK4J294D5eRG5__5Q@mail.gmail.com/
> > 
> > Based on that, I guess this is probably ok, but still,
> > 
> > > Remove the BUG_ON and change the return type from void to int, so that
> > > callers can optionally handle the error.
> > but you don't have the existing callers handling the error.  It's
> > conceivable they won't care, but it's also possible that they were
> > counting on a BUG_ON in that case.
> > 
> > What *should* callers (icmp_reply, etc) do if an error code is
> > returned?  Should they ignore it?  In that case, would it be
> > better to change security_skb_classify_flow() to return void?
> > 
> Thanks for your pointer.
> 
> So I think Feng's patch is sufficient and can by applied ?

Well, selinux_xfrm_decode_session() calls selinux_xfrm_skb_sid_ingress()
which *can* return -EINVAL.

So I'd like to know, what is supposed to happen in that case?

Stephen, do you know?  Is it safe for callers to ignore this?
