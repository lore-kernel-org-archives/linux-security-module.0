Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559FA19C56D;
	Thu, 19 Dec 2024 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629397; cv=none; b=IL4gv44DBKuoJYhmEFVv/OlAi9e0ozUFgPeBeAiqP1Y4tnKDnPLsqcvWZ4EKGzuxsCUmkKn+C725NBS/mYefKYJVcysSFdjeMHEBFQTm+eoyCutTksGnWyHdaRS/+VaGdM5YrJyKvdWnYBlH5I972eMP/sQ2nbzS/PWhuyHh1c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629397; c=relaxed/simple;
	bh=iaiPfrciG1fMTdQ6maIaP/A6XF3YaQlnpSVK4cTLW5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiDdI7PH0FV2ohqHyEnZZ7JNEOUu5or2aapg9TRw9GUlH0jwsirK7f+O5iXbQv/CyPu8PAPogIdiY/anRqQvOgDak55C87P2wFFdRognJ3Xb1spBtIEjrJQhq7f7XQGt8NoG8OkFGBmaAhgrP14gM11vt50bUpsMKCKiZ//D+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=fnbZMXCr; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="fnbZMXCr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=sXh/U0KQsO7CRbmKWyCg7PNQ0Ou8EAdGuWfXQUz82f0=; b=fnbZMXCrUE/HpG4S
	lCHZaVMS696RVYqZkfuaOemwlw0S/g7FRs1iDHmuVqZ60VO4e7IWZ03kQwYz/UcO4cyGBc4DUE67t
	hSiSI2Jf7ES9Hvzg9nfZdPVp4+UeQHold6U2seOWUXt9BdpX2oLnuvn02Q3e+o59kjibUvJRVqY2w
	+B4nabt7QIvpIk7PTGqOnouiKYtRpAejuhIx9DjQBriAkVadeDde2b9Y/RvW+ul/Mf7nueJKKTheh
	9kb5V/WBEiGfxbneblC9ywDuF4MPJDtmK+gZfvjZW99lD/LO0fadNh2yJRff1ZYKS/Cp2mDBLIaz7
	CMWQjNvKY8iDSSI+5w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tOKLQ-006MRx-0r;
	Thu, 19 Dec 2024 17:29:52 +0000
Date: Thu, 19 Dec 2024 17:29:52 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Paul Moore <paul@paul-moore.com>
Cc: serge@hallyn.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capability: Remove unused has_capability
Message-ID: <Z2RYECe3OIS4Hcl4@gallifrey>
References: <20241215165352.186692-1-linux@treblig.org>
 <CAHC9VhRyf8Jo54gnz2Nu17eHFOEqeXd3B5_HoXbz9uLYDba=HA@mail.gmail.com>
 <Z2NIpSZ9iY0q1EAl@gallifrey>
 <CAHC9VhTmqMKkemeyWK3d6tyPGSus9ApMpZzTjtrmgHqbC_au+Q@mail.gmail.com>
 <Z2QrgI0coNmBMonB@gallifrey>
 <CAHC9VhTZ98OwAAtk52MreZaU1OJwKS6PqOU=SCzhfBYNEM8qqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTZ98OwAAtk52MreZaU1OJwKS6PqOU=SCzhfBYNEM8qqw@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:29:24 up 225 days,  4:43,  1 user,  load average: 0.03, 0.03,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Paul Moore (paul@paul-moore.com) wrote:
> On Thu, Dec 19, 2024 at 9:19 AM Dr. David Alan Gilbert
> <linux@treblig.org> wrote:
> >
> > OK, maybe:
> >
> > * NOTE WELL: cap_capable() has reverse semantics to the capable() call
> > * and friends. That is cap_capable() returns an int 0 when a task has
> > * a capability, while the kernel's capable(), has_ns_capability(),
> > * has_ns_capability_noaudit(), and has_capability_noaudit() return a
> > * bool true (1) for this case.
> 
> Works for me, thanks.

Thanks,

v2 sent - see 20241219172859.188117-1-linux@treblig.org

Dave

> -- 
> paul-moore.com
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
