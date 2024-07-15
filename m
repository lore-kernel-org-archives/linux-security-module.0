Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB2188CDF;
	Mon, 15 Jul 2024 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039891; cv=none; b=nkZQ+OysmydAUvHkDEL+CbBeJkpm3zQd4LsNCsRyFZHMOdyT4WKg321xyRZMzk+zNZZxJf8/bQ32fxFthGgIwLIlWqiJO4cWk/BhQriAhKQTE/azu6RhOIwV88ZWdrfm1VgyN8kWLKtTFIXerIcZ/ABsfwZP2lqz02BZGgrdDdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039891; c=relaxed/simple;
	bh=lE7FrfdkLBlUpifxmV9zzJ79DyhZz5RPYEjWLn8zz3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s74yK8gpdPDRa6eQqeUjE51tWMqNKvwz3ugWoEaFBj4+FnPQAEI1BdD82gCqLZxrymO890wd6DeHEi4/QLy0QeRkvyRBDOaN2MXtYhhZ/DVhUDBsZeA14o2+hsHQlgsvDTzSovNlu8Ftp21U6YIdUL55pssl6EZU1F5qsTgi57o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=s2+zFhHA; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="s2+zFhHA"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WMzDj193wzC4M;
	Mon, 15 Jul 2024 12:37:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721039877;
	bh=KuHNObI2LzO0QtwTAS849qPCxUo8g2dKwL8aDC0U+Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s2+zFhHAbXAXy3xNyWk6oTsZl9y3ELVIB8o/ZVGkHnD21c6y73sdx52PZ6bVpZJSG
	 rCFSW21qrninMnI29pajBICHfwBshsKnKaBDwGM2ngfVsfFcSMiwCN+pGp9/0LU0Nl
	 m8glSxH2+/ty8C+x14dJ6j3+o9E1/Y18d9FAW6aU=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WMzDh4zfPzKfn;
	Mon, 15 Jul 2024 12:37:56 +0200 (CEST)
Date: Mon, 15 Jul 2024 12:37:53 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: CVE-2024-40938: landlock: Fix d_parent walk
Message-ID: <20240715.aeLiunipi8ia@digikod.net>
References: <2024071218-CVE-2024-40938-1619@gregkh>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024071218-CVE-2024-40938-1619@gregkh>
X-Infomaniak-Routing: alpha

Hello,

AFAIK, commit 88da52ccd66e ("landlock: Fix d_parent walk") doesn't fix a
security issue but an unexpected case.  The triggered WARN_ON_ONCE() is
just a canary, and this case was correctly handled with defensive
programming and didn't allow to bypass the security policy nor to harm
the kernel.  However, this fix should indeed be backported.

Could you please Cc me for future CVE related to my changes or to
Landlock?  For kernel CVEs, I think it would be good to Cc at least
maintainers, reviewers, authors, and committers for the related commits.

Regards,
 Mickaël

On Fri, Jul 12, 2024 at 02:27:36PM +0200, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> landlock: Fix d_parent walk
> 
> The WARN_ON_ONCE() in collect_domain_accesses() can be triggered when
> trying to link a root mount point.  This cannot work in practice because
> this directory is mounted, but the VFS check is done after the call to
> security_path_link().
> 
> Do not use source directory's d_parent when the source directory is the
> mount point.
> 
> [mic: Fix commit message]
> 
> The Linux kernel CVE team has assigned CVE-2024-40938 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Issue introduced in 5.19 with commit b91c3e4ea756 and fixed in 6.1.95 with commit b6e5e6964358
> 	Issue introduced in 5.19 with commit b91c3e4ea756 and fixed in 6.6.35 with commit cc30d05b34f9
> 	Issue introduced in 5.19 with commit b91c3e4ea756 and fixed in 6.9.6 with commit c7618c7b0b8c
> 	Issue introduced in 5.19 with commit b91c3e4ea756 and fixed in 6.10-rc2 with commit 88da52ccd66e
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-40938
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	security/landlock/fs.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/b6e5e696435832b33e40775f060ef5c95f4fda1f
> 	https://git.kernel.org/stable/c/cc30d05b34f9a087a6928d09b131f7b491e9ab11
> 	https://git.kernel.org/stable/c/c7618c7b0b8c45bcef34410cc1d1e953eb17f8f6
> 	https://git.kernel.org/stable/c/88da52ccd66e65f2e63a6c35c9dff55d448ef4dc
