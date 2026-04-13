Received: from beta.bencteux.fr (114.ip-51-178-41.eu [51.178.41.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7BE2EB0F
	for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.178.41.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110470; cv=none; b=bllmQPGDi8wYGRum4i4iFWYh8Mc3Ofp7VG5AgIYMcVwaGSdyeArDHZZ6R0tfhIAczmEvSErOi/kfXEPyuSzOl0N7PpBiHy3YRsS4frlz495XrTfbASwchhWmaZa68fef52QjZmHefwhoYjZtH4bbXIH7pwvvIH0K9CWj9BrlHOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110470; c=relaxed/simple;
	bh=YkBdcOOZ1PTOLiWWf6uzsnHuWV7zPGEg/syF7Oo80uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV/VsEzqABOwG8LzI4xdJVq9fjWlCkAgvk9IXdfPQcqF7MPWVh4xLLwPmmgcqnsSe2+iunAOi28FbECN4CiOZSI7rEcd0f3zNJchA+6EA0fYOKGjt1xIaDbI39s6dQ0O3poYshUTPGVF3+8hm4FUiLNAVhTXhQsHK21fFbQLDr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr; spf=pass smtp.mailfrom=bencteux.fr; dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b=nHM2UT8E; arc=none smtp.client-ip=51.178.41.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b="nHM2UT8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bencteux.fr; s=mail;
	t=1776110416; bh=YkBdcOOZ1PTOLiWWf6uzsnHuWV7zPGEg/syF7Oo80uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nHM2UT8Ec44XZ5TciygUu72eIOJFoQkUcSr0PTCywOYbwsF0CU3slREAprMa6Yx2A
	 zYl9mY7Fn9KQV0QeaGWS80gxU2rhQMirm3AbtxJsz+pzsZDMV36j9lcSAc88hiJHzK
	 D7g9L8lSz96k4iweyLztkV6LFICFodqnyUdb88aU=
Received: from localhost (unknown [146.70.188.177])
	by beta.bencteux.fr (Postfix) with ESMTPSA id 23E204030E;
	Mon, 13 Apr 2026 22:00:16 +0200 (CEST)
Date: Mon, 13 Apr 2026 21:51:08 +0200
From: Jeffrey Bencteux <jeff@bencteux.fr>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: mic@digikod.net, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-security-module@vger.kernel.org,
	xiujianfeng@huawei.com
Subject: Re: landlock: Add support for chmod and chown system calls families
Message-ID: <ad1JE8Qtwf40lVik@ultrabook.localdomain>
References: <20260412095233.34306-1-jeff@bencteux.fr>
 <adzjW7t7kJjne6Ze@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adzjW7t7kJjne6Ze@google.com>

Hi Günther,

On Mon, Apr 13, 2026 at 02:36:43PM +0200, Günther Noack wrote:
> Before you start your investigation completely from scratch,
> did you see the prior work on this topic?
> 
> * https://github.com/landlock-lsm/linux/issues/11
> * https://lore.kernel.org/all/20220822114701.26975-1-xiujianfeng@huawei.com/

I missed it, thanks for pointing it out.

> That specific patchset was unfortunately abandoned at the time, but I
> suspect that some of the discussion still applies for your patchset as
> well?

Indeed, my feeling it that Xiu's patchset is more elaborate than mine.

> In my understanding, it was in the end blocked on a LSM hook change.
> (If this is needed, a common approach for doing that hook change is to
> add it to the same patch series as one of the earliest commits.)

To my understanding, it is too. The implementation of
LANDLOCK_ACCESS_FS_(READ|WRITE)_METADATA are tied to several LSM hooks
changes (currently working with dentry/inode and not struct path as
arguments as discussed here:
https://lore.kernel.org/all/df99abcc-e7ec-ad34-27fa-25abee28a300@digikod.net

