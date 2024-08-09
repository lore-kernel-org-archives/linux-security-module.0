Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04F19046B
	for <linux-security-module@vger.kernel.org>; Fri,  9 Aug 2024 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209923; cv=none; b=cD/PrDPXDA3AXBYYLsHZRdFh6KyNQ5a50VKEuQsyMoM09lhYfJO6po49h/H/9QEyaMai3JXqlL4VMhGm4+RvqlQtpNwRzXisT2/3qpDZHOaU2Ipo3WHZiQGhQ/hUPV3ra9gD9u7mCBTcW5lsIFp8YTdMDC/xcbsNLEJLXhRi55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209923; c=relaxed/simple;
	bh=q8oFJ6K14ti4AQLK6XdG+/LYuY63JwP/I8q1yCKwPQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5+/RocnAPXniIn9U0GDO68Y15glYUHVafNoCfTpg2SoizN6EHuY47p5dh04xEJOHsOco+FHC9ktcK030q9F72OJ5KmrsAWoPCqCZw6vfdqEwbtj+HQokmetadGka9W/5yjem4Pur0h4+G1J4pOTdPajCp9FjRPTW+4/O/8c4fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=mcChpKnK; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="mcChpKnK"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WgPbx276fzGS7;
	Fri,  9 Aug 2024 15:18:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723209485;
	bh=8q0uMX7tRV16e+74Wja3JoKpQoc7+O1R17EEnmf2d4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mcChpKnKXoBQDUVS6APCY4X8MEEW2+vQIMX78usfyc4876MD9PSrjaRIaphad53Aj
	 ctN8yRjFqqyWkqCDhA2qq85gS7iY37fY2a1OKKutZ/CVbTAyrNl5teAhXo8MKRbuSR
	 /tcpGWvG1QbqKBJmuaQauVSSd7PqwAbQBawqHlPI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WgPbw27Byzbn0;
	Fri,  9 Aug 2024 15:18:04 +0200 (CEST)
Date: Fri, 9 Aug 2024 15:17:59 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	Casey Schaufler <casey@schaufler-ca.com>
Cc: Jann Horn <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>, 
	gnoack@google.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: f_modown and LSM inconsistency (was [PATCH v2 1/4] Landlock: Add
 signal control)
Message-ID: <20240809.se0ha8tiuJai@digikod.net>
References: <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
 <20240807.Yee4al2lahCo@digikod.net>
 <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
 <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
 <20240808.kaiyaeZoo1ha@digikod.net>
 <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
 <20240809.eejeekoo4Quo@digikod.net>
 <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
X-Infomaniak-Routing: alpha

Talking about f_modown() and security_file_set_fowner(), it looks like
there are some issues:

On Fri, Aug 09, 2024 at 02:44:06PM +0200, Jann Horn wrote:
> On Fri, Aug 9, 2024 at 12:59 PM Mickaël Salaün <mic@digikod.net> wrote:

[...]

> > BTW, I don't understand why neither SELinux nor Smack use (explicit)
> > atomic operations nor lock.
> 
> Yeah, I think they're sloppy and kinda wrong - but it sorta works in
> practice mostly because they don't have to do any refcounting around
> this?
> 
> > And it looks weird that
> > security_file_set_fowner() isn't called by f_modown() with the same
> > locking to avoid races.
> 
> True. I imagine maybe the thought behind this design could have been
> that LSMs should have their own locking, and that calling an LSM hook
> with IRQs off is a little weird? But the way the LSMs actually use the
> hook now, it might make sense to call the LSM with the lock held and
> IRQs off...
> 

Would it be OK (for VFS, SELinux, and Smack maintainers) to move the
security_file_set_fowner() call into f_modown(), especially where
UID/EUID are populated.  That would only call security_file_set_fowner()
when the fown is actually set, which I think could also fix a bug for
SELinux and Smack.

Could we replace the uid and euid fields with a pointer to the current
credentials?  This would enables LSMs to not copy the same kind of
credential informations and save some memory, simplify credential
management, and improve consistency.
