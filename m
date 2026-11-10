Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347564;
	b=yzlCheGIUdHf7bW7oau10Rr5nRz/lS046ri+CgAp2K5J86bmzsCmFwdIcXCCcMBFdHXh
	 2Rul3TG171hSD7GbQ/A29AVeK1Z/VTVqjbn2dmvZ/suhtk46N7y1f4ZynvdinXFSwhrkf
	 PIlCdKPIw2D+SdtHC/q+zA9kmRoTfKrOnpyxKIaXtsVyfHneVz9shXHc96VMzOOv4GCn6
	 NQAMrAYN0+EnbLpEUPuxRuB/6dzL65cliVpxX8QIIvrlJRI6dKCqW8rxr2NzhOIa039Nn
	 X5nkizT755f6YjM2pmvLmscPjxqpUcHIo/frxo08+Sh60unSLjeAADXkiTlUfqVjNMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347564;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=i0+zYI8kdiBWsDryds3EEzsTydcCxxKO3QkUoki2DtA=;
	b=S0MotcSO1ilwZh29yad34b/9svork3iFQbHnXl83gyPQcRSBHQqJ+BhPieYAxNwWa3zf
	 eCx6VsZ8zKK2Iqo5hcWag7oodY27/teJA/8uGiS6zk6PjxNERuODru/ysf1GmeZpaTC+Z
	 cJSCvGBsE3P3/HW5HbWRM5zzhENoMxoi4OUI/Ju9MEkvadh3jX1iUMQiJ3ja3MV4x5AR7
	 2XKxuGthol4t/Tr2/KH15nc6yjll/fvHn1/UM6EUfyDqFVd3KXsowPx4aC9i4gQjwdYQk
	 DgR6tghsANey61Kgz8BaWWuDYJsdTnYLoCp8yBbLq+Ei1ouPHMom4cdEN08QXoi8WOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sDIO4Y6y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E9606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sDIO4Y6y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07D11F0089F;
	Tue, 10 Nov 2026 21:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794347563;
	bh=i0+zYI8kdiBWsDryds3EEzsTydcCxxKO3QkUoki2DtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sDIO4Y6yuRUfqi6E2szdfJbKm9QMjfcyDUfa+ngAdKZw0koMXdlRzxNElnbUmzfVG
	 /8MqSfKkcBGtgP6Ia+SJanxClk/AVzLULJlMIuT3fT5TgyAAVe6Fhi5va8G1QiPbor
	 o9EM8rkKcySUoZLLymJNJbSudwWdR71N6yOqevO8=
Date: Tue, 10 Nov 2026 16:52:41 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Nakashima Seiichi <s-nakashima@kjb.biglobe.ne.jp>
Cc: kernel-hardening@lists.openwall.com,
	linux-security-module@vger.kernel.org
Subject: Re: [Case Study] CVE-2024-0582: Why We Need a Standard for CVE
 Emergency Mitigation
Message-ID: <2026111052-spectator-legwarmer-4c1e@gregkh>
References: <1d9ab7140a015e94829e2356a4c6c9e18d92b864.camel@kjb.biglobe.ne.jp>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d9ab7140a015e94829e2356a4c6c9e18d92b864.camel@kjb.biglobe.ne.jp>

On Wed, Nov 11, 2026 at 06:28:39AM +0900, Nakashima Seiichi wrote:
> The case study demonstrates the gap between "technically possible"
> and "operationally scalable." With a standardized framework, the
> mitigation could have started on CVE publication day instead of
> waiting ~2.5 months for the distro patch.

There was a working patch before the CVE was issued, so who is waiting 2
1/2 months for anything?

Also, remember we are issuing about 55 CVEs per day right now, who is
going to do all of this review and "mitigation" for all of those
entries?  That's almost 2 per hour, 24 hours a day.  Do you have the
free tokens to burn on that?

And again, why?  You have a fix.  Given to you for free.  Just apply it.

good luck!

greg k-h
