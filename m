Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEEE25F972;
	Fri,  9 May 2025 04:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746765984; cv=none; b=ILQggYbrbySMU6SJh1L+TUnX3R0EEXKCa/VgwSU8nb0p0Iav0qsjubCuxFnPYLIw5bKXUCRBljOhnSQ4NR1kaEw4yfRQehuMqs7BSLet2wAUPaLHIlqrZWsyWnaxfE5HzNp+HLqcNoc/C4pg/Gbstf9GbLTl0kYb8eNZM7I8yPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746765984; c=relaxed/simple;
	bh=lH8LZ6clVl9c1ZHcQbObRFxrPn6Sm8KbZ1BjHN97YBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjY5w3EnKFHkr6i0pKa6EHyiVpIVTomC/R1T88uqDzHGiO/8AK7V0EV7tqjydezu6H7sINcbXyqo6Mh5h2245iaxLCx2ZQn3opwOXgwx9WW8WSqr9gsXIncu7TUtAFZiub7HH/JqwlM67wYkIRkoodl0ECcoduDIonNcI/HzZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=j3wGZzIQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="j3wGZzIQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kCiQ08WuF4knOAWguEhAZ/eUS7sjpUs7wFbu+26MI2E=; b=j3wGZzIQv5N9Sxgw2FTK4Wacgh
	LN3/ENWn7E2H8NwhWKy+QlN/DTF8Jl9es1/5GcjHnI1QE1mk9ddgIXOjXc2wCqqysa0f8FIP+Xze4
	wvClzmwUE7QTSap7xMsMyaVnkars2JjvLcTc2TYXq+v/nmEFOa39ujomhhev6Eid48jSmw45dhxZD
	/U1sNYHwn+jVssKeUuYgKAjsVHtbXTbN5Epio66BQ40bfQqKwtPKrh5wp2i7k/N0es8YhcTVtyHK5
	/0RocMIu46uRx++SFxldXs3Xie1Pj9RN6/uxDQNlVy9WbdrPubnaBoQpn/QF9ADo3l7eWuRtysh6H
	zshgEK9A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFcj-0000000A9b6-3y0f;
	Fri, 09 May 2025 04:46:13 +0000
Date: Fri, 9 May 2025 05:46:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: alexjlzheng@gmail.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	greg@kroah.com, chrisw@osdl.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v3] securityfs: fix missing of d_delete() in
 securityfs_remove()
Message-ID: <20250509044613.GT2023217@ZenIV>
References: <20250508140438.648533-2-alexjlzheng@tencent.com>
 <20250509032326.GJ2023217@ZenIV>
 <20250509043712.GK2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509043712.GK2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 09, 2025 at 05:37:12AM +0100, Al Viro wrote:
> On Fri, May 09, 2025 at 04:23:26AM +0100, Al Viro wrote:
> 
> > I have fixes for some of that crap done on top of tree-in-dcache series;
> > give me an hour or two and I'll separate those and rebase to mainline...
> 
> Completely untested:
> git://git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git #untested.securityfs
> 
> on top of v6.15-rc5.  And I'm serious about the "untested" part - it builds
> with allmodconfig, but that's all I've checked.  So treat that as an outline
> of what could be done, but don't use as-is without serious testing.

PS: I'm really, really serious - do not use without a serious review; this
is a rebase of a branch last touched back in March and it was a part of
long tail, with pretty much zero testing even back then.

Patches are simple enough to have a chance to be somewhere in the vicinity
of being correct, but that's all I can promise.
