Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F341D4ED
	for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2026 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431228; cv=none; b=Ji36xyXvOXEqzk+nVK4HcRh+9ubQvwQovATzo7ZhMjUlVN48MJmjKNw9fZltZjurp8y4qq3zhc1iBtVrJl0/+xwIWEa3B/qNJTfSIxfx5z8j6/0Gt7foJEOFhk4TO8x+xMfrvZWlHbmccOfDndyRgV2+cyWaYb8hzce1+x3PEKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431228; c=relaxed/simple;
	bh=JKtzA7TalV7KpwJrSJ7/1o+/5DMUmjzth8LFEplhCuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qk4Ub/EAdJlv9pfmpXgdwl/WVND+0f5YB8uiZh5JlUWXtCcjIWn+wenwj/bOKnMin8LjoR6lwwpXLORU5aGEwhZIeq9t1CwLudFWbzi3okSR+1HaHo4+zNSXD2umvidh6xSoyHj8dyWBYA2tnrsROrISQA4+f2ZmMiC6WEDbXP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0ZcLvGv7; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0ZcLvGv7"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gvhy80pf6zqD6;
	Tue,  7 Jul 2026 15:33:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1783431215;
	bh=1yDnmyxuj24MmdyOIrVy1yMDkssTMDCJebqy56PKwNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0ZcLvGv7AeqMYXLKA3ETIu1A8HfoCRwfukKiIvFA5kDDgIN0XA2po+5WxTKlNozXG
	 6Rd25xf4z1cS+uKAq+uogG1X2Kphp9xGy5C5NCvkWUnSD7Ai/6z18woo3KcfKXGYMc
	 UKbGYvoXTkntTKoRJSHQ0griMYbFJDnc/jH0QHU8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gvhy71L1JzH48;
	Tue,  7 Jul 2026 15:33:35 +0200 (CEST)
Date: Tue, 7 Jul 2026 15:33:33 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Doehyun Baek <doehyunbaek@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH] Documentation: landlock: Document fs.resolve_unix audit
 blocker
Message-ID: <20260707.Ahbee1Fah6Ah@digikod.net>
References: <20260625092819.1870049-1-doehyunbaek@gmail.com>
 <aj0fldJZ2dl0gas1@google.com>
 <CAN-j9UrCAkNgzj+xG8bRaOnducE16_O909Msi3EFVZjEJf9oAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN-j9UrCAkNgzj+xG8bRaOnducE16_O909Msi3EFVZjEJf9oAw@mail.gmail.com>
X-Infomaniak-Routing: alpha

It's applied, thanks!

On Tue, Jul 07, 2026 at 11:40:51AM +0200, Doehyun Baek wrote:
> Hi Mickaël,
> 
> Gentle ping on this documentation fix.
> 
> Günther reviewed it:
> 
> Reviewed-by: Günther Noack <gnoack@google.com>
> 
> The patch still applies cleanly. Could this be picked up via the
> Landlock tree?
> 
> Thanks,
> Doehyun
