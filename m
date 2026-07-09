Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AFE3AF665
	for <linux-security-module@vger.kernel.org>; Thu,  9 Jul 2026 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596163; cv=none; b=paaeRYNqC5Cp7ywTIDoci+kQpKFNQcybITJjkFNSYDEiGzLnQtKxqVvYgKbGZweYTdO3DPGSZ4WvrF/XAQ+OBbrG+QLW7UZboEdAo46Y6TNB8pPU3+H/zIvs+QyAWbq1vX5LorNQqzQEr+tlsAbuNY2DEG1aV0sYf9xcU3fF/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596163; c=relaxed/simple;
	bh=QNa2S/eCbFJWcKBHc9i4wDTevVKXV/ZcAElLAWZKQ58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT4NmFQLig/1TZUDrUY2dvD6AGoVd4qAlbn+x36tqMA33tIZ1XgcxGg1lp+mVpTXRgRVBlvNRf0+61+r4W72Hz0EsrR9YsJUoZu3VjCQMO/KW0cebRT5C0q7hqtK6A2DEDQOUQk1h+V1ZD1zfWNJmDs+AMyp0x8cLpGfDI0LzVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iNocUnfo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iNocUnfo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783596160;
	bh=QNa2S/eCbFJWcKBHc9i4wDTevVKXV/ZcAElLAWZKQ58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNocUnfo/XQArf5XcjtXd+mrY845QxMW0qZKxU3CJKHJoUhGfX7xJLob+jHzw9UpC
	 I5FsqG2tXyYCWdvFmb5pIDFAwBnQC4zudgZ/yq/hGmD0/mWUPbHb9hdCpQgE/ERlUv
	 ljQoffKlVwFATJ/G+UUYEHT+3vK1EAriHNj9x9evG4sMr/EAKGX0Gura805ApGj/Ds
	 MsLXhZWiS2VJ/l5+42gk0/72S5s5yO2ufJhDV0dWOoA8Q05CXmrOxfXQ4OdCyjfRQa
	 1/ZtfKfDd10B9CEKes9fehY2GG5nd+sCzuVoNssAn+scT0qP9Ime4Bhr4nuTsbin3K
	 zrD1c9eK6Ym/Q==
Received: from localhost (unknown [100.64.0.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: smcv)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id C030217E0CDE;
	Thu, 09 Jul 2026 13:22:40 +0200 (CEST)
Date: Thu, 9 Jul 2026 12:22:40 +0100
From: Simon McVittie <smcv@collabora.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org, gnoack@google.com
Subject: Re: [PATCH 0/3] Implement LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
Message-ID: <ak-EgMPeFtH8MAQP@descent>
References: <20260708133928.852999-1-utilityemal77@gmail.com>
 <20260709.Eaphooyoh6sh@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709.Eaphooyoh6sh@digikod.net>

On Thu, 09 Jul 2026 at 12:09:25 +0200, Mickaël Salaün wrote:
> On Wed, Jul 08, 2026 at 09:39:24AM -0400, Justin Suess wrote:
> > Consider a sandbox launcher that depends on a set-user-ID helper, such
> > as launching applications through bubblewrap on distributions where
> > unprivileged user namespaces are disabled and bwrap is installed
> > set-user-ID root.

It's perhaps worth noting that the current version 0.11.2 of bubblewrap
deprecates this mode of use (it will refuse to run while setuid unless
that was explicitly enabled at compile-time), and the next release 0.12.0
will also remove the ability to enable it at compile-time.

When bubblewrap was first written, having it be setuid was a necessary
workaround for kernels/distros not letting it do its sandboxing job any
other way; but now that unprivileged user namespaces are more widespread,
its maintainers have come to the conclusion that when it's setuid,
the risk of vulnerabilities that allow a root privilege escalation
(CVE-2020-5291, CVE-2026-41163) is unacceptably high, so being able to
make it setuid is no longer a good trade-off.

> > This flag also closes a gap for CAP_SYS_ADMIN callers of
> > landlock_restrict_self(2) itself.  The no_new_privs/CAP_SYS_ADMIN
> > requirement exists to keep set-user-ID programs from running confused
> > inside a sandbox they do not expect.  However, a privileged process
> > that enforces a domain without setting no_new_privs leaves that hole
> > open for all of its descendants
> 
> In a nutshell, not setting NNP might be risky, even when not strictly
> needed.  We might want to update the Landlock doc with that.

If the CAP_SYS_ADMIN caller is setuid or setcap, then it has been
granted special privileges by the sysadmin or distro, and part of
the "contract" between the sysadmin/distro and the setuid program is
that setuid/setcap must only be set on executables that have taken
responsibility for ensuring that they can't create insecure situations
(for example bubblewrap always sets PR_SET_NO_NEW_PRIVS, unconditionally,
for this reason).

A large part of why bubblewrap no longer supports being setuid is that
its maintainers don't want it to have this heavy responsibility.

    smcv
